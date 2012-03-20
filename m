From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH v2 7/7] ARM: OMAP2+: Mark omap_hsmmc_init and omap_mux
 related functions as __init
Date: Tue, 20 Mar 2012 09:30:51 +0200
Message-ID: <1332228651.2409.5.camel@lappy>
References: <1329997247-27342-1-git-send-email-rnayak@ti.com>
	 <1329997247-27342-8-git-send-email-rnayak@ti.com>
	 <1332148116.2144.1.camel@deskari> <1332152442.2144.27.camel@deskari>
	 <20120319180928.GA9859@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-JyeQkEsMo3qzd6YREmgf"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog133.obsmtp.com ([74.125.149.82]:39482 "EHLO
	psmtp.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751294Ab2CTHib (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 20 Mar 2012 03:38:31 -0400
Received: by mail-lpp01m010-f50.google.com with SMTP id m13so6822947lah.23
        for <linux-omap@vger.kernel.org>; Tue, 20 Mar 2012 00:38:30 -0700 (PDT)
In-Reply-To: <20120319180928.GA9859@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Rajendra Nayak <rnayak@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Russell King <rmk+kernel@arm.linux.org.uk>


--=-JyeQkEsMo3qzd6YREmgf
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2012-03-19 at 11:09 -0700, Tony Lindgren wrote:

> I've updated your patch a bit for the comments a bit and marked
> omap4_hdmi_mux_pads as __init, will apply to fixes. Updated patch
> below.

Hmm, is there something funny with these init changes now...

Initially the situation was that there were no __inits in display.c's
mux functions. Then "Mark omap_hsmmc_init..." patch added __inits to all
of them. My patch removed the __inits from dsi functions, but left them
to hdmi functions.

But now you modified my patch to add the __inits to hdmi functions.
Which should already have them from the "Mark omap_hsmmc_init..." patch.

 Tomi

--=-JyeQkEsMo3qzd6YREmgf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJPaDIiAAoJEPo9qoy8lh71mXMP/iUz2QNFhMbLYPq5tNPPQgmx
LOf5DBZAol0VGuh9D6pr7AlJe4lNmjyPIXbZdRlJaAE1pQCNkZL91fvJklMUlp2C
OnaYJBDB2PwS4948e9i01EZoK3qCNGy675HSMwwdRlAzhTZpf2EQu3nsIYix2eOf
46O5Cu6L5Cts6MBBAvsuXdK1fNkJZRnyvLu8skMfE18aQ3wvGPeg9yv5Kj4H+32r
3WLSgAXnFeBamCroSuTHbWPTq4wJTnKAdMM33sudyJdFEMRK6DSisgW5gSW3T7V9
vCIGKeZrebxPaV+yJO9VMr2UguIEHibKB4ffRKNQYxuQxFaO+6ARW9XscmogShg4
GuT1fCwojwICDfR8ip9eJLQEDUKKVQIYJFCXijh4m5S4w2qmBEFOyffYTPWA2DUm
o5pnBjWx9qNKhYOgHj6W6Miv7CuJGsVoa6tGHVdL3q1cEbhd40CN2m3uFYXnAYNY
D75y4PDKU6fv6OdvG3c23Uw5gQCvCXyj3OE4aa5sKPv6B2u20U5l8HD5n8pW69Il
+JUj+kf6jB3OfgURA/E5ltfC6gCFFmomNLwppIubUZIqK2EHeisqUaerv1nCGYex
PUMk+76V/aNghl8HQcATJyLMulyDDOlyN23nzRzoOv886LrCbrpAVkV/nS1c0Nga
rTSIjO7bKo4sib1yPOqs
=lVlc
-----END PGP SIGNATURE-----

--=-JyeQkEsMo3qzd6YREmgf--

