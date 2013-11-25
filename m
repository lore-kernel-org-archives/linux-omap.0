From: Sebastian Reichel <sre@ring0.de>
Subject: Re: [PATCH v2 2/3] bq2415x_charger: Use power_supply notifier for
 automode
Date: Mon, 25 Nov 2013 18:14:21 +0100
Message-ID: <20131125171420.GA12995@earth.universe>
References: <1851041258.29554.1385398914287.JavaMail.apache@mail83.abv.bg>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ibTvN161/egqYuK8"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1851041258.29554.1385398914287.JavaMail.apache@mail83.abv.bg>
Sender: linux-kernel-owner@vger.kernel.org
To: =?utf-8?B?0JjQstCw0LnQu9C+INCU0LjQvNC40YLRgNC+0LI=?= <freemangordon@abv.bg>
Cc: Pavel Machek <pavel@ucw.cz>, pali.rohar@gmail.com, anton@enomsg.org, dwmw2@infradead.org, tony@atomide.com, linux@arm.linux.org.uk, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, aaro.koskinen@iki.fi
List-Id: linux-omap@vger.kernel.org


--ibTvN161/egqYuK8
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 25, 2013 at 07:01:54PM +0200, =D0=98=D0=B2=D0=B0=D0=B9=D0=BB=D0=
=BE =D0=94=D0=B8=D0=BC=D0=B8=D1=82=D1=80=D0=BE=D0=B2 wrote:
>> Now.. Imagine phone left in car in charger (on sun). Likely
>> temperature will reach high values, kernel is charging, dsme will
>> reboot the system, but kernel will start charging again, dsme will
>> reboot again, ...
>>
>> And it is not only high temperatures that are problem for li-ion
>> charging; battery should not be fast charged below 5C and should not
>> be charged below 0C. (Again, both are likely to happen if you leave
>> your phone in car).
>>
>> AFAICT, we should simply disable charging below 5C or above 45C.
>=20
> AFAIK dsme will not restart it, but power it off, so the above
> scenario won't happen.

Just assume what happens, when dsme does not start (e.g. system boot
hangs).

If everything is controlled from userspace, charger would not start
(-> safe!). If everything is controlled by the kernel, temperature
safety checks are taken (-> safe!). But in the currently proposed
variant: No safety checks.

-- Sebastian


--ibTvN161/egqYuK8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBCAAGBQJSk4VsAAoJENju1/PIO/qaEGcP/jYZKDCBRL4EB9qg7PofQDMn
kFoXcwp9wNPFP/JW78Gm0u5217oCTxZA4YQBt7N+Cfn//aJAMwJguJPbd5D0hyCu
SV7M0Wv4R7odatvk/OXcWGfvk9Ofid+6eaZRPDRwnDw6VTmHgmj15FdRk7a/w7K7
5IhZmAh4TBbIW2nKCF9mpZX5vqGBkvDvr5g+zQA6i9P3AtGaHDlYuTyQHIgX+DrW
urltahuq8BdhOFTefcQ3cnOI7Hap3h7ng24eXfkIVYkZv8vez7TrURzyTn+3ETqd
zyDRsLspvSKZUqTYd+kN/NkhYMhqtkBduZMkcOPA0htLFPp5Hz/Y2bNEH6VOBbi4
BLlqFREZBLgdL20O5+XsI3bwYjk/++wU4P15KeYrdDKOMC8d8W0e4oPlB4UDWw7s
iMe4gBXhgXup0sCn9/oebteRMoeQ0BnG9OtJUgt1Xn7RezIhC5DFAldejkEGSlWb
hMhZjGqAYhmj9JUGriklZSkUUR1yPuufDM0WmrK1t4zziq5XKIAEWb7ZAY3e1F2V
jObaCj4vGTJi/ZGyyeUC1p1hiJ2EdZ61GIf58cWt0fhisjrbSIbopE4h5Xzt4lLc
Y5ZbWyiMCCwK8ZqjbDNQFDr+m9XS1gFGJGOwKEFLNV6/eGjQ90OoRxvBryX2DYci
Fy/43Q/U8g9ksFw6LVx3
=rFmr
-----END PGP SIGNATURE-----

--ibTvN161/egqYuK8--
