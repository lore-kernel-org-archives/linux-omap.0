From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCHv4 01/33] CLK: clkdev: add support for looking up clocks
 from DT
Date: Wed, 31 Jul 2013 11:43:41 +0300
Message-ID: <51F8CE3D.6040101@ti.com>
References: <1374564028-11352-1-git-send-email-t-kristo@ti.com>
 <1374564028-11352-2-git-send-email-t-kristo@ti.com> <51F7D5FE.7030003@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <51F7D5FE.7030003@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Nishanth Menon <nm@ti.com>
Cc: paul@pwsan.com, khilman@linaro.org, mturquette@linaro.org, tony@atomide.com, devicetree-discuss@lists.ozlabs.org, rnayak@ti.com, Russell King <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 07/30/2013 06:04 PM, Nishanth Menon wrote:
> On 07/23/2013 02:19 AM, Tero Kristo wrote:
>> clk_get_sys / clk_get can now find clocks from device-tree. If a DT clock
>> is found, an entry is added to the clk_lookup list also for subsequent
>> searches.
>>
>> Signed-off-by: Tero Kristo <t-kristo@ti.com>
>> Cc: Russell King <linux@arm.linux.org.uk>
>> ---
>>   drivers/clk/clkdev.c |   32 ++++++++++++++++++++++++++++++++
>>   1 file changed, 32 insertions(+)
>>
>> diff --git a/drivers/clk/clkdev.c b/drivers/clk/clkdev.c
>> index 442a313..e39f082 100644
>> --- a/drivers/clk/clkdev.c
>> +++ b/drivers/clk/clkdev.c
>> @@ -93,6 +93,18 @@ struct clk *of_clk_get_by_name(struct device_node
>> *np, const char *name)
>>   EXPORT_SYMBOL(of_clk_get_by_name);
>>   #endif
>>
>> +/**
>> + * clkdev_add_nolock - add lookup entry for a clock
>> + * @cl: pointer to new clock lookup entry
>> + *
>> + * Non-locking version, used internally by clk_find() to add DT based
>> + * clock lookup entries.
>> + */
>> +static void clkdev_add_nolock(struct clk_lookup *cl)
>> +{
>> +    list_add_tail(&cl->node, &clocks);
>> +}
>> +
>>   /*
>>    * Find the correct struct clk for the device and connection ID.
>>    * We do slightly fuzzy matching here:
>> @@ -106,6 +118,9 @@ static struct clk_lookup *clk_find(const char
>> *dev_id, const char *con_id)
>>   {
>>       struct clk_lookup *p, *cl = NULL;
>>       int match, best_found = 0, best_possible = 0;
>> +    struct device_node *node;
>> +    struct clk *clk;
>> +    struct of_phandle_args clkspec;
>>
>>       if (dev_id)
>>           best_possible += 2;
>> @@ -133,6 +148,23 @@ static struct clk_lookup *clk_find(const char
>> *dev_id, const char *con_id)
>>                   break;
>>           }
>>       }
>> +
>> +    if (cl)
>> +        return cl;
>> +
>> +    /* If clock was not found, attempt to look-up from DT */
>> +    node = of_find_node_by_name(NULL, con_id);
>> +
>> +    clkspec.np = node;
>> +
>> +    clk = of_clk_get_from_provider(&clkspec);
>> +
>> +    if (!IS_ERR(clk)) {
>> +        /* We found a clock, add node to clkdev */
>> +        cl = clkdev_alloc(clk, con_id, dev_id);
>
> clkdev_alloc may return NULL depending on vclkdev_alloc in which case
> clkdev_add_nolock will crash trying to dereference it.

I'll add a check for that.

-Tero

>
>> +        clkdev_add_nolock(cl);
>> +    }
>> +
>>       return cl;
>>   }
>>
>>
>
>
