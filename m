From: "Mark A. Greer" <mgreer@animalcreek.com>
Subject: Re: [PATCH 00/15] OMAP SHAM & AES Crypto Updates
Date: Fri, 1 Feb 2013 13:18:24 -0700
Message-ID: <20130201201824.GA6326@animalcreek.com>
References: <1356107295-11121-1-git-send-email-mgreer@animalcreek.com>
 <alpine.DEB.2.00.1212230836160.16045@utopia.booyaka.com>
 <20130108203853.GB1876@animalcreek.com>
 <alpine.DEB.2.00.1301171904070.14118@utopia.booyaka.com>
 <20130117222728.GA32446@animalcreek.com>
 <20130128191635.GA14158@animalcreek.com>
 <alpine.DEB.2.00.1302011722070.10853@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from p3plsmtpa01-05.prod.phx3.secureserver.net ([72.167.82.85]:57871
	"HELO p3plsmtpa01-05.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1756373Ab3BAUSZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 Feb 2013 15:18:25 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1302011722070.10853@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Fri, Feb 01, 2013 at 05:35:05PM +0000, Paul Walmsley wrote:
> Hi Mark
>=20
> On Mon, 28 Jan 2013, Mark A. Greer wrote:
>=20
> > On Thu, Jan 17, 2013 at 03:27:28PM -0700, Mark A. Greer wrote:
> > > On Thu, Jan 17, 2013 at 07:13:36PM +0000, Paul Walmsley wrote:
> > > > On Tue, 8 Jan 2013, Mark A. Greer wrote:
> > > >=20
> > > > > On Sun, Dec 23, 2012 at 08:40:43AM +0000, Paul Walmsley wrote=
:
> >=20
> > > > What do you think about adding an am35xx_es11plus_hwmod_ocp_ifs=
[] array to=20
> > > > omap_hwmod_3xxx_data.c for these secure hwmods?  That carries t=
he implicit=20
> > > > and possibly wrong assumption that it's likely to be ES1.0 devi=
ces that=20
> > > > are missing the SHAM/AES, but it seems unlikely that TI would h=
ave=20
> > > > multiple silicon revs running around claiming to be ES1.1?  Or =
maybe I'm=20
> > > > just being na=EFve.
> > >=20
> > > Something like that makes sense to me.  I'll re-read my email, et=
c. and
> > > see if I can find something to help us figure it out.
> >=20
> > I couldn't find any information that helped with this so AFAIK ther=
e is no
> > good way to tell if a particular am35xx has the crypto hardware ava=
ilable
> > or not.
>=20
> I was thinking that we might assume that they are present on AM35xx=20
> ES1.1+.  If the TI folks are saying that they aren't available on onl=
y a=20
> few early devices, I'd guess that means ES1.0.  I personally have nev=
er=20
> seen an ES1.0 AM35xx device...=20
>=20
> Discriminating between ES1.0 and ES1.1+ should be pretty easy in the =
hwmod=20
> init...
>=20
> >  At this point, I vote for moving 'omap3xxx_l4_core__sham' and
> > 'omap3xxx_l4_core__aes' from omap3xxx_gp_hwmod_ocp_ifs[] and puttin=
g them
> > in omap34xx_hwmod_ocp_ifs[] and omap36xx_hwmod_ocp_ifs[]. =20
>=20
> I'm pretty sure that's going to break on HS OMAPs, like the HS OMAP34=
30 in=20
> the N900.  I don't think those IP blocks are directly accessible from=
=20
> Linux on most HS setups, although this might vary by device.  I'd fee=
l=20
> more comfortable if you created an omap34xx_gp_hwmod_ocp_ifs[] list a=
nd an=20
> omap36xx_gp_hwmod_ocp_ifs[] list.  We should probably get rid of=20
> omap3xxx_gp_hwmod_ocp_ifs[] altogether.
>=20
> > That should be safe in general and if someone with an am35xx wants =
to=20
> > use those modules, they can edit am35xx_hwmod_ocp_ifs[] locally.
>=20
> If you want to just leave them commented in am35xx_hwmod_ocp_ifs[], r=
ather=20
> than enabling them for ES1.1+ AM35xx, that's fine with me too, since =
we=20
> don't know that they are ES-level-based.  Maybe put a comment there t=
hat=20
> says that these are likely to be present, but no one seems to know fo=
r=20
> certain?  Seems ludicrous, but I guess that's what we're reduced to!

Thanks Paul.  I will have some patches early next week.

Mark
--
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
