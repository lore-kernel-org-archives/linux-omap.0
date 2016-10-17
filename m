From: "H. Nikolaus Schaller" <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
Subject: Re: [PATCH v4 7/8] drivers:input:ads7846(+tsc2046): fix spi module table
Date: Mon, 17 Oct 2016 18:52:51 +0200
Message-ID: <FB793B8D-2CFB-4070-9267-A6A9680C8B5C@goldelico.com>
References: <cover.1476712675.git.hns@goldelico.com> <70cc986f3cf98dd89f0460b5042083aad58a7366.1476712675.git.hns@goldelico.com> <acdf452f-01f2-27df-11c5-bb8db002394a@ti.com>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <acdf452f-01f2-27df-11c5-bb8db002394a-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Andrew F. Davis" <afd-l0cyMroinI0@public.gmane.org>
Cc: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, =?windows-1252?Q?Beno=EEt_Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Michael Welling <mwelling-EkmVulN54Sk@public.gmane.org>, =?windows-1252?Q?Mika_Penttil=E4?= <mika.penttila-MRsr7dthA9VWk0Htik3J/w@public.gmane.org>, Javier Martinez Canillas <javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>, Igor Grinberg <grinberg-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, letux-kernel-S0jZdbWzriLCfDggNXIi3w@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kernel@p
List-Id: linux-omap@vger.kernel.org


> Am 17.10.2016 um 17:54 schrieb Andrew F. Davis <afd-l0cyMroinI0@public.gmane.org>:
>=20
> On 10/17/2016 08:57 AM, H. Nikolaus Schaller wrote:
>> Fix module table so that the driver is loaded if compiled
>> as module and requested by DT.
>>=20
>> Signed-off-by: H. Nikolaus Schaller <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
>> ---
>> drivers/input/touchscreen/ads7846.c | 11 +++++++++++
>> 1 file changed, 11 insertions(+)
>>=20
>> diff --git a/drivers/input/touchscreen/ads7846.c =
b/drivers/input/touchscreen/ads7846.c
>> index 400e421..9a5d84d 100644
>> --- a/drivers/input/touchscreen/ads7846.c
>> +++ b/drivers/input/touchscreen/ads7846.c
>> @@ -1532,6 +1532,17 @@ static int ads7846_remove(struct spi_device =
*spi)
>> 	return 0;
>> }
>>=20
>> +static const struct spi_device_id ads7846_idtable[] =3D {
>> +	{ "tsc2046", 0 },
>> +	{ "ads7843", 0 },
>> +	{ "ads7845", 0 },
>> +	{ "ads7846", 0 },
>> +	{ "ads7873", 0 },
>> +	{ }
>> +};
>> +
>=20
> no space needed
>=20
>> +MODULE_DEVICE_TABLE(spi, ads7846_idtable);
>> +
>> static struct spi_driver ads7846_driver =3D {
>> 	.driver =3D {
>> 		.name	=3D "ads7846",
>>=20
>=20
> the MODULE_ALIAS below can now also be removed with this patch.

Ok! Noted for V5.

BR and thanks,
Nikolaus

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
