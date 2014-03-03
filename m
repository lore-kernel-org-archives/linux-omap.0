From: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v9 0/9] USB Host support for OMAP5 uEVM
Date: Mon, 3 Mar 2014 11:34:52 +0200
Message-ID: <53144CBC.2050607@ti.com>
References: <1393510711-4697-1-git-send-email-rogerq@ti.com> <20140228225627.GU13624@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140228225627.GU13624-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi Tony,

On 03/01/2014 12:56 AM, Tony Lindgren wrote:
> * Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org> [140227 06:21]:
>> Hi,
>>
>> This patchset brings up USB Host ports and Ethernet port on
>> the OMAP5 uEVM board.
>>
>> It also does some cleanup with respect to DT clock binding
>> for the mfd/omap-usb-host driver.
>>
>> Please queue these for -next.
>>
>> Lee,
>>
>> I've folded some platform data dependent patches with mfd patches
>> so that they don't break functionality when applied individually.
>> You can safely pull in all MFD patches (1 to 6).
>>
>> Tony & Benoit,
>>
>> Can you please accept patches 7, 8 and 9?
> 
> Are 7, 8 and 9 safe to queue separately from the MFD changes
> or do they need to wait for the MFD changes to get merged
> first?
> 

They are safe to queue separately.

cheers,
-roger
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
