From: Sergei Shtylyov <sshtylyov-hkdhdckH98+B+jHODAdFcQ@public.gmane.org>
Subject: Re: [patch-v2.6.34 8/9] arm: omap: musb: do not pass clock name to
 driver
Date: Wed, 30 Dec 2009 16:10:21 +0300
Message-ID: <4B3B513D.5070601@ru.mvista.com>
References: <1262127567-15202-1-git-send-email-felipe.balbi@nokia.com>	 <1262127567-15202-9-git-send-email-felipe.balbi@nokia.com>	 <4B3B3818.5030804@ru.mvista.com> <1262174106.28789.180.camel@gandalf>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1262174106.28789.180.camel@gandalf>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: me-uiRdBs8odbtmTBlB0Cgj/Q@public.gmane.org
Cc: Felipe Balbi <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hello.

Felipe Balbi wrote:

>>    It's not so actually. This depends on the matching mechanism 
>> established within clkdev: by device, by name, or by both. Not all 
>> implementations will match by device, e.g. DA8xx/OMAP-L1x will match by 
>> clock name.
>>     
>
> then it has to be fixed. The name shouldn't matter.

   It's not always feasible to do as you say. The same clock can be used 
by more than two drivers, or the clock may be used out of driver context 
altogether.

> This was a big
> discussion when Russell came up with the clkdev stuff and I remember
> clearly that clock names shouldn't be passed down to drivers because
> they don't matter.

   Why then there are two matching mechanisms in the clkdev code?

WBR, Sergei


--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
