From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 3/4] ARM: OMAP: Make FS USB omap1 only
Date: Tue, 22 May 2012 10:08:25 +0300
Message-ID: <20120522070824.GC30559@arwen.pp.htv.fi>
References: <20120521185323.927.88012.stgit@muffinssi.local>
 <20120521190109.927.44462.stgit@muffinssi.local>
Reply-To: balbi-l0cyMroinI0@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4ZLFUWh1odzi/v6L"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20120521190109.927.44462.stgit-t/zwCYRDW5/25TI67NSWRg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Kyungmin Park <kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org


--4ZLFUWh1odzi/v6L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 21, 2012 at 12:01:09PM -0700, Tony Lindgren wrote:
> As the FS USB code is not being actively used for omap2+
> there's no point keeping it around for omap2+.
>=20
> Let's make the FS USB platform init code omap1 only so
> we can remove the last user of omap_read/write for omap2+,
> and simplify things for further USB, DMA, and device tree
> related work.
>=20
> While at it, also group the mach includes for the related
> drivers.
>=20
> Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> Cc: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
> Cc: Kyungmin Park <kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>

Acked-by: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>

Are you planning to send this on v3.5 or v3.6 ? I guess it's too late
for v3.5 ?!?

> ---
>  arch/arm/mach-omap1/board-ams-delta.c   |    2=20
>  arch/arm/mach-omap1/board-generic.c     |    4 -
>  arch/arm/mach-omap1/board-h2.c          |    2=20
>  arch/arm/mach-omap1/board-h3.c          |    2=20
>  arch/arm/mach-omap1/board-htcherald.c   |    2=20
>  arch/arm/mach-omap1/board-innovator.c   |    2=20
>  arch/arm/mach-omap1/board-nokia770.c    |    2=20
>  arch/arm/mach-omap1/board-osk.c         |    2=20
>  arch/arm/mach-omap1/board-palmte.c      |    2=20
>  arch/arm/mach-omap1/board-palmtt.c      |    2=20
>  arch/arm/mach-omap1/board-palmz71.c     |    2=20
>  arch/arm/mach-omap1/board-sx1.c         |    2=20
>  arch/arm/mach-omap1/board-voiceblue.c   |    3=20
>  arch/arm/mach-omap1/clock_data.c        |    3=20
>  arch/arm/mach-omap1/include/mach/usb.h  |  165 ++++++++++++++++++++++++++
>  arch/arm/mach-omap1/usb.c               |  116 ++++++++++++++++++
>  arch/arm/plat-omap/Makefile             |    2=20
>  arch/arm/plat-omap/include/plat/board.h |   38 ------
>  arch/arm/plat-omap/include/plat/usb.h   |  196 -------------------------=
------
>  arch/arm/plat-omap/usb.c                |  145 -----------------------
>  drivers/usb/gadget/Kconfig              |    2=20
>  drivers/usb/gadget/omap_udc.c           |    3=20
>  drivers/usb/host/Kconfig                |    2=20
>  drivers/usb/host/ohci-omap.c            |    7 +
>  drivers/usb/otg/isp1301_omap.c          |    2=20
>  25 files changed, 310 insertions(+), 400 deletions(-)
>  create mode 100644 arch/arm/mach-omap1/include/mach/usb.h
>  delete mode 100644 arch/arm/plat-omap/usb.c
>=20
> diff --git a/arch/arm/mach-omap1/board-ams-delta.c b/arch/arm/mach-omap1/=
board-ams-delta.c
> index f2f8a58..c534698 100644
> --- a/arch/arm/mach-omap1/board-ams-delta.c
> +++ b/arch/arm/mach-omap1/board-ams-delta.c
> @@ -37,12 +37,12 @@
>  #include <plat/board-ams-delta.h>
>  #include <plat/keypad.h>
>  #include <plat/mux.h>
> -#include <plat/usb.h>
>  #include <plat/board.h>
> =20
>  #include <mach/hardware.h>
>  #include <mach/ams-delta-fiq.h>
>  #include <mach/camera.h>
> +#include <mach/usb.h>
> =20
>  #include "iomap.h"
>  #include "common.h"
> diff --git a/arch/arm/mach-omap1/board-generic.c b/arch/arm/mach-omap1/bo=
ard-generic.c
> index e75e2d5..6ec385e 100644
> --- a/arch/arm/mach-omap1/board-generic.c
> +++ b/arch/arm/mach-omap1/board-generic.c
> @@ -23,8 +23,10 @@
>  #include <asm/mach/map.h>
> =20
>  #include <plat/mux.h>
> -#include <plat/usb.h>
>  #include <plat/board.h>
> +
> +#include <mach/usb.h>
> +
>  #include "common.h"
> =20
>  /* assume no Mini-AB port */
> diff --git a/arch/arm/mach-omap1/board-h2.c b/arch/arm/mach-omap1/board-h=
2.c
> index a28e989..44a4ab1 100644
> --- a/arch/arm/mach-omap1/board-h2.c
> +++ b/arch/arm/mach-omap1/board-h2.c
> @@ -40,11 +40,11 @@
>  #include <plat/dma.h>
>  #include <plat/tc.h>
>  #include <plat/irda.h>
> -#include <plat/usb.h>
>  #include <plat/keypad.h>
>  #include <plat/flash.h>
> =20
>  #include <mach/hardware.h>
> +#include <mach/usb.h>
> =20
>  #include "common.h"
>  #include "board-h2.h"
> diff --git a/arch/arm/mach-omap1/board-h3.c b/arch/arm/mach-omap1/board-h=
3.c
> index 108a864..86cb5a0 100644
> --- a/arch/arm/mach-omap1/board-h3.c
> +++ b/arch/arm/mach-omap1/board-h3.c
> @@ -40,13 +40,13 @@
> =20
>  #include <plat/mux.h>
>  #include <plat/tc.h>
> -#include <plat/usb.h>
>  #include <plat/keypad.h>
>  #include <plat/dma.h>
>  #include <plat/flash.h>
> =20
>  #include <mach/hardware.h>
>  #include <mach/irqs.h>
> +#include <mach/usb.h>
> =20
>  #include "common.h"
>  #include "board-h3.h"
> diff --git a/arch/arm/mach-omap1/board-htcherald.c b/arch/arm/mach-omap1/=
board-htcherald.c
> index 118a9d4..b3f6e94 100644
> --- a/arch/arm/mach-omap1/board-htcherald.c
> +++ b/arch/arm/mach-omap1/board-htcherald.c
> @@ -44,10 +44,10 @@
>  #include <plat/omap7xx.h>
>  #include <plat/board.h>
>  #include <plat/keypad.h>
> -#include <plat/usb.h>
>  #include <plat/mmc.h>
> =20
>  #include <mach/irqs.h>
> +#include <mach/usb.h>
> =20
>  #include "common.h"
> =20
> diff --git a/arch/arm/mach-omap1/board-innovator.c b/arch/arm/mach-omap1/=
board-innovator.c
> index 7970223..f21c296 100644
> --- a/arch/arm/mach-omap1/board-innovator.c
> +++ b/arch/arm/mach-omap1/board-innovator.c
> @@ -35,11 +35,11 @@
>  #include <plat/flash.h>
>  #include <plat/fpga.h>
>  #include <plat/tc.h>
> -#include <plat/usb.h>
>  #include <plat/keypad.h>
>  #include <plat/mmc.h>
> =20
>  #include <mach/hardware.h>
> +#include <mach/usb.h>
> =20
>  #include "iomap.h"
>  #include "common.h"
> diff --git a/arch/arm/mach-omap1/board-nokia770.c b/arch/arm/mach-omap1/b=
oard-nokia770.c
> index 7212ae9..4007a372 100644
> --- a/arch/arm/mach-omap1/board-nokia770.c
> +++ b/arch/arm/mach-omap1/board-nokia770.c
> @@ -26,7 +26,6 @@
>  #include <asm/mach/map.h>
> =20
>  #include <plat/mux.h>
> -#include <plat/usb.h>
>  #include <plat/board.h>
>  #include <plat/keypad.h>
>  #include <plat/lcd_mipid.h>
> @@ -34,6 +33,7 @@
>  #include <plat/clock.h>
> =20
>  #include <mach/hardware.h>
> +#include <mach/usb.h>
> =20
>  #include "common.h"
> =20
> diff --git a/arch/arm/mach-omap1/board-osk.c b/arch/arm/mach-omap1/board-=
osk.c
> index da8d872..8784705 100644
> --- a/arch/arm/mach-omap1/board-osk.c
> +++ b/arch/arm/mach-omap1/board-osk.c
> @@ -45,11 +45,11 @@
>  #include <asm/mach/map.h>
> =20
>  #include <plat/flash.h>
> -#include <plat/usb.h>
>  #include <plat/mux.h>
>  #include <plat/tc.h>
> =20
>  #include <mach/hardware.h>
> +#include <mach/usb.h>
> =20
>  #include "common.h"
> =20
> diff --git a/arch/arm/mach-omap1/board-palmte.c b/arch/arm/mach-omap1/boa=
rd-palmte.c
> index 949b62a..26bcb9d 100644
> --- a/arch/arm/mach-omap1/board-palmte.c
> +++ b/arch/arm/mach-omap1/board-palmte.c
> @@ -35,7 +35,6 @@
> =20
>  #include <plat/flash.h>
>  #include <plat/mux.h>
> -#include <plat/usb.h>
>  #include <plat/tc.h>
>  #include <plat/dma.h>
>  #include <plat/board.h>
> @@ -43,6 +42,7 @@
>  #include <plat/keypad.h>
> =20
>  #include <mach/hardware.h>
> +#include <mach/usb.h>
> =20
>  #include "common.h"
> =20
> diff --git a/arch/arm/mach-omap1/board-palmtt.c b/arch/arm/mach-omap1/boa=
rd-palmtt.c
> index 7f1e1cf..4d09944 100644
> --- a/arch/arm/mach-omap1/board-palmtt.c
> +++ b/arch/arm/mach-omap1/board-palmtt.c
> @@ -35,7 +35,6 @@
>  #include <plat/led.h>
>  #include <plat/flash.h>
>  #include <plat/mux.h>
> -#include <plat/usb.h>
>  #include <plat/dma.h>
>  #include <plat/tc.h>
>  #include <plat/board.h>
> @@ -43,6 +42,7 @@
>  #include <plat/keypad.h>
> =20
>  #include <mach/hardware.h>
> +#include <mach/usb.h>
> =20
>  #include "common.h"
> =20
> diff --git a/arch/arm/mach-omap1/board-palmz71.c b/arch/arm/mach-omap1/bo=
ard-palmz71.c
> index 3c71c6b..cc71a26 100644
> --- a/arch/arm/mach-omap1/board-palmz71.c
> +++ b/arch/arm/mach-omap1/board-palmz71.c
> @@ -37,7 +37,6 @@
> =20
>  #include <plat/flash.h>
>  #include <plat/mux.h>
> -#include <plat/usb.h>
>  #include <plat/dma.h>
>  #include <plat/tc.h>
>  #include <plat/board.h>
> @@ -45,6 +44,7 @@
>  #include <plat/keypad.h>
> =20
>  #include <mach/hardware.h>
> +#include <mach/usb.h>
> =20
>  #include "common.h"
> =20
> diff --git a/arch/arm/mach-omap1/board-sx1.c b/arch/arm/mach-omap1/board-=
sx1.c
> index 3b7b82b..8c665bd 100644
> --- a/arch/arm/mach-omap1/board-sx1.c
> +++ b/arch/arm/mach-omap1/board-sx1.c
> @@ -37,13 +37,13 @@
>  #include <plat/mux.h>
>  #include <plat/dma.h>
>  #include <plat/irda.h>
> -#include <plat/usb.h>
>  #include <plat/tc.h>
>  #include <plat/board.h>
>  #include <plat/keypad.h>
>  #include <plat/board-sx1.h>
> =20
>  #include <mach/hardware.h>
> +#include <mach/usb.h>
> =20
>  #include "common.h"
> =20
> diff --git a/arch/arm/mach-omap1/board-voiceblue.c b/arch/arm/mach-omap1/=
board-voiceblue.c
> index afd67f0..3497769 100644
> --- a/arch/arm/mach-omap1/board-voiceblue.c
> +++ b/arch/arm/mach-omap1/board-voiceblue.c
> @@ -35,9 +35,10 @@
>  #include <plat/flash.h>
>  #include <plat/mux.h>
>  #include <plat/tc.h>
> -#include <plat/usb.h>
> +#include <plat/board.h>
> =20
>  #include <mach/hardware.h>
> +#include <mach/usb.h>
> =20
>  #include "common.h"
> =20
> diff --git a/arch/arm/mach-omap1/clock_data.c b/arch/arm/mach-omap1/clock=
_data.c
> index c6ce93f..c007d80 100644
> --- a/arch/arm/mach-omap1/clock_data.c
> +++ b/arch/arm/mach-omap1/clock_data.c
> @@ -25,10 +25,11 @@
>  #include <plat/clock.h>
>  #include <plat/cpu.h>
>  #include <plat/clkdev_omap.h>
> +#include <plat/board.h>
>  #include <plat/sram.h>	/* for omap_sram_reprogram_clock() */
> -#include <plat/usb.h>   /* for OTG_BASE */
> =20
>  #include <mach/hardware.h>
> +#include <mach/usb.h>   /* for OTG_BASE */
> =20
>  #include "iomap.h"
>  #include "clock.h"
> diff --git a/arch/arm/mach-omap1/include/mach/usb.h b/arch/arm/mach-omap1=
/include/mach/usb.h
> new file mode 100644
> index 0000000..753cd5c
> --- /dev/null
> +++ b/arch/arm/mach-omap1/include/mach/usb.h
> @@ -0,0 +1,165 @@
> +/*
> + * FIXME correct answer depends on hmc_mode,
> + * as does (on omap1) any nonzero value for config->otg port number
> + */
> +#ifdef	CONFIG_USB_GADGET_OMAP
> +#define	is_usb0_device(config)	1
> +#else
> +#define	is_usb0_device(config)	0
> +#endif
> +
> +struct omap_usb_config {
> +	/* Configure drivers according to the connectors on your board:
> +	 *  - "A" connector (rectagular)
> +	 *	... for host/OHCI use, set "register_host".
> +	 *  - "B" connector (squarish) or "Mini-B"
> +	 *	... for device/gadget use, set "register_dev".
> +	 *  - "Mini-AB" connector (very similar to Mini-B)
> +	 *	... for OTG use as device OR host, initialize "otg"
> +	 */
> +	unsigned	register_host:1;
> +	unsigned	register_dev:1;
> +	u8		otg;	/* port number, 1-based:  usb1 =3D=3D 2 */
> +
> +	u8		hmc_mode;
> +
> +	/* implicitly true if otg:  host supports remote wakeup? */
> +	u8		rwc;
> +
> +	/* signaling pins used to talk to transceiver on usbN:
> +	 *  0 =3D=3D usbN unused
> +	 *  2 =3D=3D usb0-only, using internal transceiver
> +	 *  3 =3D=3D 3 wire bidirectional
> +	 *  4 =3D=3D 4 wire bidirectional
> +	 *  6 =3D=3D 6 wire unidirectional (or TLL)
> +	 */
> +	u8		pins[3];
> +
> +	struct platform_device *udc_device;
> +	struct platform_device *ohci_device;
> +	struct platform_device *otg_device;
> +
> +	u32 (*usb0_init)(unsigned nwires, unsigned is_device);
> +	u32 (*usb1_init)(unsigned nwires);
> +	u32 (*usb2_init)(unsigned nwires, unsigned alt_pingroup);
> +
> +	int (*ocpi_enable)(void);
> +};
> +
> +void omap_otg_init(struct omap_usb_config *config);
> +
> +#if defined(CONFIG_USB) || defined(CONFIG_USB_MODULE)
> +void omap1_usb_init(struct omap_usb_config *pdata);
> +#else
> +static inline void omap1_usb_init(struct omap_usb_config *pdata)
> +{
> +}
> +#endif
> +
> +#define OMAP1_OTG_BASE			0xfffb0400
> +#define OMAP1_UDC_BASE			0xfffb4000
> +#define OMAP1_OHCI_BASE			0xfffba000
> +
> +#define OMAP2_OHCI_BASE			0x4805e000
> +#define OMAP2_UDC_BASE			0x4805e200
> +#define OMAP2_OTG_BASE			0x4805e300
> +#define OTG_BASE			OMAP1_OTG_BASE
> +#define UDC_BASE			OMAP1_UDC_BASE
> +#define OMAP_OHCI_BASE			OMAP1_OHCI_BASE
> +
> +/*
> + * OTG and transceiver registers, for OMAPs starting with ARM926
> + */
> +#define OTG_REV				(OTG_BASE + 0x00)
> +#define OTG_SYSCON_1			(OTG_BASE + 0x04)
> +#	define	 USB2_TRX_MODE(w)	(((w)>>24)&0x07)
> +#	define	 USB1_TRX_MODE(w)	(((w)>>20)&0x07)
> +#	define	 USB0_TRX_MODE(w)	(((w)>>16)&0x07)
> +#	define	 OTG_IDLE_EN		(1 << 15)
> +#	define	 HST_IDLE_EN		(1 << 14)
> +#	define	 DEV_IDLE_EN		(1 << 13)
> +#	define	 OTG_RESET_DONE		(1 << 2)
> +#	define	 OTG_SOFT_RESET		(1 << 1)
> +#define OTG_SYSCON_2			(OTG_BASE + 0x08)
> +#	define	 OTG_EN			(1 << 31)
> +#	define	 USBX_SYNCHRO		(1 << 30)
> +#	define	 OTG_MST16		(1 << 29)
> +#	define	 SRP_GPDATA		(1 << 28)
> +#	define	 SRP_GPDVBUS		(1 << 27)
> +#	define	 SRP_GPUVBUS(w)		(((w)>>24)&0x07)
> +#	define	 A_WAIT_VRISE(w)	(((w)>>20)&0x07)
> +#	define	 B_ASE_BRST(w)		(((w)>>16)&0x07)
> +#	define	 SRP_DPW		(1 << 14)
> +#	define	 SRP_DATA		(1 << 13)
> +#	define	 SRP_VBUS		(1 << 12)
> +#	define	 OTG_PADEN		(1 << 10)
> +#	define	 HMC_PADEN		(1 << 9)
> +#	define	 UHOST_EN		(1 << 8)
> +#	define	 HMC_TLLSPEED		(1 << 7)
> +#	define	 HMC_TLLATTACH		(1 << 6)
> +#	define	 OTG_HMC(w)		(((w)>>0)&0x3f)
> +#define OTG_CTRL			(OTG_BASE + 0x0c)
> +#	define	 OTG_USB2_EN		(1 << 29)
> +#	define	 OTG_USB2_DP		(1 << 28)
> +#	define	 OTG_USB2_DM		(1 << 27)
> +#	define	 OTG_USB1_EN		(1 << 26)
> +#	define	 OTG_USB1_DP		(1 << 25)
> +#	define	 OTG_USB1_DM		(1 << 24)
> +#	define	 OTG_USB0_EN		(1 << 23)
> +#	define	 OTG_USB0_DP		(1 << 22)
> +#	define	 OTG_USB0_DM		(1 << 21)
> +#	define	 OTG_ASESSVLD		(1 << 20)
> +#	define	 OTG_BSESSEND		(1 << 19)
> +#	define	 OTG_BSESSVLD		(1 << 18)
> +#	define	 OTG_VBUSVLD		(1 << 17)
> +#	define	 OTG_ID			(1 << 16)
> +#	define	 OTG_DRIVER_SEL		(1 << 15)
> +#	define	 OTG_A_SETB_HNPEN	(1 << 12)
> +#	define	 OTG_A_BUSREQ		(1 << 11)
> +#	define	 OTG_B_HNPEN		(1 << 9)
> +#	define	 OTG_B_BUSREQ		(1 << 8)
> +#	define	 OTG_BUSDROP		(1 << 7)
> +#	define	 OTG_PULLDOWN		(1 << 5)
> +#	define	 OTG_PULLUP		(1 << 4)
> +#	define	 OTG_DRV_VBUS		(1 << 3)
> +#	define	 OTG_PD_VBUS		(1 << 2)
> +#	define	 OTG_PU_VBUS		(1 << 1)
> +#	define	 OTG_PU_ID		(1 << 0)
> +#define OTG_IRQ_EN			(OTG_BASE + 0x10)	/* 16-bit */
> +#	define	 DRIVER_SWITCH		(1 << 15)
> +#	define	 A_VBUS_ERR		(1 << 13)
> +#	define	 A_REQ_TMROUT		(1 << 12)
> +#	define	 A_SRP_DETECT		(1 << 11)
> +#	define	 B_HNP_FAIL		(1 << 10)
> +#	define	 B_SRP_TMROUT		(1 << 9)
> +#	define	 B_SRP_DONE		(1 << 8)
> +#	define	 B_SRP_STARTED		(1 << 7)
> +#	define	 OPRT_CHG		(1 << 0)
> +#define OTG_IRQ_SRC			(OTG_BASE + 0x14)	/* 16-bit */
> +	// same bits as in IRQ_EN
> +#define OTG_OUTCTRL			(OTG_BASE + 0x18)	/* 16-bit */
> +#	define	 OTGVPD			(1 << 14)
> +#	define	 OTGVPU			(1 << 13)
> +#	define	 OTGPUID		(1 << 12)
> +#	define	 USB2VDR		(1 << 10)
> +#	define	 USB2PDEN		(1 << 9)
> +#	define	 USB2PUEN		(1 << 8)
> +#	define	 USB1VDR		(1 << 6)
> +#	define	 USB1PDEN		(1 << 5)
> +#	define	 USB1PUEN		(1 << 4)
> +#	define	 USB0VDR		(1 << 2)
> +#	define	 USB0PDEN		(1 << 1)
> +#	define	 USB0PUEN		(1 << 0)
> +#define OTG_TEST			(OTG_BASE + 0x20)	/* 16-bit */
> +#define OTG_VENDOR_CODE			(OTG_BASE + 0xfc)	/* 16-bit */
> +
> +/*----------------------------------------------------------------------=
---*/
> +
> +/* OMAP1 */
> +#define	USB_TRANSCEIVER_CTRL		(0xfffe1000 + 0x0064)
> +#	define	CONF_USB2_UNI_R		(1 << 8)
> +#	define	CONF_USB1_UNI_R		(1 << 7)
> +#	define	CONF_USB_PORT0_R(x)	(((x)>>4)&0x7)
> +#	define	CONF_USB0_ISOLATE_R	(1 << 3)
> +#	define	CONF_USB_PWRDN_DM_R	(1 << 2)
> +#	define	CONF_USB_PWRDN_DP_R	(1 << 1)
> diff --git a/arch/arm/mach-omap1/usb.c b/arch/arm/mach-omap1/usb.c
> index e61afd9..65f8817 100644
> --- a/arch/arm/mach-omap1/usb.c
> +++ b/arch/arm/mach-omap1/usb.c
> @@ -27,7 +27,8 @@
>  #include <asm/irq.h>
> =20
>  #include <plat/mux.h>
> -#include <plat/usb.h>
> +
> +#include <mach/usb.h>
> =20
>  #include "common.h"
> =20
> @@ -55,6 +56,119 @@
>  #define INT_USB_IRQ_HGEN	INT_USB_HHC_1
>  #define INT_USB_IRQ_OTG		IH2_BASE + 8
> =20
> +#ifdef	CONFIG_ARCH_OMAP_OTG
> +
> +void __init
> +omap_otg_init(struct omap_usb_config *config)
> +{
> +	u32		syscon;
> +	int		alt_pingroup =3D 0;
> +
> +	/* NOTE:  no bus or clock setup (yet?) */
> +
> +	syscon =3D omap_readl(OTG_SYSCON_1) & 0xffff;
> +	if (!(syscon & OTG_RESET_DONE))
> +		pr_debug("USB resets not complete?\n");
> +
> +	//omap_writew(0, OTG_IRQ_EN);
> +
> +	/* pin muxing and transceiver pinouts */
> +	if (config->pins[0] > 2)	/* alt pingroup 2 */
> +		alt_pingroup =3D 1;
> +	syscon |=3D config->usb0_init(config->pins[0], is_usb0_device(config));
> +	syscon |=3D config->usb1_init(config->pins[1]);
> +	syscon |=3D config->usb2_init(config->pins[2], alt_pingroup);
> +	pr_debug("OTG_SYSCON_1 =3D %08x\n", omap_readl(OTG_SYSCON_1));
> +	omap_writel(syscon, OTG_SYSCON_1);
> +
> +	syscon =3D config->hmc_mode;
> +	syscon |=3D USBX_SYNCHRO | (4 << 16) /* B_ASE0_BRST */;
> +#ifdef	CONFIG_USB_OTG
> +	if (config->otg)
> +		syscon |=3D OTG_EN;
> +#endif
> +	if (cpu_class_is_omap1())
> +		pr_debug("USB_TRANSCEIVER_CTRL =3D %03x\n",
> +			 omap_readl(USB_TRANSCEIVER_CTRL));
> +	pr_debug("OTG_SYSCON_2 =3D %08x\n", omap_readl(OTG_SYSCON_2));
> +	omap_writel(syscon, OTG_SYSCON_2);
> +
> +	printk("USB: hmc %d", config->hmc_mode);
> +	if (!alt_pingroup)
> +		printk(", usb2 alt %d wires", config->pins[2]);
> +	else if (config->pins[0])
> +		printk(", usb0 %d wires%s", config->pins[0],
> +			is_usb0_device(config) ? " (dev)" : "");
> +	if (config->pins[1])
> +		printk(", usb1 %d wires", config->pins[1]);
> +	if (!alt_pingroup && config->pins[2])
> +		printk(", usb2 %d wires", config->pins[2]);
> +	if (config->otg)
> +		printk(", Mini-AB on usb%d", config->otg - 1);
> +	printk("\n");
> +
> +	if (cpu_class_is_omap1()) {
> +		u16 w;
> +
> +		/* leave USB clocks/controllers off until needed */
> +		w =3D omap_readw(ULPD_SOFT_REQ);
> +		w &=3D ~SOFT_USB_CLK_REQ;
> +		omap_writew(w, ULPD_SOFT_REQ);
> +
> +		w =3D omap_readw(ULPD_CLOCK_CTRL);
> +		w &=3D ~USB_MCLK_EN;
> +		w |=3D DIS_USB_PVCI_CLK;
> +		omap_writew(w, ULPD_CLOCK_CTRL);
> +	}
> +	syscon =3D omap_readl(OTG_SYSCON_1);
> +	syscon |=3D HST_IDLE_EN|DEV_IDLE_EN|OTG_IDLE_EN;
> +
> +#ifdef	CONFIG_USB_GADGET_OMAP
> +	if (config->otg || config->register_dev) {
> +		struct platform_device *udc_device =3D config->udc_device;
> +		int status;
> +
> +		syscon &=3D ~DEV_IDLE_EN;
> +		udc_device->dev.platform_data =3D config;
> +		status =3D platform_device_register(udc_device);
> +		if (status)
> +			pr_debug("can't register UDC device, %d\n", status);
> +	}
> +#endif
> +
> +#if	defined(CONFIG_USB_OHCI_HCD) || defined(CONFIG_USB_OHCI_HCD_MODULE)
> +	if (config->otg || config->register_host) {
> +		struct platform_device *ohci_device =3D config->ohci_device;
> +		int status;
> +
> +		syscon &=3D ~HST_IDLE_EN;
> +		ohci_device->dev.platform_data =3D config;
> +		status =3D platform_device_register(ohci_device);
> +		if (status)
> +			pr_debug("can't register OHCI device, %d\n", status);
> +	}
> +#endif
> +
> +#ifdef	CONFIG_USB_OTG
> +	if (config->otg) {
> +		struct platform_device *otg_device =3D config->otg_device;
> +		int status;
> +
> +		syscon &=3D ~OTG_IDLE_EN;
> +		otg_device->dev.platform_data =3D config;
> +		status =3D platform_device_register(otg_device);
> +		if (status)
> +			pr_debug("can't register OTG device, %d\n", status);
> +	}
> +#endif
> +	pr_debug("OTG_SYSCON_1 =3D %08x\n", omap_readl(OTG_SYSCON_1));
> +	omap_writel(syscon, OTG_SYSCON_1);
> +}
> +
> +#else
> +void omap_otg_init(struct omap_usb_config *config) {}
> +#endif
> +
>  #ifdef	CONFIG_USB_GADGET_OMAP
> =20
>  static struct resource udc_resources[] =3D {
> diff --git a/arch/arm/plat-omap/Makefile b/arch/arm/plat-omap/Makefile
> index ed8605f..6d87532 100644
> --- a/arch/arm/plat-omap/Makefile
> +++ b/arch/arm/plat-omap/Makefile
> @@ -4,7 +4,7 @@
> =20
>  # Common support
>  obj-y :=3D common.o sram.o clock.o devices.o dma.o mux.o \
> -	 usb.o fb.o counter_32k.o
> +	 fb.o counter_32k.o
>  obj-m :=3D
>  obj-n :=3D
>  obj-  :=3D
> diff --git a/arch/arm/plat-omap/include/plat/board.h b/arch/arm/plat-omap=
/include/plat/board.h
> index 4814c5b..e62f20a 100644
> --- a/arch/arm/plat-omap/include/plat/board.h
> +++ b/arch/arm/plat-omap/include/plat/board.h
> @@ -57,44 +57,6 @@ struct omap_camera_sensor_config {
>  	int (*power_off)(void * data);
>  };
> =20
> -struct omap_usb_config {
> -	/* Configure drivers according to the connectors on your board:
> -	 *  - "A" connector (rectagular)
> -	 *	... for host/OHCI use, set "register_host".
> -	 *  - "B" connector (squarish) or "Mini-B"
> -	 *	... for device/gadget use, set "register_dev".
> -	 *  - "Mini-AB" connector (very similar to Mini-B)
> -	 *	... for OTG use as device OR host, initialize "otg"
> -	 */
> -	unsigned	register_host:1;
> -	unsigned	register_dev:1;
> -	u8		otg;	/* port number, 1-based:  usb1 =3D=3D 2 */
> -
> -	u8		hmc_mode;
> -
> -	/* implicitly true if otg:  host supports remote wakeup? */
> -	u8		rwc;
> -
> -	/* signaling pins used to talk to transceiver on usbN:
> -	 *  0 =3D=3D usbN unused
> -	 *  2 =3D=3D usb0-only, using internal transceiver
> -	 *  3 =3D=3D 3 wire bidirectional
> -	 *  4 =3D=3D 4 wire bidirectional
> -	 *  6 =3D=3D 6 wire unidirectional (or TLL)
> -	 */
> -	u8		pins[3];
> -
> -	struct platform_device *udc_device;
> -	struct platform_device *ohci_device;
> -	struct platform_device *otg_device;
> -
> -	u32 (*usb0_init)(unsigned nwires, unsigned is_device);
> -	u32 (*usb1_init)(unsigned nwires);
> -	u32 (*usb2_init)(unsigned nwires, unsigned alt_pingroup);
> -
> -	int (*ocpi_enable)(void);
> -};
> -
>  struct omap_lcd_config {
>  	char panel_name[16];
>  	char ctrl_name[16];
> diff --git a/arch/arm/plat-omap/include/plat/usb.h b/arch/arm/plat-omap/i=
nclude/plat/usb.h
> index 762eeb0..548a4c8 100644
> --- a/arch/arm/plat-omap/include/plat/usb.h
> +++ b/arch/arm/plat-omap/include/plat/usb.h
> @@ -44,6 +44,8 @@ struct usbhs_omap_board_data {
>  	struct regulator		*regulator[OMAP3_HS_USB_PORTS];
>  };
> =20
> +#ifdef CONFIG_ARCH_OMAP2PLUS
> +
>  struct ehci_hcd_omap_platform_data {
>  	enum usbhs_omap_port_mode	port_mode[OMAP3_HS_USB_PORTS];
>  	int				reset_gpio_port[OMAP3_HS_USB_PORTS];
> @@ -64,26 +66,6 @@ struct usbhs_omap_platform_data {
>  };
>  /*----------------------------------------------------------------------=
---*/
> =20
> -#define OMAP1_OTG_BASE			0xfffb0400
> -#define OMAP1_UDC_BASE			0xfffb4000
> -#define OMAP1_OHCI_BASE			0xfffba000
> -
> -#define OMAP2_OHCI_BASE			0x4805e000
> -#define OMAP2_UDC_BASE			0x4805e200
> -#define OMAP2_OTG_BASE			0x4805e300
> -
> -#ifdef CONFIG_ARCH_OMAP1
> -
> -#define OTG_BASE			OMAP1_OTG_BASE
> -#define UDC_BASE			OMAP1_UDC_BASE
> -#define OMAP_OHCI_BASE			OMAP1_OHCI_BASE
> -
> -#else
> -
> -#define OTG_BASE			OMAP2_OTG_BASE
> -#define UDC_BASE			OMAP2_UDC_BASE
> -#define OMAP_OHCI_BASE			OMAP2_OHCI_BASE
> -
>  struct omap_musb_board_data {
>  	u8	interface_type;
>  	u8	mode;
> @@ -107,44 +89,6 @@ extern int omap4430_phy_init(struct device *dev);
>  extern int omap4430_phy_exit(struct device *dev);
>  extern int omap4430_phy_suspend(struct device *dev, int suspend);
> =20
> -/*
> - * NOTE: Please update omap USB drivers to use ioremap + read/write
> - */
> -
> -#define OMAP2_L4_IO_OFFSET	0xb2000000
> -#define OMAP2_L4_IO_ADDRESS(pa)	IOMEM((pa) + OMAP2_L4_IO_OFFSET)
> -
> -static inline u8 omap_readb(u32 pa)
> -{
> -	return __raw_readb(OMAP2_L4_IO_ADDRESS(pa));
> -}
> -
> -static inline u16 omap_readw(u32 pa)
> -{
> -	return __raw_readw(OMAP2_L4_IO_ADDRESS(pa));
> -}
> -
> -static inline u32 omap_readl(u32 pa)
> -{
> -	return __raw_readl(OMAP2_L4_IO_ADDRESS(pa));
> -}
> -
> -static inline void omap_writeb(u8 v, u32 pa)
> -{
> -	__raw_writeb(v, OMAP2_L4_IO_ADDRESS(pa));
> -}
> -
> -
> -static inline void omap_writew(u16 v, u32 pa)
> -{
> -	__raw_writew(v, OMAP2_L4_IO_ADDRESS(pa));
> -}
> -
> -static inline void omap_writel(u32 v, u32 pa)
> -{
> -	__raw_writel(v, OMAP2_L4_IO_ADDRESS(pa));
> -}
> -
>  #endif
> =20
>  extern void am35x_musb_reset(void);
> @@ -153,142 +97,6 @@ extern void am35x_musb_clear_irq(void);
>  extern void am35x_set_mode(u8 musb_mode);
>  extern void ti81xx_musb_phy_power(u8 on);
> =20
> -/*
> - * FIXME correct answer depends on hmc_mode,
> - * as does (on omap1) any nonzero value for config->otg port number
> - */
> -#ifdef	CONFIG_USB_GADGET_OMAP
> -#define	is_usb0_device(config)	1
> -#else
> -#define	is_usb0_device(config)	0
> -#endif
> -
> -void omap_otg_init(struct omap_usb_config *config);
> -
> -#if defined(CONFIG_USB) || defined(CONFIG_USB_MODULE)
> -void omap1_usb_init(struct omap_usb_config *pdata);
> -#else
> -static inline void omap1_usb_init(struct omap_usb_config *pdata)
> -{
> -}
> -#endif
> -
> -#if defined(CONFIG_ARCH_OMAP_OTG) || defined(CONFIG_ARCH_OMAP_OTG_MODULE)
> -void omap2_usbfs_init(struct omap_usb_config *pdata);
> -#else
> -static inline void omap2_usbfs_init(struct omap_usb_config *pdata)
> -{
> -}
> -#endif
> -
> -/*----------------------------------------------------------------------=
---*/
> -
> -/*
> - * OTG and transceiver registers, for OMAPs starting with ARM926
> - */
> -#define OTG_REV				(OTG_BASE + 0x00)
> -#define OTG_SYSCON_1			(OTG_BASE + 0x04)
> -#	define	 USB2_TRX_MODE(w)	(((w)>>24)&0x07)
> -#	define	 USB1_TRX_MODE(w)	(((w)>>20)&0x07)
> -#	define	 USB0_TRX_MODE(w)	(((w)>>16)&0x07)
> -#	define	 OTG_IDLE_EN		(1 << 15)
> -#	define	 HST_IDLE_EN		(1 << 14)
> -#	define	 DEV_IDLE_EN		(1 << 13)
> -#	define	 OTG_RESET_DONE		(1 << 2)
> -#	define	 OTG_SOFT_RESET		(1 << 1)
> -#define OTG_SYSCON_2			(OTG_BASE + 0x08)
> -#	define	 OTG_EN			(1 << 31)
> -#	define	 USBX_SYNCHRO		(1 << 30)
> -#	define	 OTG_MST16		(1 << 29)
> -#	define	 SRP_GPDATA		(1 << 28)
> -#	define	 SRP_GPDVBUS		(1 << 27)
> -#	define	 SRP_GPUVBUS(w)		(((w)>>24)&0x07)
> -#	define	 A_WAIT_VRISE(w)	(((w)>>20)&0x07)
> -#	define	 B_ASE_BRST(w)		(((w)>>16)&0x07)
> -#	define	 SRP_DPW		(1 << 14)
> -#	define	 SRP_DATA		(1 << 13)
> -#	define	 SRP_VBUS		(1 << 12)
> -#	define	 OTG_PADEN		(1 << 10)
> -#	define	 HMC_PADEN		(1 << 9)
> -#	define	 UHOST_EN		(1 << 8)
> -#	define	 HMC_TLLSPEED		(1 << 7)
> -#	define	 HMC_TLLATTACH		(1 << 6)
> -#	define	 OTG_HMC(w)		(((w)>>0)&0x3f)
> -#define OTG_CTRL			(OTG_BASE + 0x0c)
> -#	define	 OTG_USB2_EN		(1 << 29)
> -#	define	 OTG_USB2_DP		(1 << 28)
> -#	define	 OTG_USB2_DM		(1 << 27)
> -#	define	 OTG_USB1_EN		(1 << 26)
> -#	define	 OTG_USB1_DP		(1 << 25)
> -#	define	 OTG_USB1_DM		(1 << 24)
> -#	define	 OTG_USB0_EN		(1 << 23)
> -#	define	 OTG_USB0_DP		(1 << 22)
> -#	define	 OTG_USB0_DM		(1 << 21)
> -#	define	 OTG_ASESSVLD		(1 << 20)
> -#	define	 OTG_BSESSEND		(1 << 19)
> -#	define	 OTG_BSESSVLD		(1 << 18)
> -#	define	 OTG_VBUSVLD		(1 << 17)
> -#	define	 OTG_ID			(1 << 16)
> -#	define	 OTG_DRIVER_SEL		(1 << 15)
> -#	define	 OTG_A_SETB_HNPEN	(1 << 12)
> -#	define	 OTG_A_BUSREQ		(1 << 11)
> -#	define	 OTG_B_HNPEN		(1 << 9)
> -#	define	 OTG_B_BUSREQ		(1 << 8)
> -#	define	 OTG_BUSDROP		(1 << 7)
> -#	define	 OTG_PULLDOWN		(1 << 5)
> -#	define	 OTG_PULLUP		(1 << 4)
> -#	define	 OTG_DRV_VBUS		(1 << 3)
> -#	define	 OTG_PD_VBUS		(1 << 2)
> -#	define	 OTG_PU_VBUS		(1 << 1)
> -#	define	 OTG_PU_ID		(1 << 0)
> -#define OTG_IRQ_EN			(OTG_BASE + 0x10)	/* 16-bit */
> -#	define	 DRIVER_SWITCH		(1 << 15)
> -#	define	 A_VBUS_ERR		(1 << 13)
> -#	define	 A_REQ_TMROUT		(1 << 12)
> -#	define	 A_SRP_DETECT		(1 << 11)
> -#	define	 B_HNP_FAIL		(1 << 10)
> -#	define	 B_SRP_TMROUT		(1 << 9)
> -#	define	 B_SRP_DONE		(1 << 8)
> -#	define	 B_SRP_STARTED		(1 << 7)
> -#	define	 OPRT_CHG		(1 << 0)
> -#define OTG_IRQ_SRC			(OTG_BASE + 0x14)	/* 16-bit */
> -	// same bits as in IRQ_EN
> -#define OTG_OUTCTRL			(OTG_BASE + 0x18)	/* 16-bit */
> -#	define	 OTGVPD			(1 << 14)
> -#	define	 OTGVPU			(1 << 13)
> -#	define	 OTGPUID		(1 << 12)
> -#	define	 USB2VDR		(1 << 10)
> -#	define	 USB2PDEN		(1 << 9)
> -#	define	 USB2PUEN		(1 << 8)
> -#	define	 USB1VDR		(1 << 6)
> -#	define	 USB1PDEN		(1 << 5)
> -#	define	 USB1PUEN		(1 << 4)
> -#	define	 USB0VDR		(1 << 2)
> -#	define	 USB0PDEN		(1 << 1)
> -#	define	 USB0PUEN		(1 << 0)
> -#define OTG_TEST			(OTG_BASE + 0x20)	/* 16-bit */
> -#define OTG_VENDOR_CODE			(OTG_BASE + 0xfc)	/* 16-bit */
> -
> -/*----------------------------------------------------------------------=
---*/
> -
> -/* OMAP1 */
> -#define	USB_TRANSCEIVER_CTRL		(0xfffe1000 + 0x0064)
> -#	define	CONF_USB2_UNI_R		(1 << 8)
> -#	define	CONF_USB1_UNI_R		(1 << 7)
> -#	define	CONF_USB_PORT0_R(x)	(((x)>>4)&0x7)
> -#	define	CONF_USB0_ISOLATE_R	(1 << 3)
> -#	define	CONF_USB_PWRDN_DM_R	(1 << 2)
> -#	define	CONF_USB_PWRDN_DP_R	(1 << 1)
> -
> -/* OMAP2 */
> -#	define	USB_UNIDIR			0x0
> -#	define	USB_UNIDIR_TLL			0x1
> -#	define	USB_BIDIR			0x2
> -#	define	USB_BIDIR_TLL			0x3
> -#	define	USBTXWRMODEI(port, x)	((x) << (22 - (port * 2)))
> -#	define	USBT2TLL5PI		(1 << 17)
> -#	define	USB0PUENACTLOI		(1 << 16)
> -#	define	USBSTANDBYCTRL		(1 << 15)
>  /* AM35x */
>  /* USB 2.0 PHY Control */
>  #define CONF2_PHY_GPIOMODE	(1 << 23)
> diff --git a/arch/arm/plat-omap/usb.c b/arch/arm/plat-omap/usb.c
> deleted file mode 100644
> index daa0327..0000000
> --- a/arch/arm/plat-omap/usb.c
> +++ /dev/null
> @@ -1,145 +0,0 @@
> - /*
> - * arch/arm/plat-omap/usb.c -- platform level USB initialization
> - *
> - * Copyright (C) 2004 Texas Instruments, Inc.
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License as published by
> - * the Free Software Foundation; either version 2 of the License, or
> - * (at your option) any later version.
> - *
> - * This program is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - * GNU General Public License for more details.
> - *
> - * You should have received a copy of the GNU General Public License
> - * along with this program; if not, write to the Free Software
> - * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 =
 USA
> - */
> -
> -#undef	DEBUG
> -
> -#include <linux/module.h>
> -#include <linux/kernel.h>
> -#include <linux/init.h>
> -#include <linux/platform_device.h>
> -#include <linux/io.h>
> -
> -#include <plat/usb.h>
> -#include <plat/board.h>
> -
> -#include <mach/hardware.h>
> -
> -#ifdef	CONFIG_ARCH_OMAP_OTG
> -
> -void __init
> -omap_otg_init(struct omap_usb_config *config)
> -{
> -	u32		syscon;
> -	int		alt_pingroup =3D 0;
> -
> -	/* NOTE:  no bus or clock setup (yet?) */
> -
> -	syscon =3D omap_readl(OTG_SYSCON_1) & 0xffff;
> -	if (!(syscon & OTG_RESET_DONE))
> -		pr_debug("USB resets not complete?\n");
> -
> -	//omap_writew(0, OTG_IRQ_EN);
> -
> -	/* pin muxing and transceiver pinouts */
> -	if (config->pins[0] > 2)	/* alt pingroup 2 */
> -		alt_pingroup =3D 1;
> -	syscon |=3D config->usb0_init(config->pins[0], is_usb0_device(config));
> -	syscon |=3D config->usb1_init(config->pins[1]);
> -	syscon |=3D config->usb2_init(config->pins[2], alt_pingroup);
> -	pr_debug("OTG_SYSCON_1 =3D %08x\n", omap_readl(OTG_SYSCON_1));
> -	omap_writel(syscon, OTG_SYSCON_1);
> -
> -	syscon =3D config->hmc_mode;
> -	syscon |=3D USBX_SYNCHRO | (4 << 16) /* B_ASE0_BRST */;
> -#ifdef	CONFIG_USB_OTG
> -	if (config->otg)
> -		syscon |=3D OTG_EN;
> -#endif
> -	if (cpu_class_is_omap1())
> -		pr_debug("USB_TRANSCEIVER_CTRL =3D %03x\n",
> -			 omap_readl(USB_TRANSCEIVER_CTRL));
> -	pr_debug("OTG_SYSCON_2 =3D %08x\n", omap_readl(OTG_SYSCON_2));
> -	omap_writel(syscon, OTG_SYSCON_2);
> -
> -	printk("USB: hmc %d", config->hmc_mode);
> -	if (!alt_pingroup)
> -		printk(", usb2 alt %d wires", config->pins[2]);
> -	else if (config->pins[0])
> -		printk(", usb0 %d wires%s", config->pins[0],
> -			is_usb0_device(config) ? " (dev)" : "");
> -	if (config->pins[1])
> -		printk(", usb1 %d wires", config->pins[1]);
> -	if (!alt_pingroup && config->pins[2])
> -		printk(", usb2 %d wires", config->pins[2]);
> -	if (config->otg)
> -		printk(", Mini-AB on usb%d", config->otg - 1);
> -	printk("\n");
> -
> -	if (cpu_class_is_omap1()) {
> -		u16 w;
> -
> -		/* leave USB clocks/controllers off until needed */
> -		w =3D omap_readw(ULPD_SOFT_REQ);
> -		w &=3D ~SOFT_USB_CLK_REQ;
> -		omap_writew(w, ULPD_SOFT_REQ);
> -
> -		w =3D omap_readw(ULPD_CLOCK_CTRL);
> -		w &=3D ~USB_MCLK_EN;
> -		w |=3D DIS_USB_PVCI_CLK;
> -		omap_writew(w, ULPD_CLOCK_CTRL);
> -	}
> -	syscon =3D omap_readl(OTG_SYSCON_1);
> -	syscon |=3D HST_IDLE_EN|DEV_IDLE_EN|OTG_IDLE_EN;
> -
> -#ifdef	CONFIG_USB_GADGET_OMAP
> -	if (config->otg || config->register_dev) {
> -		struct platform_device *udc_device =3D config->udc_device;
> -		int status;
> -
> -		syscon &=3D ~DEV_IDLE_EN;
> -		udc_device->dev.platform_data =3D config;
> -		status =3D platform_device_register(udc_device);
> -		if (status)
> -			pr_debug("can't register UDC device, %d\n", status);
> -	}
> -#endif
> -
> -#if	defined(CONFIG_USB_OHCI_HCD) || defined(CONFIG_USB_OHCI_HCD_MODULE)
> -	if (config->otg || config->register_host) {
> -		struct platform_device *ohci_device =3D config->ohci_device;
> -		int status;
> -
> -		syscon &=3D ~HST_IDLE_EN;
> -		ohci_device->dev.platform_data =3D config;
> -		status =3D platform_device_register(ohci_device);
> -		if (status)
> -			pr_debug("can't register OHCI device, %d\n", status);
> -	}
> -#endif
> -
> -#ifdef	CONFIG_USB_OTG
> -	if (config->otg) {
> -		struct platform_device *otg_device =3D config->otg_device;
> -		int status;
> -
> -		syscon &=3D ~OTG_IDLE_EN;
> -		otg_device->dev.platform_data =3D config;
> -		status =3D platform_device_register(otg_device);
> -		if (status)
> -			pr_debug("can't register OTG device, %d\n", status);
> -	}
> -#endif
> -	pr_debug("OTG_SYSCON_1 =3D %08x\n", omap_readl(OTG_SYSCON_1));
> -	omap_writel(syscon, OTG_SYSCON_1);
> -}
> -
> -#else
> -void omap_otg_init(struct omap_usb_config *config) {}
> -#endif
> diff --git a/drivers/usb/gadget/Kconfig b/drivers/usb/gadget/Kconfig
> index bddc8fd..271ca16 100644
> --- a/drivers/usb/gadget/Kconfig
> +++ b/drivers/usb/gadget/Kconfig
> @@ -185,7 +185,7 @@ config USB_FUSB300
> =20
>  config USB_OMAP
>  	tristate "OMAP USB Device Controller"
> -	depends on ARCH_OMAP
> +	depends on ARCH_OMAP1
>  	select ISP1301_OMAP if MACH_OMAP_H2 || MACH_OMAP_H3 || MACH_OMAP_H4_OTG
>  	select USB_OTG_UTILS if ARCH_OMAP
>  	help
> diff --git a/drivers/usb/gadget/omap_udc.c b/drivers/usb/gadget/omap_udc.c
> index 7ba3246..2acf06c 100644
> --- a/drivers/usb/gadget/omap_udc.c
> +++ b/drivers/usb/gadget/omap_udc.c
> @@ -44,7 +44,8 @@
>  #include <asm/mach-types.h>
> =20
>  #include <plat/dma.h>
> -#include <plat/usb.h>
> +
> +#include <mach/usb.h>
> =20
>  #include "omap_udc.h"
> =20
> diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
> index 83e58df..dcfaaa9 100644
> --- a/drivers/usb/host/Kconfig
> +++ b/drivers/usb/host/Kconfig
> @@ -308,7 +308,7 @@ config USB_OHCI_HCD
> =20
>  config USB_OHCI_HCD_OMAP1
>  	bool "OHCI support for OMAP1/2 chips"
> -	depends on USB_OHCI_HCD && (ARCH_OMAP1 || ARCH_OMAP2)
> +	depends on USB_OHCI_HCD && ARCH_OMAP1
>  	default y
>  	---help---
>  	  Enables support for the OHCI controller on OMAP1/2 chips.
> diff --git a/drivers/usb/host/ohci-omap.c b/drivers/usb/host/ohci-omap.c
> index 9ce35d0..b02c344 100644
> --- a/drivers/usb/host/ohci-omap.c
> +++ b/drivers/usb/host/ohci-omap.c
> @@ -20,14 +20,15 @@
>  #include <linux/clk.h>
>  #include <linux/gpio.h>
> =20
> -#include <mach/hardware.h>
>  #include <asm/io.h>
>  #include <asm/mach-types.h>
> =20
>  #include <plat/mux.h>
> -#include <mach/irqs.h>
>  #include <plat/fpga.h>
> -#include <plat/usb.h>
> +
> +#include <mach/hardware.h>
> +#include <mach/irqs.h>
> +#include <mach/usb.h>
> =20
> =20
>  /* OMAP-1510 OHCI has its own MMU for DMA */
> diff --git a/drivers/usb/otg/isp1301_omap.c b/drivers/usb/otg/isp1301_oma=
p.c
> index 70cf5d7..e0558df 100644
> --- a/drivers/usb/otg/isp1301_omap.c
> +++ b/drivers/usb/otg/isp1301_omap.c
> @@ -36,9 +36,9 @@
>  #include <asm/irq.h>
>  #include <asm/mach-types.h>
> =20
> -#include <plat/usb.h>
>  #include <plat/mux.h>
> =20
> +#include <mach/usb.h>
> =20
>  #ifndef	DEBUG
>  #undef	VERBOSE
>=20

--=20
balbi

--4ZLFUWh1odzi/v6L
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPuztoAAoJEIaOsuA1yqREkMMQAIRV5ngI8wnMpbdBXRKCzrc2
c8Mjnl/f1IHpZbHx2SJXGcp2l17shHcxSbruVdCrVwVP+t/Ly6kqOmLD2dTXh69h
OS7gLqXypKiQap4xfyddC9dDeGdLg/Kb5pzlmYNM+Rfhk/BpEIBRW8XxWWB2psCT
3yeVa9eWQErBFhUJQfwm1Dr9s8Ynk+vGXrnsuciwZ33/7K7IyCzXnyjfY1wWR1sp
qGXUF1gLZfO99aeBOw4XoyTfsBVhD6RFhl1NBbrxiHIfCiGZwrgl1eu3VBfPkdeX
CwrFhawEjaa5VVlmn1SihpBhYnvPeSR92rfn9dznb8ly51zI8p7K0PhtUjxCmzlH
D+4TY48f/jPZVoozHZVY2CH2A0dBM4+aG74udZbaCxb4eBYlrJKgvN4GYSZmkXab
HlBzpPmrgEB1+toewLQwdxLQJFeTIPZyX+pUF2CUtMsM8a2YAL5dwPUX+h2xEYh/
lsGTRQg2IwwFvdMVRNej5gflwgbldgJbuvYLXhizcix0DqbIN0HI5d44JQ7kw1lF
eX5DBmBRN1tGiqzuf8/3sUfVPltzmTkMxG8+ia5fUwIPGG5Ikq3Eoyx7o9UFE84a
RGor4cjDm7fx75+CMkBjkJPynFjA6gYqi/zM7UFRRXhBtCeEXkqgwA0h7nwv9IOm
LHPc3pc+HoR+UHZcxPAY
=S594
-----END PGP SIGNATURE-----

--4ZLFUWh1odzi/v6L--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
