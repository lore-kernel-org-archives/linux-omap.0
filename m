From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCHv3 1/6] OMAP: move voltage.h and vp.h under platform
 include directory
Date: Mon, 18 Jul 2011 21:16:04 +0300
Message-ID: <20110718181604.GH25081@legolas.emea.dhcp.ti.com>
References: <1311010522-5868-1-git-send-email-t-kristo@ti.com>
 <1311010522-5868-2-git-send-email-t-kristo@ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MP5ln1Rcf9Bvi+ZW"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog105.obsmtp.com ([74.125.149.75]:37547 "EHLO
	na3sys009aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752739Ab1GRSQI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 18 Jul 2011 14:16:08 -0400
Received: by mail-ey0-f176.google.com with SMTP id 28so2762492eya.35
        for <linux-omap@vger.kernel.org>; Mon, 18 Jul 2011 11:16:07 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1311010522-5868-2-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@ti.com, tony@atomide.com, toddpoynor@google.com, broonie@opensource.wolfsonmicro.com, lrg@ti.com


--MP5ln1Rcf9Bvi+ZW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jul 18, 2011 at 08:35:17PM +0300, Tero Kristo wrote:
> This is needed so that these include files can be accessed from drivers.
>
> Signed-off-by: Tero Kristo <t-kristo@ti.com>
> ---
>  arch/arm/mach-omap2/voltage.h             |  180 -----------------------=
------
>  arch/arm/mach-omap2/vp.h                  |  128 --------------------
>  arch/arm/plat-omap/include/plat/voltage.h |  179 +++++++++++++++++++++++=
+++++
>  arch/arm/plat-omap/include/plat/vp.h      |  128 ++++++++++++++++++++
>  4 files changed, 307 insertions(+), 308 deletions(-)
>  delete mode 100644 arch/arm/mach-omap2/voltage.h
>  delete mode 100644 arch/arm/mach-omap2/vp.h
>  create mode 100644 arch/arm/plat-omap/include/plat/voltage.h
>  create mode 100644 arch/arm/plat-omap/include/plat/vp.h

just one small tip, if you use git format-patch -M, it would detect that
this was just a rename ;-)

--=20
balbi

--MP5ln1Rcf9Bvi+ZW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJOJHhkAAoJEAv8Txj19kN1fzEH/1M6kXEygXjxFxj/HRiqxr/w
7S/P4gz0oRJq3YRQc8J8YoE8t7+eO56KtY94zSFEfGgx6DzHYmZZqip2WCfoY6Rn
jsPBo4j+nd84YDHqTg5jheJzgwHkO8p31uHRgGAOFDoHr+rGyhvzvbyzMXmDAwBk
XXu4DgPJLK1yuYcY1z5y2lCYVvrHghTZ5/CWLWKSpvOjfAVvxHF5JOri07G1WbBK
dnYbTnR+pTexjRGTG2m8rOody2XaoP8i0C7SCFccMlMZpZxR/XyPVKbaRq+wQAJu
8QS5f3Z+TPWAOZddveQ1OAmZDrOw+KetRiWy5rEdUlwvOf+AZjgCkcQ8gHr3i4g=
=B7wl
-----END PGP SIGNATURE-----

--MP5ln1Rcf9Bvi+ZW--
