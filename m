From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [PATCH 4/4] OMAP: AM3517: Enable DSS2 for AM3517EVM board
Date: Wed, 13 Jan 2010 17:18:33 +0530
Message-ID: <19F8576C6E063C45BE387C64729E7394044A4716F7@dbde02.ent.ti.com>
References: <hvaibhav@ti.com>
	 <1262615657-22723-5-git-send-email-hvaibhav@ti.com>
 <1263372401.2087.91.camel@tubuntu.research.nokia.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="_002_19F8576C6E063C45BE387C64729E7394044A4716F7dbde02enttico_"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:57831 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751832Ab0AMLt6 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 13 Jan 2010 06:49:58 -0500
In-Reply-To: <1263372401.2087.91.camel@tubuntu.research.nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@Nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>

--_002_19F8576C6E063C45BE387C64729E7394044A4716F7dbde02enttico_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable


> -----Original Message-----
> From: Tomi Valkeinen [mailto:tomi.valkeinen@Nokia.com]
> Sent: Wednesday, January 13, 2010 2:17 PM
> To: Hiremath, Vaibhav
> Cc: linux-omap@vger.kernel.org; tony@atomide.com
> Subject: Re: [PATCH 4/4] OMAP: AM3517: Enable DSS2 for AM3517EVM
> board
>=20
> Hi,
>=20
> I applied these two to my tree:
> [PATCH 2/4] OMAP: DSS2: Add Sharp LQ043T1DG01 panel drivers
> [PATCH 3/4] OMAP: Enable DSS2 for OMAP3EVM board
>=20
[Hiremath, Vaibhav] Great and Thanks.

> But this patch doesn't apply, I guess the below mentioned I2C stuff
> is
> missing from the linus' tree.
>=20
[Hiremath, Vaibhav] Yes, as I mentioned, the I2C patches are still now pres=
ent under Linus's tree.=20

I have attached patch which should get applied cleanly.

Thanks,
Vaibhav

>  Tomi
>=20
>=20
> On Mon, 2010-01-04 at 15:34 +0100, ext hvaibhav@ti.com wrote:
> > From: Vaibhav Hiremath <hvaibhav@ti.com>
> >
> > This patch is dependent on I2C interface support patch, since both
> > the patch series modifies same file (board-am3517evm.c) file.
> Please refer to
> > the link -
> >
> > http://marc.info/?l=3Dlinux-omap&m=3D126261461106778&w=3D2
> >
> > Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
> > ---
> >  arch/arm/configs/am3517_evm_defconfig |   52 ++++++++++++-
> >  arch/arm/mach-omap2/board-am3517evm.c |  144
> +++++++++++++++++++++++++++++++++
> >  2 files changed, 195 insertions(+), 1 deletions(-)
> >
> > diff --git a/arch/arm/configs/am3517_evm_defconfig
> b/arch/arm/configs/am3517_evm_defconfig
> > index abe9966..859f352 100644
> > --- a/arch/arm/configs/am3517_evm_defconfig
> > +++ b/arch/arm/configs/am3517_evm_defconfig
> > @@ -653,7 +653,57 @@ CONFIG_SSB_POSSIBLE=3Dy
> >  #
> >  # CONFIG_VGASTATE is not set
> >  # CONFIG_VIDEO_OUTPUT_CONTROL is not set
> > -# CONFIG_FB is not set
> > +CONFIG_FB=3Dy
> > +# CONFIG_FIRMWARE_EDID is not set
> > +# CONFIG_FB_DDC is not set
> > +# CONFIG_FB_BOOT_VESA_SUPPORT is not set
> > +CONFIG_FB_CFB_FILLRECT=3Dy
> > +CONFIG_FB_CFB_COPYAREA=3Dy
> > +CONFIG_FB_CFB_IMAGEBLIT=3Dy
> > +# CONFIG_FB_CFB_REV_PIXELS_IN_BYTE is not set
> > +# CONFIG_FB_SYS_FILLRECT is not set
> > +# CONFIG_FB_SYS_COPYAREA is not set
> > +# CONFIG_FB_SYS_IMAGEBLIT is not set
> > +# CONFIG_FB_FOREIGN_ENDIAN is not set
> > +# CONFIG_FB_SYS_FOPS is not set
> > +# CONFIG_FB_SVGALIB is not set
> > +# CONFIG_FB_MACMODES is not set
> > +# CONFIG_FB_BACKLIGHT is not set
> > +# CONFIG_FB_MODE_HELPERS is not set
> > +# CONFIG_FB_TILEBLITTING is not set
> > +
> > +#
> > +# Frame buffer hardware drivers
> > +#
> > +# CONFIG_FB_ARMCLCD is not set
> > +# CONFIG_FB_S1D13XXX is not set
> > +# CONFIG_FB_VIRTUAL is not set
> > +# CONFIG_FB_METRONOME is not set
> > +# CONFIG_FB_MB862XX is not set
> > +# CONFIG_FB_BROADSHEET is not set
> > +# CONFIG_FB_OMAP_BOOTLOADER_INIT is not set
> > +CONFIG_OMAP2_VRAM=3Dy
> > +CONFIG_OMAP2_VRFB=3Dy
> > +CONFIG_OMAP2_DSS=3Dy
> > +CONFIG_OMAP2_VRAM_SIZE=3D4
> > +CONFIG_OMAP2_DSS_DEBUG_SUPPORT=3Dy
> > +# CONFIG_OMAP2_DSS_RFBI is not set
> > +CONFIG_OMAP2_DSS_VENC=3Dy
> > +# CONFIG_OMAP2_DSS_SDI is not set
> > +# CONFIG_OMAP2_DSS_DSI is not set
> > +# CONFIG_OMAP2_DSS_FAKE_VSYNC is not set
> > +CONFIG_OMAP2_DSS_MIN_FCK_PER_PCK=3D4
> > +CONFIG_FB_OMAP2=3Dy
> > +CONFIG_FB_OMAP2_DEBUG_SUPPORT=3Dy
> > +# CONFIG_FB_OMAP2_FORCE_AUTO_UPDATE is not set
> > +CONFIG_FB_OMAP2_NUM_FBS=3D3
> > +
> > +#
> > +# OMAP2/3 Display Device Drivers
> > +#
> > +CONFIG_PANEL_GENERIC=3Dy
> > +# CONFIG_PANEL_SHARP_LS037V7DW01 is not set
> > +CONFIG_PANEL_SHARP_LQ043T1DG01=3Dy
> >  # CONFIG_BACKLIGHT_LCD_SUPPORT is not set
> >
> >  #
> > diff --git a/arch/arm/mach-omap2/board-am3517evm.c
> b/arch/arm/mach-omap2/board-am3517evm.c
> > index e85243e..b924f15 100644
> > --- a/arch/arm/mach-omap2/board-am3517evm.c
> > +++ b/arch/arm/mach-omap2/board-am3517evm.c
> > @@ -32,12 +32,153 @@
> >  #include <plat/common.h>
> >  #include <plat/control.h>
> >  #include <plat/usb.h>
> > +#include <plat/display.h>
> >
> >  #include <media/tvp514x.h>
> >  #include <media/ti-media/vpfe_capture.h>
> >
> >  #include "mux.h"
> >
> > +#define LCD_PANEL_PWR		176
> > +#define LCD_PANEL_BKLIGHT_PWR	182
> > +#define LCD_PANEL_PWM		181
> > +
> > +static int lcd_enabled;
> > +static int dvi_enabled;
> > +
> > +static void __init am3517_evm_display_init(void)
> > +{
> > +	int r;
> > +
> > +	omap_mux_init_gpio(LCD_PANEL_PWR, OMAP_PIN_INPUT_PULLUP);
> > +	omap_mux_init_gpio(LCD_PANEL_BKLIGHT_PWR,
> OMAP_PIN_INPUT_PULLDOWN);
> > +	omap_mux_init_gpio(LCD_PANEL_PWM, OMAP_PIN_INPUT_PULLDOWN);
> > +	/*
> > +	 * Enable GPIO 182 =3D LCD Backlight Power
> > +	 */
> > +	r =3D gpio_request(LCD_PANEL_BKLIGHT_PWR, "lcd_backlight_pwr");
> > +	if (r) {
> > +		printk(KERN_ERR "failed to get lcd_backlight_pwr\n");
> > +		return;
> > +	}
> > +	gpio_direction_output(LCD_PANEL_BKLIGHT_PWR, 1);
> > +	/*
> > +	 * Enable GPIO 181 =3D LCD Panel PWM
> > +	 */
> > +	r =3D gpio_request(LCD_PANEL_PWM, "lcd_pwm");
> > +	if (r) {
> > +		printk(KERN_ERR "failed to get lcd_pwm\n");
> > +		goto err_1;
> > +	}
> > +	gpio_direction_output(LCD_PANEL_PWM, 1);
> > +	/*
> > +	 * Enable GPIO 176 =3D LCD Panel Power enable pin
> > +	 */
> > +	r =3D gpio_request(LCD_PANEL_PWR, "lcd_panel_pwr");
> > +	if (r) {
> > +		printk(KERN_ERR "failed to get lcd_panel_pwr\n");
> > +		goto err_2;
> > +	}
> > +	gpio_direction_output(LCD_PANEL_PWR, 1);
> > +
> > +	printk(KERN_INFO "Display initialized successfully\n");
> > +	return;
> > +
> > +err_2:
> > +	gpio_free(LCD_PANEL_PWM);
> > +err_1:
> > +	gpio_free(LCD_PANEL_BKLIGHT_PWR);
> > +}
> > +
> > +static int am3517_evm_panel_enable_lcd(struct omap_dss_device
> *dssdev)
> > +{
> > +	if (dvi_enabled) {
> > +		printk(KERN_ERR "cannot enable LCD, DVI is enabled\n");
> > +		return -EINVAL;
> > +	}
> > +	gpio_set_value(LCD_PANEL_PWR, 1);
> > +	lcd_enabled =3D 1;
> > +
> > +	return 0;
> > +}
> > +
> > +static void am3517_evm_panel_disable_lcd(struct omap_dss_device
> *dssdev)
> > +{
> > +	gpio_set_value(LCD_PANEL_PWR, 0);
> > +	lcd_enabled =3D 0;
> > +}
> > +
> > +static struct omap_dss_device am3517_evm_lcd_device =3D {
> > +	.type			=3D OMAP_DISPLAY_TYPE_DPI,
> > +	.name			=3D "lcd",
> > +	.driver_name		=3D "sharp_lq_panel",
> > +	.phy.dpi.data_lines 	=3D 16,
> > +	.platform_enable	=3D am3517_evm_panel_enable_lcd,
> > +	.platform_disable	=3D am3517_evm_panel_disable_lcd,
> > +};
> > +
> > +static int am3517_evm_panel_enable_tv(struct omap_dss_device
> *dssdev)
> > +{
> > +	return 0;
> > +}
> > +
> > +static void am3517_evm_panel_disable_tv(struct omap_dss_device
> *dssdev)
> > +{
> > +}
> > +
> > +static struct omap_dss_device am3517_evm_tv_device =3D {
> > +	.type 			=3D OMAP_DISPLAY_TYPE_VENC,
> > +	.name 			=3D "tv",
> > +	.driver_name		=3D "venc",
> > +	.phy.venc.type		=3D OMAP_DSS_VENC_TYPE_SVIDEO,
> > +	.platform_enable	=3D am3517_evm_panel_enable_tv,
> > +	.platform_disable	=3D am3517_evm_panel_disable_tv,
> > +};
> > +
> > +static int am3517_evm_panel_enable_dvi(struct omap_dss_device
> *dssdev)
> > +{
> > +	if (lcd_enabled) {
> > +		printk(KERN_ERR "cannot enable DVI, LCD is enabled\n");
> > +		return -EINVAL;
> > +	}
> > +	dvi_enabled =3D 1;
> > +
> > +	return 0;
> > +}
> > +
> > +static void am3517_evm_panel_disable_dvi(struct omap_dss_device
> *dssdev)
> > +{
> > +	dvi_enabled =3D 0;
> > +}
> > +
> > +static struct omap_dss_device am3517_evm_dvi_device =3D {
> > +	.type			=3D OMAP_DISPLAY_TYPE_DPI,
> > +	.name			=3D "dvi",
> > +	.driver_name		=3D "generic_panel",
> > +	.phy.dpi.data_lines	=3D 24,
> > +	.platform_enable	=3D am3517_evm_panel_enable_dvi,
> > +	.platform_disable	=3D am3517_evm_panel_disable_dvi,
> > +};
> > +
> > +static struct omap_dss_device *am3517_evm_dss_devices[] =3D {
> > +	&am3517_evm_lcd_device,
> > +	&am3517_evm_tv_device,
> > +	&am3517_evm_dvi_device,
> > +};
> > +
> > +static struct omap_dss_board_info am3517_evm_dss_data =3D {
> > +	.num_devices	=3D ARRAY_SIZE(am3517_evm_dss_devices),
> > +	.devices	=3D am3517_evm_dss_devices,
> > +	.default_device	=3D &am3517_evm_lcd_device,
> > +};
> > +
> > +struct platform_device am3517_evm_dss_device =3D {
> > +	.name		=3D "omapdss",
> > +	.id		=3D -1,
> > +	.dev		=3D {
> > +		.platform_data	=3D &am3517_evm_dss_data,
> > +	},
> > +};
> >
> >  /*
> >   * VPFE - Video Decoder interface
> > @@ -269,6 +410,7 @@ static struct omap_board_config_kernel
> am3517_evm_config[] __initdata =3D {
> >  static struct platform_device *am3517_evm_devices[] __initdata =3D
> {
> >  	&dm644x_ccdc_dev,
> >  	&vpfe_capture_dev,
> > +	&am3517_evm_dss_device,
> >  };
> >
> >  static void __init am3517_evm_init_irq(void)
> > @@ -327,6 +469,8 @@ static void __init am3517_evm_init(void)
> >
> >  	i2c_register_board_info(1, am3517evm_i2c_boardinfo,
> >  				ARRAY_SIZE(am3517evm_i2c_boardinfo));
> > +	/* DSS */
> > +	am3517_evm_display_init();
> >  }
> >
> >  static void __init am3517_evm_map_io(void)
>=20


--_002_19F8576C6E063C45BE387C64729E7394044A4716F7dbde02enttico_
Content-Type: application/octet-stream;
	name="OMAP-AM3517-Enable-DSS2-for-AM3517EVM-board.patch"
Content-Description: OMAP-AM3517-Enable-DSS2-for-AM3517EVM-board.patch
Content-Disposition: attachment;
	filename="OMAP-AM3517-Enable-DSS2-for-AM3517EVM-board.patch"; size=6688;
	creation-date="Wed, 13 Jan 2010 17:17:51 GMT";
	modification-date="Wed, 13 Jan 2010 17:17:51 GMT"
Content-Transfer-Encoding: base64

RnJvbSA0NDlmYTM1MjYwNDg0M2Y0OWU2YjJlOGZjYmEzMDhlNjJhMzUwYmRmIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBWYWliaGF2IEhpcmVtYXRoIDxodmFpYmhhdkB0aS5jb20+CkRh
dGU6IFdlZCwgMTMgSmFuIDIwMTAgMTc6MTc6MTAgKzA1MzAKU3ViamVjdDogW1BBVENIXSBPTUFQ
OiBBTTM1MTc6IEVuYWJsZSBEU1MyIGZvciBBTTM1MTdFVk0gYm9hcmQKCgpTaWduZWQtb2ZmLWJ5
OiBWYWliaGF2IEhpcmVtYXRoIDxodmFpYmhhdkB0aS5jb20+Ci0tLQogYXJjaC9hcm0vY29uZmln
cy9hbTM1MTdfZXZtX2RlZmNvbmZpZyB8ICAgNTIgKysrKysrKysrKysrLQogYXJjaC9hcm0vbWFj
aC1vbWFwMi9ib2FyZC1hbTM1MTdldm0uYyB8ICAxNDUgKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrCiAyIGZpbGVzIGNoYW5nZWQsIDE5NiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9u
cygtKQoKZGlmZiAtLWdpdCBhL2FyY2gvYXJtL2NvbmZpZ3MvYW0zNTE3X2V2bV9kZWZjb25maWcg
Yi9hcmNoL2FybS9jb25maWdzL2FtMzUxN19ldm1fZGVmY29uZmlnCmluZGV4IGFiZTk5NjYuLjg1
OWYzNTIgMTAwNjQ0Ci0tLSBhL2FyY2gvYXJtL2NvbmZpZ3MvYW0zNTE3X2V2bV9kZWZjb25maWcK
KysrIGIvYXJjaC9hcm0vY29uZmlncy9hbTM1MTdfZXZtX2RlZmNvbmZpZwpAQCAtNjUzLDcgKzY1
Myw1NyBAQCBDT05GSUdfU1NCX1BPU1NJQkxFPXkKICMKICMgQ09ORklHX1ZHQVNUQVRFIGlzIG5v
dCBzZXQKICMgQ09ORklHX1ZJREVPX09VVFBVVF9DT05UUk9MIGlzIG5vdCBzZXQKLSMgQ09ORklH
X0ZCIGlzIG5vdCBzZXQKK0NPTkZJR19GQj15CisjIENPTkZJR19GSVJNV0FSRV9FRElEIGlzIG5v
dCBzZXQKKyMgQ09ORklHX0ZCX0REQyBpcyBub3Qgc2V0CisjIENPTkZJR19GQl9CT09UX1ZFU0Ff
U1VQUE9SVCBpcyBub3Qgc2V0CitDT05GSUdfRkJfQ0ZCX0ZJTExSRUNUPXkKK0NPTkZJR19GQl9D
RkJfQ09QWUFSRUE9eQorQ09ORklHX0ZCX0NGQl9JTUFHRUJMSVQ9eQorIyBDT05GSUdfRkJfQ0ZC
X1JFVl9QSVhFTFNfSU5fQllURSBpcyBub3Qgc2V0CisjIENPTkZJR19GQl9TWVNfRklMTFJFQ1Qg
aXMgbm90IHNldAorIyBDT05GSUdfRkJfU1lTX0NPUFlBUkVBIGlzIG5vdCBzZXQKKyMgQ09ORklH
X0ZCX1NZU19JTUFHRUJMSVQgaXMgbm90IHNldAorIyBDT05GSUdfRkJfRk9SRUlHTl9FTkRJQU4g
aXMgbm90IHNldAorIyBDT05GSUdfRkJfU1lTX0ZPUFMgaXMgbm90IHNldAorIyBDT05GSUdfRkJf
U1ZHQUxJQiBpcyBub3Qgc2V0CisjIENPTkZJR19GQl9NQUNNT0RFUyBpcyBub3Qgc2V0CisjIENP
TkZJR19GQl9CQUNLTElHSFQgaXMgbm90IHNldAorIyBDT05GSUdfRkJfTU9ERV9IRUxQRVJTIGlz
IG5vdCBzZXQKKyMgQ09ORklHX0ZCX1RJTEVCTElUVElORyBpcyBub3Qgc2V0CisKKyMKKyMgRnJh
bWUgYnVmZmVyIGhhcmR3YXJlIGRyaXZlcnMKKyMKKyMgQ09ORklHX0ZCX0FSTUNMQ0QgaXMgbm90
IHNldAorIyBDT05GSUdfRkJfUzFEMTNYWFggaXMgbm90IHNldAorIyBDT05GSUdfRkJfVklSVFVB
TCBpcyBub3Qgc2V0CisjIENPTkZJR19GQl9NRVRST05PTUUgaXMgbm90IHNldAorIyBDT05GSUdf
RkJfTUI4NjJYWCBpcyBub3Qgc2V0CisjIENPTkZJR19GQl9CUk9BRFNIRUVUIGlzIG5vdCBzZXQK
KyMgQ09ORklHX0ZCX09NQVBfQk9PVExPQURFUl9JTklUIGlzIG5vdCBzZXQKK0NPTkZJR19PTUFQ
Ml9WUkFNPXkKK0NPTkZJR19PTUFQMl9WUkZCPXkKK0NPTkZJR19PTUFQMl9EU1M9eQorQ09ORklH
X09NQVAyX1ZSQU1fU0laRT00CitDT05GSUdfT01BUDJfRFNTX0RFQlVHX1NVUFBPUlQ9eQorIyBD
T05GSUdfT01BUDJfRFNTX1JGQkkgaXMgbm90IHNldAorQ09ORklHX09NQVAyX0RTU19WRU5DPXkK
KyMgQ09ORklHX09NQVAyX0RTU19TREkgaXMgbm90IHNldAorIyBDT05GSUdfT01BUDJfRFNTX0RT
SSBpcyBub3Qgc2V0CisjIENPTkZJR19PTUFQMl9EU1NfRkFLRV9WU1lOQyBpcyBub3Qgc2V0CitD
T05GSUdfT01BUDJfRFNTX01JTl9GQ0tfUEVSX1BDSz00CitDT05GSUdfRkJfT01BUDI9eQorQ09O
RklHX0ZCX09NQVAyX0RFQlVHX1NVUFBPUlQ9eQorIyBDT05GSUdfRkJfT01BUDJfRk9SQ0VfQVVU
T19VUERBVEUgaXMgbm90IHNldAorQ09ORklHX0ZCX09NQVAyX05VTV9GQlM9MworCisjCisjIE9N
QVAyLzMgRGlzcGxheSBEZXZpY2UgRHJpdmVycworIworQ09ORklHX1BBTkVMX0dFTkVSSUM9eQor
IyBDT05GSUdfUEFORUxfU0hBUlBfTFMwMzdWN0RXMDEgaXMgbm90IHNldAorQ09ORklHX1BBTkVM
X1NIQVJQX0xRMDQzVDFERzAxPXkKICMgQ09ORklHX0JBQ0tMSUdIVF9MQ0RfU1VQUE9SVCBpcyBu
b3Qgc2V0CiAKICMKZGlmZiAtLWdpdCBhL2FyY2gvYXJtL21hY2gtb21hcDIvYm9hcmQtYW0zNTE3
ZXZtLmMgYi9hcmNoL2FybS9tYWNoLW9tYXAyL2JvYXJkLWFtMzUxN2V2bS5jCmluZGV4IGI0ZTZl
Y2EuLjU0YWY1ZjggMTAwNjQ0Ci0tLSBhL2FyY2gvYXJtL21hY2gtb21hcDIvYm9hcmQtYW0zNTE3
ZXZtLmMKKysrIGIvYXJjaC9hcm0vbWFjaC1vbWFwMi9ib2FyZC1hbTM1MTdldm0uYwpAQCAtMjks
OSArMjksMTUxIEBACiAjaW5jbHVkZSA8cGxhdC9ib2FyZC5oPgogI2luY2x1ZGUgPHBsYXQvY29t
bW9uLmg+CiAjaW5jbHVkZSA8cGxhdC91c2IuaD4KKyNpbmNsdWRlIDxwbGF0L2Rpc3BsYXkuaD4K
IAogI2luY2x1ZGUgIm11eC5oIgogCisjZGVmaW5lIExDRF9QQU5FTF9QV1IJCTE3NgorI2RlZmlu
ZSBMQ0RfUEFORUxfQktMSUdIVF9QV1IJMTgyCisjZGVmaW5lIExDRF9QQU5FTF9QV00JCTE4MQor
CitzdGF0aWMgaW50IGxjZF9lbmFibGVkOworc3RhdGljIGludCBkdmlfZW5hYmxlZDsKKworc3Rh
dGljIHZvaWQgX19pbml0IGFtMzUxN19ldm1fZGlzcGxheV9pbml0KHZvaWQpCit7CisJaW50IHI7
CisKKwlvbWFwX211eF9pbml0X2dwaW8oTENEX1BBTkVMX1BXUiwgT01BUF9QSU5fSU5QVVRfUFVM
TFVQKTsKKwlvbWFwX211eF9pbml0X2dwaW8oTENEX1BBTkVMX0JLTElHSFRfUFdSLCBPTUFQX1BJ
Tl9JTlBVVF9QVUxMRE9XTik7CisJb21hcF9tdXhfaW5pdF9ncGlvKExDRF9QQU5FTF9QV00sIE9N
QVBfUElOX0lOUFVUX1BVTExET1dOKTsKKwkvKgorCSAqIEVuYWJsZSBHUElPIDE4MiA9IExDRCBC
YWNrbGlnaHQgUG93ZXIKKwkgKi8KKwlyID0gZ3Bpb19yZXF1ZXN0KExDRF9QQU5FTF9CS0xJR0hU
X1BXUiwgImxjZF9iYWNrbGlnaHRfcHdyIik7CisJaWYgKHIpIHsKKwkJcHJpbnRrKEtFUk5fRVJS
ICJmYWlsZWQgdG8gZ2V0IGxjZF9iYWNrbGlnaHRfcHdyXG4iKTsKKwkJcmV0dXJuOworCX0KKwln
cGlvX2RpcmVjdGlvbl9vdXRwdXQoTENEX1BBTkVMX0JLTElHSFRfUFdSLCAxKTsKKwkvKgorCSAq
IEVuYWJsZSBHUElPIDE4MSA9IExDRCBQYW5lbCBQV00KKwkgKi8KKwlyID0gZ3Bpb19yZXF1ZXN0
KExDRF9QQU5FTF9QV00sICJsY2RfcHdtIik7CisJaWYgKHIpIHsKKwkJcHJpbnRrKEtFUk5fRVJS
ICJmYWlsZWQgdG8gZ2V0IGxjZF9wd21cbiIpOworCQlnb3RvIGVycl8xOworCX0KKwlncGlvX2Rp
cmVjdGlvbl9vdXRwdXQoTENEX1BBTkVMX1BXTSwgMSk7CisJLyoKKwkgKiBFbmFibGUgR1BJTyAx
NzYgPSBMQ0QgUGFuZWwgUG93ZXIgZW5hYmxlIHBpbgorCSAqLworCXIgPSBncGlvX3JlcXVlc3Qo
TENEX1BBTkVMX1BXUiwgImxjZF9wYW5lbF9wd3IiKTsKKwlpZiAocikgeworCQlwcmludGsoS0VS
Tl9FUlIgImZhaWxlZCB0byBnZXQgbGNkX3BhbmVsX3B3clxuIik7CisJCWdvdG8gZXJyXzI7CisJ
fQorCWdwaW9fZGlyZWN0aW9uX291dHB1dChMQ0RfUEFORUxfUFdSLCAxKTsKKworCXByaW50ayhL
RVJOX0lORk8gIkRpc3BsYXkgaW5pdGlhbGl6ZWQgc3VjY2Vzc2Z1bGx5XG4iKTsKKwlyZXR1cm47
CisKK2Vycl8yOgorCWdwaW9fZnJlZShMQ0RfUEFORUxfUFdNKTsKK2Vycl8xOgorCWdwaW9fZnJl
ZShMQ0RfUEFORUxfQktMSUdIVF9QV1IpOworfQorCitzdGF0aWMgaW50IGFtMzUxN19ldm1fcGFu
ZWxfZW5hYmxlX2xjZChzdHJ1Y3Qgb21hcF9kc3NfZGV2aWNlICpkc3NkZXYpCit7CisJaWYgKGR2
aV9lbmFibGVkKSB7CisJCXByaW50ayhLRVJOX0VSUiAiY2Fubm90IGVuYWJsZSBMQ0QsIERWSSBp
cyBlbmFibGVkXG4iKTsKKwkJcmV0dXJuIC1FSU5WQUw7CisJfQorCWdwaW9fc2V0X3ZhbHVlKExD
RF9QQU5FTF9QV1IsIDEpOworCWxjZF9lbmFibGVkID0gMTsKKworCXJldHVybiAwOworfQorCitz
dGF0aWMgdm9pZCBhbTM1MTdfZXZtX3BhbmVsX2Rpc2FibGVfbGNkKHN0cnVjdCBvbWFwX2Rzc19k
ZXZpY2UgKmRzc2RldikKK3sKKwlncGlvX3NldF92YWx1ZShMQ0RfUEFORUxfUFdSLCAwKTsKKwls
Y2RfZW5hYmxlZCA9IDA7Cit9CisKK3N0YXRpYyBzdHJ1Y3Qgb21hcF9kc3NfZGV2aWNlIGFtMzUx
N19ldm1fbGNkX2RldmljZSA9IHsKKwkudHlwZQkJCT0gT01BUF9ESVNQTEFZX1RZUEVfRFBJLAor
CS5uYW1lCQkJPSAibGNkIiwKKwkuZHJpdmVyX25hbWUJCT0gInNoYXJwX2xxX3BhbmVsIiwKKwku
cGh5LmRwaS5kYXRhX2xpbmVzIAk9IDE2LAorCS5wbGF0Zm9ybV9lbmFibGUJPSBhbTM1MTdfZXZt
X3BhbmVsX2VuYWJsZV9sY2QsCisJLnBsYXRmb3JtX2Rpc2FibGUJPSBhbTM1MTdfZXZtX3BhbmVs
X2Rpc2FibGVfbGNkLAorfTsKKworc3RhdGljIGludCBhbTM1MTdfZXZtX3BhbmVsX2VuYWJsZV90
dihzdHJ1Y3Qgb21hcF9kc3NfZGV2aWNlICpkc3NkZXYpCit7CisJcmV0dXJuIDA7Cit9CisKK3N0
YXRpYyB2b2lkIGFtMzUxN19ldm1fcGFuZWxfZGlzYWJsZV90dihzdHJ1Y3Qgb21hcF9kc3NfZGV2
aWNlICpkc3NkZXYpCit7Cit9CisKK3N0YXRpYyBzdHJ1Y3Qgb21hcF9kc3NfZGV2aWNlIGFtMzUx
N19ldm1fdHZfZGV2aWNlID0geworCS50eXBlIAkJCT0gT01BUF9ESVNQTEFZX1RZUEVfVkVOQywK
KwkubmFtZSAJCQk9ICJ0diIsCisJLmRyaXZlcl9uYW1lCQk9ICJ2ZW5jIiwKKwkucGh5LnZlbmMu
dHlwZQkJPSBPTUFQX0RTU19WRU5DX1RZUEVfU1ZJREVPLAorCS5wbGF0Zm9ybV9lbmFibGUJPSBh
bTM1MTdfZXZtX3BhbmVsX2VuYWJsZV90diwKKwkucGxhdGZvcm1fZGlzYWJsZQk9IGFtMzUxN19l
dm1fcGFuZWxfZGlzYWJsZV90diwKK307CisKK3N0YXRpYyBpbnQgYW0zNTE3X2V2bV9wYW5lbF9l
bmFibGVfZHZpKHN0cnVjdCBvbWFwX2Rzc19kZXZpY2UgKmRzc2RldikKK3sKKwlpZiAobGNkX2Vu
YWJsZWQpIHsKKwkJcHJpbnRrKEtFUk5fRVJSICJjYW5ub3QgZW5hYmxlIERWSSwgTENEIGlzIGVu
YWJsZWRcbiIpOworCQlyZXR1cm4gLUVJTlZBTDsKKwl9CisJZHZpX2VuYWJsZWQgPSAxOworCisJ
cmV0dXJuIDA7Cit9CisKK3N0YXRpYyB2b2lkIGFtMzUxN19ldm1fcGFuZWxfZGlzYWJsZV9kdmko
c3RydWN0IG9tYXBfZHNzX2RldmljZSAqZHNzZGV2KQoreworCWR2aV9lbmFibGVkID0gMDsKK30K
Kworc3RhdGljIHN0cnVjdCBvbWFwX2Rzc19kZXZpY2UgYW0zNTE3X2V2bV9kdmlfZGV2aWNlID0g
eworCS50eXBlCQkJPSBPTUFQX0RJU1BMQVlfVFlQRV9EUEksCisJLm5hbWUJCQk9ICJkdmkiLAor
CS5kcml2ZXJfbmFtZQkJPSAiZ2VuZXJpY19wYW5lbCIsCisJLnBoeS5kcGkuZGF0YV9saW5lcwk9
IDI0LAorCS5wbGF0Zm9ybV9lbmFibGUJPSBhbTM1MTdfZXZtX3BhbmVsX2VuYWJsZV9kdmksCisJ
LnBsYXRmb3JtX2Rpc2FibGUJPSBhbTM1MTdfZXZtX3BhbmVsX2Rpc2FibGVfZHZpLAorfTsKKwor
c3RhdGljIHN0cnVjdCBvbWFwX2Rzc19kZXZpY2UgKmFtMzUxN19ldm1fZHNzX2RldmljZXNbXSA9
IHsKKwkmYW0zNTE3X2V2bV9sY2RfZGV2aWNlLAorCSZhbTM1MTdfZXZtX3R2X2RldmljZSwKKwkm
YW0zNTE3X2V2bV9kdmlfZGV2aWNlLAorfTsKKworc3RhdGljIHN0cnVjdCBvbWFwX2Rzc19ib2Fy
ZF9pbmZvIGFtMzUxN19ldm1fZHNzX2RhdGEgPSB7CisJLm51bV9kZXZpY2VzCT0gQVJSQVlfU0la
RShhbTM1MTdfZXZtX2Rzc19kZXZpY2VzKSwKKwkuZGV2aWNlcwk9IGFtMzUxN19ldm1fZHNzX2Rl
dmljZXMsCisJLmRlZmF1bHRfZGV2aWNlCT0gJmFtMzUxN19ldm1fbGNkX2RldmljZSwKK307CisK
K3N0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgYW0zNTE3X2V2bV9kc3NfZGV2aWNlID0geworCS5uYW1l
CQk9ICJvbWFwZHNzIiwKKwkuaWQJCT0gLTEsCisJLmRldgkJPSB7CisJCS5wbGF0Zm9ybV9kYXRh
CT0gJmFtMzUxN19ldm1fZHNzX2RhdGEsCisJfSwKK307CisKIC8qCiAgKiBCb2FyZCBpbml0aWFs
aXphdGlvbgogICovCkBAIC0zOSw2ICsxODEsNyBAQCBzdGF0aWMgc3RydWN0IG9tYXBfYm9hcmRf
Y29uZmlnX2tlcm5lbCBhbTM1MTdfZXZtX2NvbmZpZ1tdIF9faW5pdGRhdGEgPSB7CiB9OwogCiBz
dGF0aWMgc3RydWN0IHBsYXRmb3JtX2RldmljZSAqYW0zNTE3X2V2bV9kZXZpY2VzW10gX19pbml0
ZGF0YSA9IHsKKwkmYW0zNTE3X2V2bV9kc3NfZGV2aWNlLAogfTsKIAogc3RhdGljIHZvaWQgX19p
bml0IGFtMzUxN19ldm1faW5pdF9pcnEodm9pZCkKQEAgLTc4LDYgKzIyMSw4IEBAIHN0YXRpYyB2
b2lkIF9faW5pdCBhbTM1MTdfZXZtX2luaXQodm9pZCkKIAogCW9tYXBfc2VyaWFsX2luaXQoKTsK
IAl1c2JfZWhjaV9pbml0KCZlaGNpX3BkYXRhKTsKKwkvKiBEU1MgKi8KKwlhbTM1MTdfZXZtX2Rp
c3BsYXlfaW5pdCgpOwogfQogCiBzdGF0aWMgdm9pZCBfX2luaXQgYW0zNTE3X2V2bV9tYXBfaW8o
dm9pZCkKLS0gCjEuNi4yLjQKCg==

--_002_19F8576C6E063C45BE387C64729E7394044A4716F7dbde02enttico_--
