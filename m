From: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>
Subject: Re: [RFC PATCH 2/2] of/clk: use "clkops-clocks" to specify clocks
 handled by clock_ops domain
Date: Mon, 28 Jul 2014 20:47:48 +0300
Message-ID: <53D68CC4.1010704@ti.com>
References: <1398334403-26181-1-git-send-email-geert+renesas@glider.be>	<1402592023-13416-1-git-send-email-grygorii.strashko@ti.com>	<1402592023-13416-3-git-send-email-grygorii.strashko@ti.com> <20140728140533.6E916C4116F@trevor.secretlab.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140728140533.6E916C4116F-WNowdnHR2B42iJbIjFUEsiwD8/FfD2ys@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org
Cc: laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org, ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, khilman-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, tomasz.figa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, ben.dooks-4yDnlxn2s6sWdaTGBSpHTA@public.gmane.org, horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org, magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi Grant.

On 07/28/2014 05:05 PM, Grant Likely wrote:
> On Thu, 12 Jun 2014 19:53:43 +0300, Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org> wrote:
>> Use "clkops-clocks" property to specify clocks handled by
>> clock_ops domain PM domain. Only clocks defined in "clkops-clocks"
>> set of clocks will be handled by Runtime PM through clock_ops
>> Pm domain.
>>
>> Signed-off-by: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>
>> ---
>>   drivers/of/of_clk.c |    7 ++-----
>>   1 file changed, 2 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/of/of_clk.c b/drivers/of/of_clk.c
>> index 35f5e9f..5f9b90e 100644
>> --- a/drivers/of/of_clk.c
>> +++ b/drivers/of/of_clk.c
>> @@ -86,11 +86,8 @@ int of_clk_register_runtime_pm_clocks(struct device_node *np,
>>   	struct clk *clk;
>>   	int error;
>>   
>> -	for (i = 0; (clk = of_clk_get(np, i)) && !IS_ERR(clk); i++) {
>> -		if (!clk_may_runtime_pm(clk)) {
>> -			clk_put(clk);
>> -			continue;
>> -		}
>> +	for (i = 0; (clk = of_clk_get_from_set(np, "clkops", i)) &&
>> +		     !IS_ERR(clk); i++) {
> 
> This really looks like an ABI break to me. What happens to all the
> existing platforms who don't have this new clkops-clocks in their device
> tree?

Agree. This patch as is will break such platforms.
As possible solution for above problem - the NULL can be used as clock's prefix
by default and platform code can configure new value of clock's prefix during
initialization.
In addition, to make this solution full the of_clk_get_by_name() will
need to be modified too.

But note pls, this is pure RFC patches which I did to find out the answer on questions:
- What is better: maintain Runtime PM clocks configuration in DT or in code?

- Where and when to call of_clk_register_runtime_pm_clocks()?
  Bus notifier/ platform core/ device drivers

Also, May be platform dependent solution [1] can be acceptable for now?

[1] https://lkml.org/lkml/2014/7/25/630

Best regards,
-grygorii

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
