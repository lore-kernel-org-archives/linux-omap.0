From: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Subject: Re: [PATCH v2 6/8] usb: phy: omap: get rid of omap_get_control_dev()
Date: Fri, 16 Aug 2013 11:07:27 +0200
Message-ID: <520DEBCF.4@linutronix.de>
References: <1376572512-9561-1-git-send-email-rogerq@ti.com> <1376572512-9561-7-git-send-email-rogerq@ti.com> <20130815165152.GB10982@linutronix.de> <520DEA2B.5030608@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <520DEA2B.5030608-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Cc: balbi-l0cyMroinI0@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, kishon-l0cyMroinI0@public.gmane.org, george.cherian-l0cyMroinI0@public.gmane.org, dmurphy-l0cyMroinI0@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 08/16/2013 11:00 AM, Roger Quadros wrote:
>> I don't like that part where you can call this function even before the
>> driver probed the device. This shouldn't happen since you have hard module
>> dependency and the proper compatible string in your device. But this
>> kind of thing won't happen in the am335x reset driver.
> 
> I don't like that part either, but omap_control_usb_set_mode is being called
> from outside this driver (e.g. musb) and we are not making any changes to that behaviour
> in this patch.
> 
> I think the issue you mentioned is being fixed by Kishon's extcon migration series.

Okay then.

> 
> cheers,
> -roger
> 

Sebastian
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
