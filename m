From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [PATCH] OMAP: MCSPI: Enable mcspi wake-up
Date: Tue, 18 Nov 2008 15:32:09 +0200
Message-ID: <20081118133209.GY20808@gandalf.research.nokia.com>
References: <1227013237-13650-1-git-send-email-jouni.hogander@nokia.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:18627 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752190AbYKRNc3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 18 Nov 2008 08:32:29 -0500
Received: from esebh105.NOE.Nokia.com (esebh105.ntc.nokia.com [172.21.138.211])
	by mgw-mx06.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id mAIDWChX024780
	for <linux-omap@vger.kernel.org>; Tue, 18 Nov 2008 15:32:26 +0200
Content-Disposition: inline
In-Reply-To: <1227013237-13650-1-git-send-email-jouni.hogander@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Jouni Hogander <jouni.hogander@nokia.com>
Cc: linux-omap@vger.kernel.org

On Tue, Nov 18, 2008 at 03:00:37PM +0200, Jouni H=F6gander wrote:
> Currently mcspi wake-ups are not enabled. This might cause case where
> OMAP is not waking up on mcspi events.
>=20
> Signed-off-by: Jouni Hogander <jouni.hogander@nokia.com>
> ---
>  drivers/spi/omap2_mcspi.c |   11 +++++++++--
>  1 files changed, 9 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/spi/omap2_mcspi.c b/drivers/spi/omap2_mcspi.c
> index 454a271..4bd330c 100644
> --- a/drivers/spi/omap2_mcspi.c
> +++ b/drivers/spi/omap2_mcspi.c
> @@ -59,6 +59,8 @@
> =20
>  /* per-register bitmasks: */
> =20
> +#define OMAP2_MCSPI_SYSCONFIG_SMARTIDLE	(0x2 << 3)
> +#define OMAP2_MCSPI_SYSCONFIG_ENAWAKEUP	(0x1 << 2)

could you follow the convention below and use (1 << offset) ??

>  #define OMAP2_MCSPI_SYSCONFIG_AUTOIDLE	(1 << 0)
>  #define OMAP2_MCSPI_SYSCONFIG_SOFTRESET	(1 << 1)
> =20
> @@ -90,6 +92,7 @@
> =20
>  #define OMAP2_MCSPI_CHCTRL_EN		(1 << 0)
> =20
> +#define OMAP2_MCSPI_WAKEUPENABLE_WKEN	(1 << 0)
> =20
>  /* We have 2 DMA channels per CS, one for RX and one for TX */
>  struct omap2_mcspi_dma {
> @@ -884,8 +887,12 @@ static int __init omap2_mcspi_reset(struct omap2=
_mcspi *mcspi)
>  	} while (!(tmp & OMAP2_MCSPI_SYSSTATUS_RESETDONE));
> =20
>  	mcspi_write_reg(master, OMAP2_MCSPI_SYSCONFIG,
> -			/* (3 << 8) | (2 << 3) | */
> -			OMAP2_MCSPI_SYSCONFIG_AUTOIDLE);
> +			OMAP2_MCSPI_SYSCONFIG_AUTOIDLE |
> +			OMAP2_MCSPI_SYSCONFIG_ENAWAKEUP |
> +			OMAP2_MCSPI_SYSCONFIG_SMARTIDLE);
> +
> +	mcspi_write_reg(master, OMAP2_MCSPI_WAKEUPENABLE,
> +			OMAP2_MCSPI_WAKEUPENABLE_WKEN);
> =20
>  	omap2_mcspi_set_master_mode(master);
> =20
> --=20
> 1.6.0.1
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--=20
balbi
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
