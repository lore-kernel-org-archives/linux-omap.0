From: "Mark A. Greer" <mgreer@animalcreek.com>
Subject: Re: [PATCH 00/15] OMAP SHAM & AES Crypto Updates
Date: Mon, 28 Jan 2013 12:16:35 -0700
Message-ID: <20130128191635.GA14158@animalcreek.com>
References: <1356107295-11121-1-git-send-email-mgreer@animalcreek.com>
 <alpine.DEB.2.00.1212230836160.16045@utopia.booyaka.com>
 <20130108203853.GB1876@animalcreek.com>
 <alpine.DEB.2.00.1301171904070.14118@utopia.booyaka.com>
 <20130117222728.GA32446@animalcreek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from p3plsmtpa01-06.prod.phx3.secureserver.net ([72.167.82.86]:46530
	"HELO p3plsmtpa01-06.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753544Ab3A1TQg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 28 Jan 2013 14:16:36 -0500
Content-Disposition: inline
In-Reply-To: <20130117222728.GA32446@animalcreek.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Thu, Jan 17, 2013 at 03:27:28PM -0700, Mark A. Greer wrote:
> On Thu, Jan 17, 2013 at 07:13:36PM +0000, Paul Walmsley wrote:
> > Hi Mark,
>=20
> Hi Paul.

Hi again, Paul.  Sorry for the delay, I've been under the weather.

> > I regret the delay,
> >=20
> > On Tue, 8 Jan 2013, Mark A. Greer wrote:
> >=20
> > > On Sun, Dec 23, 2012 at 08:40:43AM +0000, Paul Walmsley wrote:

> > What do you think about adding an am35xx_es11plus_hwmod_ocp_ifs[] a=
rray to=20
> > omap_hwmod_3xxx_data.c for these secure hwmods?  That carries the i=
mplicit=20
> > and possibly wrong assumption that it's likely to be ES1.0 devices =
that=20
> > are missing the SHAM/AES, but it seems unlikely that TI would have=20
> > multiple silicon revs running around claiming to be ES1.1?  Or mayb=
e I'm=20
> > just being na=EFve.
>=20
> Something like that makes sense to me.  I'll re-read my email, etc. a=
nd
> see if I can find something to help us figure it out.

I couldn't find any information that helped with this so AFAIK there is=
 no
good way to tell if a particular am35xx has the crypto hardware availab=
le
or not.  At this point, I vote for moving 'omap3xxx_l4_core__sham' and
'omap3xxx_l4_core__aes' from omap3xxx_gp_hwmod_ocp_ifs[] and putting th=
em
in omap34xx_hwmod_ocp_ifs[] and omap36xx_hwmod_ocp_ifs[].  That should =
be
safe in general and if someone with an am35xx wants to use those module=
s,
they can edit am35xx_hwmod_ocp_ifs[] locally.

What do you think?
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
