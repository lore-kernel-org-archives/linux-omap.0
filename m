From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 12/23] drm: omapdrm: plane: update fifo size on atomic
 update
Date: Wed, 14 Dec 2016 10:43:18 +0200
Message-ID: <4c863692-d6d4-3940-b78e-3e7b9d114cad@ti.com>
References: <1457455195-1938-1-git-send-email-sre@kernel.org>
 <1457455195-1938-13-git-send-email-sre@kernel.org>
 <8209536.SBuD0B7HP3@avalon>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0536498856=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <8209536.SBuD0B7HP3@avalon>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, dri-devel@lists.freedesktop.org
Cc: Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Sebastian Reichel <sre@kernel.org>, Aaro Koskinen <aaro.koskinen@iki.fi>
List-Id: linux-omap@vger.kernel.org

--===============0536498856==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="xXiuDnCtLIaXRbXfrvSu3jA2tSBWg7Fd5"

--xXiuDnCtLIaXRbXfrvSu3jA2tSBWg7Fd5
Content-Type: multipart/mixed; boundary="a1BueXqdL9Uxn1xC3qGo8tapBJU2nak2V";
 protected-headers="v1"
From: Tomi Valkeinen <tomi.valkeinen@ti.com>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 dri-devel@lists.freedesktop.org
Cc: Sebastian Reichel <sre@kernel.org>, Tony Lindgren <tony@atomide.com>,
 Aaro Koskinen <aaro.koskinen@iki.fi>, linux-omap@vger.kernel.org,
 linux-kernel@vger.kernel.org
Message-ID: <4c863692-d6d4-3940-b78e-3e7b9d114cad@ti.com>
Subject: Re: [PATCH 12/23] drm: omapdrm: plane: update fifo size on atomic
 update
References: <1457455195-1938-1-git-send-email-sre@kernel.org>
 <1457455195-1938-13-git-send-email-sre@kernel.org>
 <8209536.SBuD0B7HP3@avalon>
In-Reply-To: <8209536.SBuD0B7HP3@avalon>

--a1BueXqdL9Uxn1xC3qGo8tapBJU2nak2V
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 13/12/16 19:35, Laurent Pinchart wrote:
> Hi Sebastian,
>=20
> Thank you for the patch.
>=20
> On Tuesday 08 Mar 2016 17:39:44 Sebastian Reichel wrote:
>> This is a workaround for a hardware bug occuring
>> on OMAP3 with manually updated panels.
>=20
> Could you please explain what the bug is and how the workaround operate=
s ? Do=20
> you have a reference to an errata document ?

I don't think I ever found out exactly why the problem happens. But on
OMAP3 DSI, the fifo thresholds had to be tuned slightly, otherwise DISPC
would stop. dispc_ovl_compute_fifo_thresholds() does that tuning if
"manual_update" parameter is set on OMAP3.

 Tomi


--a1BueXqdL9Uxn1xC3qGo8tapBJU2nak2V--

--xXiuDnCtLIaXRbXfrvSu3jA2tSBWg7Fd5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYUQYmAAoJEPo9qoy8lh71x+sQAKt1hGj4J6ZOy5iqntyzRHkM
Wixci6A/67VZ6PR16gE6V09XDFvim7mQSIDfgK+xR1S1Lg4ypZiuHWNloxxSQ6WD
m4crWOBLHURmBss0lDiJB2PFCqzBo0M2SVhcBJjTh5K2MavohPdWQKKuU2l6hI4c
dAnTdE8Ka+RgiO5UsRau8s/fTm3Itg6/nTSTvZyHRKI44Xs4Wizo0EsLDSPiwX0T
R6dYVtrqHM53xrrxRpbI+bJHwBoK+pCugNROlU/fLlzc/O6NOsRI0utAq9+8zjE/
JfMGZ0X+HkAMW8sqMi31cqEid75rhIBofPbW4gldEZ/O+HmBB0knql9iq+iNZGc0
wK4eK+5bEjpG0thl9walST/DNejrdEkz33pe9j3T9bV8jg2xhNdYxrR6zfAN8gYt
LnMcvv7UrFV6HTqy5esTCk1JtMb0cQkMwmsjGkot1kx7ZKMfZROLo3/tGTqceTXd
X30dxu5ECMIxtzFaUWztNCu4geXuoMVbnBF/LX1Iea6LEsGgCHlTYxEYC7F9TcXO
GApr+UXpwkHSWAg4pWieheCRHoVWMElt7rxUoF0UeQ0S7vs7zZEfXnk42MvcwBsg
kQYfJZfJ2x1RCIdpjRwMpdV7xmDifo6QRaO6YMRVAHJMZtjXA+UVXgc7aW0r0EBJ
VpQKh1/qyAOydhOFEVB8
=ncDS
-----END PGP SIGNATURE-----

--xXiuDnCtLIaXRbXfrvSu3jA2tSBWg7Fd5--

--===============0536498856==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==

--===============0536498856==--
