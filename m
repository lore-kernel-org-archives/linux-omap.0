From: "Premi, Sanjeev" <premi@ti.com>
Subject: RE: Mistral AM37x (with AM3715) devel board networking broken
Date: Wed, 10 Nov 2010 18:34:30 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB593023499226F@dbde02.ent.ti.com>
References: <E1PFgDD-0002jm-KX@amazonia.comcast.net>
 <AANLkTimwkLX2_WcfYYXA3QY1mPsKxbHAWmamWZLw3TUO@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:60882 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755994Ab0KJNEj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 10 Nov 2010 08:04:39 -0500
In-Reply-To: <AANLkTimwkLX2_WcfYYXA3QY1mPsKxbHAWmamWZLw3TUO@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gadiyar, Anand" <gadiyar@ti.com>, Rick Bronson <rick@efn.org>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org=20
> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Gadiyar, Anand
> Sent: Tuesday, November 09, 2010 10:32 AM
> To: Rick Bronson
> Cc: linux-omap@vger.kernel.org; Premi, Sanjeev
> Subject: Re: Mistral AM37x (with AM3715) devel board networking broke=
n
>=20
> On Tue, Nov 9, 2010 at 10:23 AM, Rick Bronson <rick@efn.org> wrote:
> > Hi Sanjeev,
> >
> > =A0Thanks much for the help.
> >
> >> I tried building the latest on l-o master and was able to=20
> boot consistently
> >> in 4 times I tried. Didn't notice the gpio clock related=20
> error I noticed in
> >> your boot log.
> >>
> >>
> >> U-Boot 2010.09 (Nov 08 2010 - 17:11:45)
> >>
> >> OMAP3630/3730-GP ES2.0, CPU-OPP2, L3-165MHz, Max CPU Clock 1 Ghz
> >> OMAP3 EVM board + LPDDR/NAND
> >
> > =A0Note that mine is ES1.0 (yours is ES2.0):
> >
> > OMAP3630/3730-GP ES1.0, CPU-OPP2, L3-165MHz, Max CPU Clock 1 Ghz
> >
> > =A0Not sure if that's any clue.
> >
>=20
> That's interesting - there shouldn't b e an ES2.0 of the=20
> 3630/3730. The highest
> revision is an ES1.2.
>=20

Now, I notice it too. Checking the u-boot sources now.

[snip]...[snip]

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
