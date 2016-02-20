From: Tero Kristo <t-kristo@ti.com>
Subject: Re: GPIO regression in Linux next caused by syscon change
Date: Sat, 20 Feb 2016 12:59:38 +0200
Message-ID: <56C8471A.1040702@ti.com>
References: <20160213002643.GQ19432@atomide.com>
 <20160213004935.GR19432@atomide.com>
 <CA+gwMccZeYimupmGsMX8YbNH9eEA6=Xi=rupciubBwzktfjvBA@mail.gmail.com>
 <20160215160115.GU19432@atomide.com>
 <1455552961.4899.37.camel@pengutronix.de>
 <20160215164757.GV19432@atomide.com> <20160215180635.GW19432@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20160215180635.GW19432@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>, Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, Lee Jones <lee.jones@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Philipp Zabel <philipp.zabel@gmail.com>
List-Id: linux-omap@vger.kernel.org

On 02/15/2016 08:06 PM, Tony Lindgren wrote:
> * Tony Lindgren <tony@atomide.com> [160215 08:49]:
>> * Philipp Zabel <p.zabel@pengutronix.de> [160215 08:17]:
>>> Am Montag, den 15.02.2016, 08:01 -0800 schrieb Tony Lindgren:
>>>> * Philipp Zabel <philipp.zabel@gmail.com> [160214 11:24]:
>>>>> I've just replaced the of_iomap() call with an open coded version,
>>>>> calling of_address_to_resource() and ioremap() directly. That was
>>>>> needed so I can use the struct resource returned by
>>>>> of_address_to_resource() to set the syscon_config.max_register. I
>>>>> don't see where this could cause resource overlap. Does just setting
>>>>> syscon_config.max_register to zero again make the problem disappear?
>>>>
>>>> Yes commenting out the syscon_config.max_register line in your patch
>>>> makes things work again.
>>>>
>>>> So what does that tell us about the problem?
>>>
>>> Maybe some out of bounds writes that previously worked are now catched
>>> by the max_register check in regmap_writable and regmap_write returns
>>> -EIO instead of the write being executed.
>>
>> Hmm weird that something like that would not produce errors?
>>
>>> Is there any omap_ctrl_write?() call with an offset > 0x32c into
>>> scm_conf?
>>
>> Indeed, that's where things go wrong. Adding Tero to Cc, something
>> is wrong there.
>
> Something like this might fix it? Needs to be tested to see if it
> happens on other omaps.
>
> Tero, got any better ideas?

The underlying problem is the fact that OMAP3 control module register 
map is split into multiple regions, which in certain cases have 
overlapping functionality, and need to be accessed over boundaries. And 
the fact that we decided to split it in such way in the first place, for 
example to have pinmux regions separate.

If you are going to bypass the usage of regmap, you could just drop it 
completely from the omap_ctrl_readl / writel APIs, and use the iomap 
directly. That simplifies the code and is slightly faster also.

Eventually this should probably be fixed in such way that any 
out-of-bounds accesses on the omap_ctrl region should use the actual 
driver APIs for that. The padconf accesses I have no clue how to fix (as 
pinctrl driver doesn't provide direct register read/write API), but for 
others we should introduce new regions under the DTS files and use a 
separate syscon mapping or something similar.

It looks like we have following accesses in kernel that should be converted:

under omap3_ctrl_init:
OMAP2_CONTROL_SYSCONFIG
OMAP3_PADCONF_SAD2D_MSTANDBY
OMAP3_PADCONF_SAD2D_IDLEACK

under omap3_core_save_context:

         omap_ctrl_writel(omap_ctrl_readl(OMAP343X_PADCONF_ETK_D14),
                 OMAP343X_CONTROL_MEM_WKUP + 0x2a0);


under omap3_control_save / restore:

OMAP2_CONTROL_SYSCONFIG
OMAP34XX_CONTROL_WKUP_CTRL
OMAP343X_CONTROL_PADCONF_SYSNIRQ

-Tero

>
> Regards,
>
> Tony
>
> 8< -------------------
> --- a/arch/arm/mach-omap2/control.c
> +++ b/arch/arm/mach-omap2/control.c
> @@ -167,15 +167,23 @@ u16 omap_ctrl_readw(u16 offset)
>   u32 omap_ctrl_readl(u16 offset)
>   {
>   	u32 val;
> +	int err;
>
>   	offset &= 0xfffc;
> -	if (!omap2_ctrl_syscon)
> -		val = readl_relaxed(omap2_ctrl_base + offset);
> -	else
> -		regmap_read(omap2_ctrl_syscon, omap2_ctrl_offset + offset,
> -			    &val);
> +	if (omap2_ctrl_syscon) {
> +		err = regmap_read(omap2_ctrl_syscon,
> +				  omap2_ctrl_offset + offset, &val);
> +		if (!err)
> +			return val;
> +	}
> +
> +	if (WARN(!omap2_ctrl_base,
> +		 "syscon out of range for offset 0x%x, no omap2_ctrl_base?\n",
> +		    offset)) {
> +		return 0;
> +	}
>
> -	return val;
> +	return readl_relaxed(omap2_ctrl_base + offset);
>   }
>
>   void omap_ctrl_writeb(u8 val, u16 offset)
> @@ -206,12 +214,23 @@ void omap_ctrl_writew(u16 val, u16 offset)
>
>   void omap_ctrl_writel(u32 val, u16 offset)
>   {
> +	int err;
> +
>   	offset &= 0xfffc;
> -	if (!omap2_ctrl_syscon)
> -		writel_relaxed(val, omap2_ctrl_base + offset);
> -	else
> -		regmap_write(omap2_ctrl_syscon, omap2_ctrl_offset + offset,
> -			     val);
> +	if (omap2_ctrl_syscon) {
> +		err = regmap_write(omap2_ctrl_syscon,
> +				   omap2_ctrl_offset + offset, val);
> +		if (!err)
> +			return;
> +	}
> +
> +	if (WARN(!omap2_ctrl_base,
> +		 "syscon out of range for offset 0x%x, no omap2_ctrl_base?\n",
> +		    offset)) {
> +		return;
> +	}
> +
> +	writel_relaxed(val, omap2_ctrl_base + offset);
>   }
>
>   #ifdef CONFIG_ARCH_OMAP3
> @@ -724,9 +743,6 @@ int __init omap_control_init(void)
>   				if (ret)
>   					return ret;
>   			}
> -
> -			iounmap(omap2_ctrl_base);
> -			omap2_ctrl_base = NULL;
>   		} else {
>   			/* No scm_conf found, direct access */
>   			ret = omap2_clk_provider_init(np, data->index, NULL,
>
