From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: [PATCH V3 1/2] ARM: OMAP3+: use cpu0-cpufreq driver in device
 tree supported boot
Date: Fri, 5 Apr 2013 15:20:49 +0530
Message-ID: <515E9E79.8010300@ti.com>
References: <1364507576-19345-1-git-send-email-nm@ti.com> <1364507576-19345-2-git-send-email-nm@ti.com> <87ppybxxi0.fsf@linaro.org> <20130404025211.GA2456@snafu> <515D0BF1.7060802@ti.com> <20130404190053.GA4371@kahuna>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:56659 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932509Ab3DEJu5 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 5 Apr 2013 05:50:57 -0400
In-Reply-To: <20130404190053.GA4371@kahuna>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Kevin Hilman <khilman@linaro.org>, linux-omap@vger.kernel.org, Rob Herring <robherring2@gmail.com>, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, =?ISO-8859-1?Q?Beno=EEt_Cousson?= <b-cousson@ti.com>, Jon Hunter <jon-hunter@ti.com>, Keerthy <j-keerthy@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Shawn Guo <shawn.guo@linaro.org>

On Friday 05 April 2013 12:30 AM, Nishanth Menon wrote:
> On 10:43-20130404, Rajendra Nayak wrote:
>> On Thursday 04 April 2013 08:22 AM, Nishanth Menon wrote:
>>> On 11:47-20130403, Kevin Hilman wrote:
>>>> Nishanth Menon <nm@ti.com> writes:
>>>>
>>> [...]
>>>>> diff --git a/arch/arm/mach-omap2/board-generic.c b/arch/arm/mach-omap2/board-generic.c
>>>>> index afa509a..5b147ef 100644
>>>>> --- a/arch/arm/mach-omap2/board-generic.c
>>>>> +++ b/arch/arm/mach-omap2/board-generic.c
>>>>> @@ -49,6 +49,11 @@ static void __init omap_generic_init(void)
>>>>>  		omap4_panda_display_init_of();
>>>>>  	else if (of_machine_is_compatible("ti,omap4-sdp"))
>>>>>  		omap_4430sdp_display_init_of();
>>>>> +
>>>>> +	if (IS_ENABLED(CONFIG_GENERIC_CPUFREQ_CPU0)) {
>>>>> +		struct platform_device_info devinfo = { .name = "cpufreq-cpu0", };
>>>>> +		platform_device_register_full(&devinfo);
>>>>> +	}
>>>>
>>>> Rather than adding new clkdev nodes below, how about using clk add_alias
>>>> here?
>>> Thanks for pointing this out, I spend some time implementing such a
>>> scheme and following is my opinion:
>>>
>>> Summary:
>>> There is one major problem which forces us to introduce this "clock
>>> hack" - clock nodes are not in device tree yet. Yes, clock add alias
>>
>> There's already a patch floating around for this..
>> https://lkml.org/lkml/2013/4/2/84
> Not really. Try on OMAP4 PandaBoard:
> Based on
> git://git.kernel.org/pub/scm/linux/kernel/git/bcousson/linux-omap-dt.git
> for_3.10/dts  d114294 ARM: dts: AM33XX: Corrects typo in interrupt field in SPI node
> + the patch https://patchwork.kernel.org/patch/2335671/ applied
> Pandaboard 4 Log: http://pastebin.com/qsdsbv7p
> The Patch does not even work, unless there is un-documented patch
> dependencies!

I guess Roger responded to that.

> 
> Secondly, even if it did work, it would still continue to need yet another
> hack[1] 

Why do you think thats a hack? Besides I don't know if you are
doing it right.

- I am agree with Tony in his discussion in
> http://marc.info/?t=136370325600009&r=1&w=2
> 
> *if* we are moving clock to DT, we should move the data to DT as well -

I don't think Tony said 'move all clock data into DT'. He was suggesting
a combination of DT and /lib/firmware

> similar to what other platforms do - highbank as far as i can quickly
> see. (drivers/clk/clk-highbank.c and arch/arm/boot/dts/ecx-common.dtsi

Well, you chose to look at highbank (which has 8 clock nodes in DT, as
opposed to OMAP5 which has around 250 in kernel) why don't you also look at imx?
drivers/clk/mxs/clk-imx28.c and Documentation/devicetree/bindings/clock/imx28-clock.txt
for examples.
They have around 65 nodes (still way lesser than OMAP) and see what
they do. Thats exactly what Roger does in his patch.

regards,
Rajendra

> as examples). Clk alias might have been a solution, but in this case,
> clk add alias (as I indicated in this thread is not really worth the
> effort for the mess of code it creates for cpu clock).
> 
> [1]
> diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
> index dd8f58f..9282b4c 100644
> --- a/arch/arm/boot/dts/omap4.dtsi
> +++ b/arch/arm/boot/dts/omap4.dtsi
> @@ -635,4 +635,9 @@
>  			ti,has-mailbox;
>  		};
>  	};
> +
> +	dpll_mpu: scrmclks {
> +		compatible = "ti,omap4-clock";
> +		#clock-cells = <1>;
> +	};
>  };
> diff --git a/arch/arm/boot/dts/omap443x.dtsi b/arch/arm/boot/dts/omap443x.dtsi
> index cccf39a..1587a5f 100644
> --- a/arch/arm/boot/dts/omap443x.dtsi
> +++ b/arch/arm/boot/dts/omap443x.dtsi
> @@ -21,6 +21,8 @@
>  				800000  1313000
>  				1008000 1375000
>  			>;
> +			clocks = <&dpll_mpu>;
> +			clock-names = "cpu";
>  			clock-latency = <300000>; /* From legacy driver */
>  		};
>  	};
> diff --git a/arch/arm/mach-omap2/board-generic.c b/arch/arm/mach-omap2/board-generic.c
> index afa509a..5b147ef 100644
> --- a/arch/arm/mach-omap2/board-generic.c
> +++ b/arch/arm/mach-omap2/board-generic.c
> @@ -49,6 +49,11 @@ static void __init omap_generic_init(void)
>  		omap4_panda_display_init_of();
>  	else if (of_machine_is_compatible("ti,omap4-sdp"))
>  		omap_4430sdp_display_init_of();
> +
> +	if (IS_ENABLED(CONFIG_GENERIC_CPUFREQ_CPU0)) {
> +		struct platform_device_info devinfo = { .name = "cpufreq-cpu0", };
> +		platform_device_register_full(&devinfo);
> +	}
>  }
>  
>  #ifdef CONFIG_SOC_OMAP2420
> diff --git a/arch/arm/mach-omap2/cclock44xx_data.c b/arch/arm/mach-omap2/cclock44xx_data.c
> index a93617b..ba4562a 100644
> --- a/arch/arm/mach-omap2/cclock44xx_data.c
> +++ b/arch/arm/mach-omap2/cclock44xx_data.c
> @@ -1675,6 +1675,7 @@ static struct clk *dt_clks[] = {
>  	&auxclk3_ck,
>  	&auxclk4_ck,
>  	&auxclk5_ck,
> +	&dpll_mpu_ck,
>  };
>  
>  static struct clk_onecell_data clock_data;
> 

