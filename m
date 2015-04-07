From: Gregory CLEMENT <gregory.clement@free-electrons.com>
Subject: Re: [PATCH 10/14] ARM: orion: use clkdev_create()
Date: Tue, 07 Apr 2015 15:20:05 +0200
Message-ID: <5523D985.60800@free-electrons.com>
References: <20150403171149.GC13898@n2100.arm.linux.org.uk> <E1Ye59d-0001BZ-Sv@rmk-PC.arm.linux.org.uk> <20150404001729.GA14824@lunn.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <20150404001729.GA14824@lunn.ch>
Sender: linux-sh-owner@vger.kernel.org
To: Andrew Lunn <andrew@lunn.ch>, Russell King <rmk+kernel@arm.linux.org.uk>
Cc: alsa-devel@alsa-project.org, Jason Cooper <jason@lakedaemon.net>, linux-sh@vger.kernel.org, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org, Mike Turquette <mturquette@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>
List-Id: linux-omap@vger.kernel.org

Hi Andrew, Russell,

On 04/04/2015 02:17, Andrew Lunn wrote:
> On Fri, Apr 03, 2015 at 06:13:13PM +0100, Russell King wrote:
>> clkdev_create() is a shorter way to write clkdev_alloc() followed by
>> clkdev_add().  Use this instead.
>>
>> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> 
> Acked-by: Andrew Lunn <andrew@lunn.ch>

This change makes sens however what about Thomas' comment: removing
orion_clkdev_add() entirely and directly using lkdev_create() all over
the place:
http://lists.infradead.org/pipermail/linux-arm-kernel/2015-March/327294.html

Then what would be the path for this patch?

As there is a dependency on the 6th patch of this series: "clkdev: add
clkdev_create() helper" which should be merged through the clk tree, I
think the best option is that this patch would be also managed by the
clk tree maintainer (I added them in CC).


Thanks,

Gregory


> 
> 	  Andrew
> 
>> ---
>>  arch/arm/plat-orion/common.c | 6 +-----
>>  1 file changed, 1 insertion(+), 5 deletions(-)
>>
>> diff --git a/arch/arm/plat-orion/common.c b/arch/arm/plat-orion/common.c
>> index f5b00f41c4f6..2235081a04ee 100644
>> --- a/arch/arm/plat-orion/common.c
>> +++ b/arch/arm/plat-orion/common.c
>> @@ -28,11 +28,7 @@
>>  void __init orion_clkdev_add(const char *con_id, const char *dev_id,
>>  			     struct clk *clk)
>>  {
>> -	struct clk_lookup *cl;
>> -
>> -	cl = clkdev_alloc(clk, con_id, dev_id);
>> -	if (cl)
>> -		clkdev_add(cl);
>> +	clkdev_create(clk, con_id, "%s", dev_id);
>>  }
>>  
>>  /* Create clkdev entries for all orion platforms except kirkwood.
>> -- 
>> 1.8.3.1
>>
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
