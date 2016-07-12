From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCHv3 2/7] clk: ti: add clkdev get helper
Date: Tue, 12 Jul 2016 18:18:01 +0300
Message-ID: <57850A29.4010806@ti.com>
References: <1467296018-25086-1-git-send-email-t-kristo@ti.com>
 <1467296018-25086-3-git-send-email-t-kristo@ti.com>
 <20160712102228.GE5783@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <20160712102228.GE5783@n2100.arm.linux.org.uk>
Sender: linux-clk-owner@vger.kernel.org
To: Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: linux-omap@vger.kernel.org, linux-clk@vger.kernel.org, tony@atomide.com, paul@pwsan.com, sboyd@codeaurora.org, mturquette@baylibre.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 12/07/16 13:22, Russell King - ARM Linux wrote:
> On Thu, Jun 30, 2016 at 05:13:33PM +0300, Tero Kristo wrote:
>>   /**
>> + * ti_clk_get - lookup a TI clock handle
>> + * @dev_id: device to lookup clock for
>> + * @con_id: connection ID to find
>> + *
>> + * Searches for a TI clock handle based on the DT node name.
>> + * Returns the pointer to the clock handle, or ERR_PTR in failure.
>> + */
>> +static struct clk *ti_clk_get(const char *dev_id, const char *con_id)
>> +{
>> +	struct of_phandle_args clkspec;
>> +	struct device_node *node;
>> +	struct clk *clk;
>> +
>> +	/* Only check for cases of type clk_get_sys(NULL, "xyz") */
>> +	if (dev_id || !con_id)
>> +		return ERR_PTR(-ENOENT);
>> +
>> +	if (of_have_populated_dt()) {
>> +		node = of_find_node_by_name(NULL, con_id);
>> +		clkspec.np = node;
>> +		clk = of_clk_get_from_provider(&clkspec);
>> +
>> +		if (!IS_ERR(clk))
>> +			return clk;
>> +	}
>> +
>> +	return ERR_PTR(-ENOENT);
>> +}
>
> I _really_ don't like this.  This takes us back to the totally broken
> idea, that's already been proven to be greatly harmful in OMAP land,
> that the "con_id" is not a _DEVICE SPECIFIC CONNECTION NAME_ but is a
> CLOCK NAME.  The connection ID is supposed to be a static string in
> the requestor of the clock, not some random string picked out from
> DT.

What is the harm in that actually? I have most likely missed some 
discussion but please educate me. The problem is, we are already using 
this convention all over the place in the kernel (not only OMAPs), and 
trying to clean up the kernel requires some intermediate steps being 
taken, otherwise we end up doing all the clean-ups in a single massive 
patch I fear (change all the hwmod data + clock data + any 
implementations related to these at the same time.)

This specific implementation should be possible to deprecate later once 
the hwmod database is gone btw, and is mostly required for hwmod data 
only (+ OMAP timer implementation, maybe some others.) The biggest 
abuser of clk_get interface atm is omap-hwmod.

>
> This series started out with the assertion that the new clkdev hook
> was to avoid registering lots of clock aliases, but it seems with
> this patch we're going to end up with lots of specifically named
> nodes in DT instead.  It's just moving the problem to somewhere else.

That is true, it will end up adding new DT nodes. However, as OMAP 
already is doing this extensively, I wonder what would be the 
alternative. Maybe move all the clock data back to kernel space to 
increase the size of multi-v7 builds?

-Tero
