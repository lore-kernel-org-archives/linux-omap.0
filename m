From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH v5 1/3] usb: dwc3: msm: Add device tree binding
 information
Date: Fri, 4 Oct 2013 09:31:51 -0500
Message-ID: <20131004143151.GD16059@radagast>
References: <1377091786-5613-1-git-send-email-iivanov@mm-sol.com>
 <1377091786-5613-2-git-send-email-iivanov@mm-sol.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="veXX9dWIonWZEC6h"
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1377091786-5613-2-git-send-email-iivanov@mm-sol.com>
Sender: linux-doc-owner@vger.kernel.org
To: "Ivan T. Ivanov" <iivanov@mm-sol.com>
Cc: balbi@ti.com, rob.herring@calxeda.com, pawel.moll@arm.com, mark.rutland@arm.com, swarren@wwwdotorg.org, ian.campbell@citrix.com, rob@landley.net, gregkh@linuxfoundation.org, grant.likely@linaro.org, idos@codeaurora.org, mgautam@codeaurora.org, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-msm@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

--veXX9dWIonWZEC6h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 21, 2013 at 04:29:44PM +0300, Ivan T. Ivanov wrote:
> From: "Ivan T. Ivanov" <iivanov@mm-sol.com>
>=20
> MSM USB3.0 core wrapper consist of USB3.0 IP from Synopsys
> (SNPS) and HS, SS PHY's control and configuration registers.
>=20
> It could operate in device mode (SS, HS, FS) and host
> mode (SS, HS, FS, LS).
>=20
> Signed-off-by: Ivan T. Ivanov <iivanov@mm-sol.com>

these patches were sent *ages* and nobody from DT mailing list has
reviewed. Unless someone steps up now, I'll be queueing these patches
next week.

--=20
balbi

--veXX9dWIonWZEC6h
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJSTtFXAAoJEIaOsuA1yqREnK4P/ib6IL8J9hQd/qnXfr3gP9I1
rSP0ywocsezTucEuyww4ztcMir7LYwfAdZp9Mb0Tlzz5XVNuQOxQ+ndOyP/+sa1x
rcDh+4sJ/KmH/6wgQX1ldDQoAyu0v84xcbDqW+317RORg1SxgOrTPDPQauJdm6Bi
Dpe+KiRD2pukoEWPVLgVd2ZJHuSTthqy05tyFW7wnpWLwwZlZ4z2fLsAYQ4zfcdr
N7BlG5X66ft334R96G1sdbefZ6WGK6R6sYoQc0l/TAgGcdyZnbFEZ++mL7i5iZs3
Sx5/vQa8XHczGyduBjsdMZ+BPETBmBLT6ps4FLy6TciZ2u8a8DoVRrefc8+scFz+
PK/E+M1de6XlmV/2Jdt5sS3MhBeiUph/A1p74rofgezzZQnckxB7Z+MBuuzdZ8BJ
blEk9g1846sqqkdqqkxpoX+zYczQ+YiHA7AcP/TNgwMV7wquYINHzfHGkmXUpbBR
PfhuKrjb+siSCI/mFxED+gNzOALvS8vYRjypokAOiG/r0D4GoOp2/UnatE6vs9rN
ntE6HQ21OgjCC7WsivwkfBQpWnra1lww92+wUO6AtJN25POKJRHfSQ1sFPLCDlqj
dbg4KUKb9ciqUotcBJMt0l0VPV6CGhI5JH180u83itaNdcpkr96owIdMBAHPzumW
HIybjD38hZO2XggXRxqy
=n24o
-----END PGP SIGNATURE-----

--veXX9dWIonWZEC6h--
