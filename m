From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/2] McSPI Slave and DMA,FIFO support
Date: Tue, 2 Jun 2009 11:11:20 -0700
Message-ID: <20090602181120.GJ27332@atomide.com>
References: <5A47E75E594F054BAF48C5E4FC4B92AB030574190F@dbde02.ent.ti.com> <878wkrpuzp.fsf@deeprootsystems.com> <00c401c9d9f8$00dbc750$LocalHost@wipultra793> <007601c9dae2$6c896ee0$LocalHost@wipultra793>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:60969 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751344AbZFBSLV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 2 Jun 2009 14:11:21 -0400
Content-Disposition: inline
In-Reply-To: <007601c9dae2$6c896ee0$LocalHost@wipultra793>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hemanth V <hemanthv@ti.com>
Cc: linux-omap@vger.kernel.org

* Hemanth V <hemanthv@ti.com> [090522 06:37]:
> Tony, would you be able merge the two patches if I removed omap_cfg_reg  
> calls

Please provide just the mux.[ch] patch separately, that way we can
patch it where needed.

<snip snip>

>>>>> @@ -666,6 +685,13 @@
>>>>>
>>>>>  static void __init omap_3430sdp_init(void)
>>>>>  {
>>>>> +
>>>>> + /* SPI2 Pin MUX */
>>>>> + omap_cfg_reg(AA3_3430_McSPI2_CLK);
>>>>> + omap_cfg_reg(Y2_3430_McSPI2_SIMO);
>>>>> + omap_cfg_reg(Y3_3430_McSPI2_SOMI);
>>>>> + omap_cfg_reg(Y4_3430_McSPI2_CS0);
>>>>> +
>>>>
>>>> This will still change the padconf for this port unconditionally.
>>>>
>>>> How do we handle the case where the same platform (SDP in this case)
>>>> could have different configurations McSPI2 vs USBHOST2, etc? Is there
>>>> a clean way, or do we have no option but to use a CONFIG option?
>>>
>>> What about building both as modules and doing the muxing on module
>>> load with a warning if it's taking the pins away from antother
>>> feature.
>>>
>>> Longer term, we need a more dynamic way to request pins when there are
>>> conflicts like this.

Yeah.

>>> Kevin
>>
>> Might be the easiest option right now is to remove omap_cfg_reg calls 
>> and allow
>> users to add it when required.

We could just have a pointer for set_pins() in the platform data,
then the driver could just do if (pdev->set_pins()) pdev->set_pins();

Just like we have set_power() for some devices.

Regards,

Tony
