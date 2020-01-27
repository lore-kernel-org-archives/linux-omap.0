From: David Lechner <david@lechnology.com>
Subject: Re: [PATCH v2] mfd: syscon: Use a unique name with regmap_config
Date: Mon, 27 Jan 2020 17:40:54 -0600
Message-ID: <217993e5-5e1d-79a1-7684-c6bb964379f0@lechnology.com>
References: <20200127231208.1443-1-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200127231208.1443-1-s-anna@ti.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Suman Anna <s-anna@ti.com>, Lee Jones <lee.jones@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Tony Lindgren <tony@atomide.com>, Roger Quadros <rogerq@ti.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 1/27/20 5:12 PM, Suman Anna wrote:
> The DT node full name is currently being used in regmap_config
> which in turn is used to create the regmap debugfs directories.
> This name however is not guaranteed to be unique and the regmap
> debugfs registration can fail in the cases where the syscon nodes
> have the same unit-address but are present in different DT node
> hierarchies. Replace this logic using the syscon reg resource
> address instead (inspired from logic used while creating platform
> devices) to ensure a unique name is given for each syscon.
> 
> Signed-off-by: Suman Anna <s-anna@ti.com>
> ---
> v2: Fix build warning reported by kbuild test bot
> v1: https://patchwork.kernel.org/patch/11346363/
> 
>   drivers/mfd/syscon.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mfd/syscon.c b/drivers/mfd/syscon.c
> index e22197c832e8..f0815d8e6e95 100644
> --- a/drivers/mfd/syscon.c
> +++ b/drivers/mfd/syscon.c
> @@ -101,12 +101,14 @@ static struct syscon *of_syscon_register(struct device_node *np, bool check_clk)
>   		}
>   	}
>   
> -	syscon_config.name = of_node_full_name(np);
> +	syscon_config.name = kasprintf(GFP_KERNEL, "%pOFn@%llx", np,
> +				       (u64)res.start);

Would it make sense to also include the node name along with the
pointer address so that the name is still easily identifiable?

>   	syscon_config.reg_stride = reg_io_width;
>   	syscon_config.val_bits = reg_io_width * 8;
>   	syscon_config.max_register = resource_size(&res) - reg_io_width;
>   
>   	regmap = regmap_init_mmio(NULL, base, &syscon_config);
> +	kfree(syscon_config.name);
>   	if (IS_ERR(regmap)) {
>   		pr_err("regmap init failed\n");
>   		ret = PTR_ERR(regmap);
> 
