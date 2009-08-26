From: Niilo Minkkinen <niilo.minkkinen-X3B1VOXEql0@public.gmane.org>
Subject: Re: [PATCH] usb: disable OTG AUTOIDLE only with omap3430
Date: Wed, 26 Aug 2009 16:53:43 +0300
Message-ID: <fb705f540908260653l990f173n8b953ebc893efb9e@mail.gmail.com>
References: <1242658456-5723-1-git-send-email-ext-niilo.1.minkkinen@nokia.com>
	<13B9B4C6EF24D648824FF11BE8967162038BED5CF1@dlee02.ent.ti.com>
	<19F8576C6E063C45BE387C64729E73940436A4A15B@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <19F8576C6E063C45BE387C64729E73940436A4A15B-/tLxBxkBPtCIQmiDNMet8wC/G2K4zDHf@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Gupta, Ajay Kumar" <ajay.gupta-l0cyMroinI0@public.gmane.org>
Cc: "Woodruff, Richard" <r-woodruff2-l0cyMroinI0@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org" <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Wed, Aug 26, 2009 at 2:47 PM, Gupta, Ajay Kumar<ajay.gupta-l0cyMroinI0@public.gmane.org> w=
rote:
>> -----Original Message-----
>> From: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org [mailto:linux-usb-
>> owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org] On Behalf Of Woodruff, Richard
>> Sent: Tuesday, May 19, 2009 12:53 AM
>> To: Niilo Minkkinen; linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>> Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org
>> Subject: RE: [PATCH] usb: disable OTG AUTOIDLE only with omap3430
>>
>>
>> > From: linux-omap-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org [mailto:linux-omap-
>> > owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org] On Behalf Of Niilo Minkkinen
>> > Sent: Monday, May 18, 2009 9:54 AM
>>
>> > Omap3 MUSB AUTOIDLE functionality configured through OTG_SYSCONFIG
>> > register prevents the device from going into retention.
>> > This is a workaround (by Richard Woodruff/TI), as his comment :
>> > > A new MUSB bug which is a match to data below was identified ver=
y
>> > > recently (on hardware and in simulation).
>> > > This bug is in 3430 and not 3630.
>> > > As a priority test (and as new default) you should have engineer=
s
>> > > disable autoidle for MUSB block.
>> > > This is the workaround which will show up in next errata.
>> >
>> > Signed-off-by: Niilo Minkkinen <ext-niilo.1.minkkinen-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
>>
>> Signed-off-by: Richard Woodruff <r-woodruff2-l0cyMroinI0@public.gmane.org>
>>
>> Yes this is needed for 34xx. Side note is this cost around 1mW of po=
wer
>> during active mode of MUSB. When device is not active cost is not
>> significant. =A0System impact depends on duty cycle of MUSB in useca=
se.
>
> Richard/Niilo,
> =A0 =A0 =A0 =A0This should also be applicable to 35xx (right?) =A0and=
 so we got to
> update the fix with below patch.
>
> Regards,
> Ajay
>

Don't have access to spec/errata of 35xx just now ;).
Could Richard confirm, if this also applies (as original comment said) =
=2E

-niilo-
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D patch =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> There is an issue with MUSB AUTOIDLE as reported by Niilo Minkkinen i=
n below commit.
>
> 9a4b5e36ce58febdd2039dd4d129ee7edf4f5536
> usb: musb: disable OTG AUTOIDLE only with omap3430
>
> As OMAP35x is just a variant of OMAP34xx chip thus the fix is also ap=
plicable for OMAP35x so updating it for OMAP35x.
>
> Signed-off-by: Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
> ---
> =A0drivers/usb/musb/omap2430.c | =A0 =A02 +-
> =A01 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/usb/musb/omap2430.c b/drivers/usb/musb/omap2430.=
c index 453796c..ab8336d 100644
> --- a/drivers/usb/musb/omap2430.c
> +++ b/drivers/usb/musb/omap2430.c
> @@ -233,7 +233,7 @@ int __init musb_platform_init(struct musb *musb)
> =A0 =A0 =A0 =A0 * MUSB AUTOIDLE don't work in 3430.
> =A0 =A0 =A0 =A0 * Workaround by Richard Woodruff/TI
> =A0 =A0 =A0 =A0 */
> - =A0 =A0 =A0 if (!cpu_is_omap3430())
> + =A0 =A0 =A0 if (!cpu_is_omap3430() && !cpu_is_omap35xx())
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0l |=3D AUTOIDLE; =A0 =A0 =A0 =A0 =A0/*=
 enable auto idle */
> =A0 =A0 =A0 =A0omap_writel(l, OTG_SYSCONFIG);
>
> --
> 1.6.2.4
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
>>
>> Regards,
>> Richard W.
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-usb"=
 in
>> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>



--=20
---------------------------------
Niilo Minkkinen
Kalhontie 69C
40950 MUURAME
+358407324526
niilo.minkkinen-X3B1VOXEql0@public.gmane.org
----------------------------------
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
