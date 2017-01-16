From: Felipe Balbi <balbi@kernel.org>
Subject: Re: [PATCH v2 1/6] usb: dwc3: omap: Replace the extcon API
Date: Mon, 16 Jan 2017 12:31:33 +0200
Message-ID: <8760lfnvne.fsf@linux.intel.com>
References: <1483070895-8213-1-git-send-email-cw00.choi@samsung.com> <CGME20161230040816epcas5p4c76ef8f364678a34e2a0ff67b0119ef9@epcas5p4.samsung.com> <1483070895-8213-2-git-send-email-cw00.choi@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1483070895-8213-2-git-send-email-cw00.choi@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-renesas-soc@vger.kernel.org, chanwoo@kernel.org, Chanwoo Choi <cw00.choi@samsung.com>
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
> Acked-by: Felipe Balbi <felipe.balbi@linux.intel.com>

doesn't apply to testing/next. Please rebase

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAlh8oQUACgkQzL64meEa
mQbK1Q/9Glg/GViUfE0246K9RrHhso+Adn0yWOia/AZmKAE5AxVLpviYtYd/2AMZ
ZnBMSJXEv6D7ifPh4ddU3I9/s9UGhh97r8K9t5Y5KlTJchIaMKPXaace3FtxIsz2
vFtvKL42LT6MTlJdztaLK+N3+IrLx7yNPmh7gIK+ukE89gQntYVrfTclJOPleCQv
oYL/rXXNaXRSoANtqHwBwY/+iLmCVbVFO3oV8+BTnFvBGc4TPQrdYUzP61/Dwsnm
BehezXcCqevZLYSFvUNob7pK/CtW/jT/gUA8pyIj/44KNWzhtRb0AUQ97xcRD9jy
5Xl1nx7V5mmNG1YSKAesogT7qKKtu0vOYSJoqMRxrbdEh9kHS5nIw+3sQo/LguOT
yVUDb7C77z1MJ5eWncN/TIXwUp4XnB2JGi/eAk1L8ubdM7iUOW15WZc0IHLB2YVk
fcR/syelh17CpC8jZDb8XWlHEUvKKs3YGfeTkqy+uY+FXV9V5PvVVcMm3tSdkdZB
CDVHJZCLJl29U9gZJO+uahaRZOtNi2RtX9PSc3wdFJH1KCiTMgJLXIcpnXTi5Sz7
C260a9lQosmkq+0oLNnsRrMQJaL6augdKb1obKeyZ9oEd+S/ivhgtfKbb93mQu94
cc554u3AEg2mPECD+RDycWyVIdWhV7EnMUXomcbPmjUmwPr/y/w=
=IkTX
-----END PGP SIGNATURE-----
--=-=-=--
