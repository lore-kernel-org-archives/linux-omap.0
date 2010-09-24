From: "Kalliguddi, Hema" <hemahk-l0cyMroinI0@public.gmane.org>
Subject: RE: [PATCH 8/9 v3] usb : musb: Using runtime pm apis for musb.
Date: Fri, 24 Sep 2010 14:23:00 +0530
Message-ID: <E0D41E29EB0DAC4E9F3FF173962E9E94027863E0DC@dbde02.ent.ti.com>
References: <1285201830-26561-1-git-send-email-hemahk@ti.com>
 <20100923063604.GE2563@legolas.emea.dhcp.ti.com>
 <87wrqc4gwd.fsf@deeprootsystems.com>
 <E0D41E29EB0DAC4E9F3FF173962E9E94027863DD4D@dbde02.ent.ti.com>
 <87fwx02wl5.fsf@deeprootsystems.com>
 <E0D41E29EB0DAC4E9F3FF173962E9E94027863E087@dbde02.ent.ti.com>
 <20100924084344.GJ8365@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100924084344.GJ8365-UiBtZHVXSwEVvW8u9ZQWYwjfymiNCTlR@public.gmane.org>
Content-Language: en-US
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Balbi, Felipe" <balbi-l0cyMroinI0@public.gmane.org>
Cc: Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Basak, Partha" <p-basak2-l0cyMroinI0@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, "Cousson, Benoit" <b-cousson-l0cyMroinI0@public.gmane.org>, Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Felipe,
 

>-----Original Message-----
>From: Balbi, Felipe 
>Sent: Friday, September 24, 2010 2:14 PM
>To: Kalliguddi, Hema
>Cc: Kevin Hilman; Balbi, Felipe; linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; 
>linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; Basak, Partha; Tony Lindgren; 
>Cousson, Benoit; Paul Walmsley
>Subject: Re: [PATCH 8/9 v3] usb : musb: Using runtime pm apis for musb.
>
>Hi,
>
>On Fri, Sep 24, 2010 at 03:16:29AM -0500, Kalliguddi, Hema wrote:
>>>I guess that's Felipe's call, but I don't like that option.
>>>
>>>I think it's cleaner to have the ->set_clock hook be a noop on OMAP
>>>and the runtime hooks be noops on the other platforms.
>>>
>>I think the set_clock function was used for setting the platform
>>specific clocks for different architecture. Anyway we need 
>this hook or
>>some other hook once we start handling the optional clocks 
>and internal
>>phy clocks for musb.  Since this is already exists I thought of making
>>use of it instand of adding another hook.
>>
>>Felipe, What do you say?
>
>Ideally we will get rid of those. It's only a matter of getting DaVinci
>to fully support clkdev. We should not have wrappers on top of clk
>framework neither pass down clock names as platform_data to driver,
>that's insane.
>
I think we will need to have some hooks for handling the clocks for
different platform as each platforms will have different clocks.
The way we are using set_clock is not the wrapper on top clock frameowrk,
it is a platform hook to enabling the clocks which still uses the clock framework.

~Hema

>-- 
>balbi
>--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
