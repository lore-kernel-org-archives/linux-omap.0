From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCHv7 01/18] I2C: OMAP: make omap_i2c_unidle/idle functions
 depend on CONFIG_PM_RUNTIME
Date: Wed, 11 Apr 2012 14:32:54 +0300
Message-ID: <20120411113254.GE12064@arwen.pp.htv.fi>
References: <1334142776-10583-1-git-send-email-shubhrajyoti@ti.com>
 <1334142776-10583-2-git-send-email-shubhrajyoti@ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ExIO7AL6tcaLjJBF"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog126.obsmtp.com ([74.125.149.155]:52365 "EHLO
	na3sys009aog126.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751384Ab2DKLdn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 11 Apr 2012 07:33:43 -0400
Received: by lbbgo4 with SMTP id go4so81955lbb.3
        for <linux-omap@vger.kernel.org>; Wed, 11 Apr 2012 04:33:40 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1334142776-10583-2-git-send-email-shubhrajyoti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Shubhrajyoti D <shubhrajyoti@ti.com>
Cc: linux-omap@vger.kernel.org, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, ben-linux@fluff.org, tony@atomide.com, w.sang@pengutronix.de


--ExIO7AL6tcaLjJBF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 11, 2012 at 04:42:39PM +0530, Shubhrajyoti D wrote:
> The functions omap_i2c_unidle/idle are called from omap_i2c_runtime_resume
> and omap_i2c_runtime_suspend which is compiled for CONFIG_PM_RUNTIME.
> This patch removes the omap_i2c_unidle/idle functions and folds them
> into the runtime callbacks.
>=20
> This fixes the below warn when CONFIG_PM_RUNTIME is not defined
>=20
>  CC      arch/arm/mach-omap2/board-ti8168evm.o
> drivers/i2c/busses/i2c-omap.c:272: warning: 'omap_i2c_unidle' defined but=
 not used
> drivers/i2c/busses/i2c-omap.c:293: warning: 'omap_i2c_idle' defined but n=
ot used
>   CC      net/ipv4/ip_forward.o
>=20
> Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>

how about just moving them into the #ifdef ? /me thinks it's easier to
read with the function. Matter of taste though, it's not that much code.

--=20
balbi

--ExIO7AL6tcaLjJBF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPhWvmAAoJEIaOsuA1yqRE+RcQAKffYkWNqPYIpI/jQW66jNaJ
pjZpl4QUggSfh7xdk60sv1kKpcT22W0gUqHY3rQ6omtvANayT5Zkqxv68VYb5FPT
QEduVz8sgkWIt0uj+l5/qIRQUpo26vDnEOZBEtcBIMWshwMG5BXIJAi6j0XfgkLB
fVbu4Tbz13b0XORRGWkmtZpoMnzCOOVqV5JY4NrUumBYM89b7qndRoEZtFfJapEU
BhuSj6Ie+WXiyfOagvRE7llso20XPGqBVGVKfimsc4EeIpGonuX2//JlUDOxmlZw
QUfG6ReYxdBdMQDQGzUihqaNnrMMDPcaSSe1eCkZn8ewaSor/ajGIQqbL30AFp32
sRVI++ZWJ62FrXS3U9Ttxh/TLJZdXOPLCoVX0gFFYMchhZbCjpW1XMvJFhMvs3d4
FPCS4yIRI8Pgygm27HRYUmDRnni+ZYD8Btq7OjKB5WN6ZdtahzcKlJEDKNWKgt8d
dhkocGCQfY8upQXlr9iR4oWZj6vqZOJvmsAlbR02FYSvggEpPx1q8HwMKY/So7Qq
8L8qMkZiekAOJPk1VusDSjQ9sEbMyva0dG1KEwuTFeTZX60jG0WMjrK5o8lpzWmo
AuvkGydh8V+h+69AqVzTGItbxqenWcH3EA+DNjvLGy6sy9FY1NDNj5gBQnjNFg4H
s4m6l4910zco6Z04Xxvn
=P1qq
-----END PGP SIGNATURE-----

--ExIO7AL6tcaLjJBF--
