From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: [PATCH 08/10] ARM: OMAP5: hwmod data: Create initial OMAP5 SOC
 hwmod data
Date: Tue, 22 Jan 2013 18:44:03 +0530
Message-ID: <50FE909B.1020001@ti.com>
References: <1358522856-12180-1-git-send-email-santosh.shilimkar@ti.com> <1358522856-12180-9-git-send-email-santosh.shilimkar@ti.com> <20130118171500.GC15361@atomide.com> <50FCF838.6000105@ti.com> <50FD5993.5010008@ti.com> <20130121180113.GA22517@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:41702 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751138Ab3AVNOS (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 22 Jan 2013 08:14:18 -0500
In-Reply-To: <20130121180113.GA22517@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, mturquette@linaro.org, b-cousson@ti.com, Paul Walmsley <paul@pwsan.com>

Hi Tony,

>> So I looked at this one with help of Rajendra. We can get rid of the
>> IRQ and DMA data(needs DMA biding updates) easily. The address
>> space though is needed since hwmod code uses it to setup the
>> sysconfig registers.
>
> OK great. The address space tinkering in hwmod code should be
> moved to be done in the drivers.
>
> As discussed earlier, there should be a driver specific reset
> function driver_xyz_reset() in the driver header file so the
> hwmod code can call it too in a late_initcall if no driver is
> loaded.

I am a little confused with what you are saying. The hwmod doing
reset of modules (and not relying on drivers doing it) was
mainly for modules which do not have drivers built in (and hence
run a risk of gating system sleep in case the bootloaders left
them in a bad state).
But if the drivers aren't built in (or are built as modules) *then*
hwmod still needs to be able to do reset (maybe in a late_initcall) of
these modules on its own (because there is no driver code to do it).

The other big reason why hwmod would need the address space
tinkering is because it also controls the various OCP master/slave
modes of these modules. Quite often these modes are broken and
need tinkering every time the module is enable/idled and also
need to be restored back to sane values (smart_idle/smart_standby)
post reset. All of this is today handled as part of hwmod and
would defeat the whole purpose of the framework if all this is
moved into drivers.

So completely getting rid of all address space tinkering in hwmod
looks really difficult.

regards,
Rajendra

>
>> Extracting that from DT code seems to be really expensive and
>> ugly [1]. I am yet to try out DMA lines removal but that seems
>> to be doable by pulling Vinod'd DMA engine branch and updating
>> DT file.
>
> The overhead here does not matter as it should only happen in a
> late_initcall and only for some of the drivers. For that to
> happen we just need to go through the list of modules not yet
> probed. We also need to have some locking in the driver specific
> reset function to avoid races with the loadable modules.
>
>> Whats your suggestion on address space part ?
>
> Let's add the code to hwmod to extract it from DT so hwmod code
> can call the driver specific reset function defined in the driver
> header. That way we can start moving the driver code out of hwmod
> one driver at a time.
>
> Note that the ioremapping should be done in the driver specific
> reset function, not in hwmod code. We just need to pass the
> iorange in a struct resource to the driver specific reset function.
>
> Regards,
>
> Tony
>

