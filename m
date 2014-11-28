From: Yegor Yefremov <yegorslists-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Subject: Re: USB OTG doesn't work in HOST mode on OMAP3 processor on 3.18-rc5
Date: Fri, 28 Nov 2014 11:35:53 +0100
Message-ID: <CAGm1_kvZnkB4MWPv3ExCqibb0Rq4xXfkPHHpfDb9HOTFNf7BiA@mail.gmail.com>
References: <CAFqH_53hyYO9DHfhzDhYkTnimKR0FOQuUw4OGCM4myKoOJSQRA@mail.gmail.com>
 <20141117180413.GF7046@atomide.com> <CAFqH_52LV8k6OyH04dUmhzZChnHrtJR23qu1ewhU49iOVT1Mwg@mail.gmail.com>
 <20141118154204.GI7046@atomide.com> <CAFqH_508pYkDXO8BCR=cFGFY_CgfkhqvseUy=Z--fJMOQCo6Tg@mail.gmail.com>
 <20141119175348.GK7046@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20141119175348.GK7046-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Enric Balletbo Serra <eballetbo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Wed, Nov 19, 2014 at 6:53 PM, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> wrote:
> * Enric Balletbo Serra <eballetbo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> [141119 03:14]:
>> 2014-11-18 16:42 GMT+01:00 Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>:
>>
>> Checked again, and no luck. It's very weird because from the OTG point
>> of view, OTG is exactly the same between Beagleboard-XM and IGEPv2.
>>
>> Can you confirm that you're using kernel 3.18-rc5 without other
>> patches applied ? At this moment, I don't have a Beagleboard-XM to
>> test, I'll try to get one because at this moment I'm a bit stuck with
>> this problem.
>
> Yes it was with v3.18-rc5 and the defconfig patch I posted except
> I had to disable all the other MUSB platforms. Also tested it with
> built in modules.
>
> Maybe you need to check the .dts pinctrl entries for hsusb0_* lines?

Just my 2 cents, My am335x based board shows similar symptoms
(CONFIG_USB_MUSB_DUAL_ROLE enabled). Only if I specify  dr_mode =
"host"; in my DTS I get device enumerated. 3.15, that I had before
made no problems as OTG.

Yegor
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
