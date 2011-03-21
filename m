From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: [PATCH] OMAP4: clockdomain: Follow recommended enable sequence
Date: Mon, 21 Mar 2011 14:21:49 +0530
Message-ID: <4D8711A5.6070301@ti.com>
References: <1299245123-23444-1-git-send-email-rnayak@ti.com>	<alpine.DEB.2.00.1103081937100.15132@utopia.booyaka.com>	<4D775418.6050105@ti.com>	<alpine.DEB.2.00.1103100514210.15132@utopia.booyaka.com>	<alpine.DEB.2.00.1103100734490.15132@utopia.booyaka.com>	<4D7A22F6.5050806@ti.com> <871v2dbo3q.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:59744 "EHLO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751956Ab1CUIwE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 21 Mar 2011 04:52:04 -0400
Received: by yia27 with SMTP id 27so2681726yia.33
        for <linux-omap@vger.kernel.org>; Mon, 21 Mar 2011 01:52:02 -0700 (PDT)
In-Reply-To: <871v2dbo3q.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, b-cousson@ti.com, santosh.shilimkar@ti.com, linux-arm-kernel@lists.infradead.org

Hi Kevin/Paul,

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

I tried to reproduce this on a Beagle rev C3, but I don't seem
to be seeing this issue. I was able to hit OFF mode in both
suspend and idle.

I also tried removing autodeps completely on OMAP3 and ran
into some issues/aborts with GPIO restore path with
OFF mode enabled.

Besides these, debugging some McBSP related crashes showed
up another issue with this patch.
Since the clockdomain is programmed back to HW_AUTO (if supported)
in the clock framework, this happens *before* waiting for the
module to become accessible. (On OMAP4, the check to make sure
the module is accessible happens in the hwmod framework, unlike
in older OMAP's, where it was part of the clock framework)

So instead of implementing the recommended sequence of
-1- Force clkdm to SW_WKUP
-2- Configure desired module mode to "enable" or "auto"
-3- Wait for the desired module idle status to be FUNC
-4- Program clkdm in HW_AUTO(if supported)

..it was actually implementing the wrong sequence as below
-1- Force clkdm to SW_WKUP
-2- Configure desired module mode to "enable" or "auto"
-3- Program clkdm in HW_AUTO(if supported)
-4- Wait for the desired module idle status to be FUNC

This however was only a problem on OMAP4.

Fixing this would require moving the clockdomain programming
back to HW_AUTO as part of the hwmod framework.
However this sequence is recommended even for optional
clock enabling, and hence might have to be handled at
the clock framework as well. (Since optional clocks
are still controlled by drivers using clock framework
directly).
Any suggestions on how to handle this without duplicating
much of this across clock and hwmod framework?

regards,
Rajendra

>
> Kevin
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

