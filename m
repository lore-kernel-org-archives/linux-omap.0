From: Daniel Morsing <daniel.morsing@gmail.com>
Subject: Re: [PATCH 0/2] Add recommended bpp for omap dss2 generic dpi
 panels
Date: Wed, 16 Feb 2011 16:42:38 +0100
Message-ID: <1297870958.8777.21.camel@morsing>
References: <1297530130-10355-1-git-send-email-daniel.morsing@gmail.com>
	 <1297861914.988.1.camel@deskari>  <1297865193.8777.8.camel@morsing>
	 <1297866996.988.69.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:35498 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751094Ab1BPPmI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 16 Feb 2011 10:42:08 -0500
In-Reply-To: <1297866996.988.69.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Bryan Wu <bryan.wu@canonical.com>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Wed, 2011-02-16 at 16:36 +0200, Tomi Valkeinen wrote:
> On Wed, 2011-02-16 at 08:06 -0600, Daniel Morsing wrote:
> > Hi Tomi
> >=20
> > On Wed, 2011-02-16 at 15:11 +0200, Tomi Valkeinen wrote:
> > > Hi,
> > >=20
> > > On Sat, 2011-02-12 at 11:02 -0600, Daniel Morsing wrote:
> > > > The panel added is the 4.3 inch display that is sold with the
> > > > Devkit8000.
> > >=20
> > > Hmm. Devkit8000's panel is connected with 24 datalines, according=
 to the
> > > board file. Why do you want to use 16 bpp format for that?
> > >=20
> > >  Tomi
> > >=20
> >=20
> > Running the panel at 24 bpp or specifying 16 datalines causes color
> > distortion.
> >=20
> > The only way I've been able to run the panel without color distorti=
on,
> > is with 24 datalines and 16 bpp.
> >=20
> > I'm not well versed in displays, so I might be making a mistake
> > somewhere. The BSP for the devkit8000 doesn't include a datasheet f=
or
> > the panel, so I can't look into what's causing this weirdness.
>=20
> I don't think I'll add a feature which doesn't make sense, to fix a
> problem we don't understand =3D).
>=20
> A datasheet I found mentions
>=20
> "One 4.3=E2=80=9D TFT LCD (With Touch panel, CHI HSIN LR043JC211 LCD
> Model)"
>=20
> And I found:
>=20
> http://www.timll.com/chinese/download/files/CHILIN_TECHNOLOGY.pdf
>=20
> It looks like 24bpp display.
>=20

Ok I looked through the datasheet and it looks to me that i got
the .config field right. Only thing that's vague from that sheet is
which pixel clock edge the v-sync and h-sync are driven low and the
color distortion is still there with either option.

> What kind of color distortion do you see? Perhaps the problem is
> somewhere else, like wrong horizontal sync, vertical sync or pixel cl=
ock
> signal setting in .config field. This info should be in the panel
> datasheet, but it usually takes some deciphering to understand it =3D=
).
>=20
>  Tomi
>=20

I'm seeing a light cyan tint to everything when running at 24bpp. Using
16 datalines causes a heavy blue tint.

Regards,
Daniel Morsing




--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
