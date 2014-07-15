From: Felipe Balbi <balbi@ti.com>
Subject: Re: [RFT/RFC/PATCH 00/31] arm: omap: irq: cleanup INTC driver
Date: Tue, 15 Jul 2014 14:56:00 -0500
Message-ID: <20140715195544.GA29237@saruman.home>
References: <1384970958-4118-1-git-send-email-balbi@ti.com>
 <20131219184815.GU27438@atomide.com>
 <20131219232153.GE707@saruman.home>
 <20131221005309.GH26054@atomide.com>
 <20131223173409.GA10536@saruman.home>
 <20140102220101.GA8652@saruman.home>
 <52C6A939.70708@ti.com>
 <20140103164055.GA18722@saruman.home>
 <20140715091435.GB28715@atomide.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Yylu36WmvOXNoKYn"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:36741 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933253AbaGOT4b (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 15 Jul 2014 15:56:31 -0400
Content-Disposition: inline
In-Reply-To: <20140715091435.GB28715@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Felipe Balbi <balbi@ti.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>

--Yylu36WmvOXNoKYn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 15, 2014 at 02:14:35AM -0700, Tony Lindgren wrote:
> * Felipe Balbi <balbi@ti.com> [140103 08:43]:
> > On Fri, Jan 03, 2014 at 05:42:41PM +0530, Rajendra Nayak wrote:
> > > []..
> > >=20
> > > >>> so a bit more work is needed. Maybe also rebase these against
> > > >>> omap-for-v3.14/dt too?
> > > >>
> > > >> Will do.
> > > >=20
> > > > Rebased on top of omap-for-v3.14/omap3-board-removal. Patches are o=
n my
> > > > k.org tree:
> > > >=20
> > > > git://git.kernel.org/pub/scm/linux/kernel/git/balbi/usb.git wip/oma=
p-fix-intc
> > >=20
> > > It needs a minor build fix though..
> > >=20
> > > diff --git a/drivers/irqchip/irq-omap-intc.c b/drivers/irqchip/irq-om=
ap-intc.c
> > > index b58c5d5..d03b5a3 100644
> > > --- a/drivers/irqchip/irq-omap-intc.c
> > > +++ b/drivers/irqchip/irq-omap-intc.c
> > > @@ -151,7 +151,7 @@ static void omap_mask_ack_irq(struct irq_data *d)
> > >  static void omap_suspend_irq(struct irq_data *d)
> > >  {
> > >         omap_intc_save_context();
> > > -       omap3_intc_prepare_idle();
> > > +       omap_intc_prepare_idle();
> >=20
> > fixed now, thanks. Wonder how come I didn't see that, I was building
> > every commit with omap2plus_defconfig :-( Oh well...
>=20
> Felipe, care to refresh this series against v3.16-rc4 and
> repost? We now finally have the DT based booting working for
> PM for omap3 the same way as legacy booting so I can test
> this easily for regressions. But I don't seem to have the
> patches in my mailbox any longer.

not sure when I'll have time to work on this again, but I'll add it to
my TODO list.

--=20
balbi

--Yylu36WmvOXNoKYn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTxYdQAAoJEIaOsuA1yqREty4QAIaz4NxLdAM3Q1BZl7hm3lm4
qIBW0fDGzLLxEnfW85tjoF2kBNTiXAqsXSktkljyo4JhLaavtYg0MN/k/UmukY2g
GL/8K4UgJhMAV4dpSId6tWvFWy75SxhSt6Sim7PTwgMuMyUFic6SmlwXQMfmENWc
j68Xjzu5XkEgDpDYfXz8KxATJnHtX30/RPWmL2mhajM53Um2tnMeyVUc8nZ/53AB
IHqfLHlua2fII1c8cAZHC/SA9+RRddi9LV7LWzBtmJKxJkCEPOFcBwd0n3K2fWi3
0g0W3eioxwqQVoNXxzcBiWfUHF/DHOJFIJ7LAbSWum66/Wb0bHO9MStbEdgSrFWG
upOh7dsvjrk3SmIzayea1ifmk0PzC8ANvlOQA0+3NZ9fCB9tsZBBrkb89QK4tkAW
UZIJClUFDMlmMVvYZjw7syzE6pVb0k2ACqUGgHb0HwnCH1nmi6CAo9CAwCV4B0N2
jLtbzP4A0CgXxfJW89eggsRp8ZphLbGkL/V89TgXHl7YiwtOeM3U7z8/pzODwFdk
k85cEepar9JGo9BYmuk//sVThMqf/LhGwPT+ki9nIbpkT3+/0z5Qe8RbEhVAz36R
u+AqfmQcUjj1W+P/AgslKJjsdXt1yfk+VGFZLAxdbjKLQNwVwBGyQTHPP3S7tT2e
eldKN+BmJupfe3uJ+fCB
=OOUd
-----END PGP SIGNATURE-----

--Yylu36WmvOXNoKYn--
