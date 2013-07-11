From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: How to keep DM37x GPIO_162 high during off-mode
Date: Thu, 11 Jul 2013 23:15:15 +0300
Message-ID: <51DF1253.50700@ti.com>
References: <51DC238B.2060103@logicpd.com> <20130709155511.GG5523@atomide.com> <51DF00B1.7000402@logicpd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:59433 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754553Ab3GKUPs (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 11 Jul 2013 16:15:48 -0400
In-Reply-To: <51DF00B1.7000402@logicpd.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Barada <peter.barada@logicpd.com>
Cc: Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi Peter,

On 07/11/2013 10:00 PM, Peter Barada wrote:
> On 07/09/2013 11:55 AM, Tony Lindgren wrote:
>> * Peter Barada <peter.barada@logicpd.com> [130709 08:14]:
>>> I'm working with a 3.0.8 kernel in Android ICS and have run into a
>>> problem using wl12xx bluetooth after a suspend/resume cycle.
>>>
>>> GPIO_162 in this design is connected to the BT_EN pin of the wl12xx and
>>> needs to be held high to keep the bluetooth core from resetting while
>>> the DM37x goes into off mode.
>>>
>>> I've tried muxing the pin using OMAP_PIN_OUTPUT |
>>> OMAP_PIN_OFF_OUTPUT_HIGH, but the pin goes low when the chip goes into
>>> off mode.  If I disable off mode via "echo 0 >
>>> /sys/kernel/debug/pm_debug/enable_off_mode" the pin remains high while
>>> the chip goes into retention and the bluetooth core works after resume.
>>>
>>> Any ideas why GPIO_162 would go low during suspend to off mode?
>> Unless the GPIO is in a GPIO bank that's connected to the WKUP
>> power domain, the GPIO bank context will be lost. So there's a short
>> period where the  GPIO bank is in an uninitialized state between waking
>> from off-idle and before the context to the GPIO bank gets restored in
>> omap_gpio_runtime_resume().
>>
>> If there's a pull on the line, the period is long enough to change
>> the line.
>>
>> Unless the TI people know some magic tricks that I'm not aware of,
>> there's no way around it, except to use external pulls to keep
>> the GPIO line in desired state, or move the GPIO somewhere else,
>> like TWL.
>>
>>
> Unfortunately the hardware doesn't have an external pullup, and
> re-spinning it to route BT_EN to a GPIO pin that's in the WKUP domain
> isn't an option at this time...
>
> Unless there's some TI-magic to keep GPIO_162 high during OFF mode I'll
> have to solve this the hard way by reinitializing the BT/GPS core during
> resume using deferred work.  Unfirtuantely I don't have a clear
> understanding of the userspace interaction to know if this is doable.
>
> Mechanically it doesn't look too difficult to use the guts of
> st_register/st_kim_start to reinitialize the GT/GPS core and download
> its firmware, but the userspace interactions (and the time it takes to
> load the firmware) is what makes coming up with a good solution difficult.
>
> Any suggestions on how to approach solving this are most appreciated!
>

The recommended way is to configure it as INPUT + PULL_UP
and don't use OFFMODE feature if the 1 value is needed on port during 
off-mode.

You need to check if you have valid pin-cfg right before call to
omap4_enter_lowpower() ->omap4_cpu_suspend(cpu, save_state);

I recommend you to ask you questions here:
  http://e2e.ti.com/support/omap/default.aspx

Regards,
- grygorii
