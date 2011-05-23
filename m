From: Felipe Balbi <balbi@ti.com>
Subject: Re: [GIT PULL] USB patches for next merge window
Date: Mon, 23 May 2011 11:15:27 +0300
Message-ID: <20110523081524.GL3095@legolas.emea.dhcp.ti.com>
References: <20110518110353.GH13908@legolas.emea.dhcp.ti.com>
 <20110518114242.GI13908@legolas.emea.dhcp.ti.com>
 <20110523061346.GD3095@legolas.emea.dhcp.ti.com>
 <20110523101515.8c47e7a2.jhnikula@gmail.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="iAzLNm1y1mIRgolD"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:52005 "EHLO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751531Ab1EWIPf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 23 May 2011 04:15:35 -0400
Received: by bwz17 with SMTP id 17so6712475bwz.14
        for <linux-omap@vger.kernel.org>; Mon, 23 May 2011 01:15:32 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110523101515.8c47e7a2.jhnikula@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jhnikula@gmail.com>
Cc: balbi@ti.com, Tony Lindgren <tony@atomide.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>


--iAzLNm1y1mIRgolD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 23, 2011 at 10:15:15AM +0300, Jarkko Nikula wrote:
> On Mon, 23 May 2011 09:14:38 +0300
> Felipe Balbi <balbi@ti.com> wrote:
>=20
> > a gentle ping here too. Without this we will have regressions on
> > ehci/ohci as the pm_runtime patches have gone in via Samuel.
> >=20
> Does this mean that those regressions happened already when those
> patches were made if there is pull request dependency?

not really, no.

> Remember bisectability is important. And very important if you are
> bisecting something else but which is dependent on this as then you
> could mark wrong good/bad points or not able to determine.

True, true... I just wanted to avoid conflicts as much as possible so
arch/arm/*omap*/ goes through Tony, and drivers/mfd/* goes through
Samuel.

pm_rutime and hwmod conversion aren't really that tightly coupled. As
long as the arch code is in place, we can do pm_runtime at any time. Not
sure if it's true the other way around. But one thing is for sure, if
this pull request isn't taken, then I guess clocks won't enable on
omap-usbhs...

--=20
balbi

--iAzLNm1y1mIRgolD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJN2hecAAoJEAv8Txj19kN1SzoIAI6iaFWqEF45qSDG5vCvUvMd
J/wLBDTnyohCbok+mda0bH9p37pTZ0NqL5OlghMGOTkXCm5QTosLiQfAq9rMCjQQ
ZxK0dTf0PEY9AnmWzou3LQjwd0OiUldqeP2BXbfWTYOIKd0EQRM2geeJui0tc3ja
Vpfu9igqwxHP4PRRYubb8WcOOn+DF73/x1fSWgv5dk9iALQ96sCVk1ff0Qa9hB4P
1Q/vLCHSgaKDtwhbFDKsKuLIdbH4LkyEtl19F8IgNJntq5mJcxVUv7ax5thoiNLN
yxv0AlGovbcCLgm1IlkrxOyCQjproNxWvCsElBibOSIr9b8hD8G5LRaKF6Lt0ec=
=zrho
-----END PGP SIGNATURE-----

--iAzLNm1y1mIRgolD--
