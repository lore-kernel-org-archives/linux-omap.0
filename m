From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH v13 v14] mfd: omap: usb: Runtime PM support
Date: Thu, 13 Oct 2011 20:31:37 +0300
Message-ID: <20111013173134.GK28290@legolas.emea.dhcp.ti.com>
References: <1318319560-20500-1-git-send-email-keshava_mgowda@ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="u3W6riq+uV6J42Ub"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1318319560-20500-1-git-send-email-keshava_mgowda@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Keshava Munegowda <keshava_mgowda@ti.com>
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, balbi@ti.com, khilman@ti.com, b-cousson@ti.com, paul@pwsan.com, gadiyar@ti.com, sameo@linux.intel.com, parthab@india.ti.com, tony@atomide.com, johnstul@us.ibm.com, vishwanath.bs@ti.com
List-Id: linux-omap@vger.kernel.org


--u3W6riq+uV6J42Ub
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 11, 2011 at 01:22:40PM +0530, Keshava Munegowda wrote:
> From: Keshava Munegowda <Keshava_mgowda@ti.com>
>=20
> The usbhs core driver does not enable/disable the interface and
> functional clocks directly, These clocks are handled by runtime pm,
> hence instead of the clock enable/disable, the runtime pm APIS are
> used. however,the optional clocks and port clocks are handled by
> the usbhs core.
>=20
> Dependency:
> This patch is dependent on this series:
> [PATCH 0/5 v13 or latest version] omap: usb: host: Runtime PM preparation=
=20
> for EHCI and OHCI drivers.
>=20
> Validation performed:
> The global suspend/resume of EHCI and OHCI is validated on=20
> OMAP3430 sdp board with this patch combined with the series:
> [PATCH 0/5 v13 or latest version] omap: usb: host: Runtime PM preparation=
=20
> for EHCI and OHCI drivers.=20
>=20
> Signed-off-by: Keshava Munegowda <keshava_mgowda@ti.com>
> Reviewed-by: Kevin Hilman <khilman@ti.com>
> Reviewed-by: Partha Basak <parthab@india.ti.com>

Acked-by: Felipe Balbi <balbi@ti.com>

--=20
balbi

--u3W6riq+uV6J42Ub
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIbBAEBAgAGBQJOlyB2AAoJEIaOsuA1yqREAFYP8QFCdHHIf4NXoEOwIn9a4tHi
Y937Q8xIfKVHvfx18s8k2YmTlmfEt+47ptyiKf/ybq0cVhIc1iXJOc4BtSjeaAcp
7fXeI2ueqVvCCNRrUAeidyYASOn+shOgRwB95xU1jKvYXGzXYm3ZmD06w2qYQHEO
0QGj/PQlGmrIpuP+6wpOh7UjgFvQGRrJ2fJwG2mNE7teNXQzxooEDNeFBBBCHAo6
47eEfAAnQS2c+DR92NCjyMozJVVnHhWxqtIQyt1KfbhUF/C6ldZhVbiovz7/cYyE
43sBN9PGRDut4dkc6Upasa/LGYkWmq8smwO10VpWuVIdo7GvdvsyboKMRNLo0q2k
fe7Z4DxQqkvCo6ATDE6OaSWzs6JSuvQ3DXlPb6M46O5CgpodkIWPikTqSYu0ZCD2
wFlqYFF2Ya0QbwL9UuN4Gk0GLfxwJatog0RtNvWjL5Msi5mkHMnSxNfDfUYgc7hO
pV/xLOj/8stWqCyfd4LYPcw/kfBlnBcCUORF6UZf9gHYhDLznDuSn/QThhmFYFGR
tQQXJQgXHCLU1dn4Q2eRDuDSdQ5tTKDjmn6HB2q03l+1RGQE37uoNFfC25/ynBOr
Ilv4Y+E4cREIV2pNNXMddalMGhqvJLJ5UWtryDPzcrrBXQxGMH9KyvOHfCASGFpX
CSd8JgPBhmbDsd53o9w=
=l/GE
-----END PGP SIGNATURE-----

--u3W6riq+uV6J42Ub--
