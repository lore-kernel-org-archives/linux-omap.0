From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: [PATCH] ARM: DTS: OMAP4: Panda/SDP: twl6030: fix mux for IRQ
 pin and msecure line
Date: Wed, 29 May 2013 11:36:29 +0300
Message-ID: <51A5BE0D.7030609@ti.com>
References: <1369423702-31501-1-git-send-email-khilman@linaro.org> <20130524200954.GA2344@kahuna> <20130524203231.GA2555@kahuna> <87obc0f54r.fsf@linaro.org> <CAGo_u6oz1v1J-6z5W-X7CsOmi+7SAMicz1LZTv0sVXhej1DJ2Q@mail.gmail.com> <87a9nkf3mu.fsf@linaro.org> <87ppwgdnxu.fsf@linaro.org> <CAGo_u6ruWQwSB8Z0BRLda7HunTyr9mGpx4eMSGdQZkCxKxbHbg@mail.gmail.com> <87a9nfc5uc.fsf@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:59283 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965092Ab3E2Ijz (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 29 May 2013 04:39:55 -0400
In-Reply-To: <87a9nfc5uc.fsf@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@linaro.org>
Cc: Nishanth Menon <nm@ti.com>, Tony Lindgren <tony@atomide.com>, Benoit Cousson <b-cousson@ti.com>, linux-omap <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On 05/28/2013 09:33 PM, Kevin Hilman wrote:
> Nishanth Menon <nm@ti.com> writes:
>
>> On Fri, May 24, 2013 at 5:15 PM, Kevin Hilman <khilman@linaro.org> wrote:
>>> Kevin Hilman <khilman@linaro.org> writes:
>>>
>>>> Nishanth Menon <nm@ti.com> writes:
>>> [...]
>>>
>>>>> Actually 2 things:
>>>>>
>>>>> a) patch seems to do the wrong thing for 4460 - 0x18 offset should
>>>>> have been used instead of 0x14 which is correct for 4430?
>>>> I see, thanks.  I'll double check the TRMs.
>>>>
>>>>> b) yes, I understand,  the current settings we did worked, but the
>>>>> mode(0) we are setting to is real weird - we are setting it up for
>>>>> clk0 out - I cant even think why it is even working in the first place
>>>>> :( - is it because we are pumping out sysclkout and as a result we are
>>>>> lucky that msecure is being sampled at the right point by twl6030
>>>>> allowing rtc access? either way, IMHO, the configuration is wrong.
>>>> Ah, yes.  Mode zero is definitely wrong.   When I did the original patch
>>>> for legacy mode, I just duplicated the settings u-boot was using.  Guess
>>>> it's a fluke that it works.
>>> Actually, for legacy mode, it's set correctly in mode 2.  This line:
>>>
>>>          omap_mux_init_signal("fref_clk0_out.sys_drm_msecure", OMAP_PIN_OUTPUT);
>>>
>>> does the right thing based on the signal name.    But for DT boot, I
>>> defintely screwed it up by setting it to mode (and putting it in the
>>> wrong padconf section.)
>>>
>>> Also, are you *really* sure about the offset difference between 4430 and
>>> 4460 here?  I don't have access to NDA docs anymore, so I cannot double
>>> check this.
>>>
>>> What I do know is that the legacy code is using 0x54 for both, and if I
>>> simply comment out that 'sys_drm_msecure' line above, RTC wake stops
>>> working (legacy boot) on both 4430 and 4460, so that seems like pretty
>>> stront evidence that it's the same offset on both.
>> Schematics are public for PandaBoard ES and PandaBoard - as you can
>> see from that the registers connected are definitely different.
> What I see from both schematics is that SYS_DRM_MSECURE is available on
> a few different pads, but on both 4430 and 4460, one of the places is in
> mode 2 of FREF_CLK0_OUT, which is at offset 0x54 on both SoCs.
>
> Based on that reading, and the fact that not correctly muxing that pad
> to mode 2 on *both* 4430 and 4460 makes the RTC work, I'm rather
> convinced that the offset should be the same for 4430 and 4460.
>
> What am I missing?
Hi Kevin,

I've rechecked it too.

According to:
Panda ES: 
http://pandaboard.org/sites/default/files/board_reference/ES/750-2170-002-sch_revb.pdf
Panda: 
http://pandaboard.org/sites/default/files/board_reference/pandaboard-a/panda-a-schematic.pdf

AD2 (FREF_CLK0_OUT) is used for on both boards as H_SYS_DRM_MSEC - so, 
valid offset is 0x14
CONTROL_WKUP_PAD0_FREF_CLK0_OUT_PAD1_FREF_CLK3_REQ lowest 16 bit

FYI: in Android K3.0 and K3.4 this pin configured to "gpio_wk6" as following
     omap_mux_init_signal("fref_clk0_out.gpio_wk6", OMAP_PIN_OUTPUT);
     gpio_request(6, "msecure");
     gpio_direction_output(6, 1);

http://git.omapzoom.org/?p=kernel/omap.git;a=commit;h=262669aebf4af4044a25e8292f0e27986e18445a


Regards,
Grygorii

>
> Kevin
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

