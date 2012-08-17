From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: gpmc generic retime function (subject was RE: [PATCH v5 3/3]
 ARM: OMAP2+: onenand: prepare for gpmc driver migration)
Date: Fri, 17 Aug 2012 10:02:34 -0500
Message-ID: <502E5D0A.2030109@ti.com>
References: <C8443D0743D26F4388EA172BF4E2A7A93E9A35E1@DBDE01.ent.ti.com> <20120705105535.GB1122@atomide.com> <C8443D0743D26F4388EA172BF4E2A7A93E9A39DF@DBDE01.ent.ti.com> <20120706120533.GU1122@atomide.com> <C8443D0743D26F4388EA172BF4E2A7A93E9A622E@DBDE01.ent.ti.com> <20120710094538.GT1122@atomide.com> <C8443D0743D26F4388EA172BF4E2A7A93E9A64D0@DBDE01.ent.ti.com> <20120710131734.GV1122@atomide.com> <C8443D0743D26F4388EA172BF4E2A7A93E9A669D@DBDE01.ent.ti.com> <4FFC6330.1040409@ti.com> <20120711064724.GA1122@atomide.com> <C8443D0743D26F4388EA172BF4E2A7A93E9B150D@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:59903 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758130Ab2HQPCb (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 17 Aug 2012 11:02:31 -0400
In-Reply-To: <C8443D0743D26F4388EA172BF4E2A7A93E9B150D@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Mohammed, Afzal" <afzal@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, "paul@pwsan.com" <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hi Afzal,

Sorry for the delay, I have been out of the office.

On 08/06/2012 08:38 AM, Mohammed, Afzal wrote:
> Hi Tony, Jon,
> 
> On Wed, Jul 11, 2012 at 12:17:25, Tony Lindgren wrote:
>> * Jon Hunter <jon-hunter@ti.com> [120710 10:20]:
> 
>>> The DT node should simply have the information required by the retime
>>> function or gpmc timings themselves if available. In the case of OneNAND
> 
>>> These can be stored in the DT and then translated to gpmc timings at
>>> runtime. DT should only store static timing or clock information known
> 
>> Yup. And the format of the timing data in DT should be standardized so
>> the only differences for each connected peripheral is the retime function.
> 
> If we are able to achieve a generic retime function applicable to all
> peripherals then we don't need wrapper layer for retime handling or two
> linux devices and drivers (one the existing and the other to handle retime)
> to represent a single physical gpmc peripheral device (for DT conversion).
> Then handling core frequency scaling and DT conversion would be easier.
> We were trying to create such a retime function that would be generic so
> as to handle different types of gpmc peripherals.

Sounds like a much better approach!

> And we have been able to create such a function. Below is an implementation
> that has been made for handling asynchronous timings. It has been tested for
> OneNAND & SMSC on OMAP3EVM (rev G & C) with [1-4]. OneNAND was tested using
> [5] (OMAP3EVM OneNAND works in async mode) & SMSC using [6] (mainline does
> not have a timing calculation for smsc911x)

Are you able to verify that the timing calculated by this function are
identical? May be some more details on exactly how you tested this would
be good.

> It was difficult to squeeze tusb6010 timing calculation into generic timing
> calculation, hence a boolean "tusb" has been used. This is what I could
> achieve based on existing retime for tusb6010 and for lack of tusb6010
> timing specifications.
> 
> ----8<-----------------------------------------------------------------------
> 
> /* Device timings in picoseconds */
> struct gpmc_device_timings {
>         u32     cs_setup;       /* CS setup time */
>         u32     adv_setup;      /* ADV setup time */
>         u32     adv_rd_off;     /* ADV read off time */
>         u32     adv_add_hold;   /* address hold time */
>         u32     oe_setup;       /* OE setup time */
>         u32     adv_access;     /* access time from ADV assertion */
>         u32     rd_access;      /* read access time */
>         u32     oe_access;      /* access time from OE assertion */
>         u32     cs_access;      /* access time from CS asertion */
>         u32     rd_cycle;       /* read cycle time */
>         u32     cs_highz;       /* CS deassertion to high Z */
>         u32     oe_highz;       /* OE deassertion to high Z */
>         u32     adv_wr_off;     /* ADV write off time */
>         u32     we_setup;       /* WE setup time */
>         u32     wr_pulse;       /* write assertion time */
>         u32     wr_data_setup;  /* data setup time from write assertion */
>         u32     wr_high;        /* write deassertion time */
>         u32     we_highz;       /* WE deassertion to high Z */
>         u32     wr_cycle;       /* write cycle time */
> 
>         bool    mux;            /* address & data muxed */
>         bool    tusb;           /* peripheral is tusb6010 */

Do you think that there is any value in making the tusb member a "u32
dev_type" and then set it too GPMC_DEVICE_TUSB then this could be used
for other devices in the future too if needed?

> };
> 
> struct gpmc_timings gpmc_calc_timings(struct gpmc_device_timings *dev_t)
> {
>         struct gpmc_timings gpmc_t;
>         bool mux = dev_t->mux;
>         bool tusb = dev_t->tusb;
>         u32 temp;
> 
>         memset(&gpmc_t, 0, sizeof(gpmc_t));
> 
>         /* cs_on */
>         gpmc_t.cs_on = gpmc_round_ns_to_ticks(dev_t->cs_setup / 1000);
> 
>         /* adv_on */
>         temp = dev_t->adv_setup;
>         if (tusb)
>                 temp = max_t(u32,
>                         (gpmc_t.cs_on + gpmc_ticks_to_ns(1)) * 1000, temp);
>         gpmc_t.adv_on = gpmc_round_ns_to_ticks(temp / 1000);

Would it be possible to create a sub-function called
gpmc_calc_timings_tusb() and put all these "if (tusb)" statements in
there? Or maybe a generic function called gpmc_calc_timings_prepare().

For the above case could have ...

void gpmc_calc_timings_prepare(struct gpmc_device_timings *dev_t)
{
	if (dev_t->tusb) {
		dev_t->adv_on = max_t(u32,
		(gpmc_t.cs_on + gpmc_ticks_to_ns(1)) * 1000,
		dev_t->adv_setup);
		...
	} else {
		dev_t->adv_on = dev_t->adv_setup;
		...
	}
}

And then in the gpmc_calc_timings() you would just have ...

         gpmc_t.adv_on = gpmc_round_ns_to_ticks(dev_t->adv_on / 1000);

>         /* adv_rd_off */
>         temp = dev_t->adv_rd_off;
>         if (tusb)
>                 temp = max_t(u32,
>                         (gpmc_t.adv_on + gpmc_ticks_to_ns(1)) * 1000, temp);
>         gpmc_t.adv_rd_off = gpmc_round_ns_to_ticks(temp / 1000);
> 
>         /* oe_on */
>         if (mux)
>                 temp = gpmc_t.adv_rd_off * 1000 + dev_t->adv_add_hold;
>         else
>                 temp = dev_t->oe_setup;
>         if (tusb)
>                 temp = max_t(u32,
>                         (gpmc_t.adv_rd_off + gpmc_ticks_to_ns(1)) * 1000, temp);
>         gpmc_t.oe_on = gpmc_round_ns_to_ticks(temp / 1000);
> 
>         /* access */
>         temp = max_t(u32, dev_t->rd_access,
>                                 gpmc_t.oe_on * 1000 + dev_t->oe_access);
>         temp = max_t(u32, temp,
>                                 gpmc_t.cs_on * 1000 + dev_t->cs_access);
>         temp = max_t(u32, temp,
>                                 gpmc_t.adv_on * 1000 + dev_t->adv_access);
>         if (tusb) {
>                 temp = max_t(u32, temp,
>                                 (gpmc_t.oe_on + gpmc_ticks_to_ns(1)) * 1000);
>                 temp = max_t(u32, temp, gpmc_t.oe_on * 1000 + 300);
>         }
>         gpmc_t.access = gpmc_round_ns_to_ticks(temp / 1000);
> 
>         gpmc_t.oe_off = gpmc_t.access + gpmc_ticks_to_ns(1);
>         gpmc_t.cs_rd_off = gpmc_t.oe_off;
> 
>         /* rd_cycle */
>         temp = max_t(u32, dev_t->rd_cycle,
>                         gpmc_t.cs_rd_off * 1000 + dev_t->cs_highz);
>         temp = max_t(u32, temp,
>                         gpmc_t.oe_off * 1000 + dev_t->oe_highz);
>         if (tusb) {
>                 temp = max_t(u32, temp,
>                         (gpmc_t.cs_rd_off + gpmc_ticks_to_ns(1)) * 1000);
>                 temp = max_t(u32, temp, gpmc_t.cs_rd_off * 1000 + 7000);
>         }
>         gpmc_t.rd_cycle = gpmc_round_ns_to_ticks(temp / 1000);
> 
>         /* adv_wr_off */
>         temp = dev_t->adv_wr_off;
>         if (tusb)
>                 temp = max_t(u32,
>                         (gpmc_t.adv_on + gpmc_ticks_to_ns(1)) * 1000, temp);
>         gpmc_t.adv_wr_off = gpmc_round_ns_to_ticks(temp / 1000);
> 
>         /* we_on */
>         if (mux)
>                 temp = gpmc_t.adv_wr_off * 1000 + dev_t->adv_add_hold;
>         else
>                 temp = dev_t->we_setup;
>         if (tusb)
>                 temp = max_t(u32,
>                         (gpmc_t.adv_wr_off + gpmc_ticks_to_ns(1)) * 1000, temp);
>         gpmc_t.we_on = gpmc_round_ns_to_ticks(temp / 1000);
> 
>         gpmc_t.wr_data_mux_bus = gpmc_t.we_on;
> 
>         /* we_off */
>         temp = max_t(u32, gpmc_t.we_on * 1000 + dev_t->wr_pulse,
>                         gpmc_t.we_on * 1000 + dev_t->wr_data_setup);
>         if (tusb) {
>                 temp = max_t(u32, temp,
>                                 (gpmc_t.we_on + gpmc_ticks_to_ns(1)) * 1000);
>                 temp = max_t(u32, temp, gpmc_t.we_on * 1000 + 300);
>         }
>         gpmc_t.we_off = gpmc_round_ns_to_ticks(temp / 1000);
> 
>         gpmc_t.cs_wr_off = gpmc_round_ns_to_ticks((gpmc_t.we_off * 1000 +
>                                 dev_t->wr_high) / 1000);
> 
>         /* wr_cycle */
>         temp = max_t(u32, dev_t->wr_cycle,
>                         gpmc_t.cs_wr_off * 1000 + dev_t->cs_highz);
>         temp = max_t(u32, temp,
>                         gpmc_t.we_off * 1000 + dev_t->we_highz);
>         if (tusb) {
>                 temp = max_t(u32, temp,
>                         (gpmc_t.cs_wr_off + gpmc_ticks_to_ns(1)) * 1000);
>                 temp = max_t(u32, temp, gpmc_t.cs_wr_off * 1000 + 7000);
>         }
>         gpmc_t.wr_cycle = gpmc_round_ns_to_ticks(temp / 1000);
> 
>         return gpmc_t;
> }
> 
>>> From a high-level I think that the goal should be ...
>>>
>>> gpmc_probe
>>> 	--> request CS
>>> 	--> calls retime function to calculate gpmc timing (optional)
>>> 	--> configures CS
>>> 	--> registers peripheral device
>>
>> Yes with few additions.. Connected peripheral probe requests CS from
>> gpmc with the optional retime function pointer passed as a parameter.
>> After gpmc code has determined the CS is available, it calls the optional
>> retime function before returning back to the connected peripheral probe.
>>
>> So how about the following with a bit more details:
>>
>> gpmc_probe
>> 	--> just sets up gpmc resources then idles itself
>>
>> connected peripheral probe
>> 	--> calls gpmc_cs_request() with gpmc timings from DT and an
>> 	    optional retime function as a parameter
>> 	--> gpmc_cs_request() allocates the CS
>> 	--> gpmc_cs_request() calls the optional retime function and
>> 	    if not specified, just sets the DT timings and disables
>> 	    L3 DFS
>> 	--> gpmc_cs_request() returns to connected peripheral probe
> 
> Once we are able to use the generic retime function as mentioned above,
> instead of requiring additional driver for each peripheral that has
> retime and its effect on complicating DT conversion,  we can have the
> gpmc driver organization similar to the one that was posted
> earlier[4].
> 
> With DT, we can pass peripheral timings that has been generalized as in 
> gpmc_device_timings structure. In addition to timings, we would need
> to have fields for specifying whether multiplexed or not ("mux" in
> struct gpmc_device_timings), asynchronous or synchronous.
> 
> With the generic retime function, driver could do as follows,
> 
> gpmc_probe
>   -> setup_device
>     -> setup_cs
>       ->setup_cs_config_timing
> 		if (gpmc_timings)
> 			gpmc_cs_set_timings(gpmc_t);
> 		else if (gpmc_device_timings) {
> 			gpmc_t = gpmc_calc_timings();
> 			gpmc_cs_set_timings(cs, &gpmc_t);
> 		}
> 

I will let Tony comment on how he would like the above to work.

> In the above, addition to already posted driver series [4] would
> be the "else if" portions.
> 
> For core DFS, we could register a notifier that would invoke,
> 	gpmc_t = gpmc_calc_timings(); /* defined above */
> 	gpmc_cs_set-timings(cs, &gpmc_t);
> enabling us to have the gpmc timings adjusted.
> 
> 
> Please let me know your comments on the above. Currently I am working
> on achieving generalized timing for synchronous operations too so
> that gpmc timings can be calculated at runtime using a single generic
> retime function for all kinds of operations like mux, sync/async etc.

Great!

Cheers
Jon
