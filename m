From: Paul Walmsley <paul@pwsan.com>
Subject: Re: OMAP4 DSS clock setup
Date: Fri, 8 Apr 2011 08:55:37 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1104080753070.22291@utopia.booyaka.com>
References: <1301467733.2333.83.camel@deskari>  <4D92F899.7010606@ti.com>  <1301483027.4045.16.camel@deskari>  <4D931E21.8090305@ti.com>  <1301489930.15095.51.camel@deskari>  <alpine.DEB.2.00.1104011925510.27897@utopia.booyaka.com>  <1301900022.2715.12.camel@deskari>
  <alpine.DEB.2.00.1104071054390.29552@utopia.booyaka.com> <1302241893.2102.21.camel@deskari>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="155748971-642827763-1302271048=:22291"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:38563 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757183Ab1DHOzi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 8 Apr 2011 10:55:38 -0400
In-Reply-To: <1302241893.2102.21.camel@deskari>
Content-ID: <alpine.DEB.2.00.1104080758160.22291@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: "Cousson, Benoit" <b-cousson@ti.com>, "Semwal, Sumit" <sumit.semwal@ti.com>, "Taneja, Archit" <archit@ti.com>, linux-omap <linux-omap@vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--155748971-642827763-1302271048=:22291
Content-Type: TEXT/PLAIN; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <alpine.DEB.2.00.1104080758161.22291@utopia.booyaka.com>

Hi

On Fri, 8 Apr 2011, Tomi Valkeinen wrote:
> On Thu, 2011-04-07 at 13:27 -0600, Paul Walmsley wrote:
> > On Mon, 4 Apr 2011, Tomi Valkeinen wrote:
> >=20
> > > On Fri, 2011-04-01 at 20:12 -0600, Paul Walmsley wrote:
> > >=20
> > > > Based on the E-mail thread so far, I'd say that changing the clock =
aliases=20
> > > > is the way to go for right now.  The clock aliases are not hardware=
 data;=20
> > > > they just control how the clock hardware is mapped to the drivers.
> > >=20
> > > I'd very much prefer this option. Below is a patch for this.
> > >=20
> > > If Benoit doesn't complain too much about this, I'd like to get this
> > > merged as soon as possible, as OMAP4 DSS is currently crashing in the
> > > mainline kernel.
> >=20
> > I will queue your clock aliases patch and attempt to merge it upstream =
for=20
> > the -rc series.  I am not happy to be disagreeing with Beno=EEt here, b=
ut=20
> > this is the rationale that I am using.  (Beno=EEt, Tomi, please feel fr=
ee to=20
> > correct if there is something blatantly false below.)
> >=20
> > 1. The integration of the DSS module is an unusual case.  The
> >    MODULEMODE bits for the DSS bits do not control the DSS "main"
> >    functional clock (the clock that is needed to access device
> >    registers); instead, they only control the DSS interface clock.
> >    (This is because the DSS can use a functional clock that is not
> >    provided by the OMAP core.)  So calling the DSS MODULEMODE struct
> >    clk "dss_fck" is not really correct, since it is really controlling
> >    the interface clock.
>=20
> If we don't apply the patch, I think the clock aliases are still broken.
> Let's forget the ick/fck thing for a second, and just think the clock
> from PRCM which is used as the source clock for pixel clock. That is
> currently called "fck" on OMAP2/3, but "dss_dss_clk" on OMAP4. This
> cannot be right, can it? From DSS's point of view that is the same
> clock, it should clearly have the same alias on all platforms. I don't
> care what the name is as long as it's consistent on all platforms.

Yes, I agree.  That is another good point.

> And I have to say I still don't quite get it what is the problem with
> "fck" name.

After the hwmod/PM runtime conversion, there shouldn't be any clock=20
aliases left that are simply called "fck", because it is almost a=20
meaningless name.

> Or is that meant to be a clock which enables the registers
> on the module,

After the hwmod/PM runtime conversion, that should have an alias name of=20
"main" that is automatically added by the omap_device code.  (Note that it=
=20
does not appear to do so now; that is a bug that needs be fixed.)

> and not the clock used for the pixel clock? If so, I'm fine with having=
=20
> "fck" to be what it is currently, but then we need a new name for the=20
> clock used for pixel clock, which is consistent on all platforms.

If there is a separate PRCM-provided clock used only for the pixel clock,=
=20
then that clock should have an alias name of "system_pixel_ck" or=20
something similar that is meaningful to the DSS driver.  I think the=20
problem in this case is that "dss_dss_clk" is (optionally) used for two=20
purposes: optionally as a "main PRCM-provided functional clock" and=20
optionally as a system-provided pixel clock.

I'll reply to the rest of your mail in a separate E-mail...


- Paul

--155748971-642827763-1302271048=:22291--
