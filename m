From: "H. Nikolaus Schaller" <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
Subject: Re: [PATCH v9 1/8] drivers:input:tsc2007: add new common binding names, pre-calibration, flipping and rotation
Date: Mon, 20 Feb 2017 17:49:53 +0100
Message-ID: <AE27E6D2-732F-47BB-8318-C5A7DF8A88B9@goldelico.com>
References: <cover.1482936802.git.hns@goldelico.com> <9830dd21e6425e3a866fac6ed4cc73ddd58b719f.1482936802.git.hns@goldelico.com> <20170128193342.GB38136@dtor-ws> <1F6355E1-A5E3-41A6-908F-619A15581BEF@goldelico.com> <20170217204041.GE13050@dtor-ws> <20170218032233.3qh5xdjbx5kkq5hm@earth> <95E59EB0-6F96-40BB-B74C-9CD56DDD7783@goldelico.com> <20170218234422.vza3toc3bphixsdn@earth> <FA96689F-AFD0-4FC9-95D9-639299341C8B@goldelico.com> <20170219201516.qw22o66t6zbolbgt@earth>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: multipart/signed; boundary="Apple-Mail=_42182033-5E06-43DC-9E0A-84CE55B3F722"; protocol="application/pgp-signature"; micalg=pgp-sha256
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170219201516.qw22o66t6zbolbgt@earth>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, =?utf-8?Q?Beno=C3=AEt_Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Michael Welling <mwelling-EkmVulN54Sk@public.gmane.org>, =?utf-8?Q?Mika_Penttil=C3=A4?= <mika.penttila-MRsr7dthA9VWk0Htik3J/w@public.gmane.org>, Javier Martinez Canillas <javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>, Igor Grinberg <grinberg-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>, "Andrew F. Davis" <afd-l0cyMroinI0@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Alexander Stein <alexander.stein-93q1YBGzJSMe9JSWTWOYM3xStJ4P+DSV@public.gmane.org>, Eric Engestrom <eric-op+oiCINJLTt9jDmeYuA0g@public.gmane.org>, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Benjamin Tissoires <benjamin.tissoires-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Petr
List-Id: linux-omap@vger.kernel.org


--Apple-Mail=_42182033-5E06-43DC-9E0A-84CE55B3F722
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

Hi Sebastian,

> Am 19.02.2017 um 21:15 schrieb Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>:
>=20
> Hi,
>=20
> On Sun, Feb 19, 2017 at 01:07:26PM +0100, H. Nikolaus Schaller wrote:
>> I don't really remember when we noticed it first. Maybe it was
>> back in tslib times some years ago where setting the sensitivity
>> threshold made problems. We then carried along our patch for a
>> long time in our local repo (and modified it several times) and
>> only started upstreaming some months ago. [...]
>>=20
>> AFAIK, GIMP and for example https://sourceforge.net/projects/xournal/ =
appear
>> to be able to handle X pressure, but I haven't running and tested =
either one
>> on our devices. Pressure is used in such drawing tools to simulate =
that some
>> physical pens make wider strokes on higher pressure.
>>=20
>> This seems to indicate that X can handle pressure in a non-boolean =
way, but rarely does.
>> Especially I think the usual menu, click, drag, scroll gestures are =
only based
>> on BTN_TOUCH status and not on ABS_PRESSURE. So it is rarely noticed =
to make
>> a difference.
>=20
> ok.
>=20
>>>>> I suggest to put the resistance vs pressure thing in its own =
patch,
>>>>> that also fixes tsc200x-core and merge it to linux-next after the
>>>>> merge window.
>>=20
>> Ok. I will propose a patch.
>=20
> Thanks. I suggest to add this in the patch description:
>=20
> While this patch changes the values reported to userspace,
> ABS_PRESSURE is used rarely by userspace. Most software only
> relies on BTN_TOUCH (boolean), which is not affected by this
> patch. Some graphics software makes use of the interface and
> does not work correctly with the currently used inverted
> behaviour.

Added. Patch set will come in some minutes (have to run checkpatch
first).

BR and thanks,
Nikolaus


--Apple-Mail=_42182033-5E06-43DC-9E0A-84CE55B3F722
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP using GPGMail

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJYqx4yAAoJEIl79TGLgAm67aAQAKpae9JClZrXx/CDUgDnFi+R
JUWteEZDBKN6/minjuGdk/RKv04X4g0WWhYdr6p2HkGldo6VTz+5bULeJVBTGZGl
XdpFMvBh9JwbVkxIL4CcyjPn+orCXPChh7OGbVkEkfD/8e2TLpw2gkEVKp8Y4T3L
3HEaJver3rfb7LbajAt2z/GyQC31RMIDIm90HFFoLo9zfzz7Hpp0TESAXf0bxiOg
zQxFqW/sI1grlAApmLqs7vYKyP1Upqr2VxCL8goFypribNju+pxbDNyPq7cjtUf2
geiaNjZuLeznCotltufm0ZjjJeVlvDCDHQiMTfF0vummhDYr7aAHbPvu0Rw5oUTi
H4wmo211oXUtSbL8pf53KkwixpxwIAkvvvCQ43TJruiZ+V0zWu4zOie8k+HBdv/s
fiKGv1h3BI7BoS9ItY3oP/zd520TIk7+4+ttAg0IAYwqYIkTy3RtsD4gt2O0DDd0
V0Qp4L0aUAe+G3ruoECnkDoV8v54th8WSuUT3M3et9u0+rXRiVakcWBUbPBWLRKN
0SDNiiYxy4VVXk/E02gLXFJjg6g4fc0oDcNF28vkdwORFQey2Rf1KgAhfXm3vFnm
rIgrsFydFG5ECZiZuKx00Ce09g8pU+xPm1jlZfuLfVXoCfnVWuxg1xhAMh9e5XHK
/qO76Ikq1cEV7yl6Gnzl
=eVZS
-----END PGP SIGNATURE-----

--Apple-Mail=_42182033-5E06-43DC-9E0A-84CE55B3F722--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
