From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCHv2 1/6] arch: Change defconfigs to point to g_mass_storage.
Date: Tue, 6 Nov 2012 13:31:57 +0200
Message-ID: <20121106113157.GE11931@arwen.pp.htv.fi>
References: <cover.1351715302.v2.git.mina86@mina86.com>
 <46dde680f525562e9fd19567deb5247f0bf26842.1351715302.v2.git.mina86@mina86.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="p8PhoBjPxaQXD0vg"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:49345 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751304Ab2KFLiu (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 6 Nov 2012 06:38:50 -0500
Content-Disposition: inline
In-Reply-To: <46dde680f525562e9fd19567deb5247f0bf26842.1351715302.v2.git.mina86@mina86.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Michal Nazarewicz <mpn@google.com>
Cc: Felipe Balbi <balbi@ti.com>, linux-usb@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>, Michal Nazarewicz <mina86@mina86.com>, Russell King <linux@arm.linux.org.uk>, linux-arm-kernel@lists.infradead.org, Haavard Skinnemoen <hskinnemoen@gmail.com>, Hans-Christian Egtvedt <egtvedt@samfundet.no>, Mike Frysinger <vapier@gentoo.org>, uclinux-dist-devel@blackfin.uclinux.org, Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org, Paul Mundt <lethal@linux-sh.org>, linux-sh@vger.kernel.org, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>

--p8PhoBjPxaQXD0vg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Nov 02, 2012 at 02:31:50PM +0100, Michal Nazarewicz wrote:
> From: Michal Nazarewicz <mina86@mina86.com>
>=20
> The File-backed Storage Gadget (g_file_storage) is being removed, since
> it has been replaced by Mass Storage Gadget (g_mass_storage).  This commit
> changes defconfigs point to the new gadget.
>=20
> Signed-off-by: Michal Nazarewicz <mina86@mina86.com>

I need more Acks here. Only got one from Nicolas. Anyone else ?

> ---
>  arch/arm/configs/afeb9260_defconfig                |    2 +-
>  arch/arm/configs/at91sam9260_defconfig             |    2 +-
>  arch/arm/configs/at91sam9261_defconfig             |    2 +-
>  arch/arm/configs/at91sam9263_defconfig             |    2 +-
>  arch/arm/configs/at91sam9g20_defconfig             |    2 +-
>  arch/arm/configs/corgi_defconfig                   |    2 +-
>  arch/arm/configs/davinci_all_defconfig             |    2 +-
>  arch/arm/configs/h7202_defconfig                   |    3 +--
>  arch/arm/configs/magician_defconfig                |    2 +-
>  arch/arm/configs/mini2440_defconfig                |    2 +-
>  arch/arm/configs/omap1_defconfig                   |    3 +--
>  arch/arm/configs/prima2_defconfig                  |    1 -
>  arch/arm/configs/spitz_defconfig                   |    2 +-
>  arch/arm/configs/stamp9g20_defconfig               |    2 +-
>  arch/arm/configs/viper_defconfig                   |    2 +-
>  arch/arm/configs/zeus_defconfig                    |    2 +-
>  arch/avr32/configs/atngw100_defconfig              |    2 +-
>  arch/avr32/configs/atngw100_evklcd100_defconfig    |    2 +-
>  arch/avr32/configs/atngw100_evklcd101_defconfig    |    2 +-
>  arch/avr32/configs/atngw100_mrmt_defconfig         |    2 +-
>  arch/avr32/configs/atngw100mkii_defconfig          |    2 +-
>  .../avr32/configs/atngw100mkii_evklcd100_defconfig |    2 +-
>  .../avr32/configs/atngw100mkii_evklcd101_defconfig |    2 +-
>  arch/avr32/configs/atstk1002_defconfig             |    2 +-
>  arch/avr32/configs/atstk1003_defconfig             |    2 +-
>  arch/avr32/configs/atstk1004_defconfig             |    2 +-
>  arch/avr32/configs/atstk1006_defconfig             |    2 +-
>  arch/avr32/configs/favr-32_defconfig               |    2 +-
>  arch/avr32/configs/hammerhead_defconfig            |    2 +-
>  arch/blackfin/configs/CM-BF527_defconfig           |    2 +-
>  arch/blackfin/configs/CM-BF548_defconfig           |    2 +-
>  arch/blackfin/configs/CM-BF561_defconfig           |    2 +-
>  arch/mips/configs/bcm47xx_defconfig                |    2 +-
>  arch/mips/configs/mtx1_defconfig                   |    2 +-
>  arch/sh/configs/ecovec24_defconfig                 |    2 +-
>  arch/sh/configs/se7724_defconfig                   |    2 +-
>  37 files changed, 35 insertions(+), 39 deletions(-)
>=20
> diff --git a/arch/arm/configs/afeb9260_defconfig b/arch/arm/configs/afeb9=
260_defconfig
> index c285a9d..a8dbc1e 100644
> --- a/arch/arm/configs/afeb9260_defconfig
> +++ b/arch/arm/configs/afeb9260_defconfig
> @@ -79,7 +79,7 @@ CONFIG_USB_STORAGE=3Dy
>  CONFIG_USB_GADGET=3Dy
>  CONFIG_USB_ZERO=3Dm
>  CONFIG_USB_GADGETFS=3Dm
> -CONFIG_USB_FILE_STORAGE=3Dm
> +CONFIG_USB_MASS_STORAGE=3Dm
>  CONFIG_USB_G_SERIAL=3Dm
>  CONFIG_RTC_CLASS=3Dy
>  CONFIG_RTC_DEBUG=3Dy
> diff --git a/arch/arm/configs/at91sam9260_defconfig b/arch/arm/configs/at=
91sam9260_defconfig
> index 505b376..0ea5d2c 100644
> --- a/arch/arm/configs/at91sam9260_defconfig
> +++ b/arch/arm/configs/at91sam9260_defconfig
> @@ -75,7 +75,7 @@ CONFIG_USB_STORAGE_DEBUG=3Dy
>  CONFIG_USB_GADGET=3Dy
>  CONFIG_USB_ZERO=3Dm
>  CONFIG_USB_GADGETFS=3Dm
> -CONFIG_USB_FILE_STORAGE=3Dm
> +CONFIG_USB_MASS_STORAGE=3Dm
>  CONFIG_USB_G_SERIAL=3Dm
>  CONFIG_RTC_CLASS=3Dy
>  CONFIG_RTC_DRV_AT91SAM9=3Dy
> diff --git a/arch/arm/configs/at91sam9261_defconfig b/arch/arm/configs/at=
91sam9261_defconfig
> index 1e8712e..c87beb9 100644
> --- a/arch/arm/configs/at91sam9261_defconfig
> +++ b/arch/arm/configs/at91sam9261_defconfig
> @@ -125,7 +125,7 @@ CONFIG_USB_GADGET=3Dy
>  CONFIG_USB_ZERO=3Dm
>  CONFIG_USB_ETH=3Dm
>  CONFIG_USB_GADGETFS=3Dm
> -CONFIG_USB_FILE_STORAGE=3Dm
> +CONFIG_USB_MASS_STORAGE=3Dm
>  CONFIG_USB_G_SERIAL=3Dm
>  CONFIG_MMC=3Dy
>  CONFIG_MMC_ATMELMCI=3Dm
> diff --git a/arch/arm/configs/at91sam9263_defconfig b/arch/arm/configs/at=
91sam9263_defconfig
> index d2050ca..c5212f4 100644
> --- a/arch/arm/configs/at91sam9263_defconfig
> +++ b/arch/arm/configs/at91sam9263_defconfig
> @@ -133,7 +133,7 @@ CONFIG_USB_GADGET=3Dy
>  CONFIG_USB_ZERO=3Dm
>  CONFIG_USB_ETH=3Dm
>  CONFIG_USB_GADGETFS=3Dm
> -CONFIG_USB_FILE_STORAGE=3Dm
> +CONFIG_USB_MASS_STORAGE=3Dm
>  CONFIG_USB_G_SERIAL=3Dm
>  CONFIG_MMC=3Dy
>  CONFIG_SDIO_UART=3Dm
> diff --git a/arch/arm/configs/at91sam9g20_defconfig b/arch/arm/configs/at=
91sam9g20_defconfig
> index e1b0e80..3b18810 100644
> --- a/arch/arm/configs/at91sam9g20_defconfig
> +++ b/arch/arm/configs/at91sam9g20_defconfig
> @@ -96,7 +96,7 @@ CONFIG_USB_STORAGE=3Dy
>  CONFIG_USB_GADGET=3Dy
>  CONFIG_USB_ZERO=3Dm
>  CONFIG_USB_GADGETFS=3Dm
> -CONFIG_USB_FILE_STORAGE=3Dm
> +CONFIG_USB_MASS_STORAGE=3Dm
>  CONFIG_USB_G_SERIAL=3Dm
>  CONFIG_MMC=3Dy
>  CONFIG_MMC_ATMELMCI=3Dm
> diff --git a/arch/arm/configs/corgi_defconfig b/arch/arm/configs/corgi_de=
fconfig
> index 4b8a25d..1fd1d1d 100644
> --- a/arch/arm/configs/corgi_defconfig
> +++ b/arch/arm/configs/corgi_defconfig
> @@ -218,7 +218,7 @@ CONFIG_USB_GADGET=3Dy
>  CONFIG_USB_ZERO=3Dm
>  CONFIG_USB_ETH=3Dm
>  CONFIG_USB_GADGETFS=3Dm
> -CONFIG_USB_FILE_STORAGE=3Dm
> +CONFIG_USB_MASS_STORAGE=3Dm
>  CONFIG_USB_G_SERIAL=3Dm
>  CONFIG_MMC=3Dy
>  CONFIG_MMC_PXA=3Dy
> diff --git a/arch/arm/configs/davinci_all_defconfig b/arch/arm/configs/da=
vinci_all_defconfig
> index 67b5abb6..4ea7c95 100644
> --- a/arch/arm/configs/davinci_all_defconfig
> +++ b/arch/arm/configs/davinci_all_defconfig
> @@ -144,7 +144,7 @@ CONFIG_USB_GADGET_DEBUG_FS=3Dy
>  CONFIG_USB_ZERO=3Dm
>  CONFIG_USB_ETH=3Dm
>  CONFIG_USB_GADGETFS=3Dm
> -CONFIG_USB_FILE_STORAGE=3Dm
> +CONFIG_USB_MASS_STORAGE=3Dm
>  CONFIG_USB_G_SERIAL=3Dm
>  CONFIG_USB_G_PRINTER=3Dm
>  CONFIG_USB_CDC_COMPOSITE=3Dm
> diff --git a/arch/arm/configs/h7202_defconfig b/arch/arm/configs/h7202_de=
fconfig
> index 69405a7..e16d3f3 100644
> --- a/arch/arm/configs/h7202_defconfig
> +++ b/arch/arm/configs/h7202_defconfig
> @@ -34,8 +34,7 @@ CONFIG_FB_MODE_HELPERS=3Dy
>  CONFIG_USB_GADGET=3Dm
>  CONFIG_USB_ZERO=3Dm
>  CONFIG_USB_GADGETFS=3Dm
> -CONFIG_USB_FILE_STORAGE=3Dm
> -CONFIG_USB_FILE_STORAGE_TEST=3Dy
> +CONFIG_USB_MASS_STORAGE=3Dm
>  CONFIG_USB_G_SERIAL=3Dm
>  CONFIG_EXT2_FS=3Dy
>  CONFIG_TMPFS=3Dy
> diff --git a/arch/arm/configs/magician_defconfig b/arch/arm/configs/magic=
ian_defconfig
> index a691ef4..557dd29 100644
> --- a/arch/arm/configs/magician_defconfig
> +++ b/arch/arm/configs/magician_defconfig
> @@ -136,7 +136,7 @@ CONFIG_USB_PXA27X=3Dy
>  CONFIG_USB_ETH=3Dm
>  # CONFIG_USB_ETH_RNDIS is not set
>  CONFIG_USB_GADGETFS=3Dm
> -CONFIG_USB_FILE_STORAGE=3Dm
> +CONFIG_USB_MASS_STORAGE=3Dm
>  CONFIG_USB_G_SERIAL=3Dm
>  CONFIG_USB_CDC_COMPOSITE=3Dm
>  CONFIG_USB_GPIO_VBUS=3Dy
> diff --git a/arch/arm/configs/mini2440_defconfig b/arch/arm/configs/mini2=
440_defconfig
> index 00630e6..a07948a 100644
> --- a/arch/arm/configs/mini2440_defconfig
> +++ b/arch/arm/configs/mini2440_defconfig
> @@ -240,7 +240,7 @@ CONFIG_USB_GADGET_S3C2410=3Dy
>  CONFIG_USB_ZERO=3Dm
>  CONFIG_USB_ETH=3Dm
>  CONFIG_USB_GADGETFS=3Dm
> -CONFIG_USB_FILE_STORAGE=3Dm
> +CONFIG_USB_MASS_STORAGE=3Dm
>  CONFIG_USB_G_SERIAL=3Dm
>  CONFIG_USB_CDC_COMPOSITE=3Dm
>  CONFIG_MMC=3Dy
> diff --git a/arch/arm/configs/omap1_defconfig b/arch/arm/configs/omap1_de=
fconfig
> index dde2a1a..42eab9a 100644
> --- a/arch/arm/configs/omap1_defconfig
> +++ b/arch/arm/configs/omap1_defconfig
> @@ -214,8 +214,7 @@ CONFIG_USB_TEST=3Dy
>  CONFIG_USB_GADGET=3Dy
>  CONFIG_USB_ETH=3Dm
>  # CONFIG_USB_ETH_RNDIS is not set
> -CONFIG_USB_FILE_STORAGE=3Dm
> -CONFIG_USB_FILE_STORAGE_TEST=3Dy
> +CONFIG_USB_MASS_STORAGE=3Dm
>  CONFIG_MMC=3Dy
>  CONFIG_MMC_SDHCI=3Dy
>  CONFIG_MMC_SDHCI_PLTFM=3Dy
> diff --git a/arch/arm/configs/prima2_defconfig b/arch/arm/configs/prima2_=
defconfig
> index 807d4e2..6a936c7 100644
> --- a/arch/arm/configs/prima2_defconfig
> +++ b/arch/arm/configs/prima2_defconfig
> @@ -37,7 +37,6 @@ CONFIG_SPI_SIRF=3Dy
>  CONFIG_SPI_SPIDEV=3Dy
>  # CONFIG_HWMON is not set
>  CONFIG_USB_GADGET=3Dy
> -CONFIG_USB_FILE_STORAGE=3Dm
>  CONFIG_USB_MASS_STORAGE=3Dm
>  CONFIG_MMC=3Dy
>  CONFIG_MMC_SDHCI=3Dy
> diff --git a/arch/arm/configs/spitz_defconfig b/arch/arm/configs/spitz_de=
fconfig
> index df77931..2e0419d 100644
> --- a/arch/arm/configs/spitz_defconfig
> +++ b/arch/arm/configs/spitz_defconfig
> @@ -214,7 +214,7 @@ CONFIG_USB_GADGET_DUMMY_HCD=3Dy
>  CONFIG_USB_ZERO=3Dm
>  CONFIG_USB_ETH=3Dm
>  CONFIG_USB_GADGETFS=3Dm
> -CONFIG_USB_FILE_STORAGE=3Dm
> +CONFIG_USB_MASS_STORAGE=3Dm
>  CONFIG_USB_G_SERIAL=3Dm
>  CONFIG_MMC=3Dy
>  CONFIG_MMC_PXA=3Dy
> diff --git a/arch/arm/configs/stamp9g20_defconfig b/arch/arm/configs/stam=
p9g20_defconfig
> index 52f1488..b845f55 100644
> --- a/arch/arm/configs/stamp9g20_defconfig
> +++ b/arch/arm/configs/stamp9g20_defconfig
> @@ -97,7 +97,7 @@ CONFIG_USB_STORAGE=3Dy
>  CONFIG_USB_GADGET=3Dm
>  CONFIG_USB_ZERO=3Dm
>  CONFIG_USB_ETH=3Dm
> -CONFIG_USB_FILE_STORAGE=3Dm
> +CONFIG_USB_MASS_STORAGE=3Dm
>  CONFIG_USB_G_SERIAL=3Dm
>  CONFIG_MMC=3Dy
>  CONFIG_MMC_ATMELMCI=3Dy
> diff --git a/arch/arm/configs/viper_defconfig b/arch/arm/configs/viper_de=
fconfig
> index 1d01ddd..d36e0d3 100644
> --- a/arch/arm/configs/viper_defconfig
> +++ b/arch/arm/configs/viper_defconfig
> @@ -139,7 +139,7 @@ CONFIG_USB_SERIAL_MCT_U232=3Dm
>  CONFIG_USB_GADGET=3Dm
>  CONFIG_USB_ETH=3Dm
>  CONFIG_USB_GADGETFS=3Dm
> -CONFIG_USB_FILE_STORAGE=3Dm
> +CONFIG_USB_MASS_STORAGE=3Dm
>  CONFIG_USB_G_SERIAL=3Dm
>  CONFIG_USB_G_PRINTER=3Dm
>  CONFIG_RTC_CLASS=3Dy
> diff --git a/arch/arm/configs/zeus_defconfig b/arch/arm/configs/zeus_defc=
onfig
> index 547a3c1..731d4f9 100644
> --- a/arch/arm/configs/zeus_defconfig
> +++ b/arch/arm/configs/zeus_defconfig
> @@ -143,7 +143,7 @@ CONFIG_USB_GADGET=3Dm
>  CONFIG_USB_PXA27X=3Dy
>  CONFIG_USB_ETH=3Dm
>  CONFIG_USB_GADGETFS=3Dm
> -CONFIG_USB_FILE_STORAGE=3Dm
> +CONFIG_USB_MASS_STORAGE=3Dm
>  CONFIG_USB_G_SERIAL=3Dm
>  CONFIG_USB_G_PRINTER=3Dm
>  CONFIG_MMC=3Dy
> diff --git a/arch/avr32/configs/atngw100_defconfig b/arch/avr32/configs/a=
tngw100_defconfig
> index a06bfcc..f4025db 100644
> --- a/arch/avr32/configs/atngw100_defconfig
> +++ b/arch/avr32/configs/atngw100_defconfig
> @@ -109,7 +109,7 @@ CONFIG_USB_GADGET_VBUS_DRAW=3D350
>  CONFIG_USB_ZERO=3Dm
>  CONFIG_USB_ETH=3Dm
>  CONFIG_USB_GADGETFS=3Dm
> -CONFIG_USB_FILE_STORAGE=3Dm
> +CONFIG_USB_MASS_STORAGE=3Dm
>  CONFIG_USB_G_SERIAL=3Dm
>  CONFIG_USB_CDC_COMPOSITE=3Dm
>  CONFIG_MMC=3Dy
> diff --git a/arch/avr32/configs/atngw100_evklcd100_defconfig b/arch/avr32=
/configs/atngw100_evklcd100_defconfig
> index d8f1fe8..c76a49b 100644
> --- a/arch/avr32/configs/atngw100_evklcd100_defconfig
> +++ b/arch/avr32/configs/atngw100_evklcd100_defconfig
> @@ -125,7 +125,7 @@ CONFIG_USB_GADGET_VBUS_DRAW=3D350
>  CONFIG_USB_ZERO=3Dm
>  CONFIG_USB_ETH=3Dm
>  CONFIG_USB_GADGETFS=3Dm
> -CONFIG_USB_FILE_STORAGE=3Dm
> +CONFIG_USB_MASS_STORAGE=3Dm
>  CONFIG_USB_G_SERIAL=3Dm
>  CONFIG_USB_CDC_COMPOSITE=3Dm
>  CONFIG_MMC=3Dy
> diff --git a/arch/avr32/configs/atngw100_evklcd101_defconfig b/arch/avr32=
/configs/atngw100_evklcd101_defconfig
> index d4c5b19..2d8ab08 100644
> --- a/arch/avr32/configs/atngw100_evklcd101_defconfig
> +++ b/arch/avr32/configs/atngw100_evklcd101_defconfig
> @@ -124,7 +124,7 @@ CONFIG_USB_GADGET_VBUS_DRAW=3D350
>  CONFIG_USB_ZERO=3Dm
>  CONFIG_USB_ETH=3Dm
>  CONFIG_USB_GADGETFS=3Dm
> -CONFIG_USB_FILE_STORAGE=3Dm
> +CONFIG_USB_MASS_STORAGE=3Dm
>  CONFIG_USB_G_SERIAL=3Dm
>  CONFIG_USB_CDC_COMPOSITE=3Dm
>  CONFIG_MMC=3Dy
> diff --git a/arch/avr32/configs/atngw100_mrmt_defconfig b/arch/avr32/conf=
igs/atngw100_mrmt_defconfig
> index 77ca4f9..b189e0c 100644
> --- a/arch/avr32/configs/atngw100_mrmt_defconfig
> +++ b/arch/avr32/configs/atngw100_mrmt_defconfig
> @@ -99,7 +99,7 @@ CONFIG_SND_ATMEL_AC97C=3Dm
>  # CONFIG_SND_SPI is not set
>  CONFIG_USB_GADGET=3Dm
>  CONFIG_USB_GADGET_DEBUG_FILES=3Dy
> -CONFIG_USB_FILE_STORAGE=3Dm
> +CONFIG_USB_MASS_STORAGE=3Dm
>  CONFIG_USB_G_SERIAL=3Dm
>  CONFIG_MMC=3Dy
>  CONFIG_MMC_ATMELMCI=3Dy
> diff --git a/arch/avr32/configs/atngw100mkii_defconfig b/arch/avr32/confi=
gs/atngw100mkii_defconfig
> index 6e0dca4..2e4de42 100644
> --- a/arch/avr32/configs/atngw100mkii_defconfig
> +++ b/arch/avr32/configs/atngw100mkii_defconfig
> @@ -111,7 +111,7 @@ CONFIG_USB_GADGET_VBUS_DRAW=3D350
>  CONFIG_USB_ZERO=3Dm
>  CONFIG_USB_ETH=3Dm
>  CONFIG_USB_GADGETFS=3Dm
> -CONFIG_USB_FILE_STORAGE=3Dm
> +CONFIG_USB_MASS_STORAGE=3Dm
>  CONFIG_USB_G_SERIAL=3Dm
>  CONFIG_USB_CDC_COMPOSITE=3Dm
>  CONFIG_MMC=3Dy
> diff --git a/arch/avr32/configs/atngw100mkii_evklcd100_defconfig b/arch/a=
vr32/configs/atngw100mkii_evklcd100_defconfig
> index 7f2a344..fad3cd2 100644
> --- a/arch/avr32/configs/atngw100mkii_evklcd100_defconfig
> +++ b/arch/avr32/configs/atngw100mkii_evklcd100_defconfig
> @@ -128,7 +128,7 @@ CONFIG_USB_GADGET_VBUS_DRAW=3D350
>  CONFIG_USB_ZERO=3Dm
>  CONFIG_USB_ETH=3Dm
>  CONFIG_USB_GADGETFS=3Dm
> -CONFIG_USB_FILE_STORAGE=3Dm
> +CONFIG_USB_MASS_STORAGE=3Dm
>  CONFIG_USB_G_SERIAL=3Dm
>  CONFIG_USB_CDC_COMPOSITE=3Dm
>  CONFIG_MMC=3Dy
> diff --git a/arch/avr32/configs/atngw100mkii_evklcd101_defconfig b/arch/a=
vr32/configs/atngw100mkii_evklcd101_defconfig
> index 085eeba..2998623 100644
> --- a/arch/avr32/configs/atngw100mkii_evklcd101_defconfig
> +++ b/arch/avr32/configs/atngw100mkii_evklcd101_defconfig
> @@ -127,7 +127,7 @@ CONFIG_USB_GADGET_VBUS_DRAW=3D350
>  CONFIG_USB_ZERO=3Dm
>  CONFIG_USB_ETH=3Dm
>  CONFIG_USB_GADGETFS=3Dm
> -CONFIG_USB_FILE_STORAGE=3Dm
> +CONFIG_USB_MASS_STORAGE=3Dm
>  CONFIG_USB_G_SERIAL=3Dm
>  CONFIG_USB_CDC_COMPOSITE=3Dm
>  CONFIG_MMC=3Dy
> diff --git a/arch/avr32/configs/atstk1002_defconfig b/arch/avr32/configs/=
atstk1002_defconfig
> index d1a887e..a582465 100644
> --- a/arch/avr32/configs/atstk1002_defconfig
> +++ b/arch/avr32/configs/atstk1002_defconfig
> @@ -126,7 +126,7 @@ CONFIG_USB_GADGET=3Dy
>  CONFIG_USB_ZERO=3Dm
>  CONFIG_USB_ETH=3Dm
>  CONFIG_USB_GADGETFS=3Dm
> -CONFIG_USB_FILE_STORAGE=3Dm
> +CONFIG_USB_MASS_STORAGE=3Dm
>  CONFIG_USB_G_SERIAL=3Dm
>  CONFIG_USB_CDC_COMPOSITE=3Dm
>  CONFIG_MMC=3Dy
> diff --git a/arch/avr32/configs/atstk1003_defconfig b/arch/avr32/configs/=
atstk1003_defconfig
> index 956f281..57a79df 100644
> --- a/arch/avr32/configs/atstk1003_defconfig
> +++ b/arch/avr32/configs/atstk1003_defconfig
> @@ -105,7 +105,7 @@ CONFIG_USB_GADGET=3Dy
>  CONFIG_USB_ZERO=3Dm
>  CONFIG_USB_ETH=3Dm
>  CONFIG_USB_GADGETFS=3Dm
> -CONFIG_USB_FILE_STORAGE=3Dm
> +CONFIG_USB_MASS_STORAGE=3Dm
>  CONFIG_USB_G_SERIAL=3Dm
>  CONFIG_USB_CDC_COMPOSITE=3Dm
>  CONFIG_MMC=3Dy
> diff --git a/arch/avr32/configs/atstk1004_defconfig b/arch/avr32/configs/=
atstk1004_defconfig
> index 40c69f3..1a49bd8 100644
> --- a/arch/avr32/configs/atstk1004_defconfig
> +++ b/arch/avr32/configs/atstk1004_defconfig
> @@ -104,7 +104,7 @@ CONFIG_USB_GADGET=3Dy
>  CONFIG_USB_ZERO=3Dm
>  CONFIG_USB_ETH=3Dm
>  CONFIG_USB_GADGETFS=3Dm
> -CONFIG_USB_FILE_STORAGE=3Dm
> +CONFIG_USB_MASS_STORAGE=3Dm
>  CONFIG_USB_G_SERIAL=3Dm
>  CONFIG_USB_CDC_COMPOSITE=3Dm
>  CONFIG_MMC=3Dy
> diff --git a/arch/avr32/configs/atstk1006_defconfig b/arch/avr32/configs/=
atstk1006_defconfig
> index 511eb8a..206a1b6 100644
> --- a/arch/avr32/configs/atstk1006_defconfig
> +++ b/arch/avr32/configs/atstk1006_defconfig
> @@ -129,7 +129,7 @@ CONFIG_USB_GADGET=3Dy
>  CONFIG_USB_ZERO=3Dm
>  CONFIG_USB_ETH=3Dm
>  CONFIG_USB_GADGETFS=3Dm
> -CONFIG_USB_FILE_STORAGE=3Dm
> +CONFIG_USB_MASS_STORAGE=3Dm
>  CONFIG_USB_G_SERIAL=3Dm
>  CONFIG_USB_CDC_COMPOSITE=3Dm
>  CONFIG_MMC=3Dy
> diff --git a/arch/avr32/configs/favr-32_defconfig b/arch/avr32/configs/fa=
vr-32_defconfig
> index 19973b0..0421498 100644
> --- a/arch/avr32/configs/favr-32_defconfig
> +++ b/arch/avr32/configs/favr-32_defconfig
> @@ -117,7 +117,7 @@ CONFIG_USB_GADGET=3Dy
>  CONFIG_USB_ZERO=3Dm
>  CONFIG_USB_ETH=3Dm
>  CONFIG_USB_GADGETFS=3Dm
> -CONFIG_USB_FILE_STORAGE=3Dm
> +CONFIG_USB_MASS_STORAGE=3Dm
>  CONFIG_USB_G_SERIAL=3Dm
>  CONFIG_USB_CDC_COMPOSITE=3Dm
>  CONFIG_MMC=3Dy
> diff --git a/arch/avr32/configs/hammerhead_defconfig b/arch/avr32/configs=
/hammerhead_defconfig
> index 6f45681..82f24eb 100644
> --- a/arch/avr32/configs/hammerhead_defconfig
> +++ b/arch/avr32/configs/hammerhead_defconfig
> @@ -127,7 +127,7 @@ CONFIG_USB_GADGET=3Dy
>  CONFIG_USB_ZERO=3Dm
>  CONFIG_USB_ETH=3Dm
>  CONFIG_USB_GADGETFS=3Dm
> -CONFIG_USB_FILE_STORAGE=3Dm
> +CONFIG_USB_MASS_STORAGE=3Dm
>  CONFIG_USB_G_SERIAL=3Dm
>  CONFIG_MMC=3Dm
>  CONFIG_MMC_ATMELMCI=3Dm
> diff --git a/arch/blackfin/configs/CM-BF527_defconfig b/arch/blackfin/con=
figs/CM-BF527_defconfig
> index c280a50..f59c80e 100644
> --- a/arch/blackfin/configs/CM-BF527_defconfig
> +++ b/arch/blackfin/configs/CM-BF527_defconfig
> @@ -106,7 +106,7 @@ CONFIG_MUSB_PIO_ONLY=3Dy
>  CONFIG_USB_STORAGE=3Dm
>  CONFIG_USB_GADGET=3Dm
>  CONFIG_USB_ETH=3Dm
> -CONFIG_USB_FILE_STORAGE=3Dm
> +CONFIG_USB_MASS_STORAGE=3Dm
>  CONFIG_USB_G_SERIAL=3Dm
>  CONFIG_USB_G_PRINTER=3Dm
>  CONFIG_RTC_CLASS=3Dy
> diff --git a/arch/blackfin/configs/CM-BF548_defconfig b/arch/blackfin/con=
figs/CM-BF548_defconfig
> index 349922b..e961483 100644
> --- a/arch/blackfin/configs/CM-BF548_defconfig
> +++ b/arch/blackfin/configs/CM-BF548_defconfig
> @@ -107,7 +107,7 @@ CONFIG_USB_ZERO=3Dm
>  CONFIG_USB_ETH=3Dm
>  # CONFIG_USB_ETH_RNDIS is not set
>  CONFIG_USB_GADGETFS=3Dm
> -CONFIG_USB_FILE_STORAGE=3Dm
> +CONFIG_USB_MASS_STORAGE=3Dm
>  CONFIG_USB_G_SERIAL=3Dm
>  CONFIG_USB_G_PRINTER=3Dm
>  CONFIG_MMC=3Dm
> diff --git a/arch/blackfin/configs/CM-BF561_defconfig b/arch/blackfin/con=
figs/CM-BF561_defconfig
> index 0456dea..24936b9 100644
> --- a/arch/blackfin/configs/CM-BF561_defconfig
> +++ b/arch/blackfin/configs/CM-BF561_defconfig
> @@ -83,7 +83,7 @@ CONFIG_GPIOLIB=3Dy
>  CONFIG_GPIO_SYSFS=3Dy
>  CONFIG_USB_GADGET=3Dm
>  CONFIG_USB_ETH=3Dm
> -CONFIG_USB_FILE_STORAGE=3Dm
> +CONFIG_USB_MASS_STORAGE=3Dm
>  CONFIG_USB_G_SERIAL=3Dm
>  CONFIG_USB_G_PRINTER=3Dm
>  CONFIG_MMC=3Dy
> diff --git a/arch/mips/configs/bcm47xx_defconfig b/arch/mips/configs/bcm4=
7xx_defconfig
> index b6fde2b..4ca8e5c 100644
> --- a/arch/mips/configs/bcm47xx_defconfig
> +++ b/arch/mips/configs/bcm47xx_defconfig
> @@ -473,7 +473,7 @@ CONFIG_USB_GADGET_NET2280=3Dy
>  CONFIG_USB_ZERO=3Dm
>  CONFIG_USB_ETH=3Dm
>  CONFIG_USB_GADGETFS=3Dm
> -CONFIG_USB_FILE_STORAGE=3Dm
> +CONFIG_USB_MASS_STORAGE=3Dm
>  CONFIG_USB_G_SERIAL=3Dm
>  CONFIG_USB_MIDI_GADGET=3Dm
>  CONFIG_LEDS_CLASS=3Dy
> diff --git a/arch/mips/configs/mtx1_defconfig b/arch/mips/configs/mtx1_de=
fconfig
> index 46c61edc..a0277d4 100644
> --- a/arch/mips/configs/mtx1_defconfig
> +++ b/arch/mips/configs/mtx1_defconfig
> @@ -661,7 +661,7 @@ CONFIG_USB_GADGET_NET2280=3Dy
>  CONFIG_USB_ZERO=3Dm
>  CONFIG_USB_ETH=3Dm
>  CONFIG_USB_GADGETFS=3Dm
> -CONFIG_USB_FILE_STORAGE=3Dm
> +CONFIG_USB_MASS_STORAGE=3Dm
>  CONFIG_USB_G_SERIAL=3Dm
>  CONFIG_USB_MIDI_GADGET=3Dm
>  CONFIG_MMC=3Dm
> diff --git a/arch/sh/configs/ecovec24_defconfig b/arch/sh/configs/ecovec2=
4_defconfig
> index 911e30c9..c6c2bec 100644
> --- a/arch/sh/configs/ecovec24_defconfig
> +++ b/arch/sh/configs/ecovec24_defconfig
> @@ -112,7 +112,7 @@ CONFIG_USB_MON=3Dy
>  CONFIG_USB_R8A66597_HCD=3Dy
>  CONFIG_USB_STORAGE=3Dy
>  CONFIG_USB_GADGET=3Dy
> -CONFIG_USB_FILE_STORAGE=3Dm
> +CONFIG_USB_MASS_STORAGE=3Dm
>  CONFIG_MMC=3Dy
>  CONFIG_MMC_SPI=3Dy
>  CONFIG_MMC_SDHI=3Dy
> diff --git a/arch/sh/configs/se7724_defconfig b/arch/sh/configs/se7724_de=
fconfig
> index ed35093..1faa788 100644
> --- a/arch/sh/configs/se7724_defconfig
> +++ b/arch/sh/configs/se7724_defconfig
> @@ -109,7 +109,7 @@ CONFIG_USB_STORAGE=3Dy
>  CONFIG_USB_GADGET=3Dy
>  CONFIG_USB_ETH=3Dm
>  CONFIG_USB_GADGETFS=3Dm
> -CONFIG_USB_FILE_STORAGE=3Dm
> +CONFIG_USB_MASS_STORAGE=3Dm
>  CONFIG_USB_G_SERIAL=3Dm
>  CONFIG_MMC=3Dy
>  CONFIG_MMC_SPI=3Dy
> --=20
> 1.7.7.3
>=20

--=20
balbi

--p8PhoBjPxaQXD0vg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQmPUtAAoJEIaOsuA1yqREn9sP/3LrRUgmYM/Av+OQhGbD0jQk
a26Vo9LjQtPT4y+rNIK/9aTd3aoHkdQ7VuH3HV9jLkOsmR2ocYm+cGZUqILnUtLs
48EVtOt9dfDHntdi0eocbJZgPS4ds0bG6zFKSMD+uzQl5JqxT3R2+oH5eD+i+jQk
qjp4N9yIURGNlzLmbTGWCHZzaIDav2uvIyetCQWwMol3yysmB1TMfOoZ0qQAQ72K
xNPbV4IpWpvfa8rpfZvUBOPNbSP90j5h1Lm+VS43aZQ4VgbaJmyVHbkSHQ6U8BW/
vqIbwoE/FQuOENhbR/3PJaVOuHHqQ/6/lQXh8zOBiegLMVQDG9unYadiFFPhZdU4
kecRudGYJSCvOQwdTgUG+uWJ4MPM5mUQcGFOEubfkYW15jq28WgoGoEKAIfon6k5
klRfAZlqlJWQJ7XIzFG0X2Kur3D3JKn54QWuFk2g0in3OBKYR61X6oexqQurEEm3
is8Pn4Yg1qlyKXTekI1DuFGeZiVSRxBssSoCLiKvHjUXpxqPzosqvZCFIi+4mK5H
oXEDNZJGwzq3nhdCEzrBc9tJ6iAosPFtJHwcdo2Vzt7vRIv7zvVPs1rELDsNLYoi
M6KgsLeHfxpuklSTm0d1GXWMuHW7i2JfjtIiAkW6PBPoDJ/HO9wFGp6wOaXIFTS+
Yldd2igFaNqfhbjs4IDS
=X6Gg
-----END PGP SIGNATURE-----

--p8PhoBjPxaQXD0vg--
