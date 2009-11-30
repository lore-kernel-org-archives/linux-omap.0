From: Tony Lindgren <tony@atomide.com>
Subject: Re: DSS2 panel question
Date: Mon, 30 Nov 2009 11:17:05 -0800
Message-ID: <20091130191705.GU4348@atomide.com>
References: <6ed0b2680911210716l529e02ck23e188417fecd4f1@mail.gmail.com>
 <1258974287.2438.76.camel@tubuntu.research.nokia.com>
 <5f4a33680911230941l468730f1k51cc26e2d6431b0c@mail.gmail.com>
 <6ed0b2680911250253h6a07fd41xeee6ca8fcb29f577@mail.gmail.com>
 <5f4a33680911250944t66ee6045wcf7f912d9f48f267@mail.gmail.com>
 <6ed0b2680911251224tb7bef3h6957106543aec283@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:63871 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752015AbZK3TRF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 30 Nov 2009 14:17:05 -0500
Content-Disposition: inline
In-Reply-To: <6ed0b2680911251224tb7bef3h6957106543aec283@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grazvydas Ignotas <notasas@gmail.com>
Cc: TAO HU <tghk48@motorola.com>, Tomi Valkeinen <tomi.valkeinen@nokia.com>, linux-omap@vger.kernel.org, TAO HU <taohu@motorola.com>

* Grazvydas Ignotas <notasas@gmail.com> [091125 12:23]:
> On Wed, Nov 25, 2009 at 7:44 PM, TAO HU <tghk48@motorola.com> wrote:
> > Hi, Grazvydas Ignotas
> >
> > What did you mean "Hm, omap_dss_register_device() takes omap_dss_dr=
iver"?
>=20
> Whoops, I meant omap_dss_register_driver()
>=20
> > Below is what I saw from the code
> > =A0int omap_dss_register_device(struct omap_dss_device *dssdev)
> >
> > I assume the code I have is for DSS. Does DSS2 change the API?
>=20
> I was referring to version that is being submitted to mainline, and
> panel drivers in particular, like:
> http://git.kernel.org/?p=3Dlinux/kernel/git/next/linux-next.git;a=3Db=
lob;f=3Ddrivers/video/omap2/displays/panel-generic.c;h=3Deb48d1afd80084=
37458bb3fe87e351b5ce785c42;hb=3DHEAD
>=20
> > BTW, what's the location for DSS2 code in linux-omap tree? Seems no=
t
> > see it anywhere
>=20
> Tony is probably waiting for it to reach mainline and fall from there=
=2E

Pulled Tomi's for-next now into linux-omap master branch for some last
testing before the merge window starts :)

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
