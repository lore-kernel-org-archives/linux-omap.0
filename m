From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCHv2 3/7] i2c: omap: remove the dtrev
Date: Mon, 5 Nov 2012 09:53:20 +0200
Message-ID: <20121105075320.GD32468@arwen.pp.htv.fi>
References: <1352025873-27492-1-git-send-email-shubhrajyoti@ti.com>
 <1352025873-27492-4-git-send-email-shubhrajyoti@ti.com>
Reply-To: <balbi-l0cyMroinI0@public.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="hoZxPH4CaxYzWscb"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1352025873-27492-4-git-send-email-shubhrajyoti-l0cyMroinI0@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, b-cousson-l0cyMroinI0@public.gmane.org, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org
List-Id: linux-omap@vger.kernel.org

--hoZxPH4CaxYzWscb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Nov 04, 2012 at 04:14:29PM +0530, Shubhrajyoti D wrote:
> The dtrev is used only for the comments. Remove the same and use
> the scheme instead to know if it is version2.
>=20
> Signed-off-by: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>

I would drop dtrev completely and not use scheme to "emulate" it. dtrev
is wrong and unnecessary; it was only created due to the wrong
assumption that HW revision register was wrong. Looks like that
assumption was made based on the driver which is clearly wrong wrt
revision detection.

Also, when dropping dtrev, also drop it from platform_data and
omap_hwmod database (could be done on a separate patch).

--=20
balbi

--hoZxPH4CaxYzWscb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQl3BwAAoJEIaOsuA1yqREr8EP/14RGLWCojNbTUBPzjdK2ezJ
qYozNcA3Dw7cubUuyzuSTE/MyCbw4VDCwE3Pd/Oz5XTot0J72jT42BovGOlvwi3O
kqDVLDzEIBCeXk1HlnMfZjPIYvMIs6UcKke4D1WISuUMom9eB6mPiRDEk6LUF819
6TxQKVqjvk3Dv+tDuVRT3jO+lcPE/hnUxDcP+Q/4z7GZKc4AcPOooP9E3S65hdzd
B2/07VvbQc5DDvyjSoLA1MugamTdm/cJ+iW5/lRiGifalWHuLU9n0w28Ojpk5fCM
fGTArDcBXgxzELn1/zYbmZa8WZ1R95Tw1XmL3smXOiKz99ab7ZDiRmA6XIshj1y/
RwCfMn+add9gzzcobFAZnlmqe7xfWxtBLLLXt0JICoI/K+G7sjRhEVUcyhHHQK8a
t9F083rVROmAN3U6V05zaWR/Fuc83Y/69GKIx/bSwyv+3KZBQUmho+TBfSYp5eKN
gr/KnqF7v/AxmljvmyeHLexUiN4KI/oV1w9hXPx1B0Mty3wbNj9Qiy1hSplmbPUT
7Z60C0p682U33EEWsJjcZ8l4why1TZ02axyn+/vnd4upU3mCx/X/Mz/BqgEQ9LSv
hze6kcllIzPmdn3Vk65fo6f+6w5eGo5y0GDtMSgYKWllpcpSDQs+5T7umDGONUor
XN9feW6G4WXL5HrOoIb5
=wLGs
-----END PGP SIGNATURE-----

--hoZxPH4CaxYzWscb--
