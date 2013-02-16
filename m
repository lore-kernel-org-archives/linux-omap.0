From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [RFC/NOT FOR MERGING 2/3] serial: omap: remove hwmod dependency
Date: Sat, 16 Feb 2013 10:29:49 +0530
Message-ID: <511F1245.60208@ti.com>
References: <1360840554-26901-1-git-send-email-balbi@ti.com> <1360840554-26901-2-git-send-email-balbi@ti.com> <87obfl60x7.fsf@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:36294 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750828Ab3BPE6f (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 15 Feb 2013 23:58:35 -0500
In-Reply-To: <87obfl60x7.fsf@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@linaro.org>
Cc: Felipe Balbi <balbi@ti.com>, Tony Lindgren <tony@atomide.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>

On Friday 15 February 2013 09:10 PM, Kevin Hilman wrote:
> Felipe Balbi <balbi@ti.com> writes:
>
>> Currently the omap-serial driver will not
>> work properly if booted via DT with CPUIDLE
>> enabled because it depends on function pointers
>> provided by hwmod to change its own SYSCONFIG
>> register.
>>
>> Remove that relyance on hwmod by moving SYSCONFIG
>> handling to driver itself. Note that this also
>> fixes a possible corner case bug where we could
>> be putting UART in Force Idle mode if we called
>> omap_serial_enable_wakeup(up, false) after setting
>> NOIDLE to the idle mode. This is because hwmod
>> has no protection against that situation.
>>
>> NYET-Signed-off-by: Felipe Balbi <balbi@ti.com>
>
> Here's another approach to getting rid of the sysconfig twiddling in the
> driver.  I wrote this some time ago at my former company ;) but don't
> think I ever got around to posting it.
>
> It doesn't solve the whole problem (e.g. doesn't address the
> context_loss or enable_wakeup func pointers), but at least gets rid of
> the need for any SYSCONFIG access in the driver for the idle modes.
>
> Needs more thorough testing.
>
I posted similar patch series[1] yesterday after testing it on OMAP4/5
devices. OMAP3 testing seems to be ok as well. AM3XXX and OMAP2 test
results is what am waiting for.

Good to know that you had similar idea in mind to get rid of
UART sysc hackery.

Regards,
Santosh

[1] http://www.mail-archive.com/linux-omap@vger.kernel.org/msg85177.html
