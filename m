From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP2: remove useless variable 'ret'
Date: Thu, 22 Aug 2013 00:17:02 -0700
Message-ID: <20130822071702.GR7656@atomide.com>
References: <521479B4.8030604@asianux.com>
 <52147AC6.9040300@asianux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:51260 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753443Ab3HVHRG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 22 Aug 2013 03:17:06 -0400
Content-Disposition: inline
In-Reply-To: <52147AC6.9040300@asianux.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Chen Gang <gang.chen@asianux.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

* Chen Gang <gang.chen@asianux.com> [130821 01:39]:
> Remove useless variable 'ret', the related warning:
>=20
>   arch/arm/mach-omap2/board-am3517crane.c:113:6: warning: unused vari=
able =E2=80=98ret=E2=80=99 [-Wunused-variable]

Thanks applying into omap-for-v3.12/fixes-non-critical.

Regards,

Tony=20
=20
> Signed-off-by: Chen Gang <gang.chen@asianux.com>
> ---
>  arch/arm/mach-omap2/board-am3517crane.c |    2 --
>  1 files changed, 0 insertions(+), 2 deletions(-)
>=20
> diff --git a/arch/arm/mach-omap2/board-am3517crane.c b/arch/arm/mach-=
omap2/board-am3517crane.c
> index fc53911..0d499a1 100644
> --- a/arch/arm/mach-omap2/board-am3517crane.c
> +++ b/arch/arm/mach-omap2/board-am3517crane.c
> @@ -110,8 +110,6 @@ static void __init am3517_crane_i2c_init(void)
> =20
>  static void __init am3517_crane_init(void)
>  {
> -	int ret;
> -
>  	omap3_mux_init(board_mux, OMAP_PACKAGE_CBB);
>  	omap_serial_init();
>  	omap_sdrc_init(NULL, NULL);
> --=20
> 1.7.7.6
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
