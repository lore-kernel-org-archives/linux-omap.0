From: "Pandita, Vikram" <vikram.pandita-l0cyMroinI0@public.gmane.org>
Subject: RE: [PATCH] usb: disable OTG AUTOIDLE only with omap3430
Date: Wed, 26 Aug 2009 20:22:05 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC35608702F9A44806@dbde02.ent.ti.com>
References: <1242658456-5723-1-git-send-email-ext-niilo.1.minkkinen@nokia.com>
 	<13B9B4C6EF24D648824FF11BE8967162038BED5CF1@dlee02.ent.ti.com>
 	<19F8576C6E063C45BE387C64729E73940436A4A15B@dbde02.ent.ti.com>
 <fb705f540908260653l990f173n8b953ebc893efb9e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <fb705f540908260653l990f173n8b953ebc893efb9e-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Content-Language: en-US
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Niilo Minkkinen <niilo.minkkinen-X3B1VOXEql0@public.gmane.org>, "Gupta, Ajay Kumar" <ajay.gupta-l0cyMroinI0@public.gmane.org>
Cc: "Woodruff, Richard" <r-woodruff2-l0cyMroinI0@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org" <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org



>-----Original Message-----
>From: linux-omap-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org [mailto:linux-omap-owner@vger.k=
ernel.org] On Behalf Of Niilo
>>> > Omap3 MUSB AUTOIDLE functionality configured through OTG_SYSCONFI=
G
>>> > register prevents the device from going into retention.
>>> > This is a workaround (by Richard Woodruff/TI), as his comment :
>>> > > A new MUSB bug which is a match to data below was identified ve=
ry
>>> > > recently (on hardware and in simulation).
>>> > > This bug is in 3430 and not 3630.
>>> > > As a priority test (and as new default) you should have enginee=
rs
>>> > > disable autoidle for MUSB block.
>>> > > This is the workaround which will show up in next errata.
>>> >
>>> > Signed-off-by: Niilo Minkkinen <ext-niilo.1.minkkinen-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
>>>
>>> Signed-off-by: Richard Woodruff <r-woodruff2-l0cyMroinI0@public.gmane.org>
>>>
>>> Yes this is needed for 34xx. Side note is this cost around 1mW of p=
ower
>>> during active mode of MUSB. When device is not active cost is not
>>> significant. =A0System impact depends on duty cycle of MUSB in usec=
ase.
>>
>> Richard/Niilo,
>> =A0 =A0 =A0 =A0This should also be applicable to 35xx (right?) =A0an=
d so we got to
>> update the fix with below patch.
>>
>> Regards,
>> Ajay
>>
>
>Don't have access to spec/errata of 35xx just now ;).
>Could Richard confirm, if this also applies (as original comment said)=
 .

There is an official errata on MUSB auto-idle not to be set:=20
Errata 1.164

There might be NDA issues with sharing the errata document, and so cann=
ot attach.
I have not come across a public omap errata document yet.

>
>-niilo-
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D patch =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> There is an issue with MUSB AUTOIDLE as reported by Niilo Minkkinen =
in below commit.
>>
>> 9a4b5e36ce58febdd2039dd4d129ee7edf4f5536
>> usb: musb: disable OTG AUTOIDLE only with omap3430
>>
>> As OMAP35x is just a variant of OMAP34xx chip thus the fix is also a=
pplicable for OMAP35x so
>updating it for OMAP35x.
>>
>> Signed-off-by: Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
>> ---
>> =A0drivers/usb/musb/omap2430.c | =A0 =A02 +-
>> =A01 files changed, 1 insertions(+), 1 deletions(-)
>>
>> diff --git a/drivers/usb/musb/omap2430.c b/drivers/usb/musb/omap2430=
=2Ec index 453796c..ab8336d
>100644
>> --- a/drivers/usb/musb/omap2430.c
>> +++ b/drivers/usb/musb/omap2430.c
>> @@ -233,7 +233,7 @@ int __init musb_platform_init(struct musb *musb)
>> =A0 =A0 =A0 =A0 * MUSB AUTOIDLE don't work in 3430.
>> =A0 =A0 =A0 =A0 * Workaround by Richard Woodruff/TI
>> =A0 =A0 =A0 =A0 */
>> - =A0 =A0 =A0 if (!cpu_is_omap3430())
>> + =A0 =A0 =A0 if (!cpu_is_omap3430() && !cpu_is_omap35xx())
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0l |=3D AUTOIDLE; =A0 =A0 =A0 =A0 =A0/=
* enable auto idle */
>> =A0 =A0 =A0 =A0omap_writel(l, OTG_SYSCONFIG);
>>
>> --
>> 1.6.2.4
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>
>>>
>>> Regards,
>>> Richard W.
>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-usb=
" in
>>> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.htm=
l
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-omap=
" in
>> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>>
>
>
>
>--
>---------------------------------
>Niilo Minkkinen
>Kalhontie 69C
>40950 MUURAME
>+358407324526
>niilo.minkkinen-X3B1VOXEql0@public.gmane.org
>----------------------------------
>--
>To unsubscribe from this list: send the line "unsubscribe linux-omap" =
in
>the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
