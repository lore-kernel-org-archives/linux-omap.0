From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [RFC 08/17] OMAPDSS: DSI: Maintain own copy of timings in
 driver data
Date: Wed, 08 Aug 2012 10:10:47 +0300
Message-ID: <1344409847.17575.40.camel@lappyti>
References: <1343817088-29645-1-git-send-email-archit@ti.com>
	   <1343817088-29645-9-git-send-email-archit@ti.com>
	  <1344348462.7216.77.camel@lappyti> <5021FFDC.6080006@ti.com>
	 <1344406508.17575.12.camel@lappyti> <5022073B.6070109@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-5daVwLH1Jv04FJvb/8SF"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:52918 "EHLO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756889Ab2HHHKy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 8 Aug 2012 03:10:54 -0400
Received: by lago2 with SMTP id o2so235518lag.29
        for <linux-omap@vger.kernel.org>; Wed, 08 Aug 2012 00:10:51 -0700 (PDT)
In-Reply-To: <5022073B.6070109@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <a0393947@ti.com>
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, sumit.semwal@ti.com, rob@ti.com


--=-5daVwLH1Jv04FJvb/8SF
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2012-08-08 at 11:59 +0530, Archit Taneja wrote:

> I tried out rotation on Taal, and it only works for 180 degrees(and 0 of=
=20
> course), 90 and 270 result in no output. I'll add a=20
> dss_mgr_set_timings() in omap_dsi_update, that should sort of fix it,=20
> but someone would need to reconfigure the connected overlays too before=
=20
> trying out an update.

Right, but that's something omapdss/panel cannot do, it must be done by
the user. The same problem is there with changing, say, DPI mode also.

Btw, can you separate smaller cleanups/fixes to another patch series, to
make this series even slightly smaller? I think at least the first
patches in this series are quite separate, and the rotation fix is also.

 Tomi


--=-5daVwLH1Jv04FJvb/8SF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJQIhD3AAoJEPo9qoy8lh71UB8P/RwgUdFlNLQdIRtpV52ybvhf
5E2/PeJE0ZPYEYOt7pgRczYNDe/E/ZhZEcornhRfvGHt4886UXwKm+MQODieBIFv
EqXhctc19hISGRMXqCHooQWz2Epjfy6W7txrI4LcmsNDSfjaZpUh5l6tsnRbyAd7
3je5mEfE+DJyuXshEUH3Og0dIqNNjsF9z9wT0vvS8q1pnWf8lEva4bcAN4WfGmfC
hZTECxOI6sIy9BmvMqdx8/a0zvTG95Ert0BMFhf8Q0lrXmNF49qlSYzylRlGi/MK
L80Nqs5OW3VgiGjyov6Iz9WEm00AV7xV15eGlb+4a7Yw3heWHzJc0rPaFnfITuzM
XOXnb+2IjqzPPhUGke3hMV7uFqJT2Agj/4S+aZrsquc4g7iuX2bcRXjlouyweTpZ
D+R3ry/pPv3tAHFI9w5oVX+Nb0O/0eqO0DBXOBHze6C+W7FkDLqe0iqH8Te5nNjS
mN/vujj0BC/qVHGtEru3vtRiKZsEDvBG5b0DaNdUky9InE491oOkYj7YLbmpegm6
Y/UeAuD33UHHx+V7YEn7SqyrwkUsCA6VMyyKFruZ8B83V7RkkToLH7J4Oy1ezVrh
eg4SAeO8tWXqwmmNuiCsnqYPwfb5ujoTYBZiBwTa8kS6jVDpVsWXK18eFkKHiWnW
+goBIsWoPLO2yLAJm1K3
=f1aV
-----END PGP SIGNATURE-----

--=-5daVwLH1Jv04FJvb/8SF--

