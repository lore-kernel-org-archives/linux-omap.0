From: Felipe Balbi <balbi@ti.com>
Subject: Re: [GIT PULL] USB patches for next merge window
Date: Mon, 23 May 2011 09:14:38 +0300
Message-ID: <20110523061346.GD3095@legolas.emea.dhcp.ti.com>
References: <20110518110353.GH13908@legolas.emea.dhcp.ti.com>
 <20110518114242.GI13908@legolas.emea.dhcp.ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tNQTSEo8WG/FKZ8E"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:60054 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750887Ab1EWGOq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 23 May 2011 02:14:46 -0400
Received: by fxm8 with SMTP id 8so3989623fxm.26
        for <linux-omap@vger.kernel.org>; Sun, 22 May 2011 23:14:44 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110518114242.GI13908@legolas.emea.dhcp.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>


--tNQTSEo8WG/FKZ8E
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, May 18, 2011 at 02:42:44PM +0300, Felipe Balbi wrote:
> Hi,
>=20
> forgot to Cc linux-omap. Sorry
>=20
> On Wed, May 18, 2011 at 02:03:53PM +0300, Felipe Balbi wrote:
> > Hi Tony,
> >=20
> > these patches are for 2.6.40 merge window.
> >=20
> > The following changes since commit 693d92a1bbc9e42681c42ed190bd42b636ca=
876f:
> >=20
> >   Linux 2.6.39-rc7 (2011-05-09 19:33:54 -0700)
> >=20
> > are available in the git repository at:
> >   master.kernel.org:/pub/scm/linux/kernel/git/balbi/usb.git for-tony-ne=
xt

a gentle ping here too. Without this we will have regressions on
ehci/ohci as the pm_runtime patches have gone in via Samuel.

--=20
balbi

--tNQTSEo8WG/FKZ8E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJN2fsaAAoJEAv8Txj19kN19cUH/iRZLXaM3Emo6boNS6g+IaEr
/NlsSd5DpKy0xb7wEIGOJDRHxBZzwTdT8/jeDMhh42MD0wdXbrWlq0XZLjfQ0QSV
G5VyarvaY1py8zOup1Af9q4Z8m/gVmQv9DuryEai+DBDr8wxzuC28Yaa7F+2RuhB
qEPQN2ZmvcPbs+oI6QF/2yvqn4e3cI/6OLeVhs646QKO4zOEd1N9CaGoglI+ZItA
wRg4jc0oVVuOEEgBfwGRhX6qcsl4M3Py2CFq3hMWVpCJE0hQTksSC5hyL4LhoH8T
kJN44eWj5WYbLJRsssbChnq0VLzYCY5Pu9VDcJYFNYY+Leaw887Q7IyHGC0O4/8=
=kzYm
-----END PGP SIGNATURE-----

--tNQTSEo8WG/FKZ8E--
