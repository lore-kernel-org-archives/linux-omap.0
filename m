From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCH] ARM: OMAP2: Fix missing omap2xxx_clkt_vps_xxx function
 calls
Date: Thu, 17 Jan 2013 13:27:03 -0600
Message-ID: <50F85087.3060507@ti.com>
References: <1357851209-5332-1-git-send-email-jon-hunter@ti.com> <alpine.DEB.2.00.1301171848490.14118@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:40138 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752701Ab3AQT1F (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 17 Jan 2013 14:27:05 -0500
In-Reply-To: <alpine.DEB.2.00.1301171848490.14118@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>

Hi Paul,

On 01/17/2013 12:51 PM, Paul Walmsley wrote:
> Hi Jon
> 
> On Thu, 10 Jan 2013, Jon Hunter wrote:
> 
>> During the migration to the common clock framework, calls to the
>> functions omap2xxx_clkt_vps_late_init() and
>> omap2xxx_clkt_vps_check_bootloader_rates() were not preserved for
>> OMAP2420 and OMAP2430. This causes the variables "sys_ck_rate" and
>> "curr_prcm_set" to be uninitialised on boot. On reboot, this causes the
>> following error message to be displayed because the appropriate MPU
>> clock frequency (derived from sys_ck_rate) cannot be found.
>>
>> "Could not set MPU rate to 4294MHz"
> 
> I don't see this message on 2430sdp or n800 with v3.8-rc3, but maybe 
> that's due to sys_clk differences.  Do you still see this on v3.8-rc3 
> with H4?

Yes I still see it. You don't see it on reboot?

The reason why there is such a large number is because
omap2_round_to_table_rate() is returning the value -EINVAL. You could
add a print to omap2_round_to_table_rate() to see what it returns on
reboot. Or we could add a WARN to the function is sys_ck_rate is 0 for
testing.

> Also, there's already a call to omap2xxx_clkt_vps_check_bootloader_rates() 
> -- is it necessary to add another one?

Thanks. I see that now and so that is not needed then.

Cheers
Jon
