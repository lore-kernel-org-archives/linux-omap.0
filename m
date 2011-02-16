From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 0/2] Add recommended bpp for omap dss2 generic dpi
 panels
Date: Wed, 16 Feb 2011 16:36:36 +0200
Message-ID: <1297866996.988.69.camel@deskari>
References: <1297530130-10355-1-git-send-email-daniel.morsing@gmail.com>
	 <1297861914.988.1.camel@deskari>  <1297865193.8777.8.camel@morsing>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:58089 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755658Ab1BPOgm (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 16 Feb 2011 09:36:42 -0500
In-Reply-To: <1297865193.8777.8.camel@morsing>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Daniel Morsing <daniel.morsing@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, Bryan Wu <bryan.wu@canonical.com>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Wed, 2011-02-16 at 08:06 -0600, Daniel Morsing wrote:
> Hi Tomi
>=20
> On Wed, 2011-02-16 at 15:11 +0200, Tomi Valkeinen wrote:
> > Hi,
> >=20
> > On Sat, 2011-02-12 at 11:02 -0600, Daniel Morsing wrote:
> > > The panel added is the 4.3 inch display that is sold with the
> > > Devkit8000.
> >=20
> > Hmm. Devkit8000's panel is connected with 24 datalines, according t=
o the
> > board file. Why do you want to use 16 bpp format for that?
> >=20
> >  Tomi
> >=20
>=20
> Running the panel at 24 bpp or specifying 16 datalines causes color
> distortion.
>=20
> The only way I've been able to run the panel without color distortion=
,
> is with 24 datalines and 16 bpp.
>=20
> I'm not well versed in displays, so I might be making a mistake
> somewhere. The BSP for the devkit8000 doesn't include a datasheet for
> the panel, so I can't look into what's causing this weirdness.

I don't think I'll add a feature which doesn't make sense, to fix a
problem we don't understand =3D).

A datasheet I found mentions

"One 4.3=E2=80=9D TFT LCD (With Touch panel, CHI HSIN LR043JC211 LCD
Model)"

And I found:

http://www.timll.com/chinese/download/files/CHILIN_TECHNOLOGY.pdf

It looks like 24bpp display.

What kind of color distortion do you see? Perhaps the problem is
somewhere else, like wrong horizontal sync, vertical sync or pixel cloc=
k
signal setting in .config field. This info should be in the panel
datasheet, but it usually takes some deciphering to understand it =3D).

 Tomi


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
