From: "H. Nikolaus Schaller" <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
Subject: Re: [PATCH v8 3/8] drivers:input:tsc2007: add iio interface to read external ADC input and temperature
Date: Mon, 12 Dec 2016 22:21:25 +0100
Message-ID: <E4E31180-A686-4631-9713-519987C55F06@goldelico.com>
References: <cover.1479823354.git.hns@goldelico.com> <cover.1479823354.git.hns@goldelico.com> <99f236df48b03b3188e12f94a20097f8440db7a5.1479823354.git.hns@goldelico.com> <E42B1EF7-222E-46D6-878B-30C789CFBBC5@jic23.retrosnub.co.uk> <811B6F6A-2E3D-45B4-A984-74ABE0E37192@goldelico.com> <8d3fc752-e69c-f568-4f71-4f1768a3fffe@kernel.org> <AC7B3C1C-C05B-45B5-8426-5225F151DC26@goldelico.com>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <AC7B3C1C-C05B-45B5-8426-5225F151DC26-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Jonathan Cameron <jic23-tko9wxEg+fIOOJlXag/Snyp2UmYkHbXO@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, =?windows-1252?Q?Beno=EEt_Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Michael Welling <mwelling-EkmVulN54Sk@public.gmane.org>, =?windows-1252?Q?Mika_Penttil=E4?= <mika.penttila-MRsr7dthA9VWk0Htik3J/w@public.gmane.org>, Javier Martinez Canillas <javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>, Igor Grinberg <grinberg-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>, "Andrew F. Davis" <afd-l0cyMroinI0@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Alexander Stein <alexander.stein-93q1YBGzJSMe9JSWTWOYM3xStJ4P+DSV@public.gmane.org>, Eric Engestrom <eric-op+oiCINJLTt9jDmeYuA0g@public.gmane.org>, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Benjamin Tissoires <benjamin.tissoires-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi,


> Am 27.11.2016 um 16:47 schrieb H. Nikolaus Schaller =
<hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>:
>=20
> Hi Jonathan,
>=20
>> Am 27.11.2016 um 12:02 schrieb Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>:
>>=20
>> On 24/11/16 18:05, H. Nikolaus Schaller wrote:
>>>=20
>>>> Am 24.11.2016 um 18:38 schrieb Jonathan Cameron =
<jic23-tko9wxEg+fIOOJlXag/Snyp2UmYkHbXO@public.gmane.org>:
>>>>=20
>>>>=20
>>>>=20
>>>> On 22 November 2016 14:02:30 GMT+00:00, "H. Nikolaus Schaller" =
<hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org> wrote:

>=20
>> - hence cc'd Yann and the Kbuild list
>> to see if they can offer some advices.

no response / advice so far.

>=20
> Thanks!
>=20
> BTW, the other tsc2007 and ads7846 patches could already be merged (if =
there
> are no more changes needed) since this one only depends on the result =
of applying
> all others before.

I wonder if input maintainers can already merge the other patches of =
this patch series?

BR and thanks,
Nikolaus=
