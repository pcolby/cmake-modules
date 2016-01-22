#include <php.h>
#include <ext/standard/info.h>

PHP_FUNCTION(my_function)
{
	php_printf("Hello world from my function!");
	RETURN_STRING("This is my function", 1);
}

PHP_MINFO_FUNCTION(my_extension)
{
	php_info_print_table_start();
	php_info_print_table_row(2, "My extension", "1.0");
	php_info_print_table_end();
}

PHP_MINIT_FUNCTION(my_extension)
{
	return SUCCESS;
}

zend_function_entry my_functions[] = {
	PHP_FE(my_function, NULL)
	PHP_FE_END
};

zend_module_entry my_extension_module_entry = {
	STANDARD_MODULE_HEADER,
	"my_extension",
	my_functions,
	PHP_MINIT(my_extension),
	NULL, // name of the MSHUTDOWN function or NULL if not applicable
	NULL, // name of the RINIT function or NULL if not applicable
	NULL, // name of the RSHUTDOWN function or NULL if not applicable
	PHP_MINFO(my_extension),
	"1.0",
	STANDARD_MODULE_PROPERTIES
};

extern "C" {
ZEND_GET_MODULE(my_extension)
}
