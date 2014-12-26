From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] arm: omap: reduce zImage size on omap2plus_defconfig
Date: Fri, 26 Dec 2014 10:26:18 -0600
Message-ID: <20141226162618.GJ17430@saruman>
References: <1419271535-4057-1-git-send-email-balbi@ti.com>
 <54991A25.2030804@compulab.co.il>
 <20141223161936.GA9147@saruman>
 <549AA94A.8030209@compulab.co.il>
 <20141224154948.GA423@saruman>
 <20141224190401.GN23854@atomide.com>
 <549BE333.9060709@compulab.co.il>
 <549D5CC0.2090408@linaro.org>
 <20141226152620.GF17430@saruman>
 <20141226161349.GC12409@atomide.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/0U0QBNx7JIUZLHm"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:52237 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751086AbaLZQ1I (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 26 Dec 2014 11:27:08 -0500
Content-Disposition: inline
In-Reply-To: <20141226161349.GC12409@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Felipe Balbi <balbi@ti.com>, "Grygorii.Strashko@linaro.org" <grygorii.strashko@linaro.org>, Igor Grinberg <grinberg@compulab.co.il>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>

--/0U0QBNx7JIUZLHm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 26, 2014 at 08:13:49AM -0800, Tony Lindgren wrote:
> * Felipe Balbi <balbi@ti.com> [141226 07:29]:
> > On Fri, Dec 26, 2014 at 03:04:00PM +0200, Grygorii.Strashko@linaro.org =
wrote:
> > > >>>
> > > >>> Tony, your call
> > >=20
> > > May be it will be good thing to split this patch. That way more
> > > information will be stored in commit log about which set of options
> > > gives us what benefits.  And also, It will allow to continue with
> > > agreed changes.  ?
> >=20
> > can be done, but then again, it's just a defconfig change. Tony, your
> > call.
> >=20
> > > >> I think we should move omap2plus_defconfig to be mostly modular and
> > > >> usable for distros as a base. Most distros prefer to build almost
> > > >> everything as loadable modules. And my preference is that we should
> > > >> only keep the minimum rootfs for devices and serial support as
> > > >> built-in and rely on initramfs for most drivers. And slowly move
> > > >> also the remaining built-in drivers to be loadable modules.
> > > >>
> > > >> The reasons for having drivers as loadable modules are many. It
> > > >> allows distros to use the same kernel for all the devices without
> > > >> bloating the kernel. It makes developing drivers easier as just the
> > > >> module needs to be reloaded. And loadable modules protect us from
> > > >> cross-framework spaghetti calls in the kernel as the interfaces are
> > > >> clearly defined.
> > > >>
> > > >> Are there people really using SATA as rootfs right now on omaps?
> > > >=20
> > > > Yes. That is exactly my point.
> > > >=20
> > >=20
> > > From my side I'd like to note that I know about few ongoing projects
> > > on DRA7x EVM where SATA is used as rootfs - now It is the fast
> > > possible way to start Android.
> >=20
> > now this is something different. This is evidence that there are people
> > relying on SATA on rootfs. I'll leave to Tony again.
>=20
> OK sounds like people are really using SATA as rootfs, so we might as
> well keep it built in then. And it does not affect the PM on the devices
> that do have PM working, that has been a problem with having some
> drivers built-in.
>=20
> We can still work towards making the current rootfs device drivers
> into loadable modules in the long term :)

Here's v3:

8<-----------------------------------------------------------------------

=46rom 7e6d99cedb12004bad1205bbaf556ebf3db0f730 Mon Sep 17 00:00:00 2001
=46rom: Felipe Balbi <balbi@ti.com>
Date: Mon, 22 Dec 2014 11:56:27 -0600
Subject: [PATCH v3] arm: omap: reduce zImage size on omap2plus_defconfig

By converting a few drivers to modules because they
won't be needed during boot anyways, we can shave off
about 700KiB of text.

Note that while at that, and after discussions with Tony
Lindgren, a few extra drivers were either removed because
they weren't needed, or added because they're useful for
debugging/testing.

Below is output of size for pre and post vmlinux binaries:

   text    data     bss     dec     hex filename
8514799  765532 8416064 17696395        10e068b vmlinux-post-patch
9069110  800316 8419072 18288498        1170f72 vmlinux-pre-patch

Signed-off-by: Felipe Balbi <balbi@ti.com>
---

changes since v1:
        - leave TWL4030 gpio alone

changes since v2:
	- leave SATA as built-in

 arch/arm/configs/omap2plus_defconfig | 116 ++++++++++++++++++++++---------=
----
 1 file changed, 72 insertions(+), 44 deletions(-)

diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2p=
lus_defconfig
index c2c3a85..efb0810 100644
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -13,7 +13,6 @@ CONFIG_CGROUP_FREEZER=3Dy
 CONFIG_CGROUP_DEVICE=3Dy
 CONFIG_CPUSETS=3Dy
 CONFIG_CGROUP_CPUACCT=3Dy
-CONFIG_RESOURCE_COUNTERS=3Dy
 CONFIG_MEMCG=3Dy
 CONFIG_MEMCG_SWAP=3Dy
 CONFIG_MEMCG_KMEM=3Dy
@@ -68,7 +67,6 @@ CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND=3Dy
 CONFIG_CPU_FREQ_GOV_POWERSAVE=3Dy
 CONFIG_CPU_FREQ_GOV_USERSPACE=3Dy
 CONFIG_CPU_FREQ_GOV_CONSERVATIVE=3Dy
-CONFIG_GENERIC_CPUFREQ_CPU0=3Dy
 # CONFIG_ARM_OMAP2PLUS_CPUFREQ is not set
 CONFIG_CPU_IDLE=3Dy
 CONFIG_BINFMT_MISC=3Dy
@@ -103,7 +101,7 @@ CONFIG_DEVTMPFS=3Dy
 CONFIG_DEVTMPFS_MOUNT=3Dy
 CONFIG_DMA_CMA=3Dy
 CONFIG_OMAP_OCP2SCP=3Dy
-CONFIG_CONNECTOR=3Dy
+CONFIG_CONNECTOR=3Dm
 CONFIG_MTD=3Dy
 CONFIG_MTD_CMDLINE_PARTS=3Dy
 CONFIG_MTD_BLOCK=3Dy
@@ -122,14 +120,12 @@ CONFIG_BLK_DEV_RAM=3Dy
 CONFIG_BLK_DEV_RAM_SIZE=3D16384
 CONFIG_SENSORS_TSL2550=3Dm
 CONFIG_BMP085_I2C=3Dm
-CONFIG_SENSORS_LIS3_I2C=3Dm
 CONFIG_SRAM=3Dy
-CONFIG_SCSI=3Dy
+CONFIG_SENSORS_LIS3_I2C=3Dm
 CONFIG_BLK_DEV_SD=3Dy
 CONFIG_SCSI_SCAN_ASYNC=3Dy
 CONFIG_ATA=3Dy
 CONFIG_SATA_AHCI_PLATFORM=3Dy
-CONFIG_MD=3Dy
 CONFIG_NETDEVICES=3Dy
 # CONFIG_NET_VENDOR_ARC is not set
 # CONFIG_NET_CADENCE is not set
@@ -154,8 +150,8 @@ CONFIG_TI_CPSW=3Dy
 # CONFIG_NET_VENDOR_WIZNET is not set
 CONFIG_AT803X_PHY=3Dy
 CONFIG_SMSC_PHY=3Dy
-CONFIG_USB_USBNET=3Dy
-CONFIG_USB_NET_SMSC95XX=3Dy
+CONFIG_USB_USBNET=3Dm
+CONFIG_USB_NET_SMSC95XX=3Dm
 CONFIG_USB_ALI_M5632=3Dy
 CONFIG_USB_AN2720=3Dy
 CONFIG_USB_EPSON2888=3Dy
@@ -172,18 +168,22 @@ CONFIG_WLCORE_SDIO=3Dm
 CONFIG_MWIFIEX=3Dm
 CONFIG_MWIFIEX_SDIO=3Dm
 CONFIG_MWIFIEX_USB=3Dm
-CONFIG_INPUT_JOYDEV=3Dy
-CONFIG_INPUT_EVDEV=3Dy
-CONFIG_KEYBOARD_GPIO=3Dy
+CONFIG_INPUT_JOYDEV=3Dm
+CONFIG_INPUT_EVDEV=3Dm
+CONFIG_KEYBOARD_ATKBD=3Dm
+CONFIG_KEYBOARD_GPIO=3Dm
 CONFIG_KEYBOARD_MATRIX=3Dm
-CONFIG_KEYBOARD_TWL4030=3Dy
+CONFIG_KEYBOARD_OMAP4=3Dm
+CONFIG_KEYBOARD_TWL4030=3Dm
+# CONFIG_INPUT_MOUSE is not set
 CONFIG_INPUT_TOUCHSCREEN=3Dy
 CONFIG_TOUCHSCREEN_ADS7846=3Dm
 CONFIG_TOUCHSCREEN_EDT_FT5X06=3Dm
 CONFIG_TOUCHSCREEN_TSC2005=3Dm
 CONFIG_TOUCHSCREEN_TSC2007=3Dm
 CONFIG_INPUT_MISC=3Dy
-CONFIG_INPUT_TWL4030_PWRBUTTON=3Dy
+CONFIG_INPUT_TWL4030_PWRBUTTON=3Dm
+CONFIG_SERIO=3Dm
 # CONFIG_LEGACY_PTYS is not set
 CONFIG_SERIAL_8250=3Dy
 CONFIG_SERIAL_8250_CONSOLE=3Dy
@@ -196,15 +196,16 @@ CONFIG_SERIAL_8250_RSA=3Dy
 CONFIG_SERIAL_OF_PLATFORM=3Dy
 CONFIG_SERIAL_OMAP=3Dy
 CONFIG_SERIAL_OMAP_CONSOLE=3Dy
-CONFIG_HW_RANDOM=3Dy
 CONFIG_I2C_CHARDEV=3Dy
 CONFIG_SPI=3Dy
 CONFIG_SPI_OMAP24XX=3Dy
+CONFIG_SPI_TI_QSPI=3Dm
 CONFIG_PINCTRL_SINGLE=3Dy
 CONFIG_DEBUG_GPIO=3Dy
 CONFIG_GPIO_SYSFS=3Dy
 CONFIG_GPIO_TWL4030=3Dy
-CONFIG_W1=3Dy
+CONFIG_W1=3Dm
+CONFIG_HDQ_MASTER_OMAP=3Dm
 CONFIG_BATTERY_BQ27x00=3Dm
 CONFIG_CHARGER_ISP1704=3Dm
 CONFIG_CHARGER_TWL4030=3Dm
@@ -213,20 +214,21 @@ CONFIG_CHARGER_BQ24190=3Dm
 CONFIG_CHARGER_BQ24735=3Dm
 CONFIG_POWER_RESET=3Dy
 CONFIG_POWER_AVS=3Dy
+CONFIG_HWMON=3Dm
 CONFIG_SENSORS_LM75=3Dm
-CONFIG_THERMAL=3Dy
+CONFIG_SENSORS_TMP102=3Dm
+CONFIG_THERMAL=3Dm
 CONFIG_THERMAL_GOV_FAIR_SHARE=3Dy
 CONFIG_THERMAL_GOV_USER_SPACE=3Dy
 CONFIG_CPU_THERMAL=3Dy
-CONFIG_TI_SOC_THERMAL=3Dy
+CONFIG_TI_SOC_THERMAL=3Dm
 CONFIG_TI_THERMAL=3Dy
 CONFIG_OMAP4_THERMAL=3Dy
 CONFIG_OMAP5_THERMAL=3Dy
 CONFIG_DRA752_THERMAL=3Dy
 CONFIG_WATCHDOG=3Dy
-CONFIG_OMAP_WATCHDOG=3Dy
-CONFIG_TWL4030_WATCHDOG=3Dy
-CONFIG_MFD_SYSCON=3Dy
+CONFIG_OMAP_WATCHDOG=3Dm
+CONFIG_TWL4030_WATCHDOG=3Dm
 CONFIG_MFD_PALMAS=3Dy
 CONFIG_MFD_TPS65217=3Dy
 CONFIG_MFD_TPS65218=3Dy
@@ -289,51 +291,77 @@ CONFIG_SND_OMAP_SOC=3Dm
 CONFIG_SND_OMAP_SOC_OMAP_TWL4030=3Dm
 CONFIG_SND_OMAP_SOC_OMAP_ABE_TWL6040=3Dm
 CONFIG_SND_OMAP_SOC_OMAP3_PANDORA=3Dm
-CONFIG_USB=3Dy
+CONFIG_HID_GENERIC=3Dm
+CONFIG_USB_HIDDEV=3Dy
+CONFIG_USB_KBD=3Dm
+CONFIG_USB_MOUSE=3Dm
+CONFIG_USB=3Dm
 CONFIG_USB_ANNOUNCE_NEW_DEVICES=3Dy
-CONFIG_USB_MON=3Dy
+CONFIG_USB_MON=3Dm
 CONFIG_USB_XHCI_HCD=3Dm
-CONFIG_USB_WDM=3Dy
-CONFIG_USB_STORAGE=3Dy
+CONFIG_USB_WDM=3Dm
+CONFIG_USB_STORAGE=3Dm
+CONFIG_USB_MUSB_HDRC=3Dm
+CONFIG_USB_MUSB_OMAP2PLUS=3Dm
+CONFIG_USB_MUSB_AM35X=3Dm
+CONFIG_USB_MUSB_DSPS=3Dm
 CONFIG_USB_DWC3=3Dm
-CONFIG_USB_TEST=3Dy
+CONFIG_USB_TEST=3Dm
 CONFIG_AM335X_PHY_USB=3Dy
-CONFIG_USB_GADGET=3Dy
+CONFIG_USB_GADGET=3Dm
 CONFIG_USB_GADGET_DEBUG=3Dy
 CONFIG_USB_GADGET_DEBUG_FILES=3Dy
 CONFIG_USB_GADGET_DEBUG_FS=3Dy
+CONFIG_USB_CONFIGFS=3Dm
+CONFIG_USB_CONFIGFS_SERIAL=3Dy
+CONFIG_USB_CONFIGFS_ACM=3Dy
+CONFIG_USB_CONFIGFS_OBEX=3Dy
+CONFIG_USB_CONFIGFS_NCM=3Dy
+CONFIG_USB_CONFIGFS_ECM=3Dy
+CONFIG_USB_CONFIGFS_ECM_SUBSET=3Dy
+CONFIG_USB_CONFIGFS_RNDIS=3Dy
+CONFIG_USB_CONFIGFS_EEM=3Dy
+CONFIG_USB_CONFIGFS_MASS_STORAGE=3Dy
+CONFIG_USB_CONFIGFS_F_LB_SS=3Dy
+CONFIG_USB_CONFIGFS_F_FS=3Dy
+CONFIG_USB_CONFIGFS_F_UAC1=3Dy
+CONFIG_USB_CONFIGFS_F_UAC2=3Dy
+CONFIG_USB_CONFIGFS_F_MIDI=3Dy
+CONFIG_USB_CONFIGFS_F_HID=3Dy
 CONFIG_USB_ZERO=3Dm
 CONFIG_MMC=3Dy
 CONFIG_SDIO_UART=3Dy
 CONFIG_MMC_OMAP=3Dy
 CONFIG_MMC_OMAP_HS=3Dy
 CONFIG_NEW_LEDS=3Dy
-CONFIG_LEDS_CLASS=3Dy
-CONFIG_LEDS_GPIO=3Dy
+CONFIG_LEDS_CLASS=3Dm
+CONFIG_LEDS_GPIO=3Dm
 CONFIG_LEDS_TRIGGERS=3Dy
-CONFIG_LEDS_TRIGGER_TIMER=3Dy
-CONFIG_LEDS_TRIGGER_ONESHOT=3Dy
-CONFIG_LEDS_TRIGGER_HEARTBEAT=3Dy
-CONFIG_LEDS_TRIGGER_BACKLIGHT=3Dy
+CONFIG_LEDS_TRIGGER_TIMER=3Dm
+CONFIG_LEDS_TRIGGER_ONESHOT=3Dm
+CONFIG_LEDS_TRIGGER_HEARTBEAT=3Dm
+CONFIG_LEDS_TRIGGER_BACKLIGHT=3Dm
 CONFIG_LEDS_TRIGGER_CPU=3Dy
-CONFIG_LEDS_TRIGGER_GPIO=3Dy
-CONFIG_LEDS_TRIGGER_DEFAULT_ON=3Dy
+CONFIG_LEDS_TRIGGER_GPIO=3Dm
+CONFIG_LEDS_TRIGGER_DEFAULT_ON=3Dm
 CONFIG_RTC_CLASS=3Dy
 CONFIG_RTC_DRV_TWL92330=3Dy
-CONFIG_RTC_DRV_TWL4030=3Dy
-CONFIG_RTC_DRV_OMAP=3Dy
+CONFIG_RTC_DRV_TWL4030=3Dm
+CONFIG_RTC_DRV_OMAP=3Dm
 CONFIG_DMADEVICES=3Dy
 CONFIG_TI_EDMA=3Dy
 CONFIG_DMA_OMAP=3Dy
-CONFIG_EXTCON=3Dy
-CONFIG_EXTCON_PALMAS=3Dy
+# CONFIG_IOMMU_SUPPORT is not set
+CONFIG_EXTCON=3Dm
+CONFIG_EXTCON_PALMAS=3Dm
+CONFIG_TI_EMIF=3Dm
 CONFIG_PWM=3Dy
-CONFIG_PWM_TIECAP=3Dy
-CONFIG_PWM_TIEHRPWM=3Dy
-CONFIG_PWM_TWL=3Dy
-CONFIG_PWM_TWL_LED=3Dy
-CONFIG_OMAP_USB2=3Dy
-CONFIG_TI_PIPE3=3Dy
+CONFIG_PWM_TIECAP=3Dm
+CONFIG_PWM_TIEHRPWM=3Dm
+CONFIG_PWM_TWL=3Dm
+CONFIG_PWM_TWL_LED=3Dm
+CONFIG_OMAP_USB2=3Dm
+CONFIG_TI_PIPE3=3Dm
 CONFIG_EXT2_FS=3Dy
 CONFIG_EXT3_FS=3Dy
 # CONFIG_EXT3_FS_XATTR is not set
--=20
2.2.0


--=20
balbi

--/0U0QBNx7JIUZLHm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUnYwqAAoJEIaOsuA1yqRESVsP/2lkF00T9E6p4jmHfSK5g1hk
5oFMmAmIgFHus6YizmGrn2zCpVjsK5D/bYUzLV7BdA3SDh9NhAPOBTxXR2Sn2Aqs
+CJLATN1K+y9PaASmOIzvtoc1jzBy2NAtui3dgBZIWvzmfsBl90xI1ulVxLUeaL+
PQZLKE3F1y1RXp3oIV241GWzudXNT9hjXOJVfN5FZCkN0L8sBnAkr9Ofausk653w
Tqz0+J4Y9QO4NxC5pNdie8CXmuZWYjOyTMPb8URP/wHlcM9a28tbFW6kr1f5MYyW
FNxoWAPF2PQjTRDacIzRzG5DQxoT0ZDPYMs/SKIuI+LwNRE36Zfhta+1nZQ9Ap8g
j+jdK+liXsm/8kekM42+IMLxX+yOhh4N27HmFi5p9mtnqRNkExrptZLlr8FCA4Um
cZzdF+pZoxIyfqEp8RmqNEUdXtBf0KMta5Lj7obftqCpyBEVnXZbrZtp4VEO54tZ
rSLMrxkyZ6bsHTUKiSB6XonLEEyJRkIDV6cHh8LoqYYDuz0DF+/AdCQrLFwb7GPy
IdO5pi7897R7CsiwtxzDW+094dxHzXSN0c6uk1MHauGsH72DmrbyKEEjId46YiYk
MLunhuS9pm2VDcRrogGM8Q30uZ/ciPVE/lBDOBB/T1K5AiY8pC7cRm2+Cjnm3vNF
sOA7W7WQweMV+yTkb+eT
=NXLY
-----END PGP SIGNATURE-----

--/0U0QBNx7JIUZLHm--
