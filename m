From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH v2] OMAPDSS: HACK: Ensure DSS clock domain gets out of
 idle when HDMI is enabled
Date: Tue, 14 Feb 2012 15:15:11 +0200
Message-ID: <1329225311.1845.109.camel@deskari>
References: <1328854552-30714-1-git-send-email-archit@ti.com>
	 <1329220678.1845.68.camel@deskari>  <4F3A5A5D.4020906@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-gl9pnnLwRtcUiXcIXqMH"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:35872 "EHLO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1760250Ab2BNNPP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 14 Feb 2012 08:15:15 -0500
In-Reply-To: <4F3A5A5D.4020906@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: Archit Taneja <archit@ti.com>, linux-omap@vger.kernel.org, linux@arm.linux.org.uk, linux-fbdev@vger.kernel.org


--=-gl9pnnLwRtcUiXcIXqMH
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2012-02-14 at 13:58 +0100, Cousson, Benoit wrote:
> Hi Tomi,

> > Benoit, do you think we'll get the MODULEMODE mess cleaned up in the
> > hwmod/clk framework at some point, and the drivers could do without
> > these kinds of hacks? =3D)
>=20
> The best way to fix that for my point of view is to go to device tree=20
> or/and to consider the DSS as the parent of all the DSS modules.
> pm_runtime will then always ensure that the parent is enabled before any=
=20
> of the child are used.

Ah, right. Sounds fine to me.

But is that a proper "fix"? Are we sure the MODULEMODE will then always
be handled correctly? Isn't the core problem still there, it just
doesn't happen with the setup anymore?

I mean, if we have these special requirements regarding MODULEMODE, and
the code doesn't really know about it, would it get broken easily with
restructuring/changes?

And no, I don't have any clear idea why/how it would break, but I have
just gotten the impression that the MODULEMODE is not handled quite
properly (and so we have these current problems), and having dss_core as
the parent of other dss modules doesn't really fix that in any way.

 Tomi


--=-gl9pnnLwRtcUiXcIXqMH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJPOl5fAAoJEPo9qoy8lh71QdIP/jXpgJXNDYkUZL4B+RB4WCfC
m6m55DTez0mT8V2ChmO4zSaCJMcsHW2SrFI5D6233UNpmFEDDCZryChd3C+PA/+S
IPIBAFaMxF2PA1U1LQblKERDxfbDv9ERcurGMV1+Gvxcsm66994RAOMYHrXk5PTF
U3E+XDZhNepOmhI7vs76trmS74jBeSZXdHdn9ZI/mYP/mrnzbPuc2vVgBifFFxia
PU8mUc1hsHmmYbV2cI9cFL8x/Pq4T/17WJHa3rZmYcS1R1TNme9FcNzeAJ/aUq5P
671MSHMkJMYgnhaRLo8ai12a72nbvbiilgpNi8rGwu+kTJ95jwvKmfevjXHhAC6j
G0RU2LLFn6gtcboG81s2rLrYM0gon7P1GCrACyOCpOi0nUX89usgPUQmghfbZb90
gnHExyAnz6r5mrmKZD8ASNOC4rjWkCKw2aqoS0gIDTDT8n9UvZAKltBXcSGjez1a
IEb67tXrW0JYGnjyl2hcwO0aE55pksv3VadZOGIsASIIjfjqz0cin+q+CI8Xx4E/
Ms+9ssCcUblC/vfq/o5jnXUGZhIq6uF/hhWDwhIPoS9LYanHXMfgeesjWn0Br3M0
rtmf5ONAczVYrPPrSt/8KUcC6CTyiVzHV7H1WD5U5+JEb8vk6q/30csvnE7Aukgg
YJP94ix9hTVFNI8zbSKZ
=/Vd8
-----END PGP SIGNATURE-----

--=-gl9pnnLwRtcUiXcIXqMH--

