From: Mike Rapoport <mike@compulab.co.il>
Subject: Re: [PATCH 2/2] omap: gpmc-nand: add ability to keep timings defined
 	by the bootloader
Date: Thu, 29 Apr 2010 09:53:06 +0300
Message-ID: <4BD92CD2.7010907@compulab.co.il>
References: <cover.1272470212.git.mike@compulab.co.il> <d97635d8d65238f8801db6bcf4e89e2fb1b44b17.1272470212.git.mike@compulab.co.il> <z2hce9ab5791004282127u817d6604oa65b8bf3b9957bda@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from compulab.co.il ([67.18.134.219]:38483 "EHLO compulab.co.il"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755702Ab0D3VDK (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 30 Apr 2010 17:03:10 -0400
In-Reply-To: <z2hce9ab5791004282127u817d6604oa65b8bf3b9957bda@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vimal Singh <vimal.newwork@gmail.com>
Cc: tony@atomide.com, s-ghorai@ti.com, linux-omap@vger.kernel.org, Mike Rapoport <mike@compulab.co.il>

Vimal Singh wrote:
> On Wed, Apr 28, 2010 at 9:36 PM, Mike Rapoport <mike@compulab.co.il> wrote:
>> Signed-off-by: Mike Rapoport <mike@compulab.co.il>
>> ---
>>  arch/arm/mach-omap2/gpmc-nand.c        |   19 ++++++++++++++++++-
>>  arch/arm/plat-omap/include/plat/nand.h |    1 +
>>  2 files changed, 19 insertions(+), 1 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/gpmc-nand.c b/arch/arm/mach-omap2/gpmc-nand.c
>> index e57fb29..7c6c027 100644
>> --- a/arch/arm/mach-omap2/gpmc-nand.c
>> +++ b/arch/arm/mach-omap2/gpmc-nand.c
>> @@ -22,6 +22,7 @@
>>  #define WR_RD_PIN_MONITORING   0x00600000
>>
>>  static struct omap_nand_platform_data *gpmc_nand_data;
>> +static struct gpmc_timings gpmc_default_timings;
>>
>>  static struct resource gpmc_nand_resource = {
>>        .flags          = IORESOURCE_MEM,
>> @@ -34,13 +35,24 @@ static struct platform_device gpmc_nand_device = {
>>        .resource       = &gpmc_nand_resource,
>>  };
>>
>> +static void gpmc_nand_detect_timings(void)
>> +{
>> +       struct gpmc_timings t;
>> +
>> +       memset(&t, 0, sizeof(t));
>> +       gpmc_cs_get_timings(gpmc_nand_data->cs, &gpmc_default_timings);
>> +}
>> +
>>  static int omap2_nand_gpmc_retime(void)
>>  {
>> +       struct device *dev = &gpmc_nand_device.dev;
>>        struct gpmc_timings t;
>>        int err;
>>
>> -       if (!gpmc_nand_data->gpmc_t)
>> +       if (!gpmc_nand_data->gpmc_t) {
>> +               dev_warn(dev, "No timings provided, skipping retime\n");
>>                return 0;
>> +       }
>>
>>        memset(&t, 0, sizeof(t));
>>        t.sync_clk = gpmc_round_ns_to_ticks(gpmc_nand_data->gpmc_t->sync_clk);
>> @@ -112,6 +124,11 @@ int __init gpmc_nand_init(struct omap_nand_platform_data *_nand_data)
>>                return err;
>>        }
>>
>> +       if (gpmc_nand_data->keep_timings) {
>> +               gpmc_nand_detect_timings();
>> +               gpmc_nand_data->gpmc_t = &gpmc_default_timings;
>> +       }
>> +
> 
> I guess moving this part to omap2_nand_gpmc_retime will be a good idea.
> As there, once we get old/default timings we can simply skip the
> rounding part and directly jump to setting the timings.

This way it would be the same as to pass 'gpmc_nand_data->gpmc_t =
NULL'. If I correctly understood the previous comments ([1]), the
problem with skipping retime is that when L3 clock changes, the gpmc
timings became wrong. So, if we convert old/default timings to
nanoseconds early during startup every time retime is called it will use
the timing settings in nanoseconds thus yielding proper gpmc registers
configuration.
And, if I'm not terribly mistaken retime should be called each time L3
frequency changes, though with current kernel it's not yet the case...

--
[1] http://thread.gmane.org/gmane.linux.ports.arm.omap/34164/focus=34558

> Rest looks fine to me.
> 


-- 
Sincerely yours,
Mike.

