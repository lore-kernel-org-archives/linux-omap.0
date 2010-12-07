From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 1/2] AM35x: musb: fix compilation error
Date: Tue, 7 Dec 2010 18:26:48 +0200
Message-ID: <20101207162645.GE2665@legolas.emea.dhcp.ti.com>
References: <1291231942.15533.32.camel@eowin>
 <19F8576C6E063C45BE387C64729E739404BCE398D7@dbde02.ent.ti.com>
 <20101202082904.GH5429@legolas.emea.dhcp.ti.com>
 <19F8576C6E063C45BE387C64729E739404BCE39A7E@dbde02.ent.ti.com>
 <20101203124317.GB2633@legolas.emea.dhcp.ti.com>
 <19F8576C6E063C45BE387C64729E739404BCE39E0D@dbde02.ent.ti.com>
 <20101206112003.GA17432@legolas.emea.dhcp.ti.com>
 <19F8576C6E063C45BE387C64729E739404BCE3A1B4@dbde02.ent.ti.com>
 <20101206121812.GC3693@legolas.emea.dhcp.ti.com>
 <19F8576C6E063C45BE387C64729E739404BCF8771E@dbde02.ent.ti.com>
Reply-To: balbi-l0cyMroinI0@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <19F8576C6E063C45BE387C64729E739404BCF8771E-/tLxBxkBPtCIQmiDNMet8wC/G2K4zDHf@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Gupta, Ajay Kumar" <ajay.gupta-l0cyMroinI0@public.gmane.org>
Cc: "Balbi, Felipe" <balbi-l0cyMroinI0@public.gmane.org>, Felipe Balbi <me-uiRdBs8odbtmTBlB0Cgj/Q@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Tue, Dec 07, 2010 at 07:25:12PM +0530, Gupta, Ajay Kumar wrote:
>Hi,
>> >> Is AM35x that different ? Can't you just write to MUSB_INTRRX
>> >> MUSB_INTRTX and MUSB_INTRUSB ??
>> >Writing to MUSB_INTRRX/TX/USB wouldn't help. We have to clear interrupt
>> >Bit in control register INTR_LVL_CLR.
>>
>> I see, thanks for the info :-)
>
>Felipe,
>
>I have recreated this patch (attached) on top of your patch
>set and AM35x is working.

applied it. Thanks

-- 
balbi
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
