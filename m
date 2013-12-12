From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 05/26] ARM: OMAP2+: add omapdss_init_of()
Date: Thu, 12 Dec 2013 09:30:11 +0200
Message-ID: <52A96603.5030709@ti.com>
References: <1386160133-24026-1-git-send-email-tomi.valkeinen@ti.com> <1386160133-24026-6-git-send-email-tomi.valkeinen@ti.com> <2199639.FbGhznOLP9@avalon>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="tf4jdftRMQf6xiCtGVqaeWIgKXg8NW1RL"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:42904 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751469Ab3LLHaR (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 12 Dec 2013 02:30:17 -0500
In-Reply-To: <2199639.FbGhznOLP9@avalon>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org, Archit Taneja <archit@ti.com>, Darren Etheridge <detheridge@ti.com>, Tony Lindgren <tony@atomide.com>

--tf4jdftRMQf6xiCtGVqaeWIgKXg8NW1RL
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 2013-12-12 01:10, Laurent Pinchart wrote:
> Hi Tomi,
>=20
> On Wednesday 04 December 2013 14:28:32 Tomi Valkeinen wrote:
>> omapdss driver uses a omapdss platform device to pass platform specifi=
c
>> function pointers and DSS hardware version from the arch code to the
>> driver. This device is needed also when booting with DT.
>>
>> This patch adds omapdss_init_of() function, called from board-generic =
at
>> init time, which creates the omapdss device.
>=20
> Is this a temporary solution that you plan to later replace with DT-onl=
y=20
> device instantiation ?

It's a long term task to remove the "virtual" omapdss device. Removing
the platform data that we pass has been very difficult.

For example, we need to get the OMAP revision to know which OMAP DSS
hardware we have. We can't get that information from the DSS hardware
(thank you, HW designers! ;).

Another is DSI pin muxing. I think we need a new pinmuxing driver for
that, or maybe change pinmux-single quite a bit. The DSI pinmuxing is
very simple, but the register fields are varying lengths and at varying
positions, so pinmux-single doesn't work for it.

 Tomi



--tf4jdftRMQf6xiCtGVqaeWIgKXg8NW1RL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJSqWYDAAoJEPo9qoy8lh71SWIP/AqkGhWSp32KXMkbsWL/TOx6
6+ER37WHhW0i9IUBsA1xuTKXMa/T2Cw2wz+0zlMD5FXB6AUlMFe2GwccPmrDwhG5
H7FNWjNLU4XgtqwuoAz7jQtfakOHcnz1BnNyFih7OJ1UIdoxtDv7KhpW0Pn9u4W+
iycTvgiLx8WTg319SVUhVX2W6y8MZKpADRqby51scteo+OJnuyPcnZrdt1Y7Xnux
mbx2HSFnJ7pV86ERHhz2VClgqHk/fvMe07cBvPBE40dMxJVy4jT9YtAsVFe8LIAA
2sE0Ve9EPzWJCd+AzN2aGaNu7tz6/03Hzu8k4sx+pARkfpR+D6wRS4vRA7uZtq4z
SJckEjcmuRIIux3of0KLnrLyxUgYvX5dVNJzVCtSNM5dIlhfqDfYQ/9gS5dsMbQ4
6eilfziWni2vPFoAy/zGUjdmS6mvByMEVvICGxGnJMSclc0eQ7kM0PYbwqPItMEC
N4ayOQbjsWXUfrGxqei9jd/TgcgVTXek+k4Yj1nx7epYhlzy9GvPi4ETjugPTx+V
oCT4/XJp/jv8TziLP9maYW6ihAB4A3PFU3VWObO4Tzbff79cUXclMSJSZS9SIfq7
CbTWPCHAbggOALStHNFj21Qfa6aFoY+8G5fuJ4B5+UViaZxpynwjZGxQ6y5o7XvI
F0y1QTzUfcaTMpEbbQ8v
=ZjTZ
-----END PGP SIGNATURE-----

--tf4jdftRMQf6xiCtGVqaeWIgKXg8NW1RL--
