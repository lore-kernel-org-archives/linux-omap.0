From: Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>
Subject: Re: [Kernel] [PATCH v2 4/5] ARM: dts: omap5: describe control for
 ckobuffer
Date: Mon, 9 May 2016 18:28:12 +0300
Message-ID: <6c0e639c-31b9-b8af-85d6-187d3706595b@ti.com>
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
 <71c88d52-3737-6edb-52af-0b0f4a74efb2@ti.com>
 <3973330a-8a73-89fa-8e09-383407d0eaf9@ti.com> <57309A08.10704@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <57309A08.10704-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>, "H. Nikolaus Schaller" <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Discussions about the Letux Kernel <letux-kernel-S0jZdbWzriLCfDggNXIi3w@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, kernel-Jl6IXVxNIMRxAtABVqVhTwC/G2K4zDHf@public.gmane.org, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, =?UTF-8?Q?Beno=c3=aet_Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Marek Belisko <marek-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>, linux-omap <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On 05/09/2016 05:09 PM, Tero Kristo wrote:
>>> Applying Tero's alone makes the board not to boot, so something the=
re... I can
>>> not see anything even with low-level debugging enabled :( I can not=
 debug it
>>> further today, will look at this tomorrow.
>>
>> The crash is in arch/arm/mach-omap2/control.c:omap_control_init()
>>
>> the syscon_node_to_regmap() returns with error for the new
>> omap5_scm_wkup_pad_conf node. The other syscon was OK, but becasue o=
f the
>> return PTR_ERR(syscon) the board will not boot...
>>
>> Tero: any idea?
>=20
> I can check this tomorrow at my end.

Aargh, I think I know why, I have placed the omap5_scm_wkup_pad_conf no=
de to a
wrong place. The inline patch did not applied so I did it by hand...
I can boot test it tomorrow.

>=20
> -Tero
>=20
>>
>>>> In any case I have attached the 3 patches I have for this, includi=
ng Tero's
>>>> ported to linux-next.
>>>>
>>>> Patch 3 might need to be done per board probably, but this should =
be good for
>>>> testing.
>>>>
>>>>
>>>>
>>>> _______________________________________________
>>>> Kernel mailing list
>>>> Kernel-Jl6IXVxNIMRxAtABVqVhTwC/G2K4zDHf@public.gmane.org
>>>> http://pyra-handheld.com/cgi-bin/mailman/listinfo/kernel
>>>>
>>>
>>>
>>
>>
>=20


--=20
P=C3=A9ter
--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
