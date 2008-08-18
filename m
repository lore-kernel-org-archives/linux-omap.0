From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/4] Refreshed PM workaround patches 2.
Date: Mon, 18 Aug 2008 16:23:22 +0300
Message-ID: <20080818132321.GJ17827@atomide.com>
References: <87iqu2rac0.fsf@trdhcp146196.ntc.nokia.com> <20080815074937.GI16231@frodo>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:55740 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751483AbYHRNX3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 18 Aug 2008 09:23:29 -0400
Content-Disposition: inline
In-Reply-To: <20080815074937.GI16231@frodo>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <me@felipebalbi.com>
Cc: H?gander Jouni <jouni.hogander@nokia.com>, linux-omap@vger.kernel.org

* Felipe Balbi <me@felipebalbi.com> [080815 10:50]:
> On Fri, Aug 15, 2008 at 10:44:47AM +0300, H?gander Jouni wrote:
> > Refreshed PM workaround set without coding style errors and 24xx bu=
ild
> > fixed. Here are instructions how to test them:
> >=20
> > To get Omap into retention, this patch set still depends on:
> > 1. ARCH: OMAP: MUSB: Do not block sleep (Felipe Balbi)
>=20
> I thought it had been applied. Probably lost while tony was on
> vacations. Anyways, here it is:

Thanks, pushing today.

Tony

> From: Felipe Balbi <felipe.balbi@nokia.com>
>=20
> arch: omap: usb: do not block sleep
>=20
> musb_set_clock should not block sleep on omap3-based
> boards, it prevents system from sleeping.
>=20
> Thanks to Jouni H=F6gander for pointing this out
>=20
> Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
> ---
>=20
> diff --git a/arch/arm/mach-omap2/usb-musb.c b/arch/arm/mach-omap2/usb=
-musb.c
> index 71ddf55..3f90a93 100644
> --- a/arch/arm/mach-omap2/usb-musb.c
> +++ b/arch/arm/mach-omap2/usb-musb.c
> @@ -58,7 +58,6 @@ static int musb_set_clock(struct clk *clk, int stat=
e)
>                 if (clk_on > 0)
>                         return -ENODEV;
> =20
> -               omap2_block_sleep();
>                 clk_enable(clk);
>                 clk_on =3D 1;
>         } else {
> @@ -67,7 +66,6 @@ static int musb_set_clock(struct clk *clk, int stat=
e)
> =20
>                 clk_disable(clk);
>                 clk_on =3D 0;
> -               omap2_allow_sleep();
>         }
> =20
>         return 0;
>=20
> --=20
> balbi
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
