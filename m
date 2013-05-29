From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH] ARM: DTS: OMAP4: Panda/SDP: twl6030: fix mux for IRQ
 pin and msecure line
Date: Wed, 29 May 2013 11:38:45 +0200
Message-ID: <51A5CCA5.7000700@ti.com>
References: <1369423702-31501-1-git-send-email-khilman@linaro.org> <20130524200954.GA2344@kahuna> <20130524203231.GA2555@kahuna> <87obc0f54r.fsf@linaro.org> <CAGo_u6oz1v1J-6z5W-X7CsOmi+7SAMicz1LZTv0sVXhej1DJ2Q@mail.gmail.com> <87a9nkf3mu.fsf@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:38313 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965239Ab3E2JjR (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 29 May 2013 05:39:17 -0400
In-Reply-To: <87a9nkf3mu.fsf@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@linaro.org>
Cc: Nishanth Menon <nm@ti.com>, Tony Lindgren <tony@atomide.com>, linux-omap <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On 5/24/2013 11:51 PM, Kevin Hilman wrote:
> Nishanth Menon <nm@ti.com> writes:
>
>> On Fri, May 24, 2013 at 4:19 PM, Kevin Hilman <khilman@linaro.org> wrote:
>>> Nishanth Menon <nm@ti.com> writes:
>>>
>>>> On 15:09-20130524, Nishanth Menon wrote:
>>>>> On 12:28-20130524, Kevin Hilman wrote:
>>>>>> Earlier commits ensured proper muxing of pins related to proper
>>>>>> TWL6030 behavior: see commit 265a2bc8 (ARM: OMAP3: TWL4030: ensure
>>>>>> sys_nirq1 is mux'd and wakeup enabled) and commit 1ef43369 (ARM:
>>>>>> OMAP4: TWL: mux sys_drm_msecure as output for PMIC).
>>>>>>
>>>>>> However these only fixed legacy boot and not DT boot.  For DT boot,
>>>>>> the default mux values need to be set properly in DT.
>>>>>>
>>>>>> Cc: Tony Lindgren <tony@atomide.com>
>>>>>> Signed-off-by: Kevin Hilman <khilman@linaro.org>
>>>>>> ---
>>>>>> Applies on v3.10-rc2
>>>>>>
>>>>>>   arch/arm/boot/dts/omap4-panda-common.dtsi | 8 ++++++++
>>>>>>   arch/arm/boot/dts/omap4-sdp.dts           | 8 ++++++++
>>>>>>   2 files changed, 16 insertions(+)
>>>>>>
>>>>>> diff --git a/arch/arm/boot/dts/omap4-panda-common.dtsi b/arch/arm/boot/dts/omap4-panda-common.dtsi
>>>>>> index 03bd60d..a7a9bc0 100644
>>>>>> --- a/arch/arm/boot/dts/omap4-panda-common.dtsi
>>>>>> +++ b/arch/arm/boot/dts/omap4-panda-common.dtsi
>>>>>> @@ -59,6 +59,7 @@
>>>>>>   &omap4_pmx_core {
>>>>>>     pinctrl-names = "default";
>>>>>>     pinctrl-0 = <
>>>>>> +                  &twl6030_pins
>>>>>>                     &twl6040_pins
>>>>>>                     &mcpdm_pins
>>>>>>                     &mcbsp1_pins
>>>>>> @@ -66,6 +67,13 @@
>>>>>>                     &tpd12s015_pins
>>>>>>     >;
>>>>>>
>>>>>> +  twl6030_pins: pinmux_twl6030_pins {
>>>>>> +          pinctrl-single,pins = <
>>>>>> +                  0x15e 0x4118    /* sys_nirq1.sys_nirq1 OMAP_WAKEUP_EN | INPUT_PULLUP | MODE0 */
>>>>> I can understand this - IRQ request comes here.
>>>>> verified on OMAP4460 Panda-ES.
>>>>> # omapconf read 0x4A10019C
>>>>> 4118011B
>>>>>
>>>>>> +                  0x14 0x0        /* fref_clk0_out.sys_drm_msecure OUTPUT */
>>>>> I do not understand this.
>>>>> OMAP4460 TRM:
>>>>> Register: CONTROL_WKUP_PAD0_FREF_CLK0_OUT_PAD1_FREF_CLK3_REQ
>>>>> omapconf read 0x4A31E054
>>>>> 010F010F
>>>>>
>>>>> I do not understand this configuration. mux modes for
>>>>> FREF_CLK0_OUT_MUXMODE:
>>>>> 0x0: Select fref_clk0_out
>>>>> 0x1: Select fref_clk1_req
>>>>> 0x2: Reserved
>>>>> 0x3: Select gpio_wk6
>>>>> 0x5: Select sdmmc2_dat7
>>>>> 0x6: Select hw_dbg6
>>>>> 0x7: Select safe_mode
>>>>>
>>>>> Why are we setting mode 0(clk out) here?
>>>>
>>>> I did a bit more research into this:
>>>> MSECURE line needs to be set for us to set anything with TWL6030 RTC.
>>>
>>> Yes, the commit referenced in the changelog described that in detail.
>>>
>>>> PandaBoard ES(4460) = this is on OMAP PIN AD4
>>>> PandaBoard (4430) = this is on OMAP PIN AD2
>>>>
>>>> translating this back,
>>>> PandaBoard ES OMAp4460 pin AD4:
>>>> FREF_CLK3_OUT/FREF_CLK2_REQ/SYS_SECURE_INDICATOR/GPIO_WK31/C2C_WAKEREQOUT/SDMMC2_DAT5/ATTILA_HW_DBG8/SAFE_MODE
>>>> This is at register 0x4A31E054(higher 16 bits) - however since we are GP device,
>>>> SYS_SECURE_INDICATOR(mode 2) is reserved.
>>>> PandaBoard OMAP4430 pin AD2:
>>>> FREF_CLK0_OUT/FREF_CLK1_REQ/SYS_DRM_MSECURE/GPIO_WK6/SDMMC2_DAT7/ATTILA_HW_DBG6/SAFE_MOD
>>>> This is at register 0x4A31E054(lower 16 bits) - however since we are GP device,
>>>> SYS_DRM_MSECURE(mode 2) is reserved.
>>>>
>>>> To use RTC, we will have to use GPIO.
>>>> on pandaboard ES, we need GPIO31 and PandaBoard, 6.
>>>>
>>>> Further the pinctrl offsets will vary as well between the same.
>>>>
>>>> IMHO, we need GPIO support and pinmux appropritate to the same to allow
>>>> RTC to work.
>>>
>>> I don't follow at all what you're trying to say.  The current settings
>>> are working fine and have been tested on both 4430/Panda and 4460/Panda-ES.
>>>
>>> The goal of this patch is to make default mux settings for twl6030 for
>>> DT boot match current legacy boot in mainline.
>>>
>>> The commits referenced in the changelog setup some default muxing for
>>> twl6030 (see changelogs referenced and mux calls in
>>> twl-common.c:omap4_pmic_init())
>>>
>>> Without those mux settings, RTC wakeup on legacy boot does not work
>>> (tested on 4430/panda, 4460/Panda with recent u-boot v2013.04 where most
>>> of the old mux setup is gone.)  With those settings, RTC wakeup works.
>>>
>>> Yes, the TRM has some mode bits marked as reserved, but that doesn't
>>> mean they don't work.  It just means the documentation is squirreled
>>> away in the secure TRM addendum.
>>>
>> Actually 2 things:
>>
>> a) patch seems to do the wrong thing for 4460 - 0x18 offset should
>> have been used instead of 0x14 which is correct for 4430?
>
> I see, thanks.  I'll double check the TRMs.
>
>> b) yes, I understand,  the current settings we did worked, but the
>> mode(0) we are setting to is real weird - we are setting it up for
>> clk0 out - I cant even think why it is even working in the first place
>> :( - is it because we are pumping out sysclkout and as a result we are
>> lucky that msecure is being sampled at the right point by twl6030
>> allowing rtc access? either way, IMHO, the configuration is wrong.
>
> Ah, yes.  Mode zero is definitely wrong.   When I did the original patch
> for legacy mode, I just duplicated the settings u-boot was using.  Guess
> it's a fluke that it works.
>
> Yet another thing wrong with my patch:  the fref_clk0 pad is in the WKUP
> padconf section, and I put it at offset 0x14 in the CORE section, which
> is yet another wrong place.
>
> Let me respin this after some more doc reading.

Did you re-spin it already?

Beside that mode0 typo, it looks good to me.

Thanks,
Benoit
