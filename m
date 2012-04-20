From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH] OMAPDSS: VENC: allow switching venc type at runtime
Date: Fri, 20 Apr 2012 11:38:57 +0300
Message-ID: <1334911137.2058.8.camel@deskari>
References: <1332978312-11959-1-git-send-email-notasas@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-yt+o9uqC2gbTJ852GcTJ"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog131.obsmtp.com ([74.125.149.247]:43473 "EHLO
	na3sys009aog131.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751420Ab2DTIjD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 20 Apr 2012 04:39:03 -0400
Received: by lbom4 with SMTP id m4so4290014lbo.5
        for <linux-omap@vger.kernel.org>; Fri, 20 Apr 2012 01:39:00 -0700 (PDT)
In-Reply-To: <1332978312-11959-1-git-send-email-notasas@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grazvydas Ignotas <notasas@gmail.com>
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org


--=-yt+o9uqC2gbTJ852GcTJ
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2012-03-29 at 02:45 +0300, Grazvydas Ignotas wrote:
> VENC type (composite/svideo) doesn't have to be fixed by board wiring,
> it is possible to provide both connectors, which is what pandora does.
> Having to recompile the kernel for users who have TV connector types
> that's don't match default board setting is very inconvenient, especially

You don't have to recompile the kernel, you could just set the venc type
in the board file depending on a boot parameter.

> for users of a consumer device, so add support for switching VENC type
> at runtime over a new sysfs file venc_type.

I really dislike adding new custom sysfs entries for omapdss, and I'd
like to avoid them if at all possible. Do you need to change the venc
type during runtime, or is it enough that it can be set during boot?

 Tomi


--=-yt+o9uqC2gbTJ852GcTJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJPkSChAAoJEPo9qoy8lh71vDQQAJQD5bAawi6eL1EQkY/w1OI4
3J+vhcOnxOU7Oc30NUsxXCZmpOyhgNeGhMfwY1RywXuaYeVMXTwOSFYl37ZQa1F5
oLeaX2NS95fcuXB5En/4/1e3DzOILpt93Scqls4CSnWej+Rvi0k+TCxcrAjrKByr
umqhf31ExIg7bnpsemAFwoFJ0ZjJLWVNRoJ0AmnLON+7x9YDWJcFaumR2oFZiF0f
cjrNlh6kpLyI9ebIySUYIWT3+XFixrGyBrSMGGhy+BpLU5NxrlNcv3knOEJC80UN
3z5c/+Z9en954H8k2i02b2YXBIuf9WU5qH+cuHT3fB2SMYbmG2iBtitpW1DSsWvd
ZrJjLEO9fTf5p7IIC+mNx9A4TJoiXfo48zoLbdgtdWy74cYGOdnt5+FGU9gj2YJr
8JhsF1pPg/JoG1AdXBgRY4RHwe7ezSq/BvOuRd/oq/bRbzri8W29xA/2xQS9m9Uu
LEub4XQgJqK0VLgPL/FI1IPdATIBzHZ+qNIOXotyWPkcs4XvTU+4Xhj0Jg9T+Sor
66o8dAHyizjQrbTq3+YFCkoUBBNqgulegnzbu4RuL0W0ybi33uG0KCCPsc1jj8wU
YlV7hiuF05AcbfTWyc7z6Yn71ipuVlAew3XzBjQluZ35igBMrawAVSdAJcBZhs0J
Pc4Sq5nMz52OCaxBZwK1
=Hg51
-----END PGP SIGNATURE-----

--=-yt+o9uqC2gbTJ852GcTJ--

