From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] usb: musb: drop superfluous pm_runtime calls around
 musb_shutdown
Date: Tue, 24 Jan 2012 11:52:46 +0200
Message-ID: <20120124095244.GB27414@legolas.emea.dhcp.ti.com>
References: <1326374498-22968-1-git-send-email-notasas@gmail.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="W7pZbPQLbZqmHLZM"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:58152 "EHLO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755734Ab2AXJww (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 24 Jan 2012 04:52:52 -0500
Content-Disposition: inline
In-Reply-To: <1326374498-22968-1-git-send-email-notasas@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grazvydas Ignotas <notasas@gmail.com>
Cc: Felipe Balbi <balbi@ti.com>, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, Hema HK <hemahk@ti.com>


--W7pZbPQLbZqmHLZM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 12, 2012 at 03:21:38PM +0200, Grazvydas Ignotas wrote:
> Since commit 4f9edd2d7e8d "usb: musb: Fix the crash issue during reboot"
> musb_shutdown() does pm_runtime_get_sync/pm_runtime_put by itself, so
> this no longer needs to be done by the caller. Also, musb_exit_debugfs()
> doesn't access the device, so just drop those runtime_pm calls.
>=20
> Signed-off-by: Grazvydas Ignotas <notasas@gmail.com>

applied, thanks

--=20
balbi

--W7pZbPQLbZqmHLZM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPHn9sAAoJEIaOsuA1yqREg/oP/i5BktkUerOHZy0qME3uT3P7
WxU/fS8vdJc8lFurOUWDhnQdFJZTRtSM+tkTySWqCl/R0AHKByniMAtWZ5wBo3Jq
mPP4mH/zbYcFZp68tNQQoj9eagiu4Amg66QynDjRvVoA+mmmRiHhFYXWfQgZKYI8
J9C9UozECqJ3W8BsprH5jbWG6f30YPiFCjJAS/XPp9vYbJ2hvGPOkXjBOQDjEcbP
PZjtc3tuSDlPZbE9+P3MDrXPmjK5bgEFs1ziIGQ16LfcVAAnwK9ZltDyFwQ6pwq4
8ouaR13l18zQDSA1OrsWQHPcN38+aNv92C9OPAWh+ieYQH2yQa/EP9cZg96jkCmf
jVOX1BSCWchvbAuwhrnaRKfwyZ9mM4JxGn8AHIQpuon9Vr1V7tyiKFJTD2tv5GZ2
Q+vsq+iy1eMv3zlCgPBdeGR6AN9CZQbpGT8AkmssJ0s18bKEL4pVxMMz62aAH6f8
Wx9JqBJ+0b4PN2yah7iaIdp6hDUdz4oJfKZea0QnG2pvQziuI5V30l/CYElO5fIW
IXWhzHfG2tPUxmCXNFf/XJyalT5nsBIkBggWlyh4IWjbDsATouQpYAp832kKK7Vh
6g0Fk1nCmoY2IJS6Z15y7dwhQt14/m3t8dxg3DrPO0JhknF8cGe6ZNPPHFDapKC/
s5As+zQXevbKggXIoHnA
=igPF
-----END PGP SIGNATURE-----

--W7pZbPQLbZqmHLZM--
