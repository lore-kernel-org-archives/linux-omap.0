From: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 14/16] mfd: omap-usb-host: Support an auxiliary clock
 per port
Date: Wed, 21 Nov 2012 18:00:43 +0200
Message-ID: <50ACFAAB.9070704@ti.com>
References: <1352990054-14680-1-git-send-email-rogerq@ti.com> <1352990054-14680-15-git-send-email-rogerq@ti.com> <20121121135841.GO10216@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20121121135841.GO10216-S8G//mZuvNWo5Im9Ml3/Zg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: balbi-l0cyMroinI0@public.gmane.org
Cc: keshava_mgowda-l0cyMroinI0@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 11/21/2012 03:58 PM, Felipe Balbi wrote:
> On Thu, Nov 15, 2012 at 04:34:12PM +0200, Roger Quadros wrote:
>> Boards like Panda require an auxiliary clock to clock the PHY
>> that is connected to one of the USB ports. This patch enables
>> board support code to  provide the name and the rate of such
>> a clock for each of the USB ports. omap-usb-host driver can
>> then manage the clock.
> 
> that clock is part of the PHY. What we need is a proper PHY driver and
> teach [ouex]hci-core about PHYs.
> 
> I'd rather this wasn't merged...
> 

Okay.

cheers,
-roger
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
