From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH 6/7] OMAP3: board-dt: Add generic board file for DT support
Date: Fri, 2 Sep 2011 10:46:56 +0200
Message-ID: <4E609800.9090402@ti.com>
References: <1314897912-18178-1-git-send-email-b-cousson@ti.com>
	<1314897912-18178-7-git-send-email-b-cousson@ti.com>
	<20110902080944.GP3548@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20110902080944.GP3548@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>
Cc: "grant.likely@secretlab.ca" <grant.likely@secretlab.ca>, "G,
	Manjunath Kondaiah" <manjugk@ti.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

Hi Tony,

On 9/2/2011 10:09 AM, Tony Lindgren wrote:
> Hi,
>
> * Benoit Cousson<b-cousson@ti.com>  [110901 19:52]:
>> Create an OMAP3 generic board to start the DT migration.
>
> I don't think this needs to be SoC specific, we can add multiple
> DT_MACHINE_START entries into a single file. So it should be
> just board-omap-dt.c.

I do agree, it should not, I made that comment into the 
board-omap4-dt.c, but for the moment we still have dedicated OMAP 
specifics stuff at board level, like the map_io.

I have an other series that make the map_io DT aware to get rid of that, 
but it still not finalized.

My goal was have a single DT_MACHINE_START for every OMAPs.
But, meanwhile, if you prefer one file with many board descriptors, 
that's fine.

>> +#include "mux.h"
>> +#include "common-board-devices.h"
>> +#include "sdram-micron-mt46h32m32lf-6.h"
>> +
>> +
>> +static void __init omap3_init_early(void)
>> +{
>> +	omap2_init_common_infrastructure();
>> +	omap2_init_common_devices(mt46h32m32lf6_sdrc_params,
>> +				  mt46h32m32lf6_sdrc_params);
>> +}
>
> This has changed, see the cleanup branch. Also, let's just leave
> out the sdram timings for now as we can work with bootloader
> timings until those come from DT too.

Yep, I know, but since that series is based on my previous series that 
is based on mainline rc-3, I missed these.

Now, that kernel.org is back, I'll pull you branches :-).

Which one do you recommend in that case, master or cleanup?

>> +static void __init omap3_init(void)
>> +{
>> +	struct device_node *node;
>> +
>> +	node = of_find_matching_node(NULL, omap_dt_intc_match);
>> +	if (node)
>> +		irq_domain_add_simple(node, 0);
>> +
>> +	omap3_mux_init(board_mux, OMAP_PACKAGE_CBB);
>> +	omap_serial_init();
>> +
>> +	of_platform_populate(NULL, omap_dt_match_table, NULL, NULL);
>> +}
>> +
>> +static const char *omap3_dt_match[] __initdata = {
>> +	"ti,omap3",
>> +	NULL
>> +};
>
> Most likely we just need SoC specific init functions in this file
> now until the mux data comes from DT also.

OK, I can get rid of mux stuff then.

>> +DT_MACHINE_START(OMAP3_DT, "TI OMAP3 (Flattened Device Tree)")
>> +	.reserve	= omap_reserve,
>> +	.map_io		= omap3_map_io,
>> +	.init_early	= omap3_init_early,
>> +	.init_irq	= omap3_init_irq,
>> +	.init_machine	= omap3_init,
>> +	.timer		=&omap3_timer,
>> +	.dt_compat	= omap3_dt_match,
>> +MACHINE_END
>
> Here omap3_init_early is now generic in the cleanup branch.

Cool, I'll update the whole series, including the OMAP4 ones.

Benoit
