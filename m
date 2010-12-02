From: Tony Lindgren <tony@atomide.com>
Subject: Re: Mainline OMAP3 breakage (and other OMAP?)
Date: Thu, 2 Dec 2010 14:32:08 -0800
Message-ID: <20101202223208.GA17222@atomide.com>
References: <20101202211421.GG10461@n2100.arm.linux.org.uk>
 <20101202215837.GW17222@atomide.com>
 <20101202221612.GJ10461@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:16466 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757274Ab0LBWc0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 2 Dec 2010 17:32:26 -0500
Content-Disposition: inline
In-Reply-To: <20101202221612.GJ10461@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@nokia.com>

* Russell King - ARM Linux <linux@arm.linux.org.uk> [101202 14:06]:
> On Thu, Dec 02, 2010 at 01:58:38PM -0800, Tony Lindgren wrote:
> > * Russell King - ARM Linux <linux@arm.linux.org.uk> [101202 13:04]:
> > > This has been around since October:
> > >=20
> > > drivers/video/omap2/vram.c: In function =E2=96=A0omap_vram_reserv=
e_sdram_memblock=E2=96=A0:
> > > drivers/video/omap2/vram.c:573: error: =E2=96=A0MEMBLOCK_REAL_LIM=
IT=E2=96=A0 undeclared (first use in this function)
> > > drivers/video/omap2/vram.c:573: error: (Each undeclared identifie=
r is reported only once
> > > drivers/video/omap2/vram.c:573: error: for each function it appea=
rs in.)
> > >=20
> > > This requires a trivial one-liner compile fix:
> > >=20
> > > diff --git a/drivers/video/omap2/vram.c b/drivers/video/omap2/vra=
m.c
> > > index fed2a72..a8973f0 100644
> > > --- a/drivers/video/omap2/vram.c
> > > +++ b/drivers/video/omap2/vram.c
> > > @@ -570,7 +570,7 @@ void __init omap_vram_reserve_sdram_memblock(=
void)
> > >  			return;
> > >  		}
> > >  	} else {
> > > -		paddr =3D memblock_alloc_base(size, PAGE_SIZE, MEMBLOCK_REAL_L=
IMIT);
> > > +		paddr =3D memblock_alloc(size, PAGE_SIZE);
> > >  	}
> > > =20
> > >  	omap_vram_add_region(paddr, size);
> > >=20
> > > which restores the old behaviour before the X86 memblock changes =
went
> > > in.  Yes, there may be other changes due to the ioremap stuff, bu=
t
> > > that's really no excuse for not fixing the compile error itself.
> >=20
> > Great. Adding fbdev and Tomi to Cc.
> >=20
> > Acked-by: Tony Lindgren <tony@atomide.com>
>=20
> http://marc.info/?l=3Dlinux-omap&w=3D2&r=3D1&s=3DMEMBLOCK_REAL_LIMIT%=
20vram&q=3Db
>=20
> There have been patches posted throughout November to fix this, but
> the problem is they're not making it to mainline.  It needs chasing
> until someone does the right thing and sends one variant of the above
> patch, rather than just leaving it until the ioremap fixes hit
> mainline during the next merge window.

Yes this should go in during the -rc for sure.

I suggest you merge this but let's wait a bit and check if Tomi
already has a similar fix queued for the -rc series.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
