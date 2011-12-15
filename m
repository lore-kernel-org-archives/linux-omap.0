From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: [PATCH v3 4/4] ARM: omap: pass minimal SoC/board data for UART
 from dt
Date: Thu, 15 Dec 2011 12:22:19 +0530
Message-ID: <4EE99923.4030902@ti.com>
References: <1323863746-18145-1-git-send-email-rnayak@ti.com> <1323863746-18145-5-git-send-email-rnayak@ti.com> <20111214192509.GH32251@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <20111214192509.GH32251@atomide.com>
Sender: linux-serial-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-serial@vger.kernel.org, linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, khilman@ti.com, govindraj.raja@ti.com, b-cousson@ti.com, linux-arm-kernel@lists.infradead.org, linaro-dev@lists.linaro.org, patches@linaro.org, robherring2@gmail.com
List-Id: linux-omap@vger.kernel.org

On Thursday 15 December 2011 12:55 AM, Tony Lindgren wrote:
> * Rajendra Nayak<rnayak@ti.com>  [111214 03:24]:
>> Pass minimal data needed for console boot, from dt, for
>> OMAP4 panda/sdp and OMAP3 beagle boards, and get rid of the
>> static initialization from generic board file.
>>
>> Acked-by: Rob Herring<rob.herring@calxeda.com>
>> Signed-off-by: Rajendra Nayak<rnayak@ti.com>
>
> This we can't merge because this breaks serial console for
> omap2 because you're not adding the omap2 specific dtsi
> entries for omap2..

But we never had omap2 working with DT, because we never added
a .dtsi file for omap2 or a .dts file for any omap2 board variants.

Until now the DT support on OMAP has been limited to OMAP3 and OMAP4
with boards limited to omap3beagle/omap4Panda and omap4sdp.

So when we do add base support for omap2, we could update those
with the serial entries.

>
>> --- a/arch/arm/mach-omap2/board-generic.c
>> +++ b/arch/arm/mach-omap2/board-generic.c
>> @@ -69,7 +69,6 @@ static void __init omap_generic_init(void)
>>   	if (node)
>>   		irq_domain_add_simple(node, 0);
>>
>> -	omap_serial_init();
>>   	omap_sdrc_init(NULL, NULL);
>>
>>   	of_platform_populate(NULL, omap_dt_match_table, NULL, NULL);
>
> ..and you're removing the call for omap_serial_init.
>
> Please just update this patch with the omap2 entries
> as well. Other than that looks good to me.
>
> Tony

