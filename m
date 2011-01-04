From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 2/4] arm: Kconfig: remove duplicated GENERIC_HARDIRQS
	entry
Date: Tue, 4 Jan 2011 15:00:31 +0100
Message-ID: <20110104140031.GE25121@pengutronix.de>
References: <1294142577-28772-1-git-send-email-balbi@ti.com> <1294142577-28772-3-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:34404 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751522Ab1ADOAh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 4 Jan 2011 09:00:37 -0500
Content-Disposition: inline
In-Reply-To: <1294142577-28772-3-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Russell King <linux@arm.linux.org.uk>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>

On Tue, Jan 04, 2011 at 02:02:55PM +0200, Felipe Balbi wrote:
> GENERIC_HARDIRQS is defined under kernel/irq/Kconfig,
> so it's safe to drop the duplicated entry and simply
> select HAVE_GENERIC_HARDIRQS.
>=20
> Signed-off-by: Felipe Balbi <balbi@ti.com>
> ---
>  arch/arm/Kconfig |    8 +-------
>  1 files changed, 1 insertions(+), 7 deletions(-)
>=20
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index d56d21c0..e6f0f8b 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -15,6 +15,7 @@ config ARM
>  	select HAVE_FTRACE_MCOUNT_RECORD if (!XIP_KERNEL)
>  	select HAVE_DYNAMIC_FTRACE if (!XIP_KERNEL)
>  	select HAVE_GENERIC_DMA_COHERENT
> +	select HAVE_GENERIC_HARDIRQS
>  	select HAVE_KERNEL_GZIP
>  	select HAVE_KERNEL_LZO
>  	select HAVE_KERNEL_LZMA
> @@ -88,10 +89,6 @@ config MCA
>  	  <file:Documentation/mca.txt> (and especially the web page given
>  	  there) before attempting to build an MCA bus kernel.
> =20
> -config GENERIC_HARDIRQS
> -	bool
> -	default y
> -
>  config STACKTRACE_SUPPORT
>  	bool
>  	default y
> @@ -171,9 +168,6 @@ config FIQ
>  config ARCH_MTD_XIP
>  	bool
> =20
> -config GENERIC_HARDIRQS_NO__DO_IRQ
> -	def_bool y
> -
You didn't mention this change in the commit log.  Is this duplicated,
too or did it just slip through?

Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
