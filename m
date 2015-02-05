From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH v13 3/6] clk: Make clk API return per-user struct clk
 instances
Date: Thu, 05 Feb 2015 14:14:01 -0800
Message-ID: <54D3EB29.4090007@codeaurora.org>
References: <1422011024-32283-1-git-send-email-tomeu.vizoso@collabora.com> <1422011024-32283-4-git-send-email-tomeu.vizoso@collabora.com> <54D3C803.30706@samsung.com> <54D3CD6A.1010209@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.11.231]:42961 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751434AbbBEWOD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 5 Feb 2015 17:14:03 -0500
In-Reply-To: <54D3CD6A.1010209@codeaurora.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sylwester Nawrocki <s.nawrocki@samsung.com>, Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc: Paul Walmsley <paul@pwsan.com>, Russell King <linux@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org, Mike Turquette <mturquette@linaro.org>, linux-omap@vger.kernel.org, Javier Martinez Canillas <javier.martinez@collabora.co.uk>, linux-arm-kernel@lists.infradead.org

On 02/05/15 12:07, Stephen Boyd wrote:
> On 02/05/15 11:44, Sylwester Nawrocki wrote:
>> Hi Tomeu,
>>
>> On 23/01/15 12:03, Tomeu Vizoso wrote:
>>>  int __clk_get(struct clk *clk)
>>>  {
>>> -	if (clk) {
>>> -		if (!try_module_get(clk->owner))
>>> +	struct clk_core *core = !clk ? NULL : clk->core;
>>> +
>>> +	if (core) {
>>> +		if (!try_module_get(core->owner))
>>>  			return 0;
>>>  
>>> -		kref_get(&clk->ref);
>>> +		kref_get(&core->ref);
>>>  	}
>>>  	return 1;
>>>  }
>>>  
>>> -void __clk_put(struct clk *clk)
>>> +static void clk_core_put(struct clk_core *core)
>>>  {
>>>  	struct module *owner;
>>>  
>>> -	if (!clk || WARN_ON_ONCE(IS_ERR(clk)))
>>> -		return;
>>> +	owner = core->owner;
>>>  
>>>  	clk_prepare_lock();
>>> -	owner = clk->owner;
>>> -	kref_put(&clk->ref, __clk_release);
>>> +	kref_put(&core->ref, __clk_release);
>>>  	clk_prepare_unlock();
>>>  
>>>  	module_put(owner);
>>>  }
>>>  
>>> +void __clk_put(struct clk *clk)
>>> +{
>>> +	if (!clk || WARN_ON_ONCE(IS_ERR(clk)))
>>> +		return;
>>> +
>>> +	clk_core_put(clk->core);
>>> +	kfree(clk);
>> Why do we have kfree() here? clk_get() doesn't allocate the data structure 
>> being freed here. What happens if we do clk_get(), clk_put(), clk_get() 
>> on same clock?
>>
>> I suspect __clk_free_clk() should be called in __clk_release() callback
>> instead, but then there is an issue of safely getting reference to
>> struct clk from struct clk_core pointer.
>>
>> I tested linux-next on Odroid U3 and booting fails with oopses as below.
>> There is no problems when the above kfree() is commented out.
>>
>>
> Ah now I get it. You meant to say that of_clk_get_by_clkspec() doesn't
> return an allocated clk pointer. Let's fix that.
>
> ----8<----
>
> From: Stephen Boyd <sboyd@codeaurora.org>
> Subject: [PATCH] clkdev: Always allocate a struct clk in OF functions
>
> of_clk_get_by_clkspec() returns a struct clk pointer but it
> doesn't create a new handle for the consumers. Instead it just
> returns whatever the OF clk provider hands out. Let's create a
> per-user handle here so that clk_put() can properly unlink it and
> free it when the consumer is done.
>
> Fixes: 035a61c314eb "clk: Make clk API return per-user struct clk instances"
> Reported-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> ---
>  drivers/clk/clkdev.c | 44 +++++++++++++++++++++++---------------------
>  1 file changed, 23 insertions(+), 21 deletions(-)
>
> diff --git a/drivers/clk/clkdev.c b/drivers/clk/clkdev.c
> index 29a1ab7af4b8..00d747d09b2a 100644
> --- a/drivers/clk/clkdev.c
> +++ b/drivers/clk/clkdev.c
> @@ -29,15 +29,8 @@ static DEFINE_MUTEX(clocks_mutex);
>  
>  #if defined(CONFIG_OF) && defined(CONFIG_COMMON_CLK)
>  
> -/**
> - * of_clk_get_by_clkspec() - Lookup a clock form a clock provider
> - * @clkspec: pointer to a clock specifier data structure
> - *
> - * This function looks up a struct clk from the registered list of clock
> - * providers, an input is a clock specifier data structure as returned
> - * from the of_parse_phandle_with_args() function call.
> - */
> -struct clk *of_clk_get_by_clkspec(struct of_phandle_args *clkspec)
> +static struct clk *__of_clk_get_by_clkspec(struct of_phandle_args *clkspec,
> +					 const char *dev_id, const char *con_id)
>  {
>  	struct clk *clk;
>  
> @@ -47,6 +40,8 @@ struct clk *of_clk_get_by_clkspec(struct of_phandle_args *clkspec)
>  	of_clk_lock();
>  	clk = __of_clk_get_from_provider(clkspec);
>  
> +	if (!IS_ERR(clk))
> +		clk = __clk_create_clk(__clk_get_hw(clk), dev_id, con_id);
>  	if (!IS_ERR(clk) && !__clk_get(clk))
>  		clk = ERR_PTR(-ENOENT);
>

Actually we can bury the __clk_create_clk() inside
__of_clk_get_from_provider(). We should also move __clk_get() into there
because right now we have a hole where whoever calls
of_clk_get_from_provider() never calls __clk_get() on the clk, leading
to possible badness. v2 coming soon.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project

