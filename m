From: kishon <kishon@ti.com>
Subject: Re: [PATCH 2/5] drivers: usb: otg: make twl6030_usb as a comparator
 driver to omap_usb2
Date: Mon, 29 Oct 2012 14:54:24 +0530
Message-ID: <508E4B48.6090202@ti.com>
References: <1346943430-18236-1-git-send-email-kishon@ti.com> <1346943430-18236-3-git-send-email-kishon@ti.com> <CAH+eYFAj1ecvmiJCu8QDCr3LjHT5eXjq6zsZMiVRPROoWcDuNQ@mail.gmail.com> <CAAe_U6K1RXA3b5u9WvE=2VoXym9Vj3KM7c0J27jKz+2KrV4tsg@mail.gmail.com> <CAH+eYFAhVE8cAte2PFk3jinV9n3m+eDLtE43QxzRXMScnFGcrA@mail.gmail.com> <508AA94B.10504@ti.com> <508AAA85.6070905@ti.com> <20121026163619.GB11908@atomide.com> <508E45CF.70303@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:55041 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753334Ab2J2JYl (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 29 Oct 2012 05:24:41 -0400
In-Reply-To: <508E45CF.70303@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Benoit Cousson <b-cousson@ti.com>, Rabin Vincent <rabin@rab.in>, balbi@ti.com, devicetree-discuss@lists.ozlabs.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org

Hi,

On Monday 29 October 2012 02:31 PM, Roger Quadros wrote:
> Hi Tony,
>
> On 10/26/2012 07:36 PM, Tony Lindgren wrote:
>> * Benoit Cousson <b-cousson@ti.com> [121026 08:23]:
>>> Hi Roger,
>>>
>>> On 10/26/2012 05:16 PM, Roger Quadros wrote:
>>>> Hi Kishon & Benoit,
>>>>
>>>> On 09/24/2012 12:06 PM, Rabin Vincent wrote:
>>>>> 2012/9/24 ABRAHAM, KISHON VIJAY <kishon@ti.com>:
>>>>>> On Sat, Sep 22, 2012 at 3:03 AM, Rabin Vincent <rabin@rab.in> wrote:
>>>>>>> USB doesn't work on pandaboard on linux-next, and bisection shows this
>>>>>>> patch.  Unfortunately, I can't provide a dmesg log because USB is the
>>>>>>> only way I currently have to get one out(!), but presumably it's because
>>>>>>> this omap-usb2 device is never registered?  Looks like this breaks
>>>>>>> non-dt USB on pandaboard; is that intended?
>>>>>>
>>>>>> Yes. omap-usb2 is *only* dt supported (New drivers shouldn't have the
>>>>>> old non-dt support).
>>>>>
>>>>> Well, USB used to work fine on Pandaboard without DT before the
>>>>> introduction of "omap-usb2", so one would expected it to continue
>>>>> working (until the board file is completely removed).
>>>>>
>>>>> Anyway, I've moved to DT now.
>>>>>
>>>>>> Some patches are queued only for 3.7.
>>>>>>
>>>>>> In case you want to use MUSB please use these patches on linux-next..
>>>>>> [PATCH v2] arm: omap: hwmod: make *phy_48m* as the main_clk of ocp2scp
>>>>>> [PATCH] ARM: OMAP2+: hwmod data: Fix ocp2scp_usb_phy and usb_host_hs
>>>>>> entries (from Benoit)
>>>>>> [PATCH 0/2] ARM: dts: Add subnode for ocp2scp (patch series)
>>>>>> [PATCH v3 0/3] ARM: dts: omap: add dt data for MUSB (patch series)
>>>>>
>>>>> I got these by merging in Benoit's for_3.7/dts_part2 on top of
>>>>> next-20120921.  Thanks.
>>>>> --
>>>>> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
>>>>> the body of a message to majordomo@vger.kernel.org
>>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>>>
>>>>
>>>> I still can't get musb to work on 3.7-rc2. Apparently it is still
>>>> missing the patches from Benoit's for_3.7/dts_part2.
>>>>
>>>> Maybe I just need to wait for it to be merged?
>>>
>>> They are now in a for_3.8/dts. Unfortunately, one patch that was adding
>>> ctrl_module address in the USB data was rejected and thus I'm not sure
>>> it will work without that.
>>>
>>> I think Tony had an idea to map the ctrl_register to regulator fmwk or
>>> something like that.
>>
>> For device tree, we may be eventually able to handle the ctrl_register
>> using pinctrl-single.c and pinconf API. It probably does not make
>> sense to set it up as a regulator as the comparator can trigger errors
>> also for the pinconf related bits at least for MMC PBIAS.
>>
>>>> Till then, where can I get a tree where musb works on Panda?
>>
>> On panda, without using device tree, use v3.7-rc2 + the following patches:
>>
>> ARM: OMAP: ocp2scp: create omap device for ocp2scp
>> ARM: OMAP4: add _dev_attr_ to ocp2scp for representing usb_phy
>> drivers: bus: ocp2scp: add pdata support
>>
>
> The above 3 patches got it to work for me. Thanks for the hint.
>
>> Also you need to enable CONFIG_OMAP_USB2. No idea what all is needed
>> to use MUSB with device tree at this point.
>>
>
> Yes, you need to enable a bunch of other things which are not so easy to
> figure out for someone who has not worked with MUSB. Do you think we
> should enable musb and all dependencies in omap2plus_defconfig?
>
> One more thing to note is that building CONFIG_OMAP_USB2 as module
> breaks the kernel build with the following error.
>
> drivers/built-in.o: In function `twl4030_usb_irq':
> /work/linux-2.6/drivers/usb/otg/twl4030-usb.c:518: undefined reference
> to `omap_musb_mailbox'
> drivers/built-in.o: In function `twl4030_usb_phy_init':
> /work/linux-2.6/drivers/usb/otg/twl4030-usb.c:540: undefined reference
> to `omap_musb_mailbox'
> make: *** [vmlinux] Error 1
>
> I bet the error would come while building twl6030-usb.c too.

There are couple of fixes floating in the list to fix this.

https://patchwork.kernel.org/patch/1370291/

and an alternative fix here:
https://patchwork.kernel.org/patch/1409671/

Thanks
Kishon
