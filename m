From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: ti-cpufreq: Fix couple of minor issues in
 probe()
Date: Mon, 2 Apr 2018 12:02:55 +0530
Message-ID: <20180402063255.GC4714@vireshk-i7>
References: <20180326215244.26304-1-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180326215244.26304-1-s-anna@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Suman Anna <s-anna@ti.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Dave Gerlach <d-gerlach@ti.com>, Tero Kristo <t-kristo@ti.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Zumeng Chen <zumeng.chen@gmail.com>
List-Id: linux-omap@vger.kernel.org

On 26-03-18, 16:52, Suman Anna wrote:
> Commit 05829d9431df ("cpufreq: ti-cpufreq: kfree opp_data when
> failure") has fixed a memory leak in the failure path, however
> kmemleak still keeps reporting a leak even on successful probes.
> This is a false-positive and is mostly a result of the opp_data

I don't agree to this reasoning for this particular patch. The code is just fine
and kmemleak is something that requires a fix.

> variable not being stored anywhere in the probe function. The
> patch also returned a positive value on the get_cpu_device()
> failure instead of a negative value.

Maybe that could have been fixed in a separate patch, cc'ing stable kernels as
well.

> unreferenced object 0xecae4d80 (size 64):
>   comm "swapper/0", pid 1, jiffies 4294937673 (age 154.420s)
>   hex dump (first 32 bytes):
>     10 40 d9 ee 74 b7 db ee 00 24 ac ec 20 a3 ea c0  .@..t....$.. ...
>     00 26 ac ec 00 00 00 00 00 00 00 00 00 00 00 00  .&..............
>   backtrace:
>     [<ec080d62>] platform_drv_probe+0x50/0xac
>     [<cbde8566>] driver_probe_device+0x24c/0x330
>     [<a5818eb4>] bus_for_each_drv+0x54/0xb8
>     [<2c6f7021>] __device_attach+0xcc/0x13c
>     [<a04478a2>] bus_probe_device+0x88/0x90
>     [<b322c963>] device_add+0x38c/0x5b4
>     [<6f1af99b>] platform_device_add+0x100/0x220
>     [<cef42bca>] platform_device_register_full+0xf0/0x104
>     [<4d492439>] ti_cpufreq_init+0x44/0x6c
>     [<81222e89>] do_one_initcall+0x48/0x190
>     [<3bebf42a>] kernel_init_freeable+0x1f4/0x2b8
>     [<230ad7df>] kernel_init+0x8/0x110
>     [<43a165c3>] ret_from_fork+0x14/0x20
>     [<  (null)>]   (null)
>     [<87288797>] 0xffffffff
> 
> Fix both issues by replacing the previous logic by using the devres
> managed API for allocating the opp_data variable, and simplifying
> the get_cpu_device() failure return path.
> 
> Fixes: 05829d9431df ("cpufreq: ti-cpufreq: kfree opp_data when failure")
> Cc: Zumeng Chen <zumeng.chen@gmail.com>
> Signed-off-by: Suman Anna <s-anna@ti.com>
> ---
>  drivers/cpufreq/ti-cpufreq.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/cpufreq/ti-cpufreq.c b/drivers/cpufreq/ti-cpufreq.c
> index a099b7bf74cd..7d353a21935b 100644
> --- a/drivers/cpufreq/ti-cpufreq.c
> +++ b/drivers/cpufreq/ti-cpufreq.c
> @@ -217,7 +217,7 @@ static int ti_cpufreq_probe(struct platform_device *pdev)
>  	if (!match)
>  		return -ENODEV;
>  
> -	opp_data = kzalloc(sizeof(*opp_data), GFP_KERNEL);
> +	opp_data = devm_kzalloc(&pdev->dev, sizeof(*opp_data), GFP_KERNEL);
>  	if (!opp_data)
>  		return -ENOMEM;
>  
> @@ -226,8 +226,7 @@ static int ti_cpufreq_probe(struct platform_device *pdev)
>  	opp_data->cpu_dev = get_cpu_device(0);
>  	if (!opp_data->cpu_dev) {
>  		pr_err("%s: Failed to get device for CPU0\n", __func__);
> -		ret = ENODEV;
> -		goto free_opp_data;
> +		return -ENODEV;
>  	}
>  
>  	opp_data->opp_node = dev_pm_opp_of_get_opp_desc_node(opp_data->cpu_dev);
> @@ -285,8 +284,6 @@ static int ti_cpufreq_probe(struct platform_device *pdev)
>  
>  fail_put_node:
>  	of_node_put(opp_data->opp_node);
> -free_opp_data:
> -	kfree(opp_data);
>  
>  	return ret;
>  }

I am fine with the diff though, as that makes sense. So maybe do this ?

- send separate patch for ENODEV thing
- and another patch to move to devres with a different reason than fixing false
  positive.

-- 
viresh
