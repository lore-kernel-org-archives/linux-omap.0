From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: [PATCH V3 1/2] ARM: OMAP3+: use cpu0-cpufreq driver in device
 tree supported boot
Date: Thu, 4 Apr 2013 10:43:21 +0530
Message-ID: <515D0BF1.7060802@ti.com>
References: <1364507576-19345-1-git-send-email-nm@ti.com> <1364507576-19345-2-git-send-email-nm@ti.com> <87ppybxxi0.fsf@linaro.org> <20130404025211.GA2456@snafu>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <20130404025211.GA2456@snafu>
Sender: cpufreq-owner@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Kevin Hilman <khilman@linaro.org>, linux-omap@vger.kernel.org, Rob Herring <robherring2@gmail.com>, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, =?ISO-8859-1?Q?Beno=EEt_Cousson?= <b-cousson@ti.com>, Jon Hunter <jon-hunter@ti.com>, Keerthy <j-keerthy@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Shawn Guo <shawn.guo@linaro.org>
List-Id: linux-omap@vger.kernel.org

On Thursday 04 April 2013 08:22 AM, Nishanth Menon wrote:
> On 11:47-20130403, Kevin Hilman wrote:
>> Nishanth Menon <nm@ti.com> writes:
>>
> [...]
>>> diff --git a/arch/arm/mach-omap2/board-generic.c b/arch/arm/mach-omap2/board-generic.c
>>> index afa509a..5b147ef 100644
>>> --- a/arch/arm/mach-omap2/board-generic.c
>>> +++ b/arch/arm/mach-omap2/board-generic.c
>>> @@ -49,6 +49,11 @@ static void __init omap_generic_init(void)
>>>  		omap4_panda_display_init_of();
>>>  	else if (of_machine_is_compatible("ti,omap4-sdp"))
>>>  		omap_4430sdp_display_init_of();
>>> +
>>> +	if (IS_ENABLED(CONFIG_GENERIC_CPUFREQ_CPU0)) {
>>> +		struct platform_device_info devinfo = { .name = "cpufreq-cpu0", };
>>> +		platform_device_register_full(&devinfo);
>>> +	}
>>
>> Rather than adding new clkdev nodes below, how about using clk add_alias
>> here?
> Thanks for pointing this out, I spend some time implementing such a
> scheme and following is my opinion:
> 
> Summary:
> There is one major problem which forces us to introduce this "clock
> hack" - clock nodes are not in device tree yet. Yes, clock add alias

There's already a patch floating around for this..
https://lkml.org/lkml/2013/4/2/84

> can be used (see option b,c,d..) - but the maintenance burden while we
> transition into DT based clock node is just not worth the effort. The
> current patch(option a) seems to be least of the compromise approaches
> available, IMHO.
> 
> (testing example:
>  options a, b, c all generate the log: http://pastebin.com/dJe7G9Q9
>  with the updated test script: http://pastebin.com/c3ZiU2Ng (now prints
> voltage as well))
> 
> So this means we have to be able to choose one of the available hacks:
> option a) - add clock nodes in cclock_xyz_data.c
> 	the current patch under discussion.
> Pros:
> 	- we keep board-generic.c intact
> 	- DT entries as needed example:
> 	clocks = <&dpll1>; can be used. So conversion of DT clock nodes
> 	and delete of cclock_xyz_data.c could be done in a smooth manner
> 	- we do can continue to support with the same code some TI
> 	platforms which have been transitioned to DT clock nodes, while
> 	in the same code others remain with _data.c and at the end of
> 	complete transition we dont need to cleanup code.
> 	- Allows us to have different DPLL names for controlling cpu0
> 	clock as SoC needs in DT/_data.c
> Cons:
> 	yes, we have those ugly clock entries in clock_xyz_data.c files
> 	- but it anyways needs an HACK to work with current data files -
> 	why spread the hack around to other files and DT as well?
> 
> option b) using *only* clock alias cpufreq_ck
> 	http://pastebin.com/BHLNsfib
> Pros:
> 	- we could maintain clock_xyz_data.c without much modification
> Cons:
> 	- forced to maintain cpufreq_ck clock node even for DT
> 	conversion
> 	- tons of cleanup in code, DT entries to be done while we
> 	are in-transition and completion of transition to DT clock
> 	nodes.
> 
> option c) detect if clock node is populated, else use clock alias:
> 	http://pastebin.com/WpP8CSL8
> Pros:
> 	- we could add DT nodes without cleanup later on.
> Cons:
> 	- replicated code (which needs to be eventually cleaned up) just
> 	to detect cpu nodes with clock nodes registered
> 	- cleanup needs to be done anyways in 
> Pros:
> 	- we could maintain clock_xyz_data.c without much modification
> Cons:
> 	- forced to maintain cpufreq_ck clock node even for DT
> 	conversion
> 	- tons of cleanup in code, DT entries to be done while we
> 	are in-transition and completion of transition to DT clock
> 	nodes.
> 
> option d) pass the dummy pdev created for cpufreq to clock_xyz_data
> init/ io.c early_init.
> 	I did not implement this, but is an theoretical possibility
> 	we create the clock nodes in early_init, yeah we could register
> 	the platform_device and pass the node over to clock_xyz_data as
> 	an option, but that just means we have to cleanup in more than
> 	one place now - board-generic, io.c, clock_xyz_data.c etc..
> 
> [...]
>>> diff --git a/arch/arm/mach-omap2/cclock3xxx_data.c b/arch/arm/mach-omap2/cclock3xxx_data.c
>>> index 4579c3c..5a5b471 100644
>>> --- a/arch/arm/mach-omap2/cclock3xxx_data.c
>>> +++ b/arch/arm/mach-omap2/cclock3xxx_data.c
>>> @@ -3501,7 +3501,8 @@ static struct omap_clk omap3xxx_clks[] = {
>>>  	CLK(NULL,	"uart4_ick",	&uart4_ick_am35xx,	CK_AM35XX),
>>>  	CLK(NULL,	"timer_32k_ck",	&omap_32k_fck,  CK_3XXX),
>>>  	CLK(NULL,	"timer_sys_ck",	&sys_ck,	CK_3XXX),
>>> -	CLK(NULL,	"cpufreq_ck",	&dpll1_ck,	CK_3XXX),
>>> +	CLK(NULL,	"cpufreq_ck",	&dpll1_ck,	CK_3XXX), /* used in non-device tree boot */
>>> +	CLK("cpufreq-cpu0.0",	NULL,	&dpll1_ck,	CK_3XXX), /* used in device tree boot */
>>>  };
> [...]
> 

