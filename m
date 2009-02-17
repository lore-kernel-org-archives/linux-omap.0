From: Philip Balister <philip@balister.org>
Subject: McSPI3 on the BeagleBoard
Date: Tue, 17 Feb 2009 18:42:28 -0500
Message-ID: <499B4B64.30109@balister.org>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature"; micalg=sha1; boundary="------------ms050201010707030201080302"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.geekisp.com ([216.168.135.169]:20062 "EHLO
	starfish.geekisp.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752097AbZBQXmc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 17 Feb 2009 18:42:32 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

This is a cryptographically signed message in MIME format.

--------------ms050201010707030201080302
Content-Type: multipart/mixed;
 boundary="------------010505030102000206020804"

This is a multi-part message in MIME format.
--------------010505030102000206020804
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

A number of people have tried using the McSPI3 interface with the spidev 
driver. Running the spidev_test program shows data coming out of the 
interface, but when we connect the SIMO to SOMI pins, the spidev_test 
program shows only 0's. Someone tried wiring SOMI to +volts and still 
only saw 0 read.

I'm attaching the patch used to configure the pinmux and the spidev 
driver. Any suggestions would be great, we are pretty confused at this 
point.

Thanks,

Philip

--------------010505030102000206020804
Content-Type: text/x-patch;
 name="spi-test.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="spi-test.patch"

diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
index fe97bab..ed7fee6 100644
--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -23,6 +23,7 @@
 #include <linux/gpio.h>
 #include <linux/input.h>
 #include <linux/gpio_keys.h>
+#include <linux/spi/spi.h>
 
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/partitions.h>
@@ -311,6 +312,27 @@ static struct platform_device *omap3_beagle_devices[] __initdata = {
 	&keys_gpio,
 };
 
+static struct spi_board_info beagle_spi_board_info[] = {
+	{
+		.modalias	= "spidev",
+		.max_speed_hz	= 48000000, //48 Mbps
+		.bus_num	= 3,
+		.chip_select	= 0,	
+		.mode = SPI_MODE_1,
+	},
+};
+
+static struct spi_board_info beagle_spi_board_info2[] = {
+	{
+		.modalias	= "spidev",
+		.max_speed_hz	= 48000000, //48 Mbps
+		.bus_num	= 4,
+		.chip_select	= 0,	
+		.mode = SPI_MODE_1,
+	},
+};
+
+
 static void __init omap3beagle_flash_init(void)
 {
 	u8 cs = 0;
@@ -358,6 +380,63 @@ static void __init omap3_beagle_init(void)
 	omap_board_config_size = ARRAY_SIZE(omap3_beagle_config);
 	omap_serial_init();
 
+	
+/*
+	printk("Debug ================> MMC2 >>> start\n");
+	omap_cfg_reg(XXX_3430_MMC2_CLK);
+	omap_cfg_reg(XXX_3430_MMC2_cmd);
+	omap_cfg_reg(XXX_3430_MMC2_dat0);
+	omap_cfg_reg(XXX_3430_MMC2_dat1);
+	omap_cfg_reg(XXX_3430_MMC2_dat2);
+	omap_cfg_reg(XXX_3430_MMC2_dat3);
+	omap_cfg_reg(XXX_3430_MMC2_dat4);
+	omap_cfg_reg(XXX_3430_MMC2_dat5);
+	omap_cfg_reg(XXX_3430_MMC2_dat6);
+	omap_cfg_reg(XXX_3430_MMC2_dat7);
+	printk("Debug ================> MMC2 >>> end\n");
+	printk("Debug ================> UART2 >>> start\n");
+	omap_cfg_reg(XXX_3430_UART2_cts);
+	omap_cfg_reg(XXX_3430_UART2_rts);
+	omap_cfg_reg(XXX_3430_UART2_tx);
+	omap_cfg_reg(XXX_3430_UART2_rx);
+	printk("Debug ================> UART2 >>> end\n");
+*/
+
+	printk("Debug ================> MCSPI >>> start\n");
+	
+	omap_cfg_reg(XXX_3430_MCSPI3_CLK);
+	omap_cfg_reg(XXX_3430_MCSPI3_SIMO);
+	omap_cfg_reg(XXX_3430_MCSPI3_SOMI);
+	omap_cfg_reg(XXX_3430_MCSPI3_CS0);
+	omap_cfg_reg(XXX_3430_MCSPI3_CS1);
+	//avoid other pins/balls with McSPI function
+	omap_cfg_reg(XXX_3430_gpio_88);
+	omap_cfg_reg(XXX_3430_gpio_89);
+	omap_cfg_reg(XXX_3430_gpio_90);
+	omap_cfg_reg(XXX_3430_gpio_91);
+	omap_cfg_reg(XXX_3430_gpio_92);
+	omap_cfg_reg(XXX_3430_gpio_14);
+	omap_cfg_reg(XXX_3430_gpio_15);
+	omap_cfg_reg(XXX_3430_gpio_16);
+	omap_cfg_reg(XXX_3430_gpio_17);
+	omap_cfg_reg(XXX_3430_gpio_21);
+
+	omap_cfg_reg(XXX_3430_MCSPI4_CLK);
+	omap_cfg_reg(XXX_3430_MCSPI4_SIMO);
+	omap_cfg_reg(XXX_3430_MCSPI4_SOMI);
+	omap_cfg_reg(XXX_3430_MCSPI4_CS0);
+	//avoid other pins/balls with McSPI function
+	omap_cfg_reg(XXX_3430_gpio_151);
+	printk("Debug ================> MCSPI >>> end\n");
+
+
+	printk("Debug ================> register SLAVE DEVICES using [spidev] protocol driver >>> start\n");
+	spi_register_board_info(beagle_spi_board_info, ARRAY_SIZE(beagle_spi_board_info));
+	spi_register_board_info(beagle_spi_board_info2, ARRAY_SIZE(beagle_spi_board_info2));
+	printk("Debug ================> register SLAVE DEVICES using [spidev] protocol driver >>> end\n");
+	omap_cfg_reg(XXX_3430_gpio_157); //add by yuchih
+
+
 	omap_cfg_reg(J25_34XX_GPIO170);
 	gpio_request(170, "DVI_nPD");
 	/* REVISIT leave DVI powered down until it's needed ... */
diff --git a/arch/arm/mach-omap2/mux.c b/arch/arm/mach-omap2/mux.c
index 1556688..9b55cf8 100644
--- a/arch/arm/mach-omap2/mux.c
+++ b/arch/arm/mach-omap2/mux.c
@@ -472,6 +472,87 @@ MUX_CFG_34XX("AF5_34XX_GPIO142", 0x170,
 MUX_CFG_34XX("AE5_34XX_GPIO143", 0x172,
 		OMAP34XX_MUX_MODE4 | OMAP34XX_PIN_OUTPUT)
 
+/* UART2 */
+MUX_CFG_34XX("XXX_3430_UART2_cts", 0x16c,
+		OMAP34XX_MUX_MODE1 | OMAP34XX_PIN_OUTPUT)
+MUX_CFG_34XX("XXX_3430_UART2_rts", 0x16e,
+		OMAP34XX_MUX_MODE1 | OMAP34XX_PIN_OUTPUT)
+MUX_CFG_34XX("XXX_3430_UART2_tx", 0x170,
+		OMAP34XX_MUX_MODE1 | OMAP34XX_PIN_OUTPUT)
+MUX_CFG_34XX("XXX_3430_UART2_rx", 0x172,
+		OMAP34XX_MUX_MODE1 | OMAP34XX_PIN_INPUT_PULLUP)
+
+/* MMC2 */
+MUX_CFG_34XX("XXX_3430_MMC2_CLK", 0x158,
+		OMAP34XX_MUX_MODE0 | OMAP34XX_PIN_INPUT)
+MUX_CFG_34XX("XXX_3430_MMC2_cmd", 0x15a,
+		OMAP34XX_MUX_MODE0 | OMAP34XX_PIN_INPUT)
+MUX_CFG_34XX("XXX_3430_MMC2_dat0", 0x15c,
+		OMAP34XX_MUX_MODE0 | OMAP34XX_PIN_INPUT)
+MUX_CFG_34XX("XXX_3430_MMC2_dat1", 0x15e,
+		OMAP34XX_MUX_MODE0 | OMAP34XX_PIN_INPUT)
+MUX_CFG_34XX("XXX_3430_MMC2_dat2", 0x160,
+		OMAP34XX_MUX_MODE0 | OMAP34XX_PIN_INPUT)
+MUX_CFG_34XX("XXX_3430_MMC2_dat3", 0x162,
+		OMAP34XX_MUX_MODE0 | OMAP34XX_PIN_INPUT)
+MUX_CFG_34XX("XXX_3430_MMC2_dat4", 0x164,
+		OMAP34XX_MUX_MODE0 | OMAP34XX_PIN_INPUT)
+MUX_CFG_34XX("XXX_3430_MMC2_dat5", 0x166,
+		OMAP34XX_MUX_MODE0 | OMAP34XX_PIN_INPUT)
+MUX_CFG_34XX("XXX_3430_MMC2_dat6", 0x168,
+		OMAP34XX_MUX_MODE0 | OMAP34XX_PIN_INPUT)
+MUX_CFG_34XX("XXX_3430_MMC2_dat7", 0x16a,
+		OMAP34XX_MUX_MODE0 | OMAP34XX_PIN_INPUT)
+
+/* MCSPI3 */
+MUX_CFG_34XX("XXX_3430_MCSPI3_CLK", 0x158,
+		OMAP34XX_MUX_MODE1 | OMAP34XX_PIN_OUTPUT)
+MUX_CFG_34XX("XXX_3430_MCSPI3_SIMO", 0x15a,
+		OMAP34XX_MUX_MODE1 | OMAP34XX_PIN_OUTPUT)
+MUX_CFG_34XX("XXX_3430_MCSPI3_SOMI", 0x15c,
+		OMAP34XX_MUX_MODE1 | OMAP34XX_PIN_INPUT_PULLUP)
+MUX_CFG_34XX("XXX_3430_MCSPI3_CS0", 0x162,
+		OMAP34XX_MUX_MODE1 | OMAP34XX_PIN_OUTPUT)
+MUX_CFG_34XX("XXX_3430_MCSPI3_CS1", 0x160,
+		OMAP34XX_MUX_MODE1 | OMAP34XX_PIN_OUTPUT)
+
+MUX_CFG_34XX("XXX_3430_gpio_88", 0x100, //mcspi3_clk
+		OMAP34XX_MUX_MODE4 | OMAP34XX_PIN_INPUT)
+MUX_CFG_34XX("XXX_3430_gpio_89", 0x102, //mcspi3_simo
+		OMAP34XX_MUX_MODE4 | OMAP34XX_PIN_INPUT)
+MUX_CFG_34XX("XXX_3430_gpio_90", 0x104, //mcspi3_somi
+		OMAP34XX_MUX_MODE4 | OMAP34XX_PIN_INPUT)
+MUX_CFG_34XX("XXX_3430_gpio_91", 0x106, //mcspi3_cs0
+		OMAP34XX_MUX_MODE4 | OMAP34XX_PIN_INPUT)
+MUX_CFG_34XX("XXX_3430_gpio_92", 0x108, //mcspi3_cs1
+		OMAP34XX_MUX_MODE4 | OMAP34XX_PIN_INPUT)
+
+MUX_CFG_34XX("XXX_3430_gpio_14", 0x5dc, //mcspi3_simo
+		OMAP34XX_MUX_MODE4 | OMAP34XX_PIN_INPUT)
+MUX_CFG_34XX("XXX_3430_gpio_15", 0x5de, //mcspi3_somi
+		OMAP34XX_MUX_MODE4 | OMAP34XX_PIN_INPUT)
+MUX_CFG_34XX("XXX_3430_gpio_16", 0x5e0, //mcspi3_cs0
+		OMAP34XX_MUX_MODE4 | OMAP34XX_PIN_INPUT)
+MUX_CFG_34XX("XXX_3430_gpio_17", 0x5e2, //mcspi3_clk
+		OMAP34XX_MUX_MODE4 | OMAP34XX_PIN_INPUT)
+MUX_CFG_34XX("XXX_3430_gpio_21", 0x5ea, //mcspi3_cs1
+		OMAP34XX_MUX_MODE4 | OMAP34XX_PIN_INPUT)
+/* MCSPI4 */
+MUX_CFG_34XX("XXX_3430_MCSPI4_CLK", 0x18c,
+		OMAP34XX_MUX_MODE1 | OMAP34XX_PIN_OUTPUT)
+MUX_CFG_34XX("XXX_3430_MCSPI4_SIMO", 0x190,
+		OMAP34XX_MUX_MODE1 | OMAP34XX_PIN_OUTPUT)
+MUX_CFG_34XX("XXX_3430_MCSPI4_SOMI", 0x192,
+		OMAP34XX_MUX_MODE1 | OMAP34XX_PIN_INPUT_PULLUP)
+MUX_CFG_34XX("XXX_3430_MCSPI4_CS0", 0x196,
+		OMAP34XX_MUX_MODE1 | OMAP34XX_PIN_OUTPUT)
+MUX_CFG_34XX("XXX_3430_gpio_151", 0x182,
+		OMAP34XX_MUX_MODE4 | OMAP34XX_PIN_INPUT)
+
+/* GPIO */
+MUX_CFG_34XX("XXX_3430_gpio_157", 0x18e,
+		OMAP34XX_MUX_MODE4 | OMAP34XX_PIN_INPUT)
+
 };
 
 #define OMAP34XX_PINS_SZ	ARRAY_SIZE(omap34xx_pins)
@@ -494,6 +575,7 @@ static void __init_or_module omap2_cfg_debug(const struct pin_config *cfg, u16 r
 
 #ifdef	CONFIG_OMAP_MUX_DEBUG
 	debug = cfg->debug;
+	debug = 1; //add by yuchih
 #endif
 	warn = (orig != reg);
 	if (debug || warn)
@@ -540,6 +622,9 @@ static int __init_or_module omap34xx_cfg_reg(const struct pin_config *cfg)
 	reg |= cfg->mux_val;
 	omap2_cfg_debug(cfg, reg);
 	omap_ctrl_writew(reg, cfg->mux_reg);
+	
+	omap2_cfg_debug(cfg, reg); //add by yuchih
+	
 	spin_unlock_irqrestore(&mux_spin_lock, flags);
 
 	return 0;
diff --git a/arch/arm/plat-omap/include/mach/mux.h b/arch/arm/plat-omap/include/mach/mux.h
index 67fddec..3dea82e 100644
--- a/arch/arm/plat-omap/include/mach/mux.h
+++ b/arch/arm/plat-omap/include/mach/mux.h
@@ -795,7 +795,54 @@ enum omap34xx_index {
 	AF6_34XX_GPIO140_UP,
 	AE6_34XX_GPIO141,
 	AF5_34XX_GPIO142,
-	AE5_34XX_GPIO143
+	AE5_34XX_GPIO143,
+
+
+	/* UART2 */
+	XXX_3430_UART2_cts,
+	XXX_3430_UART2_rts,
+	XXX_3430_UART2_tx,
+	XXX_3430_UART2_rx,
+
+	/* MMC2 */
+	XXX_3430_MMC2_CLK,
+	XXX_3430_MMC2_cmd,
+	XXX_3430_MMC2_dat0,
+	XXX_3430_MMC2_dat1,
+	XXX_3430_MMC2_dat2,
+	XXX_3430_MMC2_dat3,
+	XXX_3430_MMC2_dat4,
+	XXX_3430_MMC2_dat5,
+	XXX_3430_MMC2_dat6,
+	XXX_3430_MMC2_dat7,
+
+	/* MCSPI3 */
+	XXX_3430_MCSPI3_CLK,
+	XXX_3430_MCSPI3_SIMO,
+	XXX_3430_MCSPI3_SOMI,
+	XXX_3430_MCSPI3_CS0,
+	XXX_3430_MCSPI3_CS1,
+	XXX_3430_gpio_88,
+	XXX_3430_gpio_89,
+	XXX_3430_gpio_90,
+	XXX_3430_gpio_91,
+	XXX_3430_gpio_92,
+	XXX_3430_gpio_14,
+	XXX_3430_gpio_15,
+	XXX_3430_gpio_16,
+	XXX_3430_gpio_17,
+	XXX_3430_gpio_21,
+
+	/* MCSPI4 */
+	XXX_3430_MCSPI4_CLK,
+	XXX_3430_MCSPI4_SIMO,
+	XXX_3430_MCSPI4_SOMI,
+	XXX_3430_MCSPI4_CS0,
+	XXX_3430_gpio_151, //mcspi_clk
+	
+	/* GPIO*/
+	XXX_3430_gpio_157
+
 };
 
 struct omap_mux_cfg {

--------------010505030102000206020804--

--------------ms050201010707030201080302
Content-Type: application/x-pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIIJRTCC
Av0wggJmoAMCAQICEHW4VJIUQV0u11NnfLpF2IUwDQYJKoZIhvcNAQEFBQAwYjELMAkGA1UE
BhMCWkExJTAjBgNVBAoTHFRoYXd0ZSBDb25zdWx0aW5nIChQdHkpIEx0ZC4xLDAqBgNVBAMT
I1RoYXd0ZSBQZXJzb25hbCBGcmVlbWFpbCBJc3N1aW5nIENBMB4XDTA4MDQxNDE5MTkzMVoX
DTA5MDQxNDE5MTkzMVowYjERMA8GA1UEBBMIQmFsaXN0ZXIxDzANBgNVBCoTBlBoaWxpcDEY
MBYGA1UEAxMPUGhpbGlwIEJhbGlzdGVyMSIwIAYJKoZIhvcNAQkBFhNwaGlsaXBAYmFsaXN0
ZXIub3JnMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAxyNViPlSmMq2Kl4m7iDB
I3gB7Pwhg+4vnXCKEF3qIoLwNDVl27CP8RY0umjENzykOR6ZhzYx4fH8arNV5+nlXsH8KNnb
Dpd5ICTZvbUJdt1gPETmLczGy4hh8woCu7qodyy7YZcGMiUY5LxoL7vIQHysir4rbMRV/JId
mhKfFrHb+glDe8XbfTJ3xKO+BsMgLDaSiRMelH6uFLAVv9oRoIJxHQhwKLvlrOSQj+ek2fL6
83BzOUsM4BN/fiwvtJ/y3doVEoKUp8ippOXrwLAXFPprPAAdIydqufTxHotooFqbQzqSJv4c
TNDTxf2fg9YfH2RAs8vTdc/wgIVlL8fJnQIDAQABozAwLjAeBgNVHREEFzAVgRNwaGlsaXBA
YmFsaXN0ZXIub3JnMAwGA1UdEwEB/wQCMAAwDQYJKoZIhvcNAQEFBQADgYEASFC7i4DqutUT
ifbyNtEe+e9bqgqWUScDFl0BTV5fFVBX/mFpM3RBZJfq+iM5q0L7qont3sGaXG0cdVvRk2dk
uV2i0HwkmTLJ4HTLMyJ57BjMJWY9ydDiY+Ai1pINmjIgq/qI0aireByqNee68q+PaWE7bfW1
XvfqZD56QunCijswggL9MIICZqADAgECAhB1uFSSFEFdLtdTZ3y6RdiFMA0GCSqGSIb3DQEB
BQUAMGIxCzAJBgNVBAYTAlpBMSUwIwYDVQQKExxUaGF3dGUgQ29uc3VsdGluZyAoUHR5KSBM
dGQuMSwwKgYDVQQDEyNUaGF3dGUgUGVyc29uYWwgRnJlZW1haWwgSXNzdWluZyBDQTAeFw0w
ODA0MTQxOTE5MzFaFw0wOTA0MTQxOTE5MzFaMGIxETAPBgNVBAQTCEJhbGlzdGVyMQ8wDQYD
VQQqEwZQaGlsaXAxGDAWBgNVBAMTD1BoaWxpcCBCYWxpc3RlcjEiMCAGCSqGSIb3DQEJARYT
cGhpbGlwQGJhbGlzdGVyLm9yZzCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAMcj
VYj5UpjKtipeJu4gwSN4Aez8IYPuL51wihBd6iKC8DQ1Zduwj/EWNLpoxDc8pDkemYc2MeHx
/GqzVefp5V7B/CjZ2w6XeSAk2b21CXbdYDxE5i3MxsuIYfMKAru6qHcsu2GXBjIlGOS8aC+7
yEB8rIq+K2zEVfySHZoSnxax2/oJQ3vF230yd8SjvgbDICw2kokTHpR+rhSwFb/aEaCCcR0I
cCi75azkkI/npNny+vNwczlLDOATf34sL7Sf8t3aFRKClKfIqaTl68CwFxT6azwAHSMnarn0
8R6LaKBam0M6kib+HEzQ08X9n4PWHx9kQLPL03XP8ICFZS/HyZ0CAwEAAaMwMC4wHgYDVR0R
BBcwFYETcGhpbGlwQGJhbGlzdGVyLm9yZzAMBgNVHRMBAf8EAjAAMA0GCSqGSIb3DQEBBQUA
A4GBAEhQu4uA6rrVE4n28jbRHvnvW6oKllEnAxZdAU1eXxVQV/5haTN0QWSX6vojOatC+6qJ
7d7BmlxtHHVb0ZNnZLldotB8JJkyyeB0yzMieewYzCVmPcnQ4mPgItaSDZoyIKv6iNGoq3gc
qjXnuvKvj2lhO231tV736mQ+ekLpwoo7MIIDPzCCAqigAwIBAgIBDTANBgkqhkiG9w0BAQUF
ADCB0TELMAkGA1UEBhMCWkExFTATBgNVBAgTDFdlc3Rlcm4gQ2FwZTESMBAGA1UEBxMJQ2Fw
ZSBUb3duMRowGAYDVQQKExFUaGF3dGUgQ29uc3VsdGluZzEoMCYGA1UECxMfQ2VydGlmaWNh
dGlvbiBTZXJ2aWNlcyBEaXZpc2lvbjEkMCIGA1UEAxMbVGhhd3RlIFBlcnNvbmFsIEZyZWVt
YWlsIENBMSswKQYJKoZIhvcNAQkBFhxwZXJzb25hbC1mcmVlbWFpbEB0aGF3dGUuY29tMB4X
DTAzMDcxNzAwMDAwMFoXDTEzMDcxNjIzNTk1OVowYjELMAkGA1UEBhMCWkExJTAjBgNVBAoT
HFRoYXd0ZSBDb25zdWx0aW5nIChQdHkpIEx0ZC4xLDAqBgNVBAMTI1RoYXd0ZSBQZXJzb25h
bCBGcmVlbWFpbCBJc3N1aW5nIENBMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDEpjxV
c1X7TrnKmVoeaMB1BHCd3+n/ox7svc31W/Iadr1/DDph8r9RzgHU5VAKMNcCY1osiRVwjt3J
8CuFWqo/cVbLrzwLB+fxH5E2JCoTzyvV84J3PQO+K/67GD4Hv0CAAmTXp6a7n2XRxSpUhQ9I
BH+nttE8YQRAHmQZcmC3+wIDAQABo4GUMIGRMBIGA1UdEwEB/wQIMAYBAf8CAQAwQwYDVR0f
BDwwOjA4oDagNIYyaHR0cDovL2NybC50aGF3dGUuY29tL1RoYXd0ZVBlcnNvbmFsRnJlZW1h
aWxDQS5jcmwwCwYDVR0PBAQDAgEGMCkGA1UdEQQiMCCkHjAcMRowGAYDVQQDExFQcml2YXRl
TGFiZWwyLTEzODANBgkqhkiG9w0BAQUFAAOBgQBIjNFQg+oLLswNo2asZw9/r6y+whehQ5aU
nX9MIbj4Nh+qLZ82L8D0HFAgk3A8/a3hYWLD2ToZfoSxmRsAxRoLgnSeJVCUYsfbJ3FXJY3d
qZw5jowgT2Vfldr394fWxghOrvbqNOUQGls1TXfjViF4gtwhGTXeJLHTHUb/XV9lTzGCA2Qw
ggNgAgEBMHYwYjELMAkGA1UEBhMCWkExJTAjBgNVBAoTHFRoYXd0ZSBDb25zdWx0aW5nIChQ
dHkpIEx0ZC4xLDAqBgNVBAMTI1RoYXd0ZSBQZXJzb25hbCBGcmVlbWFpbCBJc3N1aW5nIENB
AhB1uFSSFEFdLtdTZ3y6RdiFMAkGBSsOAwIaBQCgggHDMBgGCSqGSIb3DQEJAzELBgkqhkiG
9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTA5MDIxNzIzNDIyOFowIwYJKoZIhvcNAQkEMRYEFE/f
WV6hzvsXsrA9qV4N3ZAXeatMMFIGCSqGSIb3DQEJDzFFMEMwCgYIKoZIhvcNAwcwDgYIKoZI
hvcNAwICAgCAMA0GCCqGSIb3DQMCAgFAMAcGBSsOAwIHMA0GCCqGSIb3DQMCAgEoMIGFBgkr
BgEEAYI3EAQxeDB2MGIxCzAJBgNVBAYTAlpBMSUwIwYDVQQKExxUaGF3dGUgQ29uc3VsdGlu
ZyAoUHR5KSBMdGQuMSwwKgYDVQQDEyNUaGF3dGUgUGVyc29uYWwgRnJlZW1haWwgSXNzdWlu
ZyBDQQIQdbhUkhRBXS7XU2d8ukXYhTCBhwYLKoZIhvcNAQkQAgsxeKB2MGIxCzAJBgNVBAYT
AlpBMSUwIwYDVQQKExxUaGF3dGUgQ29uc3VsdGluZyAoUHR5KSBMdGQuMSwwKgYDVQQDEyNU
aGF3dGUgUGVyc29uYWwgRnJlZW1haWwgSXNzdWluZyBDQQIQdbhUkhRBXS7XU2d8ukXYhTAN
BgkqhkiG9w0BAQEFAASCAQB+wwY/dUp83dUETK6q53Kg36uEd/LBvnySjYfvM+QN4jRM3nck
aGQlAfHOBRw9z3yiiIYx6vZpxHHOUnNZh6X3X1TWs1A/FV6Xcf6ZbGqKTrAbkbVwSAfO/B+5
ukxdDL660sUeDNDoBavQ/Ucu/O4EqjkEVkdfV+90xLXJ+Jnjb6PaCZxmqMUuG9PuTfpRkC03
tKSq+8SWUBDpom4vG5m3BjkZOv38v40x6Skza5ci2w+YxoRZILLT2d4t8RDor5iTcUeNiyzP
U12UgIuEtyY5pyoZYN+ctQiE/4AAHXbWvObevMPq3cmhQCsl0BqM7Ku44Jhw4oj4IbLbRfAk
jOZ4AAAAAAAA
--------------ms050201010707030201080302--
