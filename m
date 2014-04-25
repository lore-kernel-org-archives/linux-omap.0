From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH] power: twl4030_charger: clear IRQs after handling them
Date: Fri, 25 Apr 2014 15:58:10 -0500
Message-ID: <535ACC62.102@ti.com>
References: <1397661299-31342-1-git-send-email-balbi@ti.com> <20140416163526.GA3049@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140416163526.GA3049@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Felipe Balbi <balbi@ti.com>
Cc: dbaryshkov@gmail.com, dwmw2@infradead.org, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Russell King <linux@arm.linux.org.uk>
List-Id: linux-omap@vger.kernel.org

On 04/16/2014 11:35 AM, Tony Lindgren wrote:
> * Felipe Balbi <balbi@ti.com> [140416 08:18]:
>> TRM says we *must* write 1 to each bit we're handling
>> in order to clear the IRQ status and bring IRQ line
>> low. This patch implements that.
>>
>> Signed-off-by: Felipe Balbi <balbi@ti.com>
>> ---
>>
>> Russell, I don't have HW to test, but this should
>> solve the problem you saw when not using battery
>> with Zoom board. Let me know if it doesn't.
> 
> BTW, looks like we're enabling BCI automatically in twl4030.dtsi
> while the legacy booting does not have TWL_COMMON_PDATA_BCI
> enabled for LDP. Anyways, for LDP BCI should be enabled for
> sure, that's the only way to power at least the earlier LDP
> revisions.
> 
I picked up https://patchwork.kernel.org/patch/4002371/ for testing.

Unfortunately, it does not seem to work in my tests:

ldp-board-no-battery uses upstream u-boot in a chainloaded
configuration + does not have battery plugged in, instead, just J58
(charger) is connected - this is plugged on a remote farm setup for
developers to work with.

ldp-board-with-battery uses legacy bootloader with a battery simulator.

omap2plus_defconfig + CONFIG_CHARGER_TWL4030 enabled.

Result:
 v3-15-rc2-ldp-board-no-battery:  Boot FAIL:
http://slexy.org/raw/s20riTwu04

 v3-15-rc2-ldp-board-with-battery:  Boot PASS:
http://slexy.org/raw/s2elKdJpI7

 v3-15-rc2-with-felipe-fix-ldp-board-no-battery:  Boot FAIL:
http://slexy.org/raw/s20lKp2o0s


This patch should probably also acknowledge that Russell reported this
issue.
-- 
Regards,
Nishanth Menon
