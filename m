From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 05/11] OMAPDSS: add clk_prepare and clk_unprepare
Date: Mon, 25 Jun 2012 09:07:58 +0300
Message-ID: <1340604478.12683.25.camel@lappyti>
References: <1340372890-10091-1-git-send-email-rnayak@ti.com>
	 <1340372890-10091-6-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-PHQvJXLvB6JEmDiDIp20"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog130.obsmtp.com ([74.125.149.143]:39117 "EHLO
	na3sys009aog130.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753172Ab2FYGIF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 25 Jun 2012 02:08:05 -0400
Received: by lbbgj10 with SMTP id gj10so7926015lbb.37
        for <linux-omap@vger.kernel.org>; Sun, 24 Jun 2012 23:08:01 -0700 (PDT)
In-Reply-To: <1340372890-10091-6-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: paul@pwsan.com, mturquette@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-fbdev@vger.kernel.org


--=-PHQvJXLvB6JEmDiDIp20
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, 2012-06-22 at 19:18 +0530, Rajendra Nayak wrote:
> In preparation of OMAP moving to Common Clk Framework(CCF) add clk_prepar=
e()
> and clk_unprepare() for the omapdss clocks.

You used clk_prepare and clk_unprepare instead of clk_prepare_enable and
clk_disable_unprepare. I didn't check the dss driver yet, but my hunch
is that the clocks are normally not enabled/disabled from atomic
context.

What does the prepare/unprepare actually do? Is there any benefit in
delaying preparing, i.e. is there a difference between prepare right
after clk_get, or prepare right before clk_enable? (And similarly for
unprepare)

 Tomi


--=-PHQvJXLvB6JEmDiDIp20
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJP6AA+AAoJEPo9qoy8lh71n5EP+gN1Ebrhs8AecEDX61XCmmkQ
c5QnmMDdhYoad3Gc2OxWDon4FKnjTHwm/OLN5qTr8dKUu7pYI9zsEy41D3cNID1Z
mf4M8/dXN2TFGNek0ZSImprtpcivSael/KAP7NQTTj1A0P6GACZrdk5DOIGORGvb
XNTynUnNSZ57q7bJlTngQP+KFOlykqSPlGqSiAKHyZJrW9k383pSxZxeFPcCe6r8
fl9fhA8PnJ/kFUl5oeczgdgG/1R4qJIiUucY9otyIMLoRXfyO70p7a6mIYZEkI5/
wh19jItytWQGhVU6YxMZ9pTL6cyHZMgs8BgE2jZohtSi8w5j9dVxAfOFqBKZvet2
DEsqOC5ahI8yRvyaE9KWqBWA9Be5MmkWS10ya5SzpBSyPNeJsPsgAYrMM7JED6Aj
Cm+G131ikoCQV6PMvdcpJUYltLyJfl0k00+FpnwX01NYmIbq/Ttyhi4si1k2ANeu
kd/4S4c2E7PKFXtR+Bw0rTPhfgTboMIGfD+c2+Xdq25v3caBhkPnfen77z7W2i3C
O/Dhix0g8z5pCwX9RACmOxD58AgKXodlt99ZcpWbQhDJaUaT8pz80N3NzZjF7O0b
zgsOJdK2zVGYx4OdlyO52if+mQM5R9qnLgK92LRbfM6uK8Mi11MpaOKsgQxeYK5F
DWksJ7La9TKpIiy0kcOX
=Kgcs
-----END PGP SIGNATURE-----

--=-PHQvJXLvB6JEmDiDIp20--

