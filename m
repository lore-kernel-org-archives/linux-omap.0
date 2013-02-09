From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Subject: Re: [PATCH 7/7] ARM: omap2: gpmc-onenand: Replace printk KERN_ERR
 with dev_warn()
Date: Sat, 9 Feb 2013 15:05:31 -0300
Message-ID: <20130209180530.GC32349@localhost>
References: <1360427896-12004-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1360427896-12004-8-git-send-email-ezequiel.garcia@free-electrons.com>
 <20130209165532.GB13338@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:36958 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932439Ab3BISF2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 9 Feb 2013 13:05:28 -0500
Content-Disposition: inline
In-Reply-To: <20130209165532.GB13338@arwen.pp.htv.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Jon Hunter <jon-hunter@ti.com>, Tony Lindgren <tony@atomide.com>, Afzal Mohammed <afzal@ti.com>

On Sat, Feb 09, 2013 at 06:55:32PM +0200, Felipe Balbi wrote:
> Hi,
>=20
> On Sat, Feb 09, 2013 at 01:38:16PM -0300, Ezequiel Garcia wrote:
> > Since the condition is not an error but a warning, replace
> > printk KERN_ERR with dev_warn.
> >=20
> > Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> > ---
> >  arch/arm/mach-omap2/gpmc-onenand.c |    2 +-
> >  1 files changed, 1 insertions(+), 1 deletions(-)
> >=20
> > diff --git a/arch/arm/mach-omap2/gpmc-onenand.c b/arch/arm/mach-oma=
p2/gpmc-onenand.c
> > index 4771945..fd6e35b 100644
> > --- a/arch/arm/mach-omap2/gpmc-onenand.c
> > +++ b/arch/arm/mach-omap2/gpmc-onenand.c
> > @@ -367,7 +367,7 @@ void gpmc_onenand_init(struct omap_onenand_plat=
form_data *_onenand_data)
> > =20
> >  	if (cpu_is_omap24xx() &&
> >  			(gpmc_onenand_data->flags & ONENAND_SYNC_READWRITE)) {
> > -		printk(KERN_ERR "Onenand using only SYNC_READ on 24xx\n");
> > +		dev_warn(dev, "OneNAND using only SYNC_READ on 24xx\n");
>=20
> it would seem more natural to use dev_err() instead.
>=20

Are you sure? The error seems more a warning to me,
although I guess it's arguable.

Let me know and I'll fix it in v2.

--=20
Ezequiel Garc=C3=ADa, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
