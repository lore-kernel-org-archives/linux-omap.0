From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH v13 3/6] clk: Make clk API return per-user struct clk
 instances
Date: Thu, 05 Feb 2015 12:07:06 -0800
Message-ID: <54D3CD6A.1010209@codeaurora.org>
References: <1422011024-32283-1-git-send-email-tomeu.vizoso@collabora.com> <1422011024-32283-4-git-send-email-tomeu.vizoso@collabora.com> <54D3C803.30706@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <54D3C803.30706@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sylwester Nawrocki <s.nawrocki@samsung.com>, Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc: linux-kernel@vger.kernel.org, Mike Turquette <mturquette@linaro.org>, Javier Martinez Canillas <javier.martinez@collabora.co.uk>, Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 02/05/15 11:44, Sylwester Nawrocki wrote:
> Hi Tomeu,
>
> On 23/01/15 12:03, Tomeu Vizoso wrote:
>>  int __clk_get(struct clk *clk)
>>  {
>> -	if (clk) {
>> -		if (!try_module_get(clk->owner))
>> +	struct clk_core *core = !clk ? NULL : clk->core;
>> +
>> +	if (core) {
>> +		if (!try_module_get(core->owner))
>>  			return 0;
>>  
>> -		kref_get(&clk->ref);
>> +		kref_get(&core->ref);
>>  	}
>>  	return 1;
>>  }
>>  
>> -void __clk_put(struct clk *clk)
>> +static void clk_core_put(struct clk_core *core)
>>  {
>>  	struct module *owner;
>>  
>> -	if (!clk || WARN_ON_ONCE(IS_ERR(clk)))
>> -		return;
>> +	owner = core->owner;
>>  
>>  	clk_prepare_lock();
>> -	owner = clk->owner;
>> -	kref_put(&clk->ref, __clk_release);
>> +	kref_put(&core->ref, __clk_release);
>>  	clk_prepare_unlock();
>>  
>>  	module_put(owner);
>>  }
>>  
>> +void __clk_put(struct clk *clk)
>> +{
>> +	if (!clk || WARN_ON_ONCE(IS_ERR(clk)))
>> +		return;
>> +
>> +	clk_core_put(clk->core);
>> +	kfree(clk);
> Why do we have kfree() here? clk_get() doesn't allocate the data structure 
> being freed here. What happens if we do clk_get(), clk_put(), clk_get() 
> on same clock?
>
> I suspect __clk_free_clk() should be called in __clk_release() callback
> instead, but then there is an issue of safely getting reference to
> struct clk from struct clk_core pointer.
>
> I tested linux-next on Odroid U3 and booting fails with oopses as below.
> There is no problems when the above kfree() is commented out.
>
>

Ah now I get it. You meant to say that of_clk_get_by_clkspec() doesn't
return an allocated clk pointer. Let's fix that.

----8<----

From: Stephen Boyd <sboyd@codeaurora.org>
Subject: [PATCH] clkdev: Always allocate a struct clk in OF functions

of_clk_get_by_clkspec() returns a struct clk pointer but it
doesn't create a new handle for the consumers. Instead it just
returns whatever the OF clk provider hands out. Let's create a
per-user handle here so that clk_put() can properly unlink it and
free it when the consumer is done.

Fixes: 035a61c314eb "clk: Make clk API return per-user struct clk instances"
Reported-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 drivers/clk/clkdev.c | 44 +++++++++++++++++++++++---------------------
 1 file changed, 23 insertions(+), 21 deletions(-)

diff --git a/drivers/clk/clkdev.c b/drivers/clk/clkdev.c
index 29a1ab7af4b8..00d747d09b2a 100644
--- a/drivers/clk/clkdev.c
+++ b/drivers/clk/clkdev.c
@@ -29,15 +29,8 @@ static DEFINE_MUTEX(clocks_mutex);
 
 #if defined(CONFIG_OF) && defined(CONFIG_COMMON_CLK)
 
-/**
- * of_clk_get_by_clkspec() - Lookup a clock form a clock provider
- * @clkspec: pointer to a clock specifier data structure
- *
- * This function looks up a struct clk from the registered list of clock
- * providers, an input is a clock specifier data structure as returned
- * from the of_parse_phandle_with_args() function call.
- */
-struct clk *of_clk_get_by_clkspec(struct of_phandle_args *clkspec)
+static struct clk *__of_clk_get_by_clkspec(struct of_phandle_args *clkspec,
+					 const char *dev_id, const char *con_id)
 {
 	struct clk *clk;
 
@@ -47,6 +40,8 @@ struct clk *of_clk_get_by_clkspec(struct of_phandle_args *clkspec)
 	of_clk_lock();
 	clk = __of_clk_get_from_provider(clkspec);
 
+	if (!IS_ERR(clk))
+		clk = __clk_create_clk(__clk_get_hw(clk), dev_id, con_id);
 	if (!IS_ERR(clk) && !__clk_get(clk))
 		clk = ERR_PTR(-ENOENT);
 
@@ -54,7 +49,21 @@ struct clk *of_clk_get_by_clkspec(struct of_phandle_args *clkspec)
 	return clk;
 }
 
-static struct clk *__of_clk_get(struct device_node *np, int index)
+/**
+ * of_clk_get_by_clkspec() - Lookup a clock form a clock provider
+ * @clkspec: pointer to a clock specifier data structure
+ *
+ * This function looks up a struct clk from the registered list of clock
+ * providers, an input is a clock specifier data structure as returned
+ * from the of_parse_phandle_with_args() function call.
+ */
+struct clk *of_clk_get_by_clkspec(struct of_phandle_args *clkspec)
+{
+	return __of_clk_get_by_clkspec(clkspec, NULL, __func__);
+}
+
+static struct clk *__of_clk_get(struct device_node *np, int index,
+			       const char *dev_id, const char *con_id)
 {
 	struct of_phandle_args clkspec;
 	struct clk *clk;
@@ -68,7 +77,7 @@ static struct clk *__of_clk_get(struct device_node *np, int index)
 	if (rc)
 		return ERR_PTR(rc);
 
-	clk = of_clk_get_by_clkspec(&clkspec);
+	clk = __of_clk_get_by_clkspec(&clkspec, dev_id, con_id);
 	of_node_put(clkspec.np);
 
 	return clk;
@@ -76,12 +85,7 @@ static struct clk *__of_clk_get(struct device_node *np, int index)
 
 struct clk *of_clk_get(struct device_node *np, int index)
 {
-	struct clk *clk = __of_clk_get(np, index);
-
-	if (!IS_ERR(clk))
-		clk = __clk_create_clk(__clk_get_hw(clk), np->full_name, NULL);
-
-	return clk;
+	return __of_clk_get(np, index, np->full_name, NULL);
 }
 EXPORT_SYMBOL(of_clk_get);
 
@@ -102,12 +106,10 @@ static struct clk *__of_clk_get_by_name(struct device_node *np,
 		 */
 		if (name)
 			index = of_property_match_string(np, "clock-names", name);
-		clk = __of_clk_get(np, index);
+		clk = __of_clk_get(np, index, dev_id, name);
 		if (!IS_ERR(clk)) {
-			clk = __clk_create_clk(__clk_get_hw(clk), dev_id, name);
 			break;
-		}
-		else if (name && index >= 0) {
+		} else if (name && index >= 0) {
 			if (PTR_ERR(clk) != -EPROBE_DEFER)
 				pr_err("ERROR: could not get clock %s:%s(%i)\n",
 					np->full_name, name ? name : "", index);


-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
