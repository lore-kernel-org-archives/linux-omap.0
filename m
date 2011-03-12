From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: [PATCH] OMAP4: clockdomain: Follow recommended enable sequence
Date: Sat, 12 Mar 2011 13:23:44 +0530
Message-ID: <4D7B2688.9040506@ti.com>
References: <1299245123-23444-1-git-send-email-rnayak@ti.com>	<alpine.DEB.2.00.1103081937100.15132@utopia.booyaka.com>	<4D775418.6050105@ti.com>	<alpine.DEB.2.00.1103100514210.15132@utopia.booyaka.com>	<alpine.DEB.2.00.1103100734490.15132@utopia.booyaka.com>	<4D7A22F6.5050806@ti.com> <871v2dbo3q.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:59991 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751631Ab1CLHxz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Sat, 12 Mar 2011 02:53:55 -0500
Received: by gyd12 with SMTP id 12so438392gyd.35
        for <linux-omap@vger.kernel.org>; Fri, 11 Mar 2011 23:53:54 -0800 (PST)
In-Reply-To: <871v2dbo3q.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, b-cousson@ti.com, santosh.shilimkar@ti.com, linux-arm-kernel@lists.infradead.org

Hi Kevin,

On 3/11/2011 10:17 PM, Kevin Hilman wrote:
> Rajendra Nayak<rnayak@ti.com>  writes:
>
> [...]
>
>>>
>>> It's also breaking boot on OMAP35xx BeagleBoard rev C2.  The kernel
>>> boot messages are below - omap2plus_defconfig + DEBUG_LL.  Reverting
>>> the patch fixes it.  Could you please take a look?
>>
>> I got hold of a Beagle, a sticker on which says rev C1D.
>> Not sure if there is a better way to identify the rev, but
>> this one seems to boot fine for me even with this patch.
>> I just applied this one patch on top of the the tag
>> 'integration-2.6.39-20110310-008' of git://git.pwsan.com/linux-
>> integration.
>
> In the process of testing Santosh's OMAP4 PM series (which includes
> $SUBJECT patch) on OMAP3, I also noticed some problems on beagle (mine
> is a C3.)
>
> Specifially, with $SUBJECT patch applied, none of the powerdomains ever
> reach inactive or RET during idle (suspend seems to work fine.)
>
> Just reverting $SUBJECT patch makes things go back to working normally.
>
> I pushed the test branch I used which is a merge of Santosh's v3 branch
> with my pm branch (branch: tmp/santosh-omap4-pm)
>
> I tested by first doing a suspend test and confirming all the
> powerdomains hit retention.  That worked fine.  Then I did an idle test:
>
>    echo 5>  /sys/devices/platform/omap/omap_uart.0/sleep_timeout
>    echo 5>  /sys/devices/platform/omap/omap_uart.1/sleep_timeout
>    echo 5>  /sys/devices/platform/omap/omap_uart.2/sleep_timeout
>    echo 1>  /debug/pm_debug/sleep_while_idle
>
> and waited for the UARTs to timeout.
>
> Well after the UART timeouts expired, I do not see any powerdomains
> transitioning from ON.
>
> What's even more strange is that the same thing is working fine on all
> the other OMAP3 platforms I tested: 3430/n900, 3630/zoom3 and even a
> different 3530-based platform, the OMAP3EVM.

I probably know whats going wrong with this patch, even though I
haven't really been able to reproduce any of these issues myself.

The below change which should be the only one affecting non-OMAP4
platforms actually is calling clkdm_allow_idle() for all clkdms
without really checking for a CLKDM_CAN_ENABLE_AUTO flag, which
seems wrong. I was somehow under the impression that the
clkdm_allow_idle() function would internally do this check but
that does not seem to be the case.

+	/* If clockdomain supports hardware control, enable it */
+	if (clk->clkdm)
+		clkdm_allow_idle(clk->clkdm);

I could see that emu_clkdm on OMAP3 is one clockdomain for
which CLKDM_CAN_ENABLE_AUTO is been disabled.

 From clockdomains2xxx_3xxx_data.c file..
--------
/*
  * Disable hw supervised mode for emu_clkdm, because emu_pwrdm is
  * switched of even if sdti is in use
  */
static struct clockdomain emu_clkdm = {
         .name           = "emu_clkdm",
         .pwrdm          = { .name = "emu_pwrdm" },
         .flags          = /* CLKDM_CAN_ENABLE_AUTO |  */CLKDM_CAN_SWSUP,
         .clktrctrl_mask = OMAP3430_CLKTRCTRL_EMU_MASK,
         .omap_chip      = OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
};
--------

Maybe programming emu_clkdm in HW_AUTO is the one that shows
up these strange behavior on select BeagleBoard's.
Not sure if this would fix the issue but this does seem
like a necessary fix needed for this patch.

Paul,

To handle this I was thinking of adding another clockdomain
framework api, something like a clkdm_post_clk_enable, to do
the post clock/module enable sequencing of clockdomain
programming. Or is it ok to check for a clockdomain specific
flag in clock framework? Any thoughts?

Now that its too late for this to make it to .39, I can
experiment with this sequence on OMAP2/3 as well and see
if all the autodeps can then be removed.

regards,
Rajendra


>
> Kevin
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

