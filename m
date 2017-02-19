From: "H. Nikolaus Schaller" <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
Subject: Re: [PATCH v9 1/8] drivers:input:tsc2007: add new common binding names, pre-calibration, flipping and rotation
Date: Sun, 19 Feb 2017 18:04:14 +0100
Message-ID: <05F3816F-46E6-4BC2-9E2E-F20E645F7197@goldelico.com>
References: <9830dd21e6425e3a866fac6ed4cc73ddd58b719f.1482936802.git.hns@goldelico.com> <20170128193342.GB38136@dtor-ws> <1F6355E1-A5E3-41A6-908F-619A15581BEF@goldelico.com> <20170217204041.GE13050@dtor-ws> <20170218091526.GC8937@amd> <61F3C580-4BF2-4EE6-9DEC-FB8634434EC0@goldelico.com> <20170218180811.GB9377@amd> <27287BC5-E4E2-4F50-B140-C74D3CADED5B@goldelico.com> <20170218225435.GA4693@amd> <CC600A84-A5C8-4A8C-8CF4-B54C57DF73F3@goldelico.com> <20170219141715.GA7159@amd>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: multipart/signed; boundary="Apple-Mail=_AFF05A29-D6EB-4CDC-AFB0-0756510B7880"; protocol="application/pgp-signature"; micalg=pgp-sha256
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170219141715.GA7159@amd>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Cc: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, =?utf-8?Q?Beno=C3=AEt_Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Michael Welling <mwelling-EkmVulN54Sk@public.gmane.org>, =?utf-8?Q?Mika_Penttil=C3=A4?= <mika.penttila-MRsr7dthA9VWk0Htik3J/w@public.gmane.org>, Javier Martinez Canillas <javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>, Igor Grinberg <grinberg-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>, "Andrew F. Davis" <afd-l0cyMroinI0@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Alexander Stein <alexander.stein-93q1YBGzJSMe9JSWTWOYM3xStJ4P+DSV@public.gmane.org>, Eric Engestrom <eric-op+oiCINJLTt9jDmeYuA0g@public.gmane.org>, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Benjamin Tissoires <benjam>
List-Id: linux-omap@vger.kernel.org


--Apple-Mail=_AFF05A29-D6EB-4CDC-AFB0-0756510B7880
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=us-ascii

HI Pavel,

> Am 19.02.2017 um 15:17 schrieb Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>:
> 
> Hi!
> 
>> About loosing precision: there is already noise (jitter) in
>> real-world devices so that you can't achieve subpixel precision
>> anyways (unless your panel has a very low resolution). Please see my
>> answer to Dmitry some mails ago.
> 
> Maybe you can achieve better precision with averaging.

Can you? What do you want to average here? Multiple sequential measurements?
This makes the touch slower and hence imprecise and unuseable in another way.
Anyways, the tsc2007 chip can already do such averaging.

> 
> Anyway "input is already noisy" does not mean "so it is okay to
> degrade it more".

You have not yet said how you think it is degraded *more* than in your
example.

> Solve it properly. That means passing calibration
> data from kernel to userland.

As written before, the really proper solution would be to provide floating
or fixed point subpixel input events. Not arbitrarily scaling up in kernel
and leaving downscaling to user space (where everybody can make it worse).

But I don't think it is worth implementing subpixel touch events for real
world devices due to the jitter I mentioned.

BR,
Nikolaus


--Apple-Mail=_AFF05A29-D6EB-4CDC-AFB0-0756510B7880
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP using GPGMail

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJYqdAPAAoJEIl79TGLgAm65rEQAJ0mZZRtaztphNV8QN8Pmc3o
ouY5N7/rxvIyoC1nE94ieV3Ck4coCw3mDICbiVCB6yg0iIiji4HipuQLrUZAPKmn
WFXI+8GK5l68xMpgYug6+QuJw1dnD605H4FqEyIl+4Tt4TilhGgIYfvqEbIioidq
+qcjZCyS5zHpNp2hBDPIuL0KjO6QWa67QNU1QwK+5UAS1P93IbzJbfLsB1i+lORu
F/heq0u93HhNiOSPrhQ2SW/0erkXih+VFjOwkf8VGfHjdRNdLCrEuJ00vx6UY+uf
O4jqAyYVf3z8RFnzBBNh1lWUoUp3i+QNXZBrNORTaJ2NDxnFv2LYjRAzMLwM62gH
UTZ/jM7DLjw8MhhEVWYVpNUj2B//pyx2uCLCV6lrfHH68HTzFQBzE/nczN91A9nz
jWiAivF4HTT8cUTtplKzKjgxgTvFajNBQwdZZuueP5mmiIbMg7EPi7oSzDa0rKh5
AhAlvyphN69LxbQewnuww8nzqMdgymIkQ2oWDqoAYJNk6YWWQzdVuBdDVzoHnrsV
enl2Z4mJ+aIVkTbp3SrtI7vTb3HyJXhYs9TcRVzC3x9zy4gCdcjbRlyCAScx8fgz
9YhRwpwDEmWh+IB1IaUjohczo4ccMnii686NnL+WTjmKtm0F+fEufgRqLWQjA686
WQutmVEUZtsWD7UBj3Bv
=07bO
-----END PGP SIGNATURE-----

--Apple-Mail=_AFF05A29-D6EB-4CDC-AFB0-0756510B7880--
