From: Felipe Balbi <balbi@kernel.org>
Subject: Re: [PATCH 06/12] usb: dwc3: omap: Replace the extcon API
Date: Wed, 30 Nov 2016 12:36:25 +0200
Message-ID: <877f7lntjq.fsf@linux.intel.com>
References: <1480485460-2663-1-git-send-email-cw00.choi@samsung.com> <1480485460-2663-7-git-send-email-cw00.choi@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1480485460-2663-7-git-send-email-cw00.choi@samsung.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, kishon@ti.com, sre@kernel.org
Cc: Peter.Chen@nxp.com, wens@csie.org, yoshihiro.shimoda.uh@renesas.com, maxime.ripard@free-electrons.com, b-liu@ti.com, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-renesas-soc@vger.kernel.org, cw00.choi@samsung.com, chanwoo@kernel.org
List-Id: linux-omap@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

Chanwoo Choi <cw00.choi@samsung.com> writes:
> This patch uses the resource-managed extcon API for extcon_register_notif=
ier()
> and replaces the deprecated extcon API as following:
> - extcon_get_cable_state_() -> extcon_get_state()
>
> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>

Acked-by: Felipe Balbi <felipe.balbi@linux.intel.com>

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIyBAEBCAAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAlg+q6kACgkQzL64meEa
mQbA7w/3YuSLgP+D33ztsoVHb9RW4Zw6/O766xYdrG4jFLLgWvNwOieBQ7mINv7D
1Sc3XGku02GkXrS1iLeKwb1sEXQkdhVWW5I4tb5mGiMQyLoorlNCm3N944w+fRAp
CEgS0aN/FCbHFeJX0z6VBkcAt8DGu9C5PWAr7sVUEzOowXJ07CGGzCA/m/qnhx+c
wLD2AvzGVhlUSSu+42RGjpGAezh/sSC9GB2cacfvr1SwX7/RqQo3tb5+D8tG7ZMK
w4xIcbxNf9C+9cdCjaAO2y3hgCNXGdyjd3TaVYigXezkDjCAYt7E90ksl6gL2UZ/
Qsn7Yf5KBCuaH7nGfdeE4a8hXOAcz+XlqKlwSMNa/A3HOp6TASWvnOKhCXerl0qR
A2Fpl+uejS9mQ45onCperQ4cex/g2fvWwUnKU+PtDOyChOdCMifZim21k+7lZumN
f3L8VKVBgmIz2cx9rfio5pNxE66V6rfe5ypXwDXc2Q7WklWqS7UDWQcwJ5XJVa91
JBmnfwXD/Ov6Vl8iFSGOSe+54OwtR/TB414twEvgLW+wy6G/Bm2JA2m+6Wh3ktJt
/fbZpNIQm98Ko88A5e9dWhMr9Fd/dOWe951JrNVeuvMg/EZgnbCCPVq8WPpbAvID
SD+xyabLGXzhrr0qHjj+GgP99nhKD/c1zL7/aoppCToGAHL8Pw==
=sFCQ
-----END PGP SIGNATURE-----
--=-=-=--
