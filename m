From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCHv2 02/27] clk: ti: move generic OMAP DPLL implementation
 under drivers/clk
Date: Wed, 20 May 2015 20:43:38 +0300
Message-ID: <555CC7CA.2090104@ti.com>
References: <1431334493-24455-1-git-send-email-t-kristo@ti.com> <1431334493-24455-3-git-send-email-t-kristo@ti.com> <20150520012053.GC31054@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:57318 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753717AbbETRoI (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 20 May 2015 13:44:08 -0400
In-Reply-To: <20150520012053.GC31054@codeaurora.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: mturquette@linaro.org, tony@atomide.com, linux-omap@vger.kernel.org, linux-clk@vger.kernel.org, paul@pwsan.com, linux-arm-kernel@lists.infradead.org

On 05/20/2015 04:20 AM, Stephen Boyd wrote:
> On 05/11, Tero Kristo wrote:
>> With the legacy clock data now gone, we can start moving OMAP clock
>> type implementations under clock driver. Start this with moving the
>> generic OMAP DPLL clock type under TI clock driver.
>>
>> Signed-off-by: Tero Kristo <t-kristo@ti.com>
>> ---
>
> How much of the code is the same from the original copy? Can you
> generate these patches with -M -C so that we can see?

Looks like for the move patches the range is from 85%...95% exact copy. 
Shall I repost the patches in this format? Good hint for the -M -C btw, 
I wonder why those are not default options for git-format-patch.

-Tero

>
>>   arch/arm/mach-omap2/Makefile    |    2 +-
>>   arch/arm/mach-omap2/clkt_dpll.c |  370 ---------------------------------------
>>   drivers/clk/ti/Makefile         |    3 +-
>>   drivers/clk/ti/clkt_dpll.c      |  369 ++++++++++++++++++++++++++++++++++++++
>>   drivers/clk/ti/clock.h          |    2 +
>>   include/linux/clk/ti.h          |    1 -
>>   6 files changed, 374 insertions(+), 373 deletions(-)
>>   delete mode 100644 arch/arm/mach-omap2/clkt_dpll.c
>>   create mode 100644 drivers/clk/ti/clkt_dpll.c
>

