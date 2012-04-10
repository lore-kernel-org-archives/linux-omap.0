From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH RESEND] Input: omap-keypad: dynamically handle register
 offsets
Date: Tue, 10 Apr 2012 13:16:11 +0300
Message-ID: <20120410101609.GJ20616@arwen.pp.htv.fi>
References: <1333430546-23454-1-git-send-email-sourav.poddar@ti.com>
 <20120410092441.GB20616@arwen.pp.htv.fi>
 <CAKdam56-Pu+WJKLUpodTzOzGuGbAHuqZ3F-zVmrAtFM7EDhxpg@mail.gmail.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VIOdPewhitSMo36n"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog117.obsmtp.com ([74.125.149.242]:50596 "EHLO
	na3sys009aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751514Ab2DJKRE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 10 Apr 2012 06:17:04 -0400
Received: by lbom4 with SMTP id m4so2995879lbo.11
        for <linux-omap@vger.kernel.org>; Tue, 10 Apr 2012 03:17:01 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAKdam56-Pu+WJKLUpodTzOzGuGbAHuqZ3F-zVmrAtFM7EDhxpg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Poddar, Sourav" <sourav.poddar@ti.com>
Cc: balbi@ti.com, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org


--VIOdPewhitSMo36n
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 10, 2012 at 03:37:28PM +0530, Poddar, Sourav wrote:
> Hi Felipe,
>=20
> On Tue, Apr 10, 2012 at 2:54 PM, Felipe Balbi <balbi@ti.com> wrote:
>=20
>     On Tue, Apr 03, 2012 at 10:52:26AM +0530, Sourav Poddar wrote:
>     > +static int kbd_write_irqstatus(struct omap4_keypad *keypad_data,
>     > +                                             u32 offset, u32 value)
>     > +{
>     > +     return __raw_writel(value, keypad_data->base + offset);
>     > +}
>     > +
>     > +static int kbd_write_irqenable(struct omap4_keypad *keypad_data,
>     > +                                             u32 offset, u32 value)
>     > +{
>     > +     return __raw_writel(value, keypad_data->base + offset);
>     > +}
>=20
>     if this only writes to irqenable, why do you pass offset as an argume=
nt?
>     likewise for irqstatus.
>   =20
>=20
> Actually, here the offset is the "irqenable" register addresss offset and
> "irqstatus" register
> address offset from the base address.
> Since, the above two address are different in case of Omap4 and omap5, we=
 are
> passing an offset
> depending on the particular revision of the keyboard selected during prob=
e.=20

but you already have those in keypad_data->irqenable/irqstatus right ?
Meaning you can access them directly here and save on the arguments:

static int kbd_write_irqenable(struct omap4_keypad *keypad_data, u32 value)
{
     return __raw_writel(value, keypad_data->base + keypad_data->irqenable);
}


--=20
balbi

--VIOdPewhitSMo36n
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPhAhpAAoJEIaOsuA1yqREbaYP/iltNwmlvBslipGluxCoBrRt
8vx7doisMtnIdMWuxnFVtkoGFuLn3aGkBiBLDzBwQcE+RSpzVCdOzAzJ1eJX1uxf
i8OnNia/TDC4o9qlPKbqrQLdBdfjte5FOLAYEBVq9uaUmGBPBS99sii3pQnDlOrK
7wiMILAm/bna12sGWpeiiV9AcXbqq+r9Fbr/CENnUrrEpd+84/l1LQ1cgEJ6vMRf
eH1z9JrOI4uNALA0eEgpb3Lh7KKtnH3YmmI/BFzuPKMJBLensdkXqdccHkDQ+nnO
GkI8ucvo48iaoGWvxzw29vF8w0gSF0KzolOT1gN39vuitorLKXc2cUkYdUHlelv8
+AdGjpjNi3qkGghGe1JIFQC/nkAAdbS9U8gtwpkmU6tcHdZ72v0wefAk4pO0x/ve
7mEMbUZpuniPGTItVsooJ8gVScjPGiUQHcB/X/RPkPPhe5fwTO3OUKPGMUkFBIGg
aCflrobQVJCdgALUy7+MxhiMJ7y/wjtRGiYlX1HTmfmSD0sn8gETD22eltpVtX/w
00/JMn0ZDl3mgl1qSFHwfiTCJDWLgFgr6Fz5avSoLU3ZgAsifbHCHjPVMX9yMbF2
XT5sfZnQmVWm+GganqEZV8A0is3rtSn6eH12WC9LoVQUDEWe+gXCrkbfv7vCYg1P
Ghd5rmR1d/1tXl2gsJXx
=2og5
-----END PGP SIGNATURE-----

--VIOdPewhitSMo36n--
