From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 00/21] OMAPDSS: DISPC changes for writeback pipeline
Date: Fri, 14 Sep 2012 11:46:32 +0300
Message-ID: <1347612392.2559.54.camel@deskari>
References: <1347538505-25359-1-git-send-email-archit@ti.com>
	 <1347611263.2559.44.camel@deskari>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-xP1g4GOkMwWWMzz6kEiC"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog130.obsmtp.com ([74.125.149.143]:46410 "EHLO
	na3sys009aog130.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752024Ab2INIqg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 14 Sep 2012 04:46:36 -0400
Received: by lagy9 with SMTP id y9so2556679lag.19
        for <linux-omap@vger.kernel.org>; Fri, 14 Sep 2012 01:46:34 -0700 (PDT)
In-Reply-To: <1347611263.2559.44.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <archit@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org


--=-xP1g4GOkMwWWMzz6kEiC
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2012-09-14 at 11:27 +0300, Tomi Valkeinen wrote:
> On Thu, 2012-09-13 at 17:44 +0530, Archit Taneja wrote:

> > This series prepares the low level DISPC driver(dispc.c) to configure w=
riteback
> > registers. The aim is to reuse most of the code as most of its register=
s are
> > like overlay or manager registers, and are configured in the same way i=
n most
> > cases. The first few patches rename dispc_ovl_* functions to dispc_plan=
e_*
>=20
> I'm not sure if the renaming causes more confusion than clarity... It
> kinda creates a mishmash of ovl/plane names, and the term "plane"
> doesn't really sound like it's a base for both overlays and wb. Could we
> consider the wb as a special case, and keep the ovl name for most of the
> things and have "wb" used for wb specific things?

And while WB is a combination of overlays and ovl managers, do you think
it'd be difficult to consider WB as a special, extended overlay? So just
call it an overlay, and consider it as an overlay with special features,
at least inside dispc.c. We probably need to have it as a totally
different entity from user's point of view (i.e. the list of overlays
wouldn't return WB, etc).

 Tomi


--=-xP1g4GOkMwWWMzz6kEiC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJQUu7oAAoJEPo9qoy8lh71cLcP/3z8g7Q3ri4JJnJCEf4yUorI
5kBgSLkOkt1il1E6g9wLiCURI5iphHO9rWDPMifXA6ozfNcZ4TNLRybOiRJWTtaX
4dxHBbH/SQJsqnVmAKFTNDWftq0Nwi1+k1Zj5bMkCfFka8bUNUUPmIRpwYG3Kp8V
8gAWNb8XeJw0Fx8c2WcUU0i80167zHF/0kzYYTPe8US/c+zQsjemqNJ3XnhA5YC2
KDXWCehHeSoUXSPe6oskrK6Pm7Pb5u6GqVyYkqfn6sLvgVzkOJeWfx6/WJIuf4qg
wFqhy+e3IkF/SE2hvl6nTes4igivY2hQdlcH2vAJ7uef5qvo4f3UG3ISqQwPu3lD
Qnqj6eOPuJ4dSxFfIZpkTyIKhFOKG/tbUVPjvfoUYWE3vRxUZaOzPWrnGpb2FHDf
2WZGcGMvDbL9Fgq6ddlWASKh+NJFMFRM/6+5IN3qK0iLOjJJfwk+rmvO7hfqJy/t
kaZeVO9xk2I4c3SJahJIC757wv3jcjL39bp0cRUnuHNjQyMONirp4oHNztPoPD13
g9hU+dB9Aj5qexL0SVCIJlJ3R/Tkriw76LTxhsYQsaj7cXAGf811PPDB1SFVOO/+
/a5u3FA5r8GgrZR7ebVtfV/GYShYeseraRGFgUzc7FmGgbwzRthxdrcDVSt5MkKl
iZBFpYwYkFMcUqTBonBA
=pX0o
-----END PGP SIGNATURE-----

--=-xP1g4GOkMwWWMzz6kEiC--

