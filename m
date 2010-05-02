From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH] arm: Fix .gitignore for boot/compressed folder
Date: Sun, 2 May 2010 14:20:49 +0200
Message-ID: <20100502122049.GA5553@pengutronix.de>
References: <1267113345-18426-1-git-send-email-saaguirre@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:40578 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751754Ab0EBMUz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 2 May 2010 08:20:55 -0400
Content-Disposition: inline
In-Reply-To: <1267113345-18426-1-git-send-email-saaguirre@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sergio Aguirre <saaguirre@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Albin Tonnerre <albin.tonnerre@free-electrons.com>, Russell King <rmk@arm.linux.org.uk>

On Thu, Feb 25, 2010 at 09:55:45AM -0600, Sergio Aguirre wrote:
> This should complements changes done in:
I think this should read "complement" only, that is, no 's' at the end.
Other than that,

Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
>=20
>   commit e7db7b4270ed2a606b8c0b5f944a5f92ade0e84c
>   Author: Albin Tonnerre <albin.tonnerre@free-electrons.com>
>   Date:   Fri Jan 8 14:42:43 2010 -0800
>=20
>       arm: add support for LZO-compressed kernels
>=20
> It missed to do the respective changes in '.gitignore' file.
>=20
> Signed-off-by: Sergio Aguirre <saaguirre@ti.com>
> ---
>  arch/arm/boot/compressed/.gitignore |    4 +++-
>  1 files changed, 3 insertions(+), 1 deletions(-)
>=20
> diff --git a/arch/arm/boot/compressed/.gitignore b/arch/arm/boot/comp=
ressed/.gitignore
> index ab204db..bb984af 100644
> --- a/arch/arm/boot/compressed/.gitignore
> +++ b/arch/arm/boot/compressed/.gitignore
> @@ -1,3 +1,5 @@
>  font.c
> -piggy.gz
> +piggy.gzip
> +piggy.lzo
> +lib1funcs.S
>  vmlinux.lds
> --=20
> 1.6.3.3
>=20
>=20
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>=20

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
