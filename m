From: Felipe Balbi <felipe.balbi-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: RE: [RFC PATCH balbi-usb] usb: renesas_usbhs: usbhs_rcar3_notifier() can be static
Date: Thu, 14 Dec 2017 09:58:43 +0200
Message-ID: <87bmj1n3kc.fsf@linux.intel.com>
References: <201712140134.kYd2nFKY%fengguang.wu@intel.com> <20171213172052.GA27583@lkp-sb04.lkp.intel.com> <TY1PR06MB0992C0FA51F686B96E81628CD80A0@TY1PR06MB0992.apcprd06.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <TY1PR06MB0992C0FA51F686B96E81628CD80A0-/PRLmSCtZ16WJvbLRFYGcG0DtJ1/0DrXvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>, kbuild test robot <fengguang.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: "kbuild-all@01.org" <kbuild-all-JC7UmRfGjtg@public.gmane.org>, "linux-usb@vger.kernel.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap@vger.kernel.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

Yoshihiro Shimoda <yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org> writes:
> Hi,
>
>> From: kbuild test robot, Sent: Thursday, December 14, 2017 2:21 AM
>>=20
>> Fixes: 3a7cce26122e ("usb: renesas_usbhs: add extcon notifier to set mod=
e for non-otg channel")
>> Signed-off-by: Fengguang Wu <fengguang.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
>
> Thank you for the patch!
>
> Acked-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>

amended to patch which introduced the problem, thanks

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAloyLzMACgkQzL64meEa
mQYuRQ/9FOxY9cQ0yT7sbicku24rf3qyvfhsLO2GFNo9kcQRud7s0/XwWOKjtSG8
pHnF2U3JdcNzZj3ddbvWB5zybeaLynQjV4eJkY3H/dePwtaCWVO+0j3SPccBI5O3
mnzCkY3z9pVQxH6kfTFm0ezRJmZJJW8+XHPFW8XpYh+NcH/ANrLIddAyg6q/vt35
buLoi5WMBE40DlFjV9y/nulI7LJsnJHPSaz7cbBJNmSA2fERbL3X24+Jd30IVOLV
DdAMz9WcfmF5zudRbuD8ftUy2WZGPBM8udsA2Ochm7I0OfLnIFOMrs5z3y/aU6pV
VBceYjCG77Ke7qIXA9FDHAna20KrkWGdXHwoR7jBCTqMhVI/W766cG6PvZ0qxoAx
XliTS2583qf7qqOf4G+Sa4+sBsK5KadCBzIom9y4BkweTaPYSGng+pRkmN6Qrqr1
uWHX52I9g2lh29EOi9djgJTqlp6NPiXBwCwAZpiEHvY7jQmLCsNdxwDyxtJn7wV5
yhxcgXkylKej1tr8hhOeY78ETji1Unjrl6PyPL6oHcvSEgR2XH5CuNHDD4gTtlg6
bLm21bvbZEB7Kwp8ngd0qhRse2BwY1L+BOM0vcpHPhW2M+3r1mBDiGnkDUKSMQgE
gyOqum3GIoAGUJFoxDliNbKKxsNuTsMHGdEGmi9BseIF/LUEqZ4=
=R+dV
-----END PGP SIGNATURE-----
--=-=-=--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
