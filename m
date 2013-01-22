From: kishon <kishon-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v1 0/6] USB: Add support for multiple PHYs of same type
Date: Tue, 22 Jan 2013 21:46:33 +0530
Message-ID: <50FEBB61.9000707@ti.com>
References: <1358848694-20145-1-git-send-email-kishon@ti.com> <2D906ABA-71F2-4843-9DBE-F82527A1240A@dominion.thruhere.net> <50FEB3FD.3050001@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <50FEB3FD.3050001-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Koen Kooi <koen-QLwJDigV5abLmq1fohREcCpxlwaOVQ5f@public.gmane.org>
Cc: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, eballetbo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, javier-0uQlZySMnqxg9hUCZPvPmw@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org List" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Jason Kridner <jkridner-hcmAuCOw+vXj4SYmN/TMmA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi,

On Tuesday 22 January 2013 09:15 PM, kishon wrote:
> On Tuesday 22 January 2013 09:11 PM, Koen Kooi wrote:
>>
>> Op 22 jan. 2013, om 10:58 heeft Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
>> het volgende geschreven:
>>
>>> This patch series adds support for adding multiple PHY's (of same type).
>>> The binding information has to be present in the PHY library (otg.c) in
>>> order for it to return the appropriate PHY whenever the USB controller
>>> request for the PHY. So added a new API usb_bind_phy() to pass the
>>> binding
>>> information. This API should be called by platform specific
>>> initialization
>>> code.
>>>
>>> So the binding should be done something like
>>> usb_bind_phy("musb-hdrc.0.auto", 0, "omap-usb2.1.auto"); specifying
>>> the USB
>>> controller device name, index, and the PHY device name.
>>> I have done this binding for OMAP platforms, but it should be done for
>>> all the platforms.
>>>
>>> After this design, the phy can be got by passing the USB controller
>>> device
>>> pointer and the index.
>>>
>>> Developed this patch series on
>>> git://git.kernel.org/pub/scm/linux/kernel/git/balbi/usb.git xceiv
>>> after applying "usb: musb: add driver for control module" patch series
>>> and "ARM: dts: omap: add dt data for MUSB"
>>>
>>> Did basic enumeration testing in omap4 panda and omap3 beagle.
>>
>> With this patchset USB completely breaks on am33xx beaglebone, is that
>> intended?
> Not really.
> Does am33xx makes use of omap2430.c? Which PHY does am33xx uses?

I figured out it uses drivers/usb/musb/musb_dsps.c (So it doesn't use 
omap2430.c). I think it uses TWL4030_USB (TPS659x0) as PHY.

Then we need to adapt am33xx to use devm_usb_get_phy_by_phandle.
I'll see how to do it.

Thank you for testing and reporting it :-)

Thanks
Kishon
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
