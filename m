From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [RFC][PATCH 1/5] ARM: OMAP2+: gpmc: driver conversion
Date: Fri, 23 Mar 2012 18:21:13 -0500
Message-ID: <4F6D0569.6080203@ti.com>
References: <1332484600-21947-1-git-send-email-afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:52991 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751766Ab2CWXVX (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 23 Mar 2012 19:21:23 -0400
In-Reply-To: <1332484600-21947-1-git-send-email-afzal@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Afzal Mohammed <afzal@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Vaibhav Hiremath <hvaibhav@ti.com>

Hi Afzal,

On 03/23/2012 01:36 AM, Afzal Mohammed wrote:

[snip]

> +struct gpmc_child {
> +	char			*name;
> +	int			id;
> +	struct resource		*res;
> +	unsigned		num_res;
> +	struct resource		gpmc_res[GPMC_CS_NUM];

Does this imply a gpmc child device can use more than one chip-select? I 
am trying to understand the link between number of resources and 
GPMC_CS_NUM.

> +	unsigned		gpmc_num_res;
> +	void			*pdata;
> +	unsigned		pdata_size;
> +};

Does pdata_size need to be stored? If pdata is always of type 
gpmc_device_pdata then you could avoid using void * and elsewhere use 
sizeof.

> -static u8 gpmc_cs_read_byte(int cs, int idx)
> -{
> -	void __iomem *reg_addr;
> +struct gpmc {
> +	struct device		*dev;
> +	unsigned long		fclk_rate;
> +	void __iomem		*io_base;
> +	unsigned long		phys_base;
> +	u32			memsize;
> +	unsigned		cs_map;
> +	int			ecc_used;
> +	spinlock_t		mem_lock;
> +	struct resource		mem_root;
> +	struct resource		cs_mem[GPMC_CS_NUM];
> +	struct gpmc_child	child_device[GPMC_CS_NUM];
> +	unsigned		num_child;
> +	unsigned		num_device;
> +};
>
> -	reg_addr = gpmc_base + GPMC_CS0_OFFSET + (cs * GPMC_CS_SIZE) + idx;
> -	return __raw_readb(reg_addr);
> -}
> +static struct gpmc *gpmc;
>
> +/* Make function static */
>   void gpmc_cs_write_reg(int cs, int idx, u32 val)
>   {
>   	void __iomem *reg_addr;
>
> -	reg_addr = gpmc_base + GPMC_CS0_OFFSET + (cs * GPMC_CS_SIZE) + idx;
> -	__raw_writel(val, reg_addr);
> +	reg_addr = gpmc->io_base + GPMC_CS0_OFFSET + (cs * GPMC_CS_SIZE) + idx;
> +	writel(val, reg_addr);
>   }

I understand this was inherited from the original code, but I think that 
we should drop the "GPMC_CS0_OFFSET". We are already passing an index 
and so we should use this as an offset. This obviously implies changing 
the defintion of the GPMC_CS_xxxx registers in gpmc.h. This would save 
one addition too.

> +/* Make function static */
>   u32 gpmc_cs_read_reg(int cs, int idx)
>   {
>   	void __iomem *reg_addr;
>
> -	reg_addr = gpmc_base + GPMC_CS0_OFFSET + (cs * GPMC_CS_SIZE) + idx;
> -	return __raw_readl(reg_addr);
> +	reg_addr = gpmc->io_base + GPMC_CS0_OFFSET + (cs * GPMC_CS_SIZE) + idx;
> +	return readl(reg_addr);
>   }

Same as above.

> -/* TODO: Add support for gpmc_fck to clock framework and use it */
> -unsigned long gpmc_get_fclk_period(void)
> +static void gpmc_write_reg(int idx, u32 val)
>   {
> -	unsigned long rate = clk_get_rate(gpmc_l3_clk);
> -
> -	if (rate == 0) {
> -		printk(KERN_WARNING "gpmc_l3_clk not enabled\n");
> -		return 0;
> -	}
> -
> -	rate /= 1000;
> -	rate = 1000000000 / rate;	/* In picoseconds */
> -
> -	return rate;
> +	writel(val, gpmc->io_base + idx);
>   }
>
> -unsigned int gpmc_ns_to_ticks(unsigned int time_ns)
> +static u32 gpmc_read_reg(int idx)
>   {
> -	unsigned long tick_ps;
> -
> -	/* Calculate in picosecs to yield more exact results */
> -	tick_ps = gpmc_get_fclk_period();
> -
> -	return (time_ns * 1000 + tick_ps - 1) / tick_ps;
> +	return readl(gpmc->io_base + idx);
>   }
>
> -unsigned int gpmc_ps_to_ticks(unsigned int time_ps)
> +static void gpmc_cs_write_byte(int cs, int idx, u8 val)
>   {
> -	unsigned long tick_ps;
> -
> -	/* Calculate in picosecs to yield more exact results */
> -	tick_ps = gpmc_get_fclk_period();
> -
> -	return (time_ps + tick_ps - 1) / tick_ps;
> -}
> +	void __iomem *reg_addr;
>
> -unsigned int gpmc_ticks_to_ns(unsigned int ticks)
> -{
> -	return ticks * gpmc_get_fclk_period() / 1000;
> +	reg_addr = gpmc->io_base + GPMC_CS0_OFFSET + (cs * GPMC_CS_SIZE) + idx;
> +	writeb(val, reg_addr);
>   }

Again here, can we get rid of GPMC_CS0_OFFSET?

> -unsigned int gpmc_round_ns_to_ticks(unsigned int time_ns)
> +static u8 gpmc_cs_read_byte(int cs, int idx)
>   {
> -	unsigned long ticks = gpmc_ns_to_ticks(time_ns);
> +	void __iomem *reg_addr;
>
> -	return ticks * gpmc_get_fclk_period() / 1000;
> +	reg_addr = gpmc->io_base + GPMC_CS0_OFFSET + (cs * GPMC_CS_SIZE) + idx;
> +	return readb(reg_addr);
>   }

And here, can we get rid of GPMC_CS0_OFFSET?

> -#ifdef DEBUG
> -static int set_gpmc_timing_reg(int cs, int reg, int st_bit, int end_bit,
> -			       int time, const char *name)
> -#else
> -static int set_gpmc_timing_reg(int cs, int reg, int st_bit, int end_bit,
> -			       int time)
> -#endif
> +static int gpmc_cs_set_reserved(int cs, int reserved)
>   {
> -	u32 l;
> -	int ticks, mask, nr_bits;
> -
> -	if (time == 0)
> -		ticks = 0;
> -	else
> -		ticks = gpmc_ns_to_ticks(time);
> -	nr_bits = end_bit - st_bit + 1;
> -	if (ticks>= 1<<  nr_bits) {
> -#ifdef DEBUG
> -		printk(KERN_INFO "GPMC CS%d: %-10s* %3d ns, %3d ticks>= %d\n",
> -				cs, name, time, ticks, 1<<  nr_bits);
> -#endif
> -		return -1;
> -	}
> +	if (cs>  GPMC_CS_NUM)
> +		return -ENODEV;
>
> -	mask = (1<<  nr_bits) - 1;
> -	l = gpmc_cs_read_reg(cs, reg);
> -#ifdef DEBUG
> -	printk(KERN_INFO
> -		"GPMC CS%d: %-10s: %3d ticks, %3lu ns (was %3i ticks) %3d ns\n",
> -	       cs, name, ticks, gpmc_get_fclk_period() * ticks / 1000,
> -			(l>>  st_bit)&  mask, time);
> -#endif
> -	l&= ~(mask<<  st_bit);
> -	l |= ticks<<  st_bit;
> -	gpmc_cs_write_reg(cs, reg, l);
> +	gpmc->cs_map&= ~(1<<  cs);
> +	gpmc->cs_map |= (reserved ? 1 : 0)<<  cs;
>
>   	return 0;
>   }
>
> -#ifdef DEBUG
> -#define GPMC_SET_ONE(reg, st, end, field) \
> -	if (set_gpmc_timing_reg(cs, (reg), (st), (end),		\
> -			t->field, #field)<  0)			\
> -		return -1
> -#else
> -#define GPMC_SET_ONE(reg, st, end, field) \
> -	if (set_gpmc_timing_reg(cs, (reg), (st), (end), t->field)<  0) \
> -		return -1
> -#endif
> -
> -int gpmc_cs_calc_divider(int cs, unsigned int sync_clk)
> -{
> -	int div;
> -	u32 l;
> -
> -	l = sync_clk + (gpmc_get_fclk_period() - 1);
> -	div = l / gpmc_get_fclk_period();
> -	if (div>  4)
> -		return -1;
> -	if (div<= 0)
> -		div = 1;
> -
> -	return div;
> -}
> -
> -int gpmc_cs_set_timings(int cs, const struct gpmc_timings *t)
> +static int gpmc_cs_reserved(int cs)
>   {
> -	int div;
> -	u32 l;
> -
> -	div = gpmc_cs_calc_divider(cs, t->sync_clk);
> -	if (div<  0)
> -		return -1;
> -
> -	GPMC_SET_ONE(GPMC_CS_CONFIG2,  0,  3, cs_on);
> -	GPMC_SET_ONE(GPMC_CS_CONFIG2,  8, 12, cs_rd_off);
> -	GPMC_SET_ONE(GPMC_CS_CONFIG2, 16, 20, cs_wr_off);
> -
> -	GPMC_SET_ONE(GPMC_CS_CONFIG3,  0,  3, adv_on);
> -	GPMC_SET_ONE(GPMC_CS_CONFIG3,  8, 12, adv_rd_off);
> -	GPMC_SET_ONE(GPMC_CS_CONFIG3, 16, 20, adv_wr_off);
> -
> -	GPMC_SET_ONE(GPMC_CS_CONFIG4,  0,  3, oe_on);
> -	GPMC_SET_ONE(GPMC_CS_CONFIG4,  8, 12, oe_off);
> -	GPMC_SET_ONE(GPMC_CS_CONFIG4, 16, 19, we_on);
> -	GPMC_SET_ONE(GPMC_CS_CONFIG4, 24, 28, we_off);
> -
> -	GPMC_SET_ONE(GPMC_CS_CONFIG5,  0,  4, rd_cycle);
> -	GPMC_SET_ONE(GPMC_CS_CONFIG5,  8, 12, wr_cycle);
> -	GPMC_SET_ONE(GPMC_CS_CONFIG5, 16, 20, access);
> -
> -	GPMC_SET_ONE(GPMC_CS_CONFIG5, 24, 27, page_burst_access);
> -
> -	if (cpu_is_omap34xx()) {
> -		GPMC_SET_ONE(GPMC_CS_CONFIG6, 16, 19, wr_data_mux_bus);
> -		GPMC_SET_ONE(GPMC_CS_CONFIG6, 24, 28, wr_access);
> -	}
> -
> -	/* caller is expected to have initialized CONFIG1 to cover
> -	 * at least sync vs async
> -	 */
> -	l = gpmc_cs_read_reg(cs, GPMC_CS_CONFIG1);
> -	if (l&  (GPMC_CONFIG1_READTYPE_SYNC | GPMC_CONFIG1_WRITETYPE_SYNC)) {
> -#ifdef DEBUG
> -		printk(KERN_INFO "GPMC CS%d CLK period is %lu ns (div %d)\n",
> -				cs, (div * gpmc_get_fclk_period()) / 1000, div);
> -#endif
> -		l&= ~0x03;
> -		l |= (div - 1);
> -		gpmc_cs_write_reg(cs, GPMC_CS_CONFIG1, l);
> -	}
> +	if (cs>  GPMC_CS_NUM)
> +		return -ENODEV;
>
> -	return 0;
> +	return gpmc->cs_map&  (1<<  cs);
>   }
>
>   static void gpmc_cs_enable_mem(int cs, u32 base, u32 size)
> @@ -332,17 +186,6 @@ static void gpmc_cs_disable_mem(int cs)
>   	gpmc_cs_write_reg(cs, GPMC_CS_CONFIG7, l);
>   }
>
> -static void gpmc_cs_get_memconf(int cs, u32 *base, u32 *size)
> -{
> -	u32 l;
> -	u32 mask;
> -
> -	l = gpmc_cs_read_reg(cs, GPMC_CS_CONFIG7);
> -	*base = (l&  0x3f)<<  GPMC_CHUNK_SHIFT;
> -	mask = (l>>  8)&  0x0f;
> -	*size = (1<<  GPMC_SECTION_SHIFT) - (mask<<  GPMC_CHUNK_SHIFT);
> -}
> -
>   static int gpmc_cs_mem_enabled(int cs)
>   {
>   	u32 l;
> @@ -351,25 +194,6 @@ static int gpmc_cs_mem_enabled(int cs)
>   	return l&  GPMC_CONFIG7_CSVALID;
>   }
>
> -int gpmc_cs_set_reserved(int cs, int reserved)
> -{
> -	if (cs>  GPMC_CS_NUM)
> -		return -ENODEV;
> -
> -	gpmc_cs_map&= ~(1<<  cs);
> -	gpmc_cs_map |= (reserved ? 1 : 0)<<  cs;
> -
> -	return 0;
> -}
> -
> -int gpmc_cs_reserved(int cs)
> -{
> -	if (cs>  GPMC_CS_NUM)
> -		return -ENODEV;
> -
> -	return gpmc_cs_map&  (1<<  cs);
> -}
> -
>   static unsigned long gpmc_mem_align(unsigned long size)
>   {
>   	int order;
> @@ -384,24 +208,9 @@ static unsigned long gpmc_mem_align(unsigned long size)
>   	return size;
>   }
>
> -static int gpmc_cs_insert_mem(int cs, unsigned long base, unsigned long size)
> -{
> -	struct resource	*res =&gpmc_cs_mem[cs];
> -	int r;
> -
> -	size = gpmc_mem_align(size);
> -	spin_lock(&gpmc_mem_lock);
> -	res->start = base;
> -	res->end = base + size - 1;
> -	r = request_resource(&gpmc_mem_root, res);
> -	spin_unlock(&gpmc_mem_lock);
> -
> -	return r;
> -}
> -
>   int gpmc_cs_request(int cs, unsigned long size, unsigned long *base)
>   {
> -	struct resource *res =&gpmc_cs_mem[cs];
> +	struct resource *res =&gpmc->cs_mem[cs];
>   	int r = -1;
>
>   	if (cs>  GPMC_CS_NUM)
> @@ -411,7 +220,7 @@ int gpmc_cs_request(int cs, unsigned long size, unsigned long *base)
>   	if (size>  (1<<  GPMC_SECTION_SHIFT))
>   		return -ENOMEM;
>
> -	spin_lock(&gpmc_mem_lock);
> +	spin_lock(&gpmc->mem_lock);
>   	if (gpmc_cs_reserved(cs)) {
>   		r = -EBUSY;
>   		goto out;
> @@ -419,7 +228,7 @@ int gpmc_cs_request(int cs, unsigned long size, unsigned long *base)
>   	if (gpmc_cs_mem_enabled(cs))
>   		r = adjust_resource(res, res->start&  ~(size - 1), size);
>   	if (r<  0)
> -		r = allocate_resource(&gpmc_mem_root, res, size, 0, ~0,
> +		r = allocate_resource(&gpmc->mem_root, res, size, 0, ~0,
>   				      size, NULL, NULL);
>   	if (r<  0)
>   		goto out;
> @@ -428,66 +237,28 @@ int gpmc_cs_request(int cs, unsigned long size, unsigned long *base)
>   	*base = res->start;
>   	gpmc_cs_set_reserved(cs, 1);
>   out:
> -	spin_unlock(&gpmc_mem_lock);
> +	spin_unlock(&gpmc->mem_lock);
>   	return r;
>   }
>   EXPORT_SYMBOL(gpmc_cs_request);
>
>   void gpmc_cs_free(int cs)
>   {
> -	spin_lock(&gpmc_mem_lock);
> +	spin_lock(&gpmc->mem_lock);
>   	if (cs>= GPMC_CS_NUM || cs<  0 || !gpmc_cs_reserved(cs)) {
>   		printk(KERN_ERR "Trying to free non-reserved GPMC CS%d\n", cs);
>   		BUG();
> -		spin_unlock(&gpmc_mem_lock);
> +		spin_unlock(&gpmc->mem_lock);
>   		return;
>   	}
>   	gpmc_cs_disable_mem(cs);
> -	release_resource(&gpmc_cs_mem[cs]);
> +	release_resource(&gpmc->cs_mem[cs]);
>   	gpmc_cs_set_reserved(cs, 0);
> -	spin_unlock(&gpmc_mem_lock);
> +	spin_unlock(&gpmc->mem_lock);
>   }
>   EXPORT_SYMBOL(gpmc_cs_free);
>
>   /**
> - * gpmc_read_status - read access request to get the different gpmc status
> - * @cmd: command type
> - * @return status
> - */
> -int gpmc_read_status(int cmd)
> -{
> -	int	status = -EINVAL;
> -	u32	regval = 0;
> -
> -	switch (cmd) {
> -	case GPMC_GET_IRQ_STATUS:
> -		status = gpmc_read_reg(GPMC_IRQSTATUS);
> -		break;
> -
> -	case GPMC_PREFETCH_FIFO_CNT:
> -		regval = gpmc_read_reg(GPMC_PREFETCH_STATUS);
> -		status = GPMC_PREFETCH_STATUS_FIFO_CNT(regval);
> -		break;
> -
> -	case GPMC_PREFETCH_COUNT:
> -		regval = gpmc_read_reg(GPMC_PREFETCH_STATUS);
> -		status = GPMC_PREFETCH_STATUS_COUNT(regval);
> -		break;
> -
> -	case GPMC_STATUS_BUFFER:
> -		regval = gpmc_read_reg(GPMC_STATUS);
> -		/* 1 : buffer is available to write */
> -		status = regval&  GPMC_STATUS_BUFF_EMPTY;
> -		break;
> -
> -	default:
> -		printk(KERN_ERR "gpmc_read_status: Not supported\n");
> -	}
> -	return status;
> -}
> -EXPORT_SYMBOL(gpmc_read_status);
> -
> -/**
>    * gpmc_cs_configure - write request to configure gpmc
>    * @cs: chip select number
>    * @cmd: command type
> @@ -555,120 +326,143 @@ int gpmc_cs_configure(int cs, int cmd, int wval)
>   }
>   EXPORT_SYMBOL(gpmc_cs_configure);
>
> -/**
> - * gpmc_nand_read - nand specific read access request
> - * @cs: chip select number
> - * @cmd: command type
> +/* This is a duplication of an existing function; before GPMC probe
> +   invocation, platform code may need to find divider value, hence
> +   other function (gpmc_cs_calc_divider) is not removed, functions
> +   like it that are required by platform, probably can be put in
> +   common omap platform file. gpmc_calc_divider will get invoked
> +   only after GPMC driver gets probed. gpmc_cs_calc_divider is not
> +   invoked by GPMC driver to cleanly separate platform&  driver
> +   code, although both should return sme value.
>    */
> -int gpmc_nand_read(int cs, int cmd)
> +static int gpmc_calc_divider(u32 sync_clk)
>   {
> -	int rval = -EINVAL;
> -
> -	switch (cmd) {
> -	case GPMC_NAND_DATA:
> -		rval = gpmc_cs_read_byte(cs, GPMC_CS_NAND_DATA);
> -		break;
> +	int div;
> +	u32 l;
>
> -	default:
> -		printk(KERN_ERR "gpmc_read_nand_ctrl: Not supported\n");
> -	}
> -	return rval;
> +	l = sync_clk + (gpmc->fclk_rate - 1);

This was a little confusing to me at first. When I see fclk_rate I think 
frequency (eg. clk_get_rate()) and not period. The original code had a 
function called gpmc_get_fclk_period. I would consider renaming the 
variable to fclk_period to be clear.

> +	div = l / gpmc->fclk_rate;
> +	if (div>  4)
> +		return -1;
> +	if (div<= 0)
> +		div = 1;
> +
> +	return div;
>   }
> -EXPORT_SYMBOL(gpmc_nand_read);
>
> -/**
> - * gpmc_nand_write - nand specific write request
> - * @cs: chip select number
> - * @cmd: command type
> - * @wval: value to write
> - */
> -int gpmc_nand_write(int cs, int cmd, int wval)
> +static int set_gpmc_timing_reg(int cs, int reg, int st_bit, int end_bit,
> +			       int time, const char *name)
>   {
> -	int err = 0;
> -
> -	switch (cmd) {
> -	case GPMC_NAND_COMMAND:
> -		gpmc_cs_write_byte(cs, GPMC_CS_NAND_COMMAND, wval);
> -		break;
> +	u32 l;
> +	int ticks, mask, nr_bits;
>
> -	case GPMC_NAND_ADDRESS:
> -		gpmc_cs_write_byte(cs, GPMC_CS_NAND_ADDRESS, wval);
> -		break;
> +	if (time == 0)
> +		ticks = 0;
> +	else
> +		ticks = gpmc_ns_to_ticks(time);
> +	nr_bits = end_bit - st_bit + 1;
> +	if (ticks>= 1<<  nr_bits) {
> +		printk(KERN_DEBUG "GPMC CS%d: %-10s* %3d ns, %3d ticks>= %d\n",
> +				cs, name, time, ticks, 1<<  nr_bits);
> +		return -1;
> +	}
>
> -	case GPMC_NAND_DATA:
> -		gpmc_cs_write_byte(cs, GPMC_CS_NAND_DATA, wval);
> +	mask = (1<<  nr_bits) - 1;
> +	l = gpmc_cs_read_reg(cs, reg);
> +	printk(KERN_DEBUG
> +		"GPMC CS%d: %-10s: %3d ticks, %3lu ns (was %3i ticks) %3d ns\n",
> +	       cs, name, ticks, gpmc_get_fclk_period() * ticks / 1000,
> +			(l>>  st_bit)&  mask, time);
> +	l&= ~(mask<<  st_bit);
> +	l |= ticks<<  st_bit;
> +	gpmc_cs_write_reg(cs, reg, l);
>
> -	default:
> -		printk(KERN_ERR "gpmc_write_nand_ctrl: Not supported\n");
> -		err = -EINVAL;
> -	}
> -	return err;
> +	return 0;
>   }
> -EXPORT_SYMBOL(gpmc_nand_write);
> -
>
> +#define GPMC_SET_ONE(reg, st, end, field) \

Nit-pick, set-one is a bit generic, maybe GPMC_SET_TIME?

> +	do {							\
> +		if (set_gpmc_timing_reg(cs, (reg), (st), (end),	\
> +				t->field, #field)<  0)		\
> +			return -1;				\
> +	} while (0)
>
> -/**
> - * gpmc_prefetch_enable - configures and starts prefetch transfer
> - * @cs: cs (chip select) number
> - * @fifo_th: fifo threshold to be used for read/ write
> - * @dma_mode: dma mode enable (1) or disable (0)
> - * @u32_count: number of bytes to be transferred
> - * @is_write: prefetch read(0) or write post(1) mode
> - */
> -int gpmc_prefetch_enable(int cs, int fifo_th, int dma_mode,
> -				unsigned int u32_count, int is_write)
> +int gpmc_cs_set_timings(int cs, const struct gpmc_timings *t)
>   {
> +	int div;
> +	u32 l;
>
> -	if (fifo_th>  PREFETCH_FIFOTHRESHOLD_MAX) {
> -		pr_err("gpmc: fifo threshold is not supported\n");
> +	div = gpmc_calc_divider(t->sync_clk);
> +	if (div<  0)
>   		return -1;
> -	} else if (!(gpmc_read_reg(GPMC_PREFETCH_CONTROL))) {
> -		/* Set the amount of bytes to be prefetched */
> -		gpmc_write_reg(GPMC_PREFETCH_CONFIG2, u32_count);
>
> -		/* Set dma/mpu mode, the prefetch read / post write and
> -		 * enable the engine. Set which cs is has requested for.
> -		 */
> -		gpmc_write_reg(GPMC_PREFETCH_CONFIG1, ((cs<<  CS_NUM_SHIFT) |
> -					PREFETCH_FIFOTHRESHOLD(fifo_th) |
> -					ENABLE_PREFETCH |
> -					(dma_mode<<  DMA_MPU_MODE) |
> -					(0x1&  is_write)));
> +	GPMC_SET_ONE(GPMC_CS_CONFIG2,  0,  3, cs_on);
> +	GPMC_SET_ONE(GPMC_CS_CONFIG2,  8, 12, cs_rd_off);
> +	GPMC_SET_ONE(GPMC_CS_CONFIG2, 16, 20, cs_wr_off);
>
> -		/*  Start the prefetch engine */
> -		gpmc_write_reg(GPMC_PREFETCH_CONTROL, 0x1);
> -	} else {
> -		return -EBUSY;
> +	GPMC_SET_ONE(GPMC_CS_CONFIG3,  0,  3, adv_on);
> +	GPMC_SET_ONE(GPMC_CS_CONFIG3,  8, 12, adv_rd_off);
> +	GPMC_SET_ONE(GPMC_CS_CONFIG3, 16, 20, adv_wr_off);
> +
> +	GPMC_SET_ONE(GPMC_CS_CONFIG4,  0,  3, oe_on);
> +	GPMC_SET_ONE(GPMC_CS_CONFIG4,  8, 12, oe_off);
> +	GPMC_SET_ONE(GPMC_CS_CONFIG4, 16, 19, we_on);
> +	GPMC_SET_ONE(GPMC_CS_CONFIG4, 24, 28, we_off);
> +
> +	GPMC_SET_ONE(GPMC_CS_CONFIG5,  0,  4, rd_cycle);
> +	GPMC_SET_ONE(GPMC_CS_CONFIG5,  8, 12, wr_cycle);
> +	GPMC_SET_ONE(GPMC_CS_CONFIG5, 16, 20, access);
> +
> +	GPMC_SET_ONE(GPMC_CS_CONFIG5, 24, 27, page_burst_access);
> +
> +	if (cpu_is_omap34xx()) {
> +		GPMC_SET_ONE(GPMC_CS_CONFIG6, 16, 19, wr_data_mux_bus);
> +		GPMC_SET_ONE(GPMC_CS_CONFIG6, 24, 28, wr_access);
> +	}

OMAP4/5 also has the above fields and so maybe this should be 
(!cpu_is_omap24xx()).

> +
> +	/* caller is expected to have initialized CONFIG1 to cover
> +	 * at least sync vs async
> +	 */
> +	l = gpmc_cs_read_reg(cs, GPMC_CS_CONFIG1);
> +	if (l&  (GPMC_CONFIG1_READTYPE_SYNC | GPMC_CONFIG1_WRITETYPE_SYNC)) {

Is it valid to have READTYPE != WRITETYPE? I am wondering if there 
should be a check here to see if READTYPE and WRITETYPE are not equal?

> +		printk(KERN_DEBUG "GPMC CS%d CLK period is %lu ns (div %d)\n",
> +				cs, (div * gpmc_get_fclk_period()) / 1000, div);
> +		l&= ~0x03;

I think we should define GPMC_CONFIG1_FCLK_DIV_MASK for this.

> +		l |= (div - 1);
> +		gpmc_cs_write_reg(cs, GPMC_CS_CONFIG1, l);
>   	}
>
>   	return 0;
>   }
> -EXPORT_SYMBOL(gpmc_prefetch_enable);
>
> -/**
> - * gpmc_prefetch_reset - disables and stops the prefetch engine
> - */
> -int gpmc_prefetch_reset(int cs)
> +static __devinit void gpmc_cs_get_memconf(int cs, u32 *base, u32 *size)
>   {
> -	u32 config1;
> +	u32 l;
> +	u32 mask;
>
> -	/* check if the same module/cs is trying to reset */
> -	config1 = gpmc_read_reg(GPMC_PREFETCH_CONFIG1);
> -	if (((config1>>  CS_NUM_SHIFT)&  0x7) != cs)
> -		return -EINVAL;
> +	l = gpmc_cs_read_reg(cs, GPMC_CS_CONFIG7);
> +	*base = (l&  0x3f)<<  GPMC_CHUNK_SHIFT;

Define GPMC_CONFIG7_BASEADDRESS_MASK

> +	mask = (l>>  8)&  0x0f;

Define GPMC_CONFIG7_MASKADDRESS_MASK/SHIFT

> +	*size = (1<<  GPMC_SECTION_SHIFT) - (mask<<  GPMC_CHUNK_SHIFT);
> +}
>
> -	/* Stop the PFPW engine */
> -	gpmc_write_reg(GPMC_PREFETCH_CONTROL, 0x0);
> +static __devinit
> +int gpmc_cs_insert_mem(int cs, unsigned long base, unsigned long size)
> +{
> +	struct resource	*res =&gpmc->cs_mem[cs];
> +	int r;
>
> -	/* Reset/disable the PFPW engine */
> -	gpmc_write_reg(GPMC_PREFETCH_CONFIG1, 0x0);
> +	size = gpmc_mem_align(size);
> +	spin_lock(&gpmc->mem_lock);
> +	res->start = base;
> +	res->end = base + size - 1;
> +	r = request_resource(&gpmc->mem_root, res);
> +	spin_unlock(&gpmc->mem_lock);
>
> -	return 0;
> +	return r;
>   }
> -EXPORT_SYMBOL(gpmc_prefetch_reset);
>
> -static void __init gpmc_mem_init(void)
> +static __devinit void gpmc_mem_init(void)
>   {
>   	int cs;
>   	unsigned long boot_rom_space = 0;
> @@ -680,8 +474,8 @@ static void __init gpmc_mem_init(void)
>   	/* In apollon the CS0 is mapped as 0x0000 0000 */
>   	if (machine_is_omap_apollon())
>   		boot_rom_space = 0;
> -	gpmc_mem_root.start = GPMC_MEM_START + boot_rom_space;
> -	gpmc_mem_root.end = GPMC_MEM_END;
> +	gpmc->mem_root.start = GPMC_MEM_START + boot_rom_space;
> +	gpmc->mem_root.end = GPMC_MEM_END;
>
>   	/* Reserve all regions that has been set up by bootloader */
>   	for (cs = 0; cs<  GPMC_CS_NUM; cs++) {
> @@ -695,88 +489,245 @@ static void __init gpmc_mem_init(void)
>   	}
>   }
>
> -static int __init gpmc_init(void)
> +static inline int __devinit gpmc_find_next_child_slot(void)
>   {
> -	u32 l, irq;
> -	int cs, ret = -EINVAL;
> -	int gpmc_irq;
> -	char *ck = NULL;
> +	return gpmc->num_child;
> +}
>
> -	if (cpu_is_omap24xx()) {
> -		ck = "core_l3_ck";
> -		if (cpu_is_omap2420())
> -			l = OMAP2420_GPMC_BASE;
> -		else
> -			l = OMAP34XX_GPMC_BASE;
> -		gpmc_irq = INT_34XX_GPMC_IRQ;
> -	} else if (cpu_is_omap34xx()) {
> -		ck = "gpmc_fck";
> -		l = OMAP34XX_GPMC_BASE;
> -		gpmc_irq = INT_34XX_GPMC_IRQ;
> -	} else if (cpu_is_omap44xx()) {
> -		ck = "gpmc_ck";
> -		l = OMAP44XX_GPMC_BASE;
> -		gpmc_irq = OMAP44XX_IRQ_GPMC;
> -	}
> +static int __devinit gpmc_match_child(char *name, int id)
> +{
> +	int i;
> +	struct gpmc_child *p;
>
> -	if (WARN_ON(!ck))
> +	for (i = 0, p = gpmc->child_device; i<  gpmc->num_child; i++, p++)
> +		if (!strcmp(p->name, name)&&  (p->id == id))
> +			return i;
> +
> +	return -ENOENT;
> +}
> +
> +static __devinit int gpmc_setup_child(struct gpmc_device_pdata *gdev)

Nit-pick, gdev was a bit confusing to me, maybe just pdata instead?

> +{
> +	struct gpmc_config *c;
> +	int i, ret = 0;
> +	struct resource res;
> +	unsigned long start;
> +
> +	start = gdev->mem_start;
> +
> +	ret = gpmc_cs_request(gdev->cs, gdev->mem_size,&start);
> +	if (IS_ERR_VALUE(ret)) {
> +		dev_err(gpmc->dev, "error: gpmc request on CS: %u\n", gdev->cs);
>   		return ret;
> +	}
>
> -	gpmc_l3_clk = clk_get(NULL, ck);
> -	if (IS_ERR(gpmc_l3_clk)) {
> -		printk(KERN_ERR "Could not get GPMC clock %s\n", ck);
> -		BUG();
> +	c = gdev->config;
> +	if (!c) {
> +		dev_err(gpmc->dev, "config not present for CS: %u\n", gdev->cs);
> +		return -EINVAL;
>   	}
>
> -	gpmc_base = ioremap(l, SZ_4K);
> -	if (!gpmc_base) {
> -		clk_put(gpmc_l3_clk);
> -		printk(KERN_ERR "Could not get GPMC register memory\n");
> -		BUG();
> +	for (i = 0; i<  gdev->num_config; c++, i++) {
> +		ret = gpmc_cs_configure(gdev->cs, c->cmd, c->val);
> +		if (IS_ERR_VALUE(ret)) {
> +			dev_err(gpmc->dev, "invalid cmd or value on CS:	\
> +			 %u: cmd: %d value: %d\n", gdev->cs, c->cmd, c->val);
> +			return ret;
> +		}
> +	}
> +
> +	if (gdev->timing) {
> +		ret = gpmc_cs_set_timings(gdev->cs, gdev->timing);
> +		if (IS_ERR_VALUE(ret)) {
> +			dev_err(gpmc->dev, "error: setting timing on CS: %d\n",
> +								gdev->cs);
> +			return ret;
> +		}
>   	}
>
> -	clk_enable(gpmc_l3_clk);
> +	res.start = start + gdev->mem_offset;
> +	res.end = res.start + gdev->mem_size - 1;
> +	res.flags = IORESOURCE_MEM;
> +
> +	i = gpmc_match_child(gdev->name, gdev->id);
> +	/* i>= GPMC_CS_NUM can never happen, this is for compiler to shutup */
> +	if (i>= 0&&  i<  GPMC_CS_NUM) {
> +		int j;
> +
> +		j = gpmc->child_device[i].gpmc_num_res;
> +		gpmc->child_device[i].gpmc_res[j] = res;

So struct "res" is a local variable and you are storing in a global 
structure? Did you intend to store the address of the pdata struct passed?

> +	} else if (i == -ENOENT) {
> +		i = gpmc_find_next_child_slot();
> +		if (IS_ERR_VALUE(i)) {
> +			dev_err(gpmc->dev, "error: childs exceeded\n");
> +			return -ENODEV;
> +		}
> +		gpmc->child_device[i].name = gdev->name;
> +		gpmc->child_device[i].id = gdev->id;
> +		gpmc->child_device[i].pdata = gdev->pdata;
> +		gpmc->child_device[i].pdata_size = gdev->pdata_size;
> +		gpmc->child_device[i].gpmc_res[0] = res;

Same here as above.

To be honest, I find this whole section of code confusing. This probably 
goes back to my initial questions of number of resources versus number 
of chip-selects.

> +	} else {
> +		/* should never come here */
> +		dev_err(gpmc->dev, "error: childs exceeded\n");
> +		return -ENODEV;
> +	}
> +
> +	gpmc->child_device[i].gpmc_num_res++;
> +
> +	return ret;
> +}
> +
> +static __devinit int gpmc_create_child(int cnt)
> +{
> +	struct gpmc_child *p = gpmc->child_device + cnt;
> +	int num = p->num_res + p->gpmc_num_res;
> +	struct resource *res;
> +
> +	res = kzalloc(sizeof(struct resource) * num, GFP_KERNEL);
> +	if (!res) {
> +		dev_err(gpmc->dev, "error: allocating memory\n");
> +		return -ENOMEM;
> +	}
> +
> +	memcpy((char *)res, (const char *) p->gpmc_res,
> +				sizeof(struct resource) * p->gpmc_num_res);
> +	memcpy((char *)(res + p->gpmc_num_res), (const char *)p->res,
> +				sizeof(struct resource) * p->num_res);
> +
> +	platform_device_register_resndata(gpmc->dev, p->name, p->id, res,
> +						num, p->pdata, p->pdata_size);
> +
> +	return 0;
> +}
> +
> +static __devinit int gpmc_probe(struct platform_device *pdev)
> +{
> +	u32 l;
> +	int i;
> +	int ret = -EINVAL;
> +	struct resource *res = NULL;
> +	struct gpmc_pdata *gd = dev_get_platdata(&pdev->dev);
> +	struct gpmc_device_pdata *gdev = NULL;
> +
> +	gpmc = devm_kzalloc(&pdev->dev, sizeof(struct gpmc), GFP_KERNEL);
> +	if (!gpmc) {
> +		dev_err(&pdev->dev, "Failed to allocate memory\n");
> +		return -ENOMEM;
> +	}
> +
> +	gpmc->dev =&pdev->dev;
> +	gpmc->fclk_rate = gd->fclk_rate;
> +	gpmc->num_device = gd->num_device;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!res) {
> +		ret = -ENOENT;
> +		dev_err(gpmc->dev, "Failed to get resource: memory\n");
> +		goto err_res;
> +	}
> +	gpmc->phys_base = res->start;
> +	gpmc->memsize = resource_size(res);
> +
> +	if (request_mem_region(gpmc->phys_base,
> +		gpmc->memsize, DRIVER_NAME) == NULL) {
> +		ret = -ENOMEM;
> +		dev_err(gpmc->dev, "Failed to request memory region\n");
> +		goto err_mem;
> +	}
> +
> +	gpmc->io_base = ioremap(gpmc->phys_base, gpmc->memsize);
> +	if (!gpmc->io_base) {
> +		ret = -ENOMEM;
> +		dev_err(gpmc->dev, "Failed to ioremap memory\n");
> +		goto err_remap;
> +	}
> +
> +	gpmc->ecc_used = -EINVAL;

Why not 0?

> +	spin_lock_init(&gpmc->mem_lock);
> +	platform_set_drvdata(pdev, gpmc);
>
>   	l = gpmc_read_reg(GPMC_REVISION);
> -	printk(KERN_INFO "GPMC revision %d.%d\n", (l>>  4)&  0x0f, l&  0x0f);
> -	/* Set smart idle mode and automatic L3 clock gating */
> -	l = gpmc_read_reg(GPMC_SYSCONFIG);
> -	l&= 0x03<<  3;
> -	l |= (0x02<<  3) | (1<<  0);
> -	gpmc_write_reg(GPMC_SYSCONFIG, l);

Really need to clean up the above with some #defines. Ideally we would 
be using hwmod/pm_runtime for configuring the SYSCONFIG.

> +	dev_info(gpmc->dev, "GPMC revision %d.%d\n", (l>>  4)&  0x0f, l&  0x0f);
> +
>   	gpmc_mem_init();
>
> -	/* initalize the irq_chained */
> -	irq = OMAP_GPMC_IRQ_BASE;
> -	for (cs = 0; cs<  GPMC_CS_NUM; cs++) {
> -		irq_set_chip_and_handler(irq,&dummy_irq_chip,
> -						handle_simple_irq);
> -		set_irq_flags(irq, IRQF_VALID);
> -		irq++;
> +	for (i = 0, gdev = gd->device_pdata; i<  gd->num_device; gdev++, i++) {
> +		ret = gpmc_setup_child(gdev);
> +		if (IS_ERR_VALUE(ret))
> +			dev_err(gpmc->dev, "gpmc setup on CS: %u failed\n",
> +								gdev->cs);
> +		else
> +			gpmc->num_child++;
>   	}
>
> -	ret = request_irq(gpmc_irq,
> -			gpmc_handle_irq, IRQF_SHARED, "gpmc", gpmc_base);
> -	if (ret)
> -		pr_err("gpmc: irq-%d could not claim: err %d\n",
> -						gpmc_irq, ret);
> +	/* XXX: This would get modified once MFD */
> +	for (i = 0; i<  gpmc->num_child; i++)
> +		gpmc_create_child(i);
> +
> +	return ret;
> +
> +err_remap:
> +	release_mem_region(gpmc->phys_base, gpmc->memsize);
> +err_mem:
> +err_res:
> +	devm_kfree(&pdev->dev, gpmc);
>   	return ret;
>   }
> -postcore_initcall(gpmc_init);
>
> -static irqreturn_t gpmc_handle_irq(int irq, void *dev)
> +static __devexit int gpmc_remove(struct platform_device *pdev)
>   {
> -	u8 cs;
> +	struct gpmc *gpmc = platform_get_drvdata(pdev);
>
> -	/* check cs to invoke the irq */
> -	cs = ((gpmc_read_reg(GPMC_PREFETCH_CONFIG1))>>  CS_NUM_SHIFT)&  0x7;
> -	if (OMAP_GPMC_IRQ_BASE+cs<= OMAP_GPMC_IRQ_END)
> -		generic_handle_irq(OMAP_GPMC_IRQ_BASE+cs);
> +	platform_set_drvdata(pdev, NULL);
> +	iounmap(gpmc->io_base);
> +	release_mem_region(gpmc->phys_base, gpmc->memsize);
> +	devm_kfree(&pdev->dev, gpmc);

Do we need to free irqs here?

> -	return IRQ_HANDLED;
> +	return 0;
>   }
>
> +static struct platform_driver gpmc_driver = {
> +	.probe		= gpmc_probe,
> +	.remove		= __devexit_p(gpmc_remove),
> +	.driver		= {
> +		.name	= DRIVER_NAME,
> +		.owner	= THIS_MODULE,
> +	},
> +};
> +
> +module_platform_driver(gpmc_driver);
> +
> +/* Suspend - resume support */
> +
>   #ifdef CONFIG_ARCH_OMAP3
> +/* Structure to save gpmc cs context */
> +struct gpmc_cs_config {
> +	u32 config1;
> +	u32 config2;
> +	u32 config3;
> +	u32 config4;
> +	u32 config5;
> +	u32 config6;
> +	u32 config7;
> +	int is_valid;
> +};
> +
> +/*
> + * Structure to save/restore gpmc context
> + * to support core off on OMAP3
> + */
> +struct omap3_gpmc_regs {
> +	u32 sysconfig;
> +	u32 irqenable;
> +	u32 timeout_ctrl;
> +	u32 config;
> +	u32 prefetch_config1;
> +	u32 prefetch_config2;
> +	u32 prefetch_control;
> +	struct gpmc_cs_config cs_context[GPMC_CS_NUM];
> +};
> +
>   static struct omap3_gpmc_regs gpmc_context;
>
>   void omap3_gpmc_save_context(void)
> @@ -843,6 +794,159 @@ void omap3_gpmc_restore_context(void)
>   }
>   #endif /* CONFIG_ARCH_OMAP3 */
>
> +/* GPMC NAND related */
> +
> +/**
> + * gpmc_read_status - read access request to get the different gpmc status
> + * @cmd: command type
> + * @return status
> + */
> +int gpmc_read_status(int cmd)
> +{
> +	int	status = -EINVAL;
> +	u32	regval = 0;
> +
> +	switch (cmd) {
> +	case GPMC_GET_IRQ_STATUS:
> +		status = gpmc_read_reg(GPMC_IRQSTATUS);
> +		break;
> +
> +	case GPMC_PREFETCH_FIFO_CNT:
> +		regval = gpmc_read_reg(GPMC_PREFETCH_STATUS);
> +		status = GPMC_PREFETCH_STATUS_FIFO_CNT(regval);
> +		break;
> +
> +	case GPMC_PREFETCH_COUNT:
> +		regval = gpmc_read_reg(GPMC_PREFETCH_STATUS);
> +		status = GPMC_PREFETCH_STATUS_COUNT(regval);
> +		break;
> +
> +	case GPMC_STATUS_BUFFER:
> +		regval = gpmc_read_reg(GPMC_STATUS);
> +		/* 1 : buffer is available to write */
> +		status = regval&  GPMC_STATUS_BUFF_EMPTY;
> +		break;
> +
> +	default:
> +		printk(KERN_ERR "gpmc_read_status: Not supported\n");
> +	}
> +	return status;
> +}
> +EXPORT_SYMBOL(gpmc_read_status);
> +
> +/**
> + * gpmc_nand_read - nand specific read access request
> + * @cs: chip select number
> + * @cmd: command type
> + */
> +int gpmc_nand_read(int cs, int cmd)
> +{
> +	int rval = -EINVAL;
> +
> +	switch (cmd) {
> +	case GPMC_NAND_DATA:
> +		rval = gpmc_cs_read_byte(cs, GPMC_CS_NAND_DATA);
> +		break;
> +
> +	default:
> +		printk(KERN_ERR "gpmc_read_nand_ctrl: Not supported\n");
> +	}
> +	return rval;
> +}
> +EXPORT_SYMBOL(gpmc_nand_read);
> +
> +/**
> + * gpmc_nand_write - nand specific write request
> + * @cs: chip select number
> + * @cmd: command type
> + * @wval: value to write
> + */
> +int gpmc_nand_write(int cs, int cmd, int wval)
> +{
> +	int err = 0;
> +
> +	switch (cmd) {
> +	case GPMC_NAND_COMMAND:
> +		gpmc_cs_write_byte(cs, GPMC_CS_NAND_COMMAND, wval);
> +		break;
> +
> +	case GPMC_NAND_ADDRESS:
> +		gpmc_cs_write_byte(cs, GPMC_CS_NAND_ADDRESS, wval);
> +		break;
> +
> +	case GPMC_NAND_DATA:
> +		gpmc_cs_write_byte(cs, GPMC_CS_NAND_DATA, wval);
> +
> +	default:
> +		printk(KERN_ERR "gpmc_write_nand_ctrl: Not supported\n");
> +		err = -EINVAL;
> +	}
> +	return err;
> +}
> +EXPORT_SYMBOL(gpmc_nand_write);
> +
> +
> +
> +/**
> + * gpmc_prefetch_enable - configures and starts prefetch transfer
> + * @cs: cs (chip select) number
> + * @fifo_th: fifo threshold to be used for read/ write
> + * @dma_mode: dma mode enable (1) or disable (0)
> + * @u32_count: number of bytes to be transferred
> + * @is_write: prefetch read(0) or write post(1) mode
> + */
> +int gpmc_prefetch_enable(int cs, int fifo_th, int dma_mode,
> +				unsigned int u32_count, int is_write)
> +{
> +
> +	if (fifo_th>  PREFETCH_FIFOTHRESHOLD_MAX) {
> +		pr_err("gpmc: fifo threshold is not supported\n");
> +		return -1;
> +	} else if (!(gpmc_read_reg(GPMC_PREFETCH_CONTROL))) {
> +		/* Set the amount of bytes to be prefetched */
> +		gpmc_write_reg(GPMC_PREFETCH_CONFIG2, u32_count);
> +
> +		/* Set dma/mpu mode, the prefetch read / post write and
> +		 * enable the engine. Set which cs is has requested for.
> +		 */
> +		gpmc_write_reg(GPMC_PREFETCH_CONFIG1, ((cs<<  CS_NUM_SHIFT) |
> +					PREFETCH_FIFOTHRESHOLD(fifo_th) |
> +					ENABLE_PREFETCH |
> +					(dma_mode<<  DMA_MPU_MODE) |
> +					(0x1&  is_write)));

#define GPMC_PREFETCH_CONFIG1_ACCESSMODE

> +
> +		/*  Start the prefetch engine */
> +		gpmc_write_reg(GPMC_PREFETCH_CONTROL, 0x1);
> +	} else {
> +		return -EBUSY;
> +	}
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(gpmc_prefetch_enable);
> +
> +/**
> + * gpmc_prefetch_reset - disables and stops the prefetch engine
> + */
> +int gpmc_prefetch_reset(int cs)
> +{
> +	u32 config1;
> +
> +	/* check if the same module/cs is trying to reset */
> +	config1 = gpmc_read_reg(GPMC_PREFETCH_CONFIG1);
> +	if (((config1>>  CS_NUM_SHIFT)&  0x7) != cs)

Maybe define a mask value for the ENGINECSSELECTOR

> +		return -EINVAL;
> +
> +	/* Stop the PFPW engine */
> +	gpmc_write_reg(GPMC_PREFETCH_CONTROL, 0x0);
> +
> +	/* Reset/disable the PFPW engine */
> +	gpmc_write_reg(GPMC_PREFETCH_CONFIG1, 0x0);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(gpmc_prefetch_reset);
> +
>   /**
>    * gpmc_enable_hwecc - enable hardware ecc functionality
>    * @cs: chip select number
> @@ -855,10 +959,10 @@ int gpmc_enable_hwecc(int cs, int mode, int dev_width, int ecc_size)
>   	unsigned int val;
>
>   	/* check if ecc module is in used */
> -	if (gpmc_ecc_used != -EINVAL)
> +	if (gpmc->ecc_used != -EINVAL)
>   		return -EINVAL;

As mentioned above we could set ecc_used to 0 by default.

> -	gpmc_ecc_used = cs;
> +	gpmc->ecc_used = cs;
>
>   	/* clear ecc and enable bits */
>   	val = ((0x00000001<<8) | 0x00000001);
> @@ -906,7 +1010,7 @@ int gpmc_calculate_ecc(int cs, const u_char *dat, u_char *ecc_code)
>   {
>   	unsigned int val = 0x0;
>
> -	if (gpmc_ecc_used != cs)
> +	if (gpmc->ecc_used != cs)
>   		return -EINVAL;
>
>   	/* read ecc result */
> @@ -916,7 +1020,100 @@ int gpmc_calculate_ecc(int cs, const u_char *dat, u_char *ecc_code)
>   	/* P2048o, P1024o, P512o, P256o, P2048e, P1024e, P512e, P256e */
>   	*ecc_code++ = ((val>>  8)&  0x0f) | ((val>>  20)&  0xf0);
>
> -	gpmc_ecc_used = -EINVAL;
> +	gpmc->ecc_used = -EINVAL;

ecc_used = 0

>   	return 0;
>   }
>   EXPORT_SYMBOL_GPL(gpmc_calculate_ecc);
> +
> +/* GPMC CLK related */
> +
> +static struct clk *gpmc_l3_clk;
> +
> +static int __init gpmc_clk_init(void)
> +{
> +	char *ck = NULL;
> +
> +	if (cpu_is_omap24xx())
> +		ck = "core_l3_ck";
> +	else if (cpu_is_omap34xx())
> +		ck = "gpmc_fck";
> +	else if (cpu_is_omap44xx())
> +		ck = "gpmc_ck";
> +	if (WARN_ON(!ck))
> +		return -EINVAL;
> +
> +	gpmc_l3_clk = clk_get(NULL, ck);
> +	if (WARN_ON(IS_ERR(gpmc_l3_clk)))
> +		return -EINVAL;
> +
> +	if (WARN_ON(IS_ERR_VALUE(clk_enable(gpmc_l3_clk)))) {
> +		clk_put(gpmc_l3_clk);
> +		return -EIO;
> +	}
> +
> +	return 0;
> +}
> +postcore_initcall(gpmc_clk_init);
> +
> +/* TODO: Add support for gpmc_fck to clock framework and use it */
> +unsigned long gpmc_get_fclk_period(void)
> +{
> +	unsigned long rate = clk_get_rate(gpmc_l3_clk);
> +
> +	if (rate == 0) {
> +		printk(KERN_WARNING "gpmc_l3_clk not enabled\n");
> +		return 0;
> +	}
> +
> +	rate /= 1000;
> +	rate = 1000000000 / rate;	/* In picoseconds */
> +
> +	return rate;
> +}
> +
> +unsigned int gpmc_ns_to_ticks(unsigned int time_ns)
> +{
> +	unsigned long tick_ps;
> +
> +	/* Calculate in picosecs to yield more exact results */
> +	tick_ps = gpmc_get_fclk_period();
> +
> +	return (time_ns * 1000 + tick_ps - 1) / tick_ps;
> +}
> +
> +unsigned int gpmc_ps_to_ticks(unsigned int time_ps)
> +{
> +	unsigned long tick_ps;
> +
> +	/* Calculate in picosecs to yield more exact results */
> +	tick_ps = gpmc_get_fclk_period();
> +
> +	return (time_ps + tick_ps - 1) / tick_ps;
> +}
> +
> +unsigned int gpmc_ticks_to_ns(unsigned int ticks)
> +{
> +	return ticks * gpmc_get_fclk_period() / 1000;
> +}
> +
> +unsigned int gpmc_round_ns_to_ticks(unsigned int time_ns)
> +{
> +	unsigned long ticks = gpmc_ns_to_ticks(time_ns);
> +
> +	return ticks * gpmc_get_fclk_period() / 1000;
> +}
> +
> +int gpmc_cs_calc_divider(int cs, unsigned int sync_clk)
> +{
> +	int div;
> +	u32 l;
> +
> +	l = sync_clk + (gpmc_get_fclk_period() - 1);
> +	div = l / gpmc_get_fclk_period();
> +	if (div>  4)
> +		return -1;
> +	if (div<= 0)
> +		div = 1;
> +
> +	return div;
> +}
> diff --git a/arch/arm/plat-omap/include/plat/gpmc.h b/arch/arm/plat-omap/include/plat/gpmc.h
> index 1527929..b949c0c 100644
> --- a/arch/arm/plat-omap/include/plat/gpmc.h
> +++ b/arch/arm/plat-omap/include/plat/gpmc.h
> @@ -131,6 +131,38 @@ struct gpmc_timings {
>   	u16 wr_data_mux_bus;	/* WRDATAONADMUXBUS */
>   };
>
> +struct gpmc_config {
> +	int cmd;
> +	int val;
> +};
> +
> +struct gpmc_device_pdata {
> +	/* connected peripheral specific */
> +	char			*name;
> +	int			id;
> +	/* resources configured via GPMC will be created by GPMC driver */
> +	struct resource		*res;
> +	unsigned		num_res;
> +	void			*pdata;
> +	unsigned		pdata_size;

Do you need pdata_size here?

> +
> +	/* GPMC specific */
> +	unsigned		cs;
> +	unsigned long		mem_size;
> +	unsigned long		mem_start;
> +	unsigned long		mem_offset;
> +	struct gpmc_config	*config;
> +	unsigned		num_config;
> +	struct gpmc_timings	*timing;
> +};
> +
> +struct gpmc_pdata {
> +	/* GPMC_FCLK rate in picoseconds */
> +	unsigned long			fclk_rate;

fclk_period

> +	struct gpmc_device_pdata	*device_pdata;
> +	unsigned			num_device;
> +};

Do you need both gpmc_pdata and gpmc_device_pdata? Would not a single 
structure work?

Cheers
Jon
