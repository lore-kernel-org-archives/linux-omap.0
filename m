From: Eliad Peller <eliad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v6 5/6] ARM: dts: add wl12xx/wl18xx bindings
Date: Tue, 17 Mar 2015 09:02:33 +0200
Message-ID: <CAB3XZEeqKy2Zox0wvZmc-pJjCRzBcAXRFj2TjD=WGZjvnFuAqg@mail.gmail.com>
References: <1426162154-8716-1-git-send-email-eliad@wizery.com>
	<1426162154-8716-6-git-send-email-eliad@wizery.com>
	<CABxcv=mETO9ESVa04YjRO1d-h5ksEwvwGKb1G-jxVk6ttr9JYg@mail.gmail.com>
	<CAFqH_53D52WGDZUTv=w7SguTeROwrzmn9XLB+cTg-3y+Q4FxfQ@mail.gmail.com>
	<CAN692hmTGDDB3W5TtgfmQK5V9hUGpqVHpF=xK7F_v85cUjcRPw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAN692hmTGDDB3W5TtgfmQK5V9hUGpqVHpF=xK7F_v85cUjcRPw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Pau Pajuel <paupa13-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Enric Balletbo Serra <eballetbo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Javier Martinez Canillas <javier-0uQlZySMnqxg9hUCZPvPmw@public.gmane.org>, "linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, =?UTF-8?Q?Beno=C3=AEt_Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>, =?UTF-8?Q?Agust=C3=AD?= <afontquerni-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, eduard gavin <egavinc-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

that would be great. thanks.
i'll try posting the updated patchset (v7, some minor changes) tomorrow=
=2E

Eliad.

On Mon, Mar 16, 2015 at 3:08 PM, Pau Pajuel <paupa13-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> Hi,
>
> 2015-03-13 9:17 GMT+01:00 Enric Balletbo Serra <eballetbo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>:
>>
>> Hello,
>>
>> 2015-03-13 9:01 GMT+01:00 Javier Martinez Canillas <javier@dowhile0.=
org>:
>> > Hello Eliad,
>> >
>> > On Thu, Mar 12, 2015 at 1:09 PM, Eliad Peller <eliad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org> w=
rote:
>> >> Replace all the pdata-quirks for setting wl12xx/wl18xx
>> >> platform data with proper DT definitions.
>> >>
>> >> The patch was compile-tested only.
>> >>
>> >> Signed-off-by: Eliad Peller <eliad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>
>> >> ---
>> >
>> > I wanted to test your series but I realized that the IGEPv2 I've
>> > access is the old revision that has another SDIO wlan module inste=
ad
>> > of a Wilink8.
>> >
>> > Maybe Enric have the new revision? I also added to Pau Pajuel as c=
c
>> > who still works in the company manufacturing these boards so he sh=
ould
>> > be able to test it.
>> >
>>
>> Sorry, now I only have an old revision too, so I can't test, cc'ing
>> Agust=C3=AD that has access to the hardware, maybe he can test it or=
 he can
>> provide to us a board ;)
>>
>> > But in any case, your patch looks good to me so for the
>> > arch/arm/boot/dts/omap3-igep00* changes:
>> >
>> > Acked-by: Javier Martinez Canillas <javier-0uQlZySMnqxg9hUCZPvPmw@public.gmane.org>
>> >
>>
>> For my part also looks good.
>>
>> Acked-by: Enric Balletbo i Serra <eballetbo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>>
>> Best regards,
>>    Enric
>>
>> > Best regards,
>> > Javier
>
>
> I'm gonna test it this week. I added Eduard Gavin as cc too.
>
> Cheers!
--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
