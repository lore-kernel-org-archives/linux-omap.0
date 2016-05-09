From: Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>
Subject: Re: [Kernel] [PATCH v2 4/5] ARM: dts: omap5: describe control for
 ckobuffer
Date: Mon, 9 May 2016 22:44:38 +0300
Message-ID: <ce5a9afb-77c3-b3b7-d651-aa3c1602f0db@ti.com>
References: <cover.1461003660.git.hns@goldelico.com>
 <a5fb89737594a656318896a8e43814c21ca992eb.1461003660.git.hns@goldelico.com>
 <20160426172710.GI5995@atomide.com>
 <70572DA1-BEB4-4681-BA6C-2E1C9002D730@goldelico.com>
 <5720B107.4000907@ti.com>
 <A90F1BFC-A834-4EC0-81F9-2C8222AAA010@goldelico.com>
 <5720C85B.9010701@ti.com> <ce9a7840-e86f-0d0c-3ed6-a571eec6659d@ti.com>
 <40536322-073F-48BD-9D07-32B9A9F07AF2@goldelico.com>
 <5721C3D4.7040401@ti.com>
 <2A9D82CD-9ACA-49F6-9D2B-9EACFC517914@goldelico.com>
 <57220EDD.7080903@ti.com>
 <F2BCD4BA-E4E4-43F4-B65C-B625ED3B2D13@goldelico.com>
 <573079F5.7050507@ti.com> <145c9917-6a85-292b-c3c9-cf85ceb26f21@ti.com>
 <f66cd508-fe53-af58-bda5-822c8213cf7d@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <f66cd508-fe53-af58-bda5-822c8213cf7d-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>, "H. Nikolaus Schaller" <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, =?UTF-8?Q?Beno=c3=aet_Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, kernel-Jl6IXVxNIMRxAtABVqVhTwC/G2K4zDHf@public.gmane.org, Marek Belisko <marek-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>, Discussions about the Letux Kernel <letux-kernel-S0jZdbWzriLCfDggNXIi3w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On 05/09/2016 03:32 PM, Peter Ujfalusi wrote:
> On 05/09/16 15:10, Peter Ujfalusi wrote:
>=20
>>>> finally I found some time to apply your patches. Sorry for the lon=
g time.
>>>>
>>>> Unfortunately, it does not work. Neither on omap5evm nor on our om=
ap5 hardware.
>>>> I get no sound on the twl6040 - just white noise (which can be con=
trolled in
>>>> level through
>>>> amixer so it is created on the digital input side of the twl6040).
>>>>
>>>> So I think your patch is missing a detail compared to my simple so=
lution.
>>>
>>> Did you implement anything on the audio driver side? The audio driv=
er must
>>> enable the clock implemented by this patch.
>>
>> I did, can test it in 10 minutes or so...
>=20
> might work, but linux-next is not booting on omap5-uevm :o I don't kn=
ow why...
>=20
> In any case I have attached the 3 patches I have for this, including =
Tero's
> ported to linux-next.
>=20
> Patch 3 might need to be done per board probably, but this should be =
good for
> testing.

Please ignore these patches, I got HPPLL mode working, I need to clean =
the
patches up first and I will send it for testing tomorrow.

--=20
P=C3=A9ter
--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
