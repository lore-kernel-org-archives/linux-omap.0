From: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 13/16] mfd: omap-usb-host: Get rid of unnecessary spinlock
Date: Wed, 21 Nov 2012 17:55:19 +0200
Message-ID: <50ACF967.30703@ti.com>
References: <1352990054-14680-1-git-send-email-rogerq@ti.com> <1352990054-14680-14-git-send-email-rogerq@ti.com> <20121121135732.GN10216@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20121121135732.GN10216-S8G//mZuvNWo5Im9Ml3/Zg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: balbi-l0cyMroinI0@public.gmane.org
Cc: keshava_mgowda-l0cyMroinI0@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 11/21/2012 03:57 PM, Felipe Balbi wrote:
> Hi,
> 
> On Thu, Nov 15, 2012 at 04:34:11PM +0200, Roger Quadros wrote:
>> We don't really need a spinlock here, so get rid of it.
> 
> can you prove it ? what if an IRQ happens right after disabling clocks
> on ->runtime_suspend() but before it returns ? Will this not cause a
> problem for you ?
>

Which IRQ are you referring to? I don't see any IRQ handler in
omap-usb-hot.c

In the original code, the spinlock is used only in
runtime_suspend/resume and probe functions and it didn't make any sense
to me why it was there in the first place.

> (note that I have not dug pm_runtime code to make sure this wouldn't
> cause a race).
> 

cheers,
-roger
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
