From: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 10/16] mfd: omap-usb-host: Intialize all available ports
Date: Tue, 27 Nov 2012 15:39:47 +0200
Message-ID: <50B4C2A3.5050908@ti.com>
References: <1352990054-14680-1-git-send-email-rogerq@ti.com> <1352990054-14680-11-git-send-email-rogerq@ti.com> <20121121135246.GL10216@arwen.pp.htv.fi> <50B4ADCA.5000909@ti.com> <20121127132827.GC22556@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20121127132827.GC22556-S8G//mZuvNWo5Im9Ml3/Zg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: balbi-l0cyMroinI0@public.gmane.org
Cc: keshava_mgowda-l0cyMroinI0@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 11/27/2012 03:28 PM, Felipe Balbi wrote:
> Hi,
> 
> On Tue, Nov 27, 2012 at 02:10:50PM +0200, Roger Quadros wrote:
>>> in fact, I would convert this construct into a switch which would look
>>> like:
>>>
>>> reg &= ~(OMAP4_P1_MODE_MASK << i * 2);
>>>
>>> switch (port_mode[i]) {
>>> case OMAP4_P1_MODE_TLL:
>>> 	reg |= OMAP4_P1_MODE_TLL << i * 2;
>>> 	break;
>>> case OMAP_P1_MODE_HSIC:
>>> 	reg |= OMAP4_P1_MODE_HSIC << i * 2;
>>> 	break;
>>> }
>>>
>>
>> Just realized that is_ohci_port() takes care of 10 cases, so I'll leave
>> it the way it was with if statement.
> 
> fair enough.
> 
>>> Also, it looks like the whoel for loop with port mode settings could be
>>> re-factored to a separate function to aid readability.
>>>
>>
>> it seems that the purpose of omap_usbhs_init() is to initialize
>> HOSTCONFIG so I see no point in adding another function for it. I can
>> clean it up for better readability though.
> 
> when functions get too big, it starts to become a little difficult to
> see bugs. Re-factoring parts of a bigger function, into smaller
> functions helps with that as long as the new functions are
> self-contained and logical. At the end of the day, GCC will inline the
> new smaller functions anyway.
> 

OK. I'll split the initialization of different revisions into different
functions.

regards,
-roger
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
