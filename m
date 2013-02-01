From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 00/15] OMAP SHAM & AES Crypto Updates
Date: Fri, 1 Feb 2013 17:35:05 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1302011722070.10853@utopia.booyaka.com>
References: <1356107295-11121-1-git-send-email-mgreer@animalcreek.com> <alpine.DEB.2.00.1212230836160.16045@utopia.booyaka.com> <20130108203853.GB1876@animalcreek.com> <alpine.DEB.2.00.1301171904070.14118@utopia.booyaka.com> <20130117222728.GA32446@animalcreek.com>
 <20130128191635.GA14158@animalcreek.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="843723315-496196887-1359740105=:10853"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:60331 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756890Ab3BARfG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 Feb 2013 12:35:06 -0500
In-Reply-To: <20130128191635.GA14158@animalcreek.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Mark A. Greer" <mgreer@animalcreek.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--843723315-496196887-1359740105=:10853
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Mark

On Mon, 28 Jan 2013, Mark A. Greer wrote:

> On Thu, Jan 17, 2013 at 03:27:28PM -0700, Mark A. Greer wrote:
> > On Thu, Jan 17, 2013 at 07:13:36PM +0000, Paul Walmsley wrote:
> > > On Tue, 8 Jan 2013, Mark A. Greer wrote:
> > >=20
> > > > On Sun, Dec 23, 2012 at 08:40:43AM +0000, Paul Walmsley wrote:
>=20
> > > What do you think about adding an am35xx_es11plus_hwmod_ocp_ifs[] arr=
ay to=20
> > > omap_hwmod_3xxx_data.c for these secure hwmods?  That carries the imp=
licit=20
> > > and possibly wrong assumption that it's likely to be ES1.0 devices th=
at=20
> > > are missing the SHAM/AES, but it seems unlikely that TI would have=20
> > > multiple silicon revs running around claiming to be ES1.1?  Or maybe =
I'm=20
> > > just being na=EFve.
> >=20
> > Something like that makes sense to me.  I'll re-read my email, etc. and
> > see if I can find something to help us figure it out.
>=20
> I couldn't find any information that helped with this so AFAIK there is n=
o
> good way to tell if a particular am35xx has the crypto hardware available
> or not.

I was thinking that we might assume that they are present on AM35xx=20
ES1.1+.  If the TI folks are saying that they aren't available on only a=20
few early devices, I'd guess that means ES1.0.  I personally have never=20
seen an ES1.0 AM35xx device...=20

Discriminating between ES1.0 and ES1.1+ should be pretty easy in the hwmod=
=20
init...

>  At this point, I vote for moving 'omap3xxx_l4_core__sham' and
> 'omap3xxx_l4_core__aes' from omap3xxx_gp_hwmod_ocp_ifs[] and putting them
> in omap34xx_hwmod_ocp_ifs[] and omap36xx_hwmod_ocp_ifs[]. =20

I'm pretty sure that's going to break on HS OMAPs, like the HS OMAP3430 in=
=20
the N900.  I don't think those IP blocks are directly accessible from=20
Linux on most HS setups, although this might vary by device.  I'd feel=20
more comfortable if you created an omap34xx_gp_hwmod_ocp_ifs[] list and an=
=20
omap36xx_gp_hwmod_ocp_ifs[] list.  We should probably get rid of=20
omap3xxx_gp_hwmod_ocp_ifs[] altogether.

> That should be safe in general and if someone with an am35xx wants to=20
> use those modules, they can edit am35xx_hwmod_ocp_ifs[] locally.

If you want to just leave them commented in am35xx_hwmod_ocp_ifs[], rather=
=20
than enabling them for ES1.1+ AM35xx, that's fine with me too, since we=20
don't know that they are ES-level-based.  Maybe put a comment there that=20
says that these are likely to be present, but no one seems to know for=20
certain?  Seems ludicrous, but I guess that's what we're reduced to!


- Paul
--843723315-496196887-1359740105=:10853--
