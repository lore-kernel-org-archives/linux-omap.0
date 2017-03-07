From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCH 02/15] clk: ti: add support for automatic clock alias
 generation
Date: Wed, 8 Mar 2017 00:16:38 +0200
Message-ID: <63a69af9-38b2-6633-5ed6-35cc2fd3c91c@ti.com>
References: <1486978511-29668-1-git-send-email-t-kristo@ti.com>
 <1486978511-29668-3-git-send-email-t-kristo@ti.com>
 <20170307144823.GF10239@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170307144823.GF10239@codeaurora.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: tony@atomide.com, mturquette@baylibre.com, linux-omap@vger.kernel.org, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 07/03/17 16:48, Stephen Boyd wrote:
> On 02/13, Tero Kristo wrote:
>> diff --git a/drivers/clk/ti/clock.h b/drivers/clk/ti/clock.h
>> index 13c37f4..ac95fda 100644
>> --- a/drivers/clk/ti/clock.h
>> +++ b/drivers/clk/ti/clock.h
>> @@ -16,6 +16,8 @@
>>  #ifndef __DRIVERS_CLK_TI_CLOCK__
>>  #define __DRIVERS_CLK_TI_CLOCK__
>>
>> +#include <linux/clkdev.h>
>
> What is this include for? Shouldn't this be in whatever C file is
> using clkdev?

Good question. This seems to be a leftover from some evolution of this 
patch, it is totally unneeded for anything. Will drop from v2.

-Tero
