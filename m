From: Sutharsan Ramamoorthy <sutharsan.ramamoorthy@yahoo.com>
Subject: [PATCH] Westbridge software module, fixes errors reported by checkpatch.pl
Date: Wed, 19 Jan 2011 17:31:46 -0800 (PST)
Message-ID: <444938.26253.qm@web121610.mail.ne1.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: greg@kroah.com
Cc: tony@atomide.com, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-usb@vger.kernel.org, david.cross@cypress.com, srmt@cypress.com
List-Id: linux-omap@vger.kernel.org

=46rom: Sutharsan Ramamoorthy <srmt@cypress.com>

This patch fixes errors in westbridge device controller driver in the=20
staging tree reported by checkpatch.pl. File containing EXPORT_SYMBOL()=
=20
macros for all the APIs exported by the westbridge software has been re=
moved. EXPORT_SYMBOL() macros are added after the corresponding functio=
n definitions.

Signed-off-by: Sutharsan Ramamoorthy <srmt@cypress.com>

---

diff -uprN -X linux-2.6.37_vanilla/Documentation/dontdiff linux-2.6.37_=
vanilla/drivers/staging/westbridge/astoria/api/src/cyasmisc.c linux-2.6=
=2E37-wb/drivers/staging/westbridge/astoria/api/src/cyasmisc.c
--- linux-2.6.37_vanilla/drivers/staging/westbridge/astoria/api/src/cya=
smisc.c=A0=A0=A0 2010-11-29 20:42:04.000000000 -0800
+++ linux-2.6.37-wb/drivers/staging/westbridge/astoria/api/src/cyasmisc=
=2Ec=A0=A0=A0 2011-01-19 11:55:07.842669281 -0800
@@ -926,6 +926,8 @@ destroy:
=20
 =A0=A0=A0 return ret;
 }
+EXPORT_SYMBOL(cy_as_misc_get_firmware_version);
+
 static cy_as_return_status_t
 my_handle_response_read_m_c_u_register(cy_as_device *dev_p,
 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 cy_as_ll_request_response *req=
_p,
@@ -1115,7 +1117,7 @@ destroy:
=20
 =A0=A0=A0 return ret;
 }
-
+EXPORT_SYMBOL(cy_as_misc_read_m_c_u_register);
=20
 cy_as_return_status_t
 cy_as_misc_write_m_c_u_register(cy_as_device_handle handle,
@@ -1336,6 +1338,7 @@ cy_as_misc_reset(cy_as_device_handle han
=20
 =A0=A0=A0 return ret;
 }
+EXPORT_SYMBOL(cy_as_misc_reset);
=20
 static cy_as_return_status_t
 get_unallocated_resource(cy_as_device *dev_p, cy_as_resource_type reso=
urce)
@@ -1508,6 +1511,8 @@ destroy:
=20
 =A0=A0=A0 return ret;
 }
+EXPORT_SYMBOL(cy_as_misc_acquire_resource);
+
 cy_as_return_status_t
 cy_as_misc_release_resource(cy_as_device_handle handle,
 =A0=A0=A0 cy_as_resource_type resource)
@@ -1560,6 +1565,7 @@ cy_as_misc_release_resource(cy_as_device
=20
 =A0=A0=A0 return CY_AS_ERROR_SUCCESS;
 }
+EXPORT_SYMBOL(cy_as_misc_release_resource);
=20
 cy_as_return_status_t
 cy_as_misc_set_trace_level(cy_as_device_handle handle,
@@ -1718,6 +1724,7 @@ destroy:
=20
 =A0=A0=A0 return ret;
 }
+EXPORT_SYMBOL(cy_as_misc_heart_beat_control);
=20
 static cy_as_return_status_t
 my_set_sd_clock_freq(
@@ -1805,6 +1812,7 @@ cy_as_misc_set_low_speed_sd_freq(
=20
 =A0=A0=A0 return my_set_sd_clock_freq(dev_p, 0, (uint8_t)setting, cb, =
client);
 }
+EXPORT_SYMBOL(cy_as_misc_set_low_speed_sd_freq);
=20
 cy_as_return_status_t
 cy_as_misc_set_high_speed_sd_freq(
@@ -1830,6 +1838,7 @@ cy_as_misc_set_high_speed_sd_freq(
=20
 =A0=A0=A0 return my_set_sd_clock_freq(dev_p, 1, (uint8_t)setting, cb, =
client);
 }
+EXPORT_SYMBOL(cy_as_misc_set_high_speed_sd_freq);
=20
 cy_as_return_status_t
 cy_as_misc_get_gpio_value(cy_as_device_handle handle,
@@ -1921,7 +1930,7 @@ destroy:
=20
 =A0=A0=A0 return ret;
 }
-
+EXPORT_SYMBOL(cy_as_misc_get_gpio_value);
=20
 cy_as_return_status_t
 cy_as_misc_set_gpio_value(cy_as_device_handle handle,
@@ -2020,6 +2029,7 @@ destroy:
=20
 =A0=A0=A0 return ret;
 }
+EXPORT_SYMBOL(cy_as_misc_set_gpio_value);
=20
 static cy_as_return_status_t
 my_enter_standby(cy_as_device *dev_p, cy_bool pin)
@@ -2213,6 +2223,7 @@ destroy:
=20
 =A0=A0=A0 return ret;
 }
+EXPORT_SYMBOL(cy_as_misc_enter_standby);
=20
 cy_as_return_status_t
 cy_as_misc_enter_standby_e_x_u(cy_as_device_handle handle,
@@ -2425,6 +2436,7 @@ try_wakeup_again:
=20
 =A0=A0=A0 return ret;
 }
+EXPORT_SYMBOL(cy_as_misc_leave_standby);
=20
 cy_as_return_status_t
 cy_as_misc_register_callback(
@@ -2526,7 +2538,7 @@ destroy:
=20
 =A0=A0=A0 return ret;
 }
-
+EXPORT_SYMBOL(cy_as_misc_storage_changed);
=20
 cy_as_return_status_t
 cy_as_misc_enter_suspend(
@@ -2634,6 +2646,7 @@ destroy:
=20
 =A0=A0=A0 return ret;
 }
+EXPORT_SYMBOL(cy_as_misc_enter_suspend);
=20
 cy_as_return_status_t
 cy_as_misc_leave_suspend(
@@ -2704,6 +2717,7 @@ cy_as_misc_leave_suspend(
=20
 =A0=A0=A0 return ret;
 }
+EXPORT_SYMBOL(cy_as_misc_leave_suspend);
=20
 cy_as_return_status_t
 cy_as_misc_reserve_l_n_a_boot_area(cy_as_device_handle handle,
diff -uprN -X linux-2.6.37_vanilla/Documentation/dontdiff linux-2.6.37_=
vanilla/drivers/staging/westbridge/astoria/api/src/cyasmtp.c linux-2.6.=
37-wb/drivers/staging/westbridge/astoria/api/src/cyasmtp.c
--- linux-2.6.37_vanilla/drivers/staging/westbridge/astoria/api/src/cya=
smtp.c=A0=A0=A0 2010-11-29 20:42:04.000000000 -0800
+++ linux-2.6.37-wb/drivers/staging/westbridge/astoria/api/src/cyasmtp.=
c=A0=A0=A0 2011-01-14 12:04:06.786111000 -0800
@@ -402,6 +402,7 @@ destroy:
=20
 =A0=A0=A0 return ret;
 }
+EXPORT_SYMBOL(cy_as_mtp_start);
=20
 static cy_as_return_status_t
 my_handle_response_mtp_stop(cy_as_device *dev_p,
@@ -744,6 +745,7 @@ cy_as_mtp_init_send_object(cy_as_device_
 =A0=A0=A0 =A0=A0=A0 client, CY_RQT_INIT_SEND_OBJECT);
=20
 }
+EXPORT_SYMBOL(cy_as_mtp_init_send_object);
=20
 cy_as_return_status_t
 cy_as_mtp_init_get_object(cy_as_device_handle handle,
@@ -763,6 +765,7 @@ cy_as_mtp_init_get_object(cy_as_device_h
 =A0=A0=A0 =A0=A0=A0 transaction_id, cb, client, CY_RQT_INIT_GET_OBJECT=
);
=20
 }
+EXPORT_SYMBOL(cy_as_mtp_init_get_object);
=20
 static cy_as_return_status_t
 my_handle_response_cancel_send_object(cy_as_device *dev_p,
@@ -850,6 +853,7 @@ destroy:
=20
 =A0=A0=A0 return ret;
 }
+EXPORT_SYMBOL(cy_as_mtp_cancel_send_object);
=20
 static cy_as_return_status_t
 my_handle_response_cancel_get_object(cy_as_device *dev_p,
@@ -937,6 +941,7 @@ destroy:
=20
 =A0=A0=A0 return ret;
 }
+EXPORT_SYMBOL(cy_as_mtp_cancel_get_object);
=20
 cy_as_return_status_t
 cy_as_mtp_send_block_table(cy_as_device_handle handle,
@@ -1058,6 +1063,7 @@ cy_as_mtp_storage_only_start(cy_as_devic
 =A0=A0=A0 dev_p->is_storage_only_mode =3D cy_true;
 =A0=A0=A0 return CY_AS_ERROR_SUCCESS;
 }
+EXPORT_SYMBOL(cy_as_mtp_storage_only_start);
=20
 cy_as_return_status_t
 cy_as_mtp_storage_only_stop(cy_as_device_handle handle,
@@ -1126,3 +1132,5 @@ destroy:
=20
 =A0=A0=A0 return ret;
 }
+EXPORT_SYMBOL(cy_as_mtp_storage_only_stop);
+
diff -uprN -X linux-2.6.37_vanilla/Documentation/dontdiff linux-2.6.37_=
vanilla/drivers/staging/westbridge/astoria/api/src/cyasstorage.c linux-=
2.6.37-wb/drivers/staging/westbridge/astoria/api/src/cyasstorage.c
--- linux-2.6.37_vanilla/drivers/staging/westbridge/astoria/api/src/cya=
sstorage.c=A0=A0=A0 2010-11-29 20:42:04.000000000 -0800
+++ linux-2.6.37-wb/drivers/staging/westbridge/astoria/api/src/cyasstor=
age.c=A0=A0=A0 2011-01-14 16:05:22.990611000 -0800
@@ -522,7 +522,7 @@ destroy:
=20
 =A0=A0=A0 return ret;
 }
-
+EXPORT_SYMBOL(cy_as_storage_start);
=20
 static cy_as_return_status_t
 my_handle_response_storage_stop(cy_as_device *dev_p,
@@ -632,6 +632,7 @@ destroy:
=20
 =A0=A0=A0 return ret;
 }
+EXPORT_SYMBOL(cy_as_storage_stop);
=20
 cy_as_return_status_t
 cy_as_storage_register_callback(cy_as_device_handle handle,
@@ -655,7 +656,7 @@ cy_as_storage_register_callback(cy_as_de
=20
 =A0=A0=A0 return CY_AS_ERROR_SUCCESS;
 }
-
+EXPORT_SYMBOL(cy_as_storage_register_callback);
=20
=20
 static cy_as_return_status_t
@@ -783,6 +784,7 @@ cy_as_storage_claim(cy_as_device_handle=20
 =A0=A0=A0 return my_storage_claim(dev_p, NULL, bus, device,
 =A0=A0=A0 =A0=A0=A0 CY_AS_REQUEST_RESPONSE_MS, cb, client);
 }
+EXPORT_SYMBOL(cy_as_storage_claim);
=20
 static cy_as_return_status_t
 my_handle_response_storage_release(cy_as_device *dev_p,
@@ -911,6 +913,7 @@ cy_as_storage_release(cy_as_device_handl
 =A0=A0=A0 return my_storage_release(dev_p, NULL, bus, device,
 =A0=A0=A0 =A0=A0=A0 CY_AS_REQUEST_RESPONSE_MS, cb, client);
 }
+EXPORT_SYMBOL(cy_as_storage_release);
=20
 static cy_as_return_status_t
 my_handle_response_storage_query_bus(cy_as_device *dev_p,
@@ -1059,6 +1062,7 @@ cy_as_storage_query_bus(cy_as_device_han
 =A0=A0=A0 return my_storage_query_bus(dev_p, bus, cy_as_media_max_medi=
a_value,
 =A0=A0=A0 =A0=A0=A0 CY_AS_REQUEST_RESPONSE_MS, count, cb, client);
 }
+EXPORT_SYMBOL(cy_as_storage_query_bus);
=20
 cy_as_return_status_t
 cy_as_storage_query_media(cy_as_device_handle handle,
@@ -1086,6 +1090,7 @@ cy_as_storage_query_media(cy_as_device_h
 =A0=A0=A0 return my_storage_query_bus(dev_p, bus, type, CY_AS_REQUEST_=
RESPONSE_EX,
 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 count, cb, client);
 }
+EXPORT_SYMBOL(cy_as_storage_query_media);
=20
 static cy_as_return_status_t
 my_handle_response_storage_query_device(cy_as_device *dev_p,
@@ -1260,6 +1265,7 @@ cy_as_storage_query_device(cy_as_device_
 =A0=A0=A0 =A0=A0=A0 CY_AS_REQUEST_RESPONSE_MS, data_p->bus,
 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 data_p->device, cb, client);
 }
+EXPORT_SYMBOL(cy_as_storage_query_device);
=20
 static cy_as_return_status_t
 my_handle_response_storage_query_unit(cy_as_device *dev_p,
@@ -1434,7 +1440,7 @@ cy_as_storage_query_unit(cy_as_device_ha
 =A0=A0=A0 return my_storage_query_unit(dev_p, data_p, CY_AS_REQUEST_RE=
SPONSE_MS,
 =A0=A0=A0 =A0=A0=A0 data_p->bus, data_p->device, data_p->unit, cb, cli=
ent);
 }
-
+EXPORT_SYMBOL(cy_as_storage_query_unit);
=20
 static cy_as_return_status_t
 cy_as_get_block_size(cy_as_device *dev_p,
@@ -1615,6 +1621,7 @@ cy_as_storage_device_control(cy_as_devic
 =A0=A0=A0 return my_storage_device_control(dev_p, bus, device, card_de=
tect_en,
 =A0=A0=A0 =A0=A0=A0 write_prot_en, config_detect, cb, client);
 }
+EXPORT_SYMBOL(cy_as_storage_device_control);
=20
 static void
 cy_as_async_storage_callback(cy_as_device *dev_p,
@@ -2069,6 +2076,7 @@ cy_as_storage_read(cy_as_device_handle h
 =A0=A0=A0 =A0=A0=A0 CY_RQT_READ_BLOCK, bus, device,
 =A0=A0=A0 =A0=A0=A0 unit, block, data_p, num_blocks);
 }
+EXPORT_SYMBOL(cy_as_storage_read);
=20
 cy_as_return_status_t
 cy_as_storage_write(cy_as_device_handle handle,
@@ -2089,7 +2097,7 @@ cy_as_storage_write(cy_as_device_handle=20
 =A0=A0=A0 =A0=A0=A0 CY_RQT_WRITE_BLOCK, bus, device,
 =A0=A0=A0 =A0=A0=A0 unit, block, data_p, num_blocks);
 }
-
+EXPORT_SYMBOL(cy_as_storage_write);
=20
 cy_as_return_status_t
 cy_as_storage_read_async(cy_as_device_handle handle,
@@ -2110,6 +2118,7 @@ cy_as_storage_read_async(cy_as_device_ha
 =A0=A0=A0 =A0=A0=A0 CY_AS_REQUEST_RESPONSE_MS, bus, device, unit,
 =A0=A0=A0 =A0=A0=A0 block, data_p, num_blocks, NULL, callback);
 }
+EXPORT_SYMBOL(cy_as_storage_read_async);
=20
 cy_as_return_status_t
 cy_as_storage_write_async(cy_as_device_handle handle,
@@ -2133,7 +2142,7 @@ cy_as_storage_write_async(cy_as_device_h
 =A0=A0=A0 =A0=A0=A0 CY_AS_REQUEST_RESPONSE_MS, bus, device, unit, bloc=
k,
 =A0=A0=A0 =A0=A0=A0 data_p, num_blocks, NULL, callback);
 }
-
+EXPORT_SYMBOL(cy_as_storage_write_async);
=20
 static void
 my_storage_cancel_callback(
@@ -2196,6 +2205,7 @@ cy_as_storage_cancel_async(cy_as_device_
=20
 =A0=A0=A0 return CY_AS_ERROR_SUCCESS;
 }
+EXPORT_SYMBOL(cy_as_storage_cancel_async);
=20
 /*
=A0 * This function does all the API side clean-up associated with
@@ -2374,6 +2384,7 @@ destroy:
=20
 =A0=A0=A0 return ret;
 }
+EXPORT_SYMBOL(cy_as_storage_sd_register_read);
=20
 cy_as_return_status_t
 cy_as_storage_create_p_partition(
@@ -2450,6 +2461,7 @@ destroy:
=20
 =A0=A0=A0 return ret;
 }
+EXPORT_SYMBOL(cy_as_storage_create_p_partition);
=20
 cy_as_return_status_t
 cy_as_storage_remove_p_partition(
@@ -2519,6 +2531,7 @@ destroy:
=20
 =A0=A0=A0 return ret;
 }
+EXPORT_SYMBOL(cy_as_storage_remove_p_partition);
=20
 static cy_as_return_status_t
 my_handle_response_get_transfer_amount(cy_as_device *dev_p,
@@ -2621,6 +2634,7 @@ destroy:
 =A0=A0=A0 return ret;
=20
 }
+EXPORT_SYMBOL(cy_as_storage_get_transfer_amount);
=20
 cy_as_return_status_t
 cy_as_storage_erase(
@@ -2722,6 +2736,7 @@ destroy:
=20
 =A0=A0=A0 return ret;
 }
+EXPORT_SYMBOL(cy_as_storage_erase);
=20
 static void
 cy_as_storage_func_callback(cy_as_device *dev_p,
@@ -3005,6 +3020,7 @@ cy_as_sdio_direct_read(
 =A0=A0=A0 return cy_as_sdio_direct_io(handle, bus, device, n_function_=
no,
 =A0=A0=A0 =A0=A0=A0 address, misc_buf, 0x00, cy_false, data_p);
 }
+EXPORT_SYMBOL(cy_as_sdio_direct_read);
=20
 cy_as_return_status_t
 cy_as_sdio_direct_write(
@@ -3020,6 +3036,7 @@ cy_as_sdio_direct_write(
 =A0=A0=A0 return cy_as_sdio_direct_io(handle, bus, device, n_function_=
no,
 =A0=A0=A0 =A0=A0=A0 address, misc_buf, argument, cy_true, data_p);
 }
+EXPORT_SYMBOL(cy_as_sdio_direct_write);
=20
 /*Cmd53 IO*/
 cy_as_return_status_t
@@ -3403,6 +3420,7 @@ cy_as_sdio_extended_read(
 =A0=A0=A0 =A0=A0=A0 n_function_no, address, misc_buf, argument, cy_fal=
se,
 =A0=A0=A0 =A0=A0=A0 data_p, callback);
 }
+EXPORT_SYMBOL(cy_as_sdio_extended_read);
=20
 /* CMD53 Extended Write*/
 cy_as_return_status_t
@@ -3426,7 +3444,7 @@ cy_as_sdio_extended_write(
 =A0=A0=A0 =A0=A0=A0 n_function_no, address, misc_buf, argument, cy_tru=
e,
 =A0=A0=A0 =A0=A0=A0 data_p, callback);
 }
-
+EXPORT_SYMBOL(cy_as_sdio_extended_write);
=20
 /* Read the CIS info tuples for the given function and Tuple ID*/
 cy_as_return_status_t
@@ -3617,6 +3635,7 @@ destroy:
 =A0=A0=A0 =A0=A0=A0 cy_as_ll_destroy_response(dev_p, reply_p);
 =A0=A0=A0 return ret;
 }
+EXPORT_SYMBOL(cy_as_sdio_query_card);
=20
 /*Reset SDIO card. */
 cy_as_return_status_t
@@ -3767,6 +3786,7 @@ destroy:
 =A0=A0=A0 =A0=A0=A0 cy_as_ll_destroy_response(dev_p, reply_p);
 =A0=A0=A0 return ret;
 }
+EXPORT_SYMBOL(cy_as_sdio_init_function);
=20
 /*Query individual functions. */
 cy_as_return_status_t
@@ -4066,6 +4086,7 @@ cy_as_sdio_set_blocksize(
 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 bus, n_function_no, blocksize);
 =A0=A0=A0 return ret;
 }
+EXPORT_SYMBOL(cy_as_sdio_set_blocksize);
=20
 /* Deinitialize an SDIO function*/
 cy_as_return_status_t
diff -uprN -X linux-2.6.37_vanilla/Documentation/dontdiff linux-2.6.37_=
vanilla/drivers/staging/westbridge/astoria/api/src/cyasusb.c linux-2.6.=
37-wb/drivers/staging/westbridge/astoria/api/src/cyasusb.c
--- linux-2.6.37_vanilla/drivers/staging/westbridge/astoria/api/src/cya=
susb.c=A0=A0=A0 2010-11-29 20:42:04.000000000 -0800
+++ linux-2.6.37-wb/drivers/staging/westbridge/astoria/api/src/cyasusb.=
c=A0=A0=A0 2011-01-14 11:50:16.350111000 -0800
@@ -800,6 +800,7 @@ destroy:
=20
 =A0=A0=A0 return ret;
 }
+EXPORT_SYMBOL(cy_as_usb_start);
=20
 void
 cy_as_usb_reset(cy_as_device *dev_p)
@@ -977,6 +978,7 @@ destroy:
=20
 =A0=A0=A0 return ret;
 }
+EXPORT_SYMBOL(cy_as_usb_stop);
=20
 /*
 * This function registers a callback to be called when
@@ -1004,7 +1006,7 @@ cy_as_usb_register_callback(cy_as_device
 =A0=A0=A0 dev_p->usb_event_cb_ms =3D callback;
 =A0=A0=A0 return CY_AS_ERROR_SUCCESS;
 }
-
+EXPORT_SYMBOL(cy_as_usb_register_callback);
=20
 static cy_as_return_status_t
 my_handle_response_no_data(cy_as_device *dev_p,
@@ -1124,6 +1126,7 @@ destroy:
=20
 =A0=A0=A0 return ret;
 }
+EXPORT_SYMBOL(cy_as_usb_connect);
=20
 static cy_as_return_status_t
 my_handle_response_disconnect(cy_as_device *dev_p,
@@ -1222,6 +1225,7 @@ destroy:
=20
 =A0=A0=A0 return ret;
 }
+EXPORT_SYMBOL(cy_as_usb_disconnect);
=20
 static cy_as_return_status_t
 my_handle_response_set_enum_config(cy_as_device *dev_p,
@@ -1437,7 +1441,7 @@ cy_as_usb_set_enum_config(cy_as_device_h
 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 client
 =A0=A0=A0 =A0=A0=A0 );
 }
-
+EXPORT_SYMBOL(cy_as_usb_set_enum_config);
=20
 static cy_as_return_status_t
 my_handle_response_get_enum_config(cy_as_device *dev_p,
@@ -1622,7 +1626,7 @@ cy_as_usb_get_enum_config(cy_as_device_h
 =A0=A0=A0 return my_usb_get_enum_config(handle,
 =A0=A0=A0 =A0=A0=A0 CY_AS_REQUEST_RESPONSE_MS, config_p, cb, client);
 }
-
+EXPORT_SYMBOL(cy_as_usb_get_enum_config);
=20
 /*
 * This method sets the USB descriptor for a given entity.
@@ -1705,6 +1709,7 @@ destroy:
=20
 =A0=A0=A0 return ret;
 }
+EXPORT_SYMBOL(cy_as_usb_set_descriptor);
=20
 /*
=A0 * This method clears all descriptors that were previously
@@ -1771,6 +1776,7 @@ destroy:
=20
 =A0=A0=A0 return ret;
 }
+EXPORT_SYMBOL(cy_as_usb_clear_descriptors);
=20
 static cy_as_return_status_t
 my_handle_response_get_descriptor(cy_as_device *dev_p,
@@ -1881,6 +1887,7 @@ destroy:
=20
 =A0=A0=A0 return ret;
 }
+EXPORT_SYMBOL(cy_as_usb_get_descriptor);
=20
 cy_as_return_status_t
 cy_as_usb_set_physical_configuration(cy_as_device_handle handle,
@@ -1910,6 +1917,7 @@ cy_as_usb_set_physical_configuration(cy_
=20
 =A0=A0=A0 return CY_AS_ERROR_SUCCESS;
 }
+EXPORT_SYMBOL(cy_as_usb_set_physical_configuration);
=20
 static cy_bool
 is_physical_valid(uint8_t config, cy_as_end_point_number_t ep)
@@ -2027,6 +2035,7 @@ cy_as_usb_set_end_point_config(cy_as_dev
 =A0=A0=A0 return cy_as_dma_enable_end_point(dev_p, ep,
 =A0=A0=A0 =A0=A0=A0 config_p->enabled, (cy_as_dma_direction)config_p->=
dir);
 }
+EXPORT_SYMBOL(cy_as_usb_set_end_point_config);
=20
 cy_as_return_status_t
 cy_as_usb_get_end_point_config(cy_as_device_handle handle,
@@ -2053,6 +2062,7 @@ cy_as_usb_get_end_point_config(cy_as_dev
=20
 =A0=A0=A0 return CY_AS_ERROR_SUCCESS;
 }
+EXPORT_SYMBOL(cy_as_usb_get_end_point_config);
=20
 /*
 * Commit the configuration of the various endpoints to the hardware.
@@ -2180,6 +2190,7 @@ destroy:
=20
 =A0=A0=A0 return ret;
 }
+EXPORT_SYMBOL(cy_as_usb_commit_config);
=20
 static void
 sync_request_callback(cy_as_device *dev_p,
@@ -2381,6 +2392,7 @@ cy_as_usb_read_data(cy_as_device_handle=20
=20
 =A0=A0=A0 return ret;
 }
+EXPORT_SYMBOL(cy_as_usb_read_data);
=20
 cy_as_return_status_t
 cy_as_usb_read_data_async(cy_as_device_handle handle,
@@ -2459,6 +2471,7 @@ cy_as_usb_read_data_async(cy_as_device_h
 =A0=A0=A0 }
 =A0=A0=A0 return ret;
 }
+EXPORT_SYMBOL(cy_as_usb_read_data_async);
=20
 cy_as_return_status_t
 cy_as_usb_write_data(cy_as_device_handle handle,
@@ -2571,6 +2584,7 @@ cy_as_usb_write_data(cy_as_device_handle
 =A0=A0=A0 ret =3D dev_p->usb_error;
 =A0=A0=A0 return ret;
 }
+EXPORT_SYMBOL(cy_as_usb_write_data);
=20
 static void
 mtp_write_callback(
@@ -2736,6 +2750,7 @@ cy_as_usb_write_data_async(cy_as_device_
=20
 =A0=A0=A0 return CY_AS_ERROR_SUCCESS;
 }
+EXPORT_SYMBOL(cy_as_usb_write_data_async);
=20
 static void
 my_usb_cancel_async_callback(
@@ -2827,6 +2842,7 @@ cy_as_usb_cancel_async(cy_as_device_hand
=20
 =A0=A0=A0 return CY_AS_ERROR_SUCCESS;
 }
+EXPORT_SYMBOL(cy_as_usb_cancel_async);
=20
 static void
 cy_as_usb_ack_callback(
@@ -3212,7 +3228,7 @@ cy_as_usb_set_nak(cy_as_device_handle ha
 =A0=A0=A0 return cy_as_usb_nak_stall_request(handle, ep,
 =A0=A0=A0 =A0=A0=A0 CY_RQT_ENDPOINT_SET_NAK, cy_true, 0, cb, client);
 }
-
+EXPORT_SYMBOL(cy_as_usb_set_nak);
=20
 cy_as_return_status_t
 cy_as_usb_clear_nak(cy_as_device_handle handle,
@@ -3238,6 +3254,7 @@ cy_as_usb_clear_nak(cy_as_device_handle=20
 =A0=A0=A0 return cy_as_usb_nak_stall_request(handle, ep,
 =A0=A0=A0 =A0=A0=A0 CY_RQT_ENDPOINT_SET_NAK, cy_false, 0, cb, client);
 }
+EXPORT_SYMBOL(cy_as_usb_clear_nak);
=20
 cy_as_return_status_t
 cy_as_usb_get_nak(cy_as_device_handle handle,
@@ -3265,7 +3282,7 @@ cy_as_usb_get_nak(cy_as_device_handle ha
 =A0=A0=A0 =A0=A0=A0 CY_RQT_GET_ENDPOINT_NAK, CY_RESP_ENDPOINT_NAK,
 =A0=A0=A0 =A0=A0=A0 nak_p, cb, client);
 }
-
+EXPORT_SYMBOL(cy_as_usb_get_nak);
=20
 cy_as_return_status_t
 cy_as_usb_set_stall(cy_as_device_handle handle,
@@ -3291,6 +3308,7 @@ cy_as_usb_set_stall(cy_as_device_handle=20
 =A0=A0=A0 return cy_as_usb_nak_stall_request(handle, ep,
 =A0=A0=A0 =A0=A0=A0 CY_RQT_STALL_ENDPOINT, cy_true, 0, cb, client);
 }
+EXPORT_SYMBOL(cy_as_usb_set_stall);
=20
 cy_as_return_status_t
 cy_as_usb_clear_stall(cy_as_device_handle handle,
@@ -3316,6 +3334,7 @@ cy_as_usb_clear_stall(cy_as_device_handl
 =A0=A0=A0 return cy_as_usb_nak_stall_request(handle, ep,
 =A0=A0=A0 =A0=A0=A0 CY_RQT_STALL_ENDPOINT, cy_false, 0, cb, client);
 }
+EXPORT_SYMBOL(cy_as_usb_clear_stall);
=20
 cy_as_return_status_t
 cy_as_usb_get_stall(cy_as_device_handle handle,
@@ -3342,6 +3361,7 @@ cy_as_usb_get_stall(cy_as_device_handle=20
 =A0=A0=A0 return cy_as_usb_get_nak_stall(handle, ep,
 =A0=A0=A0 =A0=A0=A0 CY_RQT_GET_STALL, CY_RESP_ENDPOINT_STALL, stall_p,=
 cb, client);
 }
+EXPORT_SYMBOL(cy_as_usb_get_stall);
=20
 cy_as_return_status_t
 cy_as_usb_signal_remote_wakeup(cy_as_device_handle handle,
@@ -3405,6 +3425,7 @@ destroy:
=20
 =A0=A0=A0 return ret;
 }
+EXPORT_SYMBOL(cy_as_usb_signal_remote_wakeup);
=20
 cy_as_return_status_t
 cy_as_usb_set_m_s_report_threshold(cy_as_device_handle handle,
@@ -3482,6 +3503,7 @@ destroy:
=20
 =A0=A0=A0 return ret;
 }
+EXPORT_SYMBOL(cy_as_usb_set_m_s_report_threshold);
=20
 cy_as_return_status_t
 cy_as_usb_select_m_s_partitions(
@@ -3563,6 +3585,7 @@ destroy:
=20
 =A0=A0=A0 return ret;
 }
+EXPORT_SYMBOL(cy_as_usb_select_m_s_partitions);
=20
 static void
 cy_as_usb_func_callback(
diff -uprN -X linux-2.6.37_vanilla/Documentation/dontdiff linux-2.6.37_=
vanilla/drivers/staging/westbridge/astoria/device/cyandevice_export.h l=
inux-2.6.37-wb/drivers/staging/westbridge/astoria/device/cyandevice_exp=
ort.h
--- linux-2.6.37_vanilla/drivers/staging/westbridge/astoria/device/cyan=
device_export.h=A0=A0=A0 2010-11-29 20:42:04.000000000 -0800
+++ linux-2.6.37-wb/drivers/staging/westbridge/astoria/device/cyandevic=
e_export.h=A0=A0=A0 1969-12-31 16:00:00.000000000 -0800
@@ -1,132 +0,0 @@
-/*
-## cyandevice_export.h - Linux Antioch device driver file
-##
-## =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
-## Copyright (C) 2010=A0 Cypress Semiconductor
-##
-## This program is free software; you can redistribute it and/or
-## modify it under the terms of the GNU General Public License
-## as published by the Free Software Foundation; either version 2
-## of the License, or (at your option) any later version.
-##
-## This program is distributed in the hope that it will be useful,
-## but WITHOUT ANY WARRANTY; without even the implied warranty of
-## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.=A0 See the
-## GNU General Public License for more details.
-##
-## You should have received a copy of the GNU General Public License
-## along with this program; if not, write to the Free Software
-## Foundation, Inc., 51 Franklin Street
-## Fifth Floor, Boston, MA=A0 02110-1301, USA.
-## =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
-*/
-
-/*
- * Export Misc APIs that can be used from the other driver modules.
- * The APIs to create a device handle and download firmware are not ex=
ported
- * because they are expected to be used only by this kernel module.
- */
-EXPORT_SYMBOL(cy_as_misc_get_firmware_version);
-EXPORT_SYMBOL(cy_as_misc_read_m_c_u_register);
-EXPORT_SYMBOL(cy_as_misc_reset);
-EXPORT_SYMBOL(cy_as_misc_acquire_resource);
-EXPORT_SYMBOL(cy_as_misc_release_resource);
-EXPORT_SYMBOL(cy_as_misc_enter_standby);
-EXPORT_SYMBOL(cy_as_misc_leave_standby);
-EXPORT_SYMBOL(cy_as_misc_enter_suspend);
-EXPORT_SYMBOL(cy_as_misc_leave_suspend);
-EXPORT_SYMBOL(cy_as_misc_storage_changed);
-EXPORT_SYMBOL(cy_as_misc_heart_beat_control);
-EXPORT_SYMBOL(cy_as_misc_get_gpio_value);
-EXPORT_SYMBOL(cy_as_misc_set_gpio_value);
-EXPORT_SYMBOL(cy_as_misc_set_low_speed_sd_freq);
-EXPORT_SYMBOL(cy_as_misc_set_high_speed_sd_freq);
-
-/*
- * Export the USB APIs that can be used by the dependent kernel module=
s.
- */
-EXPORT_SYMBOL(cy_as_usb_set_end_point_config);
-EXPORT_SYMBOL(cy_as_usb_read_data_async);
-EXPORT_SYMBOL(cy_as_usb_write_data_async);
-EXPORT_SYMBOL(cy_as_usb_cancel_async);
-EXPORT_SYMBOL(cy_as_usb_set_stall);
-EXPORT_SYMBOL(cy_as_usb_clear_stall);
-EXPORT_SYMBOL(cy_as_usb_connect);
-EXPORT_SYMBOL(cy_as_usb_disconnect);
-EXPORT_SYMBOL(cy_as_usb_start);
-EXPORT_SYMBOL(cy_as_usb_stop);
-EXPORT_SYMBOL(cy_as_usb_set_enum_config);
-EXPORT_SYMBOL(cy_as_usb_get_enum_config);
-EXPORT_SYMBOL(cy_as_usb_set_physical_configuration);
-EXPORT_SYMBOL(cy_as_usb_register_callback);
-EXPORT_SYMBOL(cy_as_usb_commit_config);
-EXPORT_SYMBOL(cy_as_usb_set_descriptor);
-EXPORT_SYMBOL(cy_as_usb_clear_descriptors);
-EXPORT_SYMBOL(cy_as_usb_get_descriptor);
-EXPORT_SYMBOL(cy_as_usb_get_end_point_config);
-EXPORT_SYMBOL(cy_as_usb_read_data);
-EXPORT_SYMBOL(cy_as_usb_write_data);
-EXPORT_SYMBOL(cy_as_usb_get_stall);
-EXPORT_SYMBOL(cy_as_usb_set_nak);
-EXPORT_SYMBOL(cy_as_usb_clear_nak);
-EXPORT_SYMBOL(cy_as_usb_get_nak);
-EXPORT_SYMBOL(cy_as_usb_signal_remote_wakeup);
-EXPORT_SYMBOL(cy_as_usb_set_m_s_report_threshold);
-EXPORT_SYMBOL(cy_as_usb_select_m_s_partitions);
-
-/*
- * Export all Storage APIs that can be used by dependent kernel module=
s.
- */
-EXPORT_SYMBOL(cy_as_storage_start);
-EXPORT_SYMBOL(cy_as_storage_stop);
-EXPORT_SYMBOL(cy_as_storage_register_callback);
-EXPORT_SYMBOL(cy_as_storage_query_bus);
-EXPORT_SYMBOL(cy_as_storage_query_media);
-EXPORT_SYMBOL(cy_as_storage_query_device);
-EXPORT_SYMBOL(cy_as_storage_query_unit);
-EXPORT_SYMBOL(cy_as_storage_device_control);
-EXPORT_SYMBOL(cy_as_storage_claim);
-EXPORT_SYMBOL(cy_as_storage_release);
-EXPORT_SYMBOL(cy_as_storage_read);
-EXPORT_SYMBOL(cy_as_storage_write);
-EXPORT_SYMBOL(cy_as_storage_read_async);
-EXPORT_SYMBOL(cy_as_storage_write_async);
-EXPORT_SYMBOL(cy_as_storage_cancel_async);
-EXPORT_SYMBOL(cy_as_storage_sd_register_read);
-EXPORT_SYMBOL(cy_as_storage_create_p_partition);
-EXPORT_SYMBOL(cy_as_storage_remove_p_partition);
-EXPORT_SYMBOL(cy_as_storage_get_transfer_amount);
-EXPORT_SYMBOL(cy_as_storage_erase);
-
-EXPORT_SYMBOL(cy_as_sdio_query_card);
-EXPORT_SYMBOL(cy_as_sdio_init_function);
-EXPORT_SYMBOL(cy_as_sdio_set_blocksize);
-EXPORT_SYMBOL(cy_as_sdio_direct_read);
-EXPORT_SYMBOL(cy_as_sdio_direct_write);
-EXPORT_SYMBOL(cy_as_sdio_extended_read);
-EXPORT_SYMBOL(cy_as_sdio_extended_write);
-
-EXPORT_SYMBOL(cy_as_hal_alloc);
-EXPORT_SYMBOL(cy_as_hal_free);
-EXPORT_SYMBOL(cy_as_hal_sleep);
-EXPORT_SYMBOL(cy_as_hal_create_sleep_channel);
-EXPORT_SYMBOL(cy_as_hal_destroy_sleep_channel);
-EXPORT_SYMBOL(cy_as_hal_sleep_on);
-EXPORT_SYMBOL(cy_as_hal_wake);
-EXPORT_SYMBOL(cy_as_hal_mem_set);
-
-EXPORT_SYMBOL(cy_as_mtp_storage_only_start);
-EXPORT_SYMBOL(cy_as_mtp_storage_only_stop);
-EXPORT_SYMBOL(cy_as_mtp_start);
-EXPORT_SYMBOL(cy_as_mtp_init_send_object);
-EXPORT_SYMBOL(cy_as_mtp_init_get_object);
-EXPORT_SYMBOL(cy_as_mtp_cancel_send_object);
-EXPORT_SYMBOL(cy_as_mtp_cancel_get_object);
-
-#ifdef __CY_ASTORIA_SCM_KERNEL_HAL__
-/* Functions in the SCM kernel HAL implementation only. */
-EXPORT_SYMBOL(cy_as_hal_enable_scatter_list);
-EXPORT_SYMBOL(cy_as_hal_disable_scatter_list);
-#endif
-
-/*[]*/
diff -uprN -X linux-2.6.37_vanilla/Documentation/dontdiff linux-2.6.37_=
vanilla/drivers/staging/westbridge/astoria/device/cyasdevice.c linux-2.=
6.37-wb/drivers/staging/westbridge/astoria/device/cyasdevice.c
--- linux-2.6.37_vanilla/drivers/staging/westbridge/astoria/device/cyas=
device.c=A0=A0=A0 2010-11-29 20:42:04.000000000 -0800
+++ linux-2.6.37-wb/drivers/staging/westbridge/astoria/device/cyasdevic=
e.c=A0=A0=A0 2011-01-19 14:01:39.139418883 -0800
@@ -40,9 +40,6 @@
 #include "../include/linux/westbridge/cyashal.h"
 #include "../include/linux/westbridge/cyasregs.h"
=20
-/* API exports include file */
-#include "cyandevice_export.h"
-
 typedef struct cyasdevice {
 =A0=A0=A0 =A0=A0=A0 /* Handle to the Antioch device */
 =A0=A0=A0 =A0=A0=A0 cy_as_device_handle=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 d=
ev_handle;



     =20
