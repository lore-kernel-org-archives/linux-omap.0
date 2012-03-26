From: "Mohammed, Afzal" <afzal@ti.com>
Subject: RE: [RFC][PATCH 1/5] ARM: OMAP2+: gpmc: driver conversion
Date: Mon, 26 Mar 2012 08:04:50 +0000
Message-ID: <C8443D0743D26F4388EA172BF4E2A7A9317BB895@DBDE01.ent.ti.com>
References: <1332484600-21947-1-git-send-email-afzal@ti.com>
 <4F6D0569.6080203@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:47773 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754034Ab2CZIE4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 26 Mar 2012 04:04:56 -0400
In-Reply-To: <4F6D0569.6080203@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hunter, Jon" <jon-hunter@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Hiremath, Vaibhav" <hvaibhav@ti.com>

Hi Jon,

On Sat, Mar 24, 2012 at 04:51:13, Hunter, Jon wrote:
> > +struct gpmc_child {
> > +	char			*name;
> > +	int			id;
> > +	struct resource		*res;
> > +	unsigned		num_res;
> > +	struct resource		gpmc_res[GPMC_CS_NUM];
> 
> Does this imply a gpmc child device can use more than one chip-select? I 
> am trying to understand the link between number of resources and 
> GPMC_CS_NUM.

Yes, relevant portion in commit message as follows,

A peripheral connected to GPMC can have multiple
address spaces using different chip select. Hence
GPMC driver has been provided capability to
distinguish this scenario, i.e. create platform
devices only once for each connected peripheral,
and not for each configured chip select. The
peripheral that made it necessary was tusb6010.


> 
> > +	unsigned		gpmc_num_res;
> > +	void			*pdata;
> > +	unsigned		pdata_size;
> > +};
> 
> Does pdata_size need to be stored? If pdata is always of type 
> gpmc_device_pdata then you could avoid using void * and elsewhere use 
> sizeof.

This is the size of platform data of peripheral connected to GPMC,
like NAND.

> > -	reg_addr = gpmc_base + GPMC_CS0_OFFSET + (cs * GPMC_CS_SIZE) + idx;
> > -	__raw_writel(val, reg_addr);
> > +	reg_addr = gpmc->io_base + GPMC_CS0_OFFSET + (cs * GPMC_CS_SIZE) + idx;
> > +	writel(val, reg_addr);
> >   }
> 
> I understand this was inherited from the original code, but I think that 
> we should drop the "GPMC_CS0_OFFSET". We are already passing an index 
> and so we should use this as an offset. This obviously implies changing 
> the defintion of the GPMC_CS_xxxx registers in gpmc.h. This would save 
> one addition too.

Ok

> > +/* This is a duplication of an existing function; before GPMC probe
> > +   invocation, platform code may need to find divider value, hence
> > +   other function (gpmc_cs_calc_divider) is not removed, functions
> > +   like it that are required by platform, probably can be put in
> > +   common omap platform file. gpmc_calc_divider will get invoked
> > +   only after GPMC driver gets probed. gpmc_cs_calc_divider is not
> > +   invoked by GPMC driver to cleanly separate platform&  driver
> > +   code, although both should return sme value.
> >    */
> > -int gpmc_nand_read(int cs, int cmd)
> > +static int gpmc_calc_divider(u32 sync_clk)
> >   {
> > -	int rval = -EINVAL;
> > -
> > -	switch (cmd) {
> > -	case GPMC_NAND_DATA:
> > -		rval = gpmc_cs_read_byte(cs, GPMC_CS_NAND_DATA);
> > -		break;
> > +	int div;
> > +	u32 l;
> >
> > -	default:
> > -		printk(KERN_ERR "gpmc_read_nand_ctrl: Not supported\n");
> > -	}
> > -	return rval;
> > +	l = sync_clk + (gpmc->fclk_rate - 1);
> 
> This was a little confusing to me at first. When I see fclk_rate I think 
> frequency (eg. clk_get_rate()) and not period. The original code had a 
> function called gpmc_get_fclk_period. I would consider renaming the 
> variable to fclk_period to be clear.

Agree

> > +#define GPMC_SET_ONE(reg, st, end, field) \
> 
> Nit-pick, set-one is a bit generic, maybe GPMC_SET_TIME?

Agree

> > +	if (cpu_is_omap34xx()) {
> > +		GPMC_SET_ONE(GPMC_CS_CONFIG6, 16, 19, wr_data_mux_bus);
> > +		GPMC_SET_ONE(GPMC_CS_CONFIG6, 24, 28, wr_access);
> > +	}
> 
> OMAP4/5 also has the above fields and so maybe this should be 
> (!cpu_is_omap24xx()).

Will try to remove the usage of cpu_is_xxx itself

> 
> > +
> > +	/* caller is expected to have initialized CONFIG1 to cover
> > +	 * at least sync vs async
> > +	 */
> > +	l = gpmc_cs_read_reg(cs, GPMC_CS_CONFIG1);
> > +	if (l&  (GPMC_CONFIG1_READTYPE_SYNC | GPMC_CONFIG1_WRITETYPE_SYNC)) {
> 
> Is it valid to have READTYPE != WRITETYPE? I am wondering if there 
> should be a check here to see if READTYPE and WRITETYPE are not equal?

Seems possible, but not sure, will look into this
 
> > +		printk(KERN_DEBUG "GPMC CS%d CLK period is %lu ns (div %d)\n",
> > +				cs, (div * gpmc_get_fclk_period()) / 1000, div);
> > +		l&= ~0x03;
> 
> I think we should define GPMC_CONFIG1_FCLK_DIV_MASK for this.

Ok

> +	*base = (l&  0x3f)<<  GPMC_CHUNK_SHIFT;
> 
> Define GPMC_CONFIG7_BASEADDRESS_MASK

Ok

> > +	mask = (l>>  8)&  0x0f;
> 
> Define GPMC_CONFIG7_MASKADDRESS_MASK/SHIFT

Ok

> > +static __devinit int gpmc_setup_child(struct gpmc_device_pdata *gdev)
> 
> Nit-pick, gdev was a bit confusing to me, maybe just pdata instead?

Ok

> > +		gpmc->child_device[i].gpmc_res[j] = res;
> 
> So struct "res" is a local variable and you are storing in a global 
> structure? Did you intend to store the address of the pdata struct passed?


No, copy res structure

> > +	gpmc->ecc_used = -EINVAL;
> 
> Why not 0?

That may modify default behavior of OMAP NAND driver w.r.t ECC,
will check this.
 
> > +	spin_lock_init(&gpmc->mem_lock);
> > +	platform_set_drvdata(pdev, gpmc);
> >
> >   	l = gpmc_read_reg(GPMC_REVISION);
> > -	printk(KERN_INFO "GPMC revision %d.%d\n", (l>>  4)&  0x0f, l&  0x0f);
> > -	/* Set smart idle mode and automatic L3 clock gating */
> > -	l = gpmc_read_reg(GPMC_SYSCONFIG);
> > -	l&= 0x03<<  3;
> > -	l |= (0x02<<  3) | (1<<  0);
> > -	gpmc_write_reg(GPMC_SYSCONFIG, l);
> 
> Really need to clean up the above with some #defines. Ideally we would 
> be using hwmod/pm_runtime for configuring the SYSCONFIG.

Ok

> Do we need to free irqs here?

Irqs has been conveniently forgotten in this patch, in mainline, I could
not find any platforms using GPMC irq. This can be added later once
driver conversion is done, if required.

> > +		gpmc_write_reg(GPMC_PREFETCH_CONFIG1, ((cs<<  CS_NUM_SHIFT) |
> > +					PREFETCH_FIFOTHRESHOLD(fifo_th) |
> > +					ENABLE_PREFETCH |
> > +					(dma_mode<<  DMA_MPU_MODE) |
> > +					(0x1&  is_write)));
> 
> #define GPMC_PREFETCH_CONFIG1_ACCESSMODE

Ok

> > +	/* check if the same module/cs is trying to reset */
> > +	config1 = gpmc_read_reg(GPMC_PREFETCH_CONFIG1);
> > +	if (((config1>>  CS_NUM_SHIFT)&  0x7) != cs)
> 
> Maybe define a mask value for the ENGINECSSELECTOR

Ok

> > +	/* GPMC specific */
> > +	unsigned		cs;
> > +	unsigned long		mem_size;
> > +	unsigned long		mem_start;
> > +	unsigned long		mem_offset;
> > +	struct gpmc_config	*config;
> > +	unsigned		num_config;
> > +	struct gpmc_timings	*timing;
> > +};
> > +
> > +struct gpmc_pdata {
> > +	/* GPMC_FCLK rate in picoseconds */
> > +	unsigned long			fclk_rate;
> 
> fclk_period
> 
> > +	struct gpmc_device_pdata	*device_pdata;
> > +	unsigned			num_device;
> > +};
> 
> Do you need both gpmc_pdata and gpmc_device_pdata? Would not a single 
> structure work?

Gpmc_device_data is dedicated to each CS, gpmc_pdata is required
at least to inform driver about clock rate.

Generally, as the change involved moving a lot of code, seems more reviews
are on those than the actual changes than what I intended to get reviewed,
next patch series will be modified not to move existing code, hence some
of your suggested changes may not be present in it, probably those to be
done as another cleanup patch.

Regards
Afzal
