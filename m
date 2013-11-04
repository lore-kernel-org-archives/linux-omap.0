From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCHv9 06/43] CLK: ti: add init support for clock IP blocks
Date: Mon, 4 Nov 2013 09:23:22 +0200
Message-ID: <52774B6A.7070607@ti.com>
References: <1382716658-6964-1-git-send-email-t-kristo@ti.com> <1382716658-6964-7-git-send-email-t-kristo@ti.com> <52727A58.9010903@ti.com> <52737095.10900@ti.com> <5273FD73.7000208@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:35028 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751519Ab3KDHXw (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 4 Nov 2013 02:23:52 -0500
In-Reply-To: <5273FD73.7000208@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>, linux-omap@vger.kernel.org, paul@pwsan.com, tony@atomide.com, bcousson@baylibre.com, rnayak@ti.com, mturquette@linaro.org
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

On 11/01/2013 09:13 PM, Nishanth Menon wrote:
> On 11/01/2013 04:12 AM, Tero Kristo wrote:
>> On 10/31/2013 05:42 PM, Nishanth Menon wrote:
>>> On 10/25/2013 10:57 AM, Tero Kristo wrote:
>>>> ti_dt_clk_init_provider() can now be used to initialize the contents of
>>>> a single clock IP block. This parses all the clocks under the IP block
>>>> and calls the corresponding init function for them.
>>>>
>>>> Signed-off-by: Tero Kristo <t-kristo@ti.com>
>>>> ---
>>>>    drivers/clk/ti/clk.c   |   59 ++++++++++++++++++++++++++++++++++++++++++++++++
>>>>    include/linux/clk/ti.h |    1 +
>>>>    2 files changed, 60 insertions(+)
>>>>
>>>> diff --git a/drivers/clk/ti/clk.c b/drivers/clk/ti/clk.c
>>>> index ad58b01..7f030d7 100644
>>>> --- a/drivers/clk/ti/clk.c
>>>> +++ b/drivers/clk/ti/clk.c
>>>> @@ -19,6 +19,9 @@
>>>>    #include <linux/clkdev.h>
>>>>    #include <linux/clk/ti.h>
>>>>    #include <linux/of.h>
>>>> +#include <linux/list.h>
>>>> +
>>>> +extern struct of_device_id __clk_of_table[];
>>>>
>>>>    /**
>>>>     * ti_dt_clocks_register - register DT duplicate clocks during boot
>>>> @@ -50,3 +53,59 @@ void __init ti_dt_clocks_register(struct ti_dt_clk oclks[])
>>>>    		}
>>>>    	}
>>>>    }
>>>> +
>>>> +typedef int (*ti_of_clk_init_cb_t)(struct device_node *, struct regmap *);
>>>> +
>>>> +struct clk_init_item {
>>>> +	struct regmap *regmap;
>>>> +	struct device_node *np;
>>>> +	ti_of_clk_init_cb_t init_cb;
>>>> +	struct list_head node;
>>>> +};
>>>> +
>>>> +static LIST_HEAD(retry_list);
>>>> +
>>>> +void __init ti_dt_clk_init_provider(struct device_node *parent,
>>>> +				    struct regmap *regmap)
>>>> +{
>>>> +	const struct of_device_id *match;
>>>> +	struct device_node *np;
>>>> +	ti_of_clk_init_cb_t clk_init_cb;
>>>> +	struct clk_init_item *retry;
>>>> +	struct clk_init_item *tmp;
>>>> +	int ret;
>>>> +
>>>> +	for_each_child_of_node(parent, np) {
>>>> +		match = of_match_node(__clk_of_table, np);
>>>> +		if (!match)
>>>> +			continue;
>>>> +		clk_init_cb = match->data;
>>>
>>> I must admit I am confused here.
>>
>> Yea this patch is something I am not quite comfortable myself yet and
>> would like improvement ideas....
>>
>>> a) of_clk_init (in the generic clk.c) uses of_clk_init_cb_t as match
>>> data. The prototype of the generic of_clk_init_cb_t is typedef void
>>> (*of_clk_init_cb_t)(struct device_node *);
>>> b) both of_clk_init and ti_dt_clk_init_provider looks up clock nodes
>>> from __clk_of_table
>>
>> __clk_of_table contains the function pointers for the clock init
>> functions, not clock nodes.
>
> yes, apologies, should have stated the prototypes of functions in a
> single __clk_of_table should not be two different argument list. The
> reason is as follows: CLK_OF_DECLARE fills up that list. there can be
> generic drivers such as [1] which might be registered, OR in the case
> of MULTI_ARCH - multiple other SoC drivers would have registered
> there. There is a bunch of stuff we could mess up here.
>
> If we do not have a choice, if we would like to maintain a different
> prototype based init list, we should probably do it in a different
> structure - example __clk_of_table_regmap or something similar..
>
>
>>
>>>
>>> I assume we need ti_dt_clk_init_provider to be always called with
>>> clock list, as a result of_clk_init(NULL); will never be invoked. This
>>> is counter productive as you have have generic non SoC clock providers
>>> as well who would have been invoked with of_clk_init(NULL);
>>
>> Can't call of_clk_init(NULL) anymore, as Paul wants to map the clock
>> nodes under respective IP blocks. Two reasons here:
>>
>> a) This requires me to pass some info from the IP block (CM1/CM2/PRM) to
>> the clock init functions, basically the pointer to the memory map region
>> (regmap.)
>> b) of_clk_init(NULL) will initialize all the clock nodes in the system,
>> irrespective of the hierarchy considerations.
>>
>> Only thing that can be done, is to make the API introduced in this patch
>> a generic API and call it something like of_clk_init_children().
>
> you still can do that:
>
> of_prcm_init->ti_dt_clk_init_provider-> instead of matching nodes from
> __clk_of_table, you can make it __clk_of_regmap_table -> the
> CLK_OF_DECLARE will not be good enough here ofcourse, but this will
> probably belong to a generic regmap enabled clock support framework -
> i dont see much that is TI specific in drivers/clk/ti/clk.c and it
> makes sense to be part of generic clock framework handling as generic
> clock framework will receive regmap support based on previous patches.
> that allows for other platforms to use regmap based clk drivers as well.

Yea different init tables can be introduced, however I still need to 
split the support between hierarchical version and the blunt version 
that registers everything. Looking at the work from Jyri, its possible I 
need to add calls to both.

-Tero

>
>
> [1] http://marc.info/?l=linux-omap&m=138331451210184&w=2
>

