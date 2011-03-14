From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: [PATCH] OMAP4: clockdomain: Follow recommended enable sequence
Date: Mon, 14 Mar 2011 16:28:25 +0530
Message-ID: <4D7DF4D1.1030209@ti.com>
References: <1299245123-23444-1-git-send-email-rnayak@ti.com>	<alpine.DEB.2.00.1103081937100.15132@utopia.booyaka.com>	<4D775418.6050105@ti.com>	<alpine.DEB.2.00.1103100514210.15132@utopia.booyaka.com>	<alpine.DEB.2.00.1103100734490.15132@utopia.booyaka.com>	<4D7A22F6.5050806@ti.com> <871v2dbo3q.fsf@ti.com> <4D7B2688.9040506@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:59222 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750964Ab1CNK6d (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 14 Mar 2011 06:58:33 -0400
Received: by mail-gw0-f47.google.com with SMTP id 11so2107402gwb.34
        for <linux-omap@vger.kernel.org>; Mon, 14 Mar 2011 03:58:32 -0700 (PDT)
In-Reply-To: <4D7B2688.9040506@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, b-cousson@ti.com, santosh.shilimkar@ti.com, linux-arm-kernel@lists.infradead.org

On 3/12/2011 1:23 PM, Rajendra Nayak wrote:
> Hi Kevin,
>
> On 3/11/2011 10:17 PM, Kevin Hilman wrote:
>> Rajendra Nayak<rnayak@ti.com>  writes:
>>
>> [...]
>>
>>>>
>>>> It's also breaking boot on OMAP35xx BeagleBoard rev C2.  The kernel
>>>> boot messages are below - omap2plus_defconfig + DEBUG_LL.  Reverting
>>>> the patch fixes it.  Could you please take a look?
>>>
>>> I got hold of a Beagle, a sticker on which says rev C1D.
>>> Not sure if there is a better way to identify the rev, but
>>> this one seems to boot fine for me even with this patch.
>>> I just applied this one patch on top of the the tag
>>> 'integration-2.6.39-20110310-008' of git://git.pwsan.com/linux-
>>> integration.
>>
>> In the process of testing Santosh's OMAP4 PM series (which includes
>> $SUBJECT patch) on OMAP3, I also noticed some problems on beagle (mine
>> is a C3.)
>>
>> Specifially, with $SUBJECT patch applied, none of the powerdomains ever
>> reach inactive or RET during idle (suspend seems to work fine.)
>>
>> Just reverting $SUBJECT patch makes things go back to working normally.
>>
>> I pushed the test branch I used which is a merge of Santosh's v3 branch
>> with my pm branch (branch: tmp/santosh-omap4-pm)
>>
>> I tested by first doing a suspend test and confirming all the
>> powerdomains hit retention.  That worked fine.  Then I did an idle test:
>>
>>    echo 5>  /sys/devices/platform/omap/omap_uart.0/sleep_timeout
>>    echo 5>  /sys/devices/platform/omap/omap_uart.1/sleep_timeout
>>    echo 5>  /sys/devices/platform/omap/omap_uart.2/sleep_timeout
>>    echo 1>  /debug/pm_debug/sleep_while_idle
>>
>> and waited for the UARTs to timeout.
>>
>> Well after the UART timeouts expired, I do not see any powerdomains
>> transitioning from ON.
>>
>> What's even more strange is that the same thing is working fine on all
>> the other OMAP3 platforms I tested: 3430/n900, 3630/zoom3 and even a
>> different 3530-based platform, the OMAP3EVM.
>
> I probably know whats going wrong with this patch, even though I
> haven't really been able to reproduce any of these issues myself.
>
> The below change which should be the only one affecting non-OMAP4
> platforms actually is calling clkdm_allow_idle() for all clkdms
> without really checking for a CLKDM_CAN_ENABLE_AUTO flag, which
> seems wrong. I was somehow under the impression that the
> clkdm_allow_idle() function would internally do this check but
> that does not seem to be the case.

Actually I was wrong, clkdm_allow_idle() does seem to have a
check for the CLKDM_CAN_ENABLE_AUTO flag.

