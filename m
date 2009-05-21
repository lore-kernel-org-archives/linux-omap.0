From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 2/2] McSPI Slave and DMA,FIFO support
Date: Thu, 21 May 2009 07:08:21 -0700
Message-ID: <87zld6im5m.fsf@deeprootsystems.com>
References: <5A47E75E594F054BAF48C5E4FC4B92AB030574190F@dbde02.ent.ti.com>
	<878wkrpuzp.fsf@deeprootsystems.com>
	<00c401c9d9f8$00dbc750$LocalHost@wipultra793>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f171.google.com ([209.85.216.171]:58570 "EHLO
	mail-px0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753560AbZEUOIY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 21 May 2009 10:08:24 -0400
Received: by pxi1 with SMTP id 1so714620pxi.33
        for <linux-omap@vger.kernel.org>; Thu, 21 May 2009 07:08:24 -0700 (PDT)
In-Reply-To: <00c401c9d9f8$00dbc750$LocalHost@wipultra793> (Hemanth V.'s message of "Thu\, 21 May 2009 15\:09\:10 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hemanth V <hemanthv@ti.com>
Cc: "Gadiyar, Anand" <gadiyar@ti.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org

"Hemanth V" <hemanthv@ti.com> writes:

>
>> "Gadiyar, Anand" <gadiyar@ti.com> writes:
>>
>>>> -----Original Message-----
>>>> From: linux-omap-owner@vger.kernel.org
>>>> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Hemanth V
>>>> Sent: Wednesday, May 20, 2009 11:27 AM
>>>> To: linux-omap@vger.kernel.org
>>>> Subject: [PATCH 2/2] McSPI Slave and DMA,FIFO support
>>>>
>>>> This patch adds MUX changes for SPI2 and also adds an
>>>> option for test driver
>>>>
[...]
>>>>  static void __init omap_3430sdp_init(void)
>>>>  {
>>>> +
>>>> + /* SPI2 Pin MUX */
>>>> + omap_cfg_reg(AA3_3430_McSPI2_CLK);
>>>> + omap_cfg_reg(Y2_3430_McSPI2_SIMO);
>>>> + omap_cfg_reg(Y3_3430_McSPI2_SOMI);
>>>> + omap_cfg_reg(Y4_3430_McSPI2_CS0);
>>>> +
>>>
>>> This will still change the padconf for this port unconditionally.
>>>
>>> How do we handle the case where the same platform (SDP in this case)
>>> could have different configurations McSPI2 vs USBHOST2, etc? Is there
>>> a clean way, or do we have no option but to use a CONFIG option?
>>
>> What about building both as modules and doing the muxing on module
>> load with a warning if it's taking the pins away from antother
>> feature.
>>
>> Longer term, we need a more dynamic way to request pins when there are
>> conflicts like this.
>>
>> Kevin
>
> Might be the easiest option right now is to remove omap_cfg_reg
> calls and allow users to add it when required.

Those calls are required for a functioning SPI driver, no?  If we
leave them out, isn't the first question going to be "why doesn't SPI2
work on my board."

That being said, I guess I'm ok with waiting a little for adding he
muxing. Not sure what others think

My "partial fix" suggestion for today was for the driver to mux them at
runtime when the module loads.  However, I don't really like that
solution either since that puts board/chip specific code into the
driver.

The real solution is to have the muxing done as part of a
device_enable call which will come as part of the forthcoming omapdev.
Then the muxing can be done as part of a generic device enable, along
clocks etc.

However, this still doesn't solve the problem of conflicting users.
If you're using McSPI2 and you enable USBHOST, then your McSPI2 will
just stop working.  At some point, we'll need some sort of
request/free mechanism for pins.

Kevin
