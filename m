From: "Gadiyar, Anand" <gadiyar@ti.com>
Subject: RE: [RFC patch] ARM: OMAP: Fix typo in drivers/usb/musb/Kconfig
Date: Mon, 19 Nov 2007 18:23:38 +0530
Message-ID: <010C7BAE6783F34D9AC336EE5A01A08804DC0849@dbde01.ent.ti.com>
References: <1195436521-10519-3-git-send-email-felipe.lima@indt.org.br>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
In-Reply-To: <1195436521-10519-3-git-send-email-felipe.lima@indt.org.br>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Felipe Balbi <felipe.lima@indt.org.br>, linux-omap-open-source@linux.omap.com
Cc: david-b@pacbel.net
List-Id: linux-omap@vger.kernel.org

Hi,=20

> We don't have ARCH_OMAP343X. Change to ARCH_OMAP34XX
>=20
> Signed-off-by: Felipe Balbi <felipe.lima@indt.org.br>
> ---
>  drivers/usb/musb/Kconfig |    6 +++---
>  1 files changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/usb/musb/Kconfig b/drivers/usb/musb/Kconfig
> index 2e030b9..c795b01 100644
> --- a/drivers/usb/musb/Kconfig
> +++ b/drivers/usb/musb/Kconfig
> @@ -30,7 +30,7 @@ config USB_MUSB_SOC
>  	depends on USB_MUSB_HDRC
>  	default y if ARCH_DAVINCI
>  	default y if ARCH_OMAP2430
> -	default y if ARCH_OMAP343X
> +	default y if ARCH_OMAP34XX
>  	help
>  	  Use a static <asm/arch/hdrc_cnf.h> file to describe how the
>  	  controller is configured (endpoints, mechanisms, etc) on the
> @@ -43,7 +43,7 @@ comment "OMAP 243x high speed USB support"
>  	depends on USB_MUSB_HDRC && ARCH_OMAP2430
> =20
>  comment "OMAP 343x high speed USB support"
> -	depends on USB_MUSB_HDRC && ARCH_OMAP343X
> +	depends on USB_MUSB_HDRC && ARCH_OMAP34XX
> =20
>  config USB_TUSB6010
>  	boolean "TUSB 6010 support"
> @@ -145,7 +145,7 @@ config MUSB_PIO_ONLY
>  config USB_INVENTRA_DMA
>  	bool
>  	depends on USB_MUSB_HDRC && !MUSB_PIO_ONLY
> -	default ARCH_OMAP2430 || ARCH_OMAP343X
> +	default ARCH_OMAP2430 || ARCH_OMAP34XX
>  	help
>  	  Enable DMA transfers using Mentor's engine.
> =20
> --=20

I made the exact same changes as part of getting MUSB running on 3430 =
ES2.

You beat me to the submission though. :)
Acked by me.

--
Anand Gadiyar
gadiyar@ti.com
