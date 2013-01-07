From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: usb: multi phy support
Date: Mon, 7 Jan 2013 14:00:40 +0200
Message-ID: <20130107120040.GD11232@arwen.pp.htv.fi>
References: <C8443D0743D26F4388EA172BF4E2A7A93EA7FDA7@DBDE01.ent.ti.com>
Reply-To: <balbi-l0cyMroinI0@public.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="J5MfuwkIyy7RmF4Q"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <C8443D0743D26F4388EA172BF4E2A7A93EA7FDA7-Er742YJ7I/eIQmiDNMet8wC/G2K4zDHf@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Mohammed, Afzal" <afzal-l0cyMroinI0@public.gmane.org>
Cc: "Balbi, Felipe" <balbi-l0cyMroinI0@public.gmane.org>, "ABRAHAM, KISHON VIJAY" <kishon-l0cyMroinI0@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Nori, Sekhar" <nsekhar-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

--J5MfuwkIyy7RmF4Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jan 07, 2013 at 12:57:15PM +0100, Mohammed, Afzal wrote:
> AM335x SoC's used in boards like beagle bone has two instances of USB
> modules (2.0) at the hardware level, each having a dedicated phy.
> Currently in mainline, only one instance of USB is supported
> (including a fix in your latest pull request). To support multi
> instance, the biggest obstacle is lack of multi phy support for
> usb phy's of same type.
>=20
> Earlier Kishon was working on usb phy device tree support, later it was
> seen that generic phy layer was preferred. And Kishon posted a couple of
> versions on generic phy framework, latest being on 26th September 2012,
> but I could not see follow up's on that series.
>=20
> It seems Kishon is not now working on generic phy support. Let me know
> your opinion/suggestions on supporting usb phy's of same type. We are
> trying to get multi USB instance support in mainline for AM335x.

Kishon is still working on generic PHY layer indeed. Right Kishon ?

I believe he should be sending some newer version soonish...

--=20
balbi

--J5MfuwkIyy7RmF4Q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQ6rjoAAoJEIaOsuA1yqRE+1cP/icfBAVbByMkpkWjCrDKP0v6
WQKFw+aEs+VMunhDbH7MIFl/ksG21yAH5TDhOmfAKHn0h8p3+vIlqIE8eSL69kE1
aiNwRZi+2HFdtc0sONoijLsotS2Do17in7f5v42HgW3q5KlGn4iovuxK5ZwCA4iv
drl1WONWkkZWpk2W4tbP3FDjd71CS1BWjZQmlJDPJRzH8zGOH25dKUdV1Il1Ll5V
XohNHmFpBMNnN2UScXri7X2Ws9pLu8+JpEa7/g+GR1HBincnrYSbiyjEVBiwN5ld
T9I+xigT/bTbMeXawX6CKk6CEsqmr/pJc59jSqiCwMWj6SpobNHIX+1yTJLJvYIt
AMyQOzeATTvzedNE176U9uz1fpeU3yn3uagAC7YFyndyJmvrfbymRsLetVmH2exF
D3y7EWqXE/BlbNPyMt4EF4KmU9IBr7dtNZyVbEUTDfdg7nICT3F9vTawrtmQjHj4
47Ua3g0WA6ChEc4qJhDrRMVo1nhoClceNAfLPCPUnSF27IRo7/w5+7sDDUDUE/d1
Idjnub6qxeFwljHpyxNcLJfK8N2oGy5CwE6LVBRq7nDBEI6qXZU2ungFEZ4vrrwm
aoi46NudjykEqdC+m3f2XvaQoa/GyBA1VYCm6XybreH68lSdsfvy3VhO1go8LRTg
+ynlQYLaF/rM8oeLEcqP
=7l0J
-----END PGP SIGNATURE-----

--J5MfuwkIyy7RmF4Q--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
