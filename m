From: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 00/16] OMAP USB Host cleanup
Date: Mon, 19 Nov 2012 12:11:15 +0200
Message-ID: <50AA05C3.7010003@ti.com>
References: <1352990054-14680-1-git-send-email-rogerq@ti.com> <87fw49cnvh.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <87fw49cnvh.fsf-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
Cc: balbi-l0cyMroinI0@public.gmane.org, keshava_mgowda-l0cyMroinI0@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Kevin,

On 11/16/2012 10:08 PM, Kevin Hilman wrote:
> Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org> writes:
> 
>> Hi,
>>
>> This patchset addresses the following
>>
>> - Avoid addressing clocks one by one by name and use a for loop + bunch
>>   of cleanups.
>> - Get number of channels/ports dynamically either from revision register
>>   or from platform data. Avoids getting clocks that are not present.
>> - Add OMAP5 and HSIC mode (Not tested)
>> - Save power on Panda when EHCI driver is not loaded.
>>
> 
> Seeing the clock changes/cleanups, I gave this a spin on OMAP3
> (3530/Beagle, 3530/Overo, 3730/Beagle-xM, 3730/OveroSTORM) to see if it
> fixed up the problem where CORE does not hit retention in idle when USB
> host is enabled, even with no devices attached.
> 
> Unfortunately, it didn't help. :(

oh that's bad. But this series wasn't meant to fix that ;).

I could take a look at it once I get hold of the serial cable to connect
to the beagle.

regards,
-roger
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
