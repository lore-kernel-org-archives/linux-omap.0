From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [RFC v2 4/7] OMAP4: mux: Add CBL package data for OMAP4430 ES1
Date: Thu, 11 Nov 2010 13:33:56 +0100
Message-ID: <4CDBE2B4.9090806@ti.com>
References: <1287526956-21853-1-git-send-email-b-cousson@ti.com> <1287526956-21853-5-git-send-email-b-cousson@ti.com> <20101111015600.GN9264@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:40278 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753482Ab0KKMeC (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 11 Nov 2010 07:34:02 -0500
In-Reply-To: <20101111015600.GN9264@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Menon, Nishanth" <nm@ti.com>, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@deeprootsystems.com>

Hi Tony,

On 11/11/2010 2:56 AM, Tony Lindgren wrote:
> * Benoit Cousson<b-cousson@ti.com>  [101019 15:14]:
>> Add data for OMAP4430 generated from HW pinout&  register database.
>> The data set is split in two partitions for both core and wkup.
>
> We should drop patch 3/7 and merge the following patch to your
> 4/7 patch.

OK

>
> Basically let's keep the omap_mux_read/write around for now,
> by adding omap_mux_get for dealing with the partition
> information.

Thanks for that.

I'll send the update today.

Regards,
Benoit

>
> Regards,
>
> Tony
>
>
> From: Tony Lindgren<tony@atomide.com>
> Date: Wed, 10 Nov 2010 09:55:47 -0800
> Subject: [PATCH] omap: mux: Fix support for partitions for dynamic muxing
>
> Revert some parts of Benoit's patch to not make
> omap_mux_read/write static at this point.
>
> We may need to do remuxing for system wide idle states,
> and also for driver specific idle states.
>
> So we still need to have omap_mux_read/write around for
> the platform level driver code.
>
> Also add omap_mux_get for getting the partition data so
> platform level device code can use it.
>
> Signed-off-by: Tony Lindgren<tony@atomide.com>
>
> diff --git a/arch/arm/mach-omap2/board-rx51-peripherals.c b/arch/arm/mach-omap2/board-rx51-peripherals.c
> index 3fec4d6..3fda20d 100644
> --- a/arch/arm/mach-omap2/board-rx51-peripherals.c
> +++ b/arch/arm/mach-omap2/board-rx51-peripherals.c
> @@ -293,6 +293,8 @@ static struct omap_board_mux rx51_mmc2_off_mux[] = {
>   	{ .reg_offset = OMAP_MUX_TERMINATOR },
>   };
>
> +static struct omap_mux_partition *partition;
> +
>   /*
>    * Current flows to eMMC when eMMC is off and the data lines are pulled up,
>    * so pull them down. N.B. we pull 8 lines because we are using 8 lines.
> @@ -300,9 +302,9 @@ static struct omap_board_mux rx51_mmc2_off_mux[] = {
>   static void rx51_mmc2_remux(struct device *dev, int slot, int power_on)
>   {
>   	if (power_on)
> -		omap_mux_write_array(rx51_mmc2_on_mux);
> +		omap_mux_write_array(partition, rx51_mmc2_on_mux);
>   	else
> -		omap_mux_write_array(rx51_mmc2_off_mux);
> +		omap_mux_write_array(partition, rx51_mmc2_off_mux);
>   }
>
>   static struct omap2_hsmmc_info mmc[] __initdata = {
> @@ -922,7 +924,11 @@ void __init rx51_peripherals_init(void)
>   	rx51_init_wl1251();
>   	spi_register_board_info(rx51_peripherals_spi_board_info,
>   				ARRAY_SIZE(rx51_peripherals_spi_board_info));
> -	omap2_hsmmc_init(mmc);
> +
> +	partition = omap_mux_get("core");
> +	if (partition)
> +		omap2_hsmmc_init(mmc);
> +
>   	platform_device_register(&rx51_charger_device);
>   }
>
> diff --git a/arch/arm/mach-omap2/mux.c b/arch/arm/mach-omap2/mux.c
> index 9b9128e..6d91bb8 100644
> --- a/arch/arm/mach-omap2/mux.c
> +++ b/arch/arm/mach-omap2/mux.c
> @@ -49,7 +49,19 @@ struct omap_mux_entry {
>   static LIST_HEAD(mux_partitions);
>   static DEFINE_MUTEX(muxmode_mutex);
>
> -static u16 omap_mux_read(struct omap_mux_partition *partition, u16 reg)
> +struct omap_mux_partition * omap_mux_get(const char *name)
> +{
> +	struct omap_mux_partition *partition;
> +
> +	list_for_each_entry(partition,&mux_partitions, node) {
> +		if (!strcmp(name, partition->name))
> +			return partition;
> +	}
> +
> +	return NULL;
> +}
> +
> +u16 omap_mux_read(struct omap_mux_partition *partition, u16 reg)
>   {
>   	if (partition->flags&  OMAP_MUX_REG_8BIT)
>   		return __raw_readb(partition->base + reg);
> @@ -57,7 +69,7 @@ static u16 omap_mux_read(struct omap_mux_partition *partition, u16 reg)
>   		return __raw_readw(partition->base + reg);
>   }
>
> -static void omap_mux_write(struct omap_mux_partition *partition, u16 val,
> +void omap_mux_write(struct omap_mux_partition *partition, u16 val,
>   			   u16 reg)
>   {
>   	if (partition->flags&  OMAP_MUX_REG_8BIT)
> @@ -66,7 +78,7 @@ static void omap_mux_write(struct omap_mux_partition *partition, u16 val,
>   		__raw_writew(val, partition->base + reg);
>   }
>
> -static void omap_mux_write_array(struct omap_mux_partition *partition,
> +void omap_mux_write_array(struct omap_mux_partition *partition,
>   				 struct omap_board_mux *board_mux)
>   {
>   	while (board_mux->reg_offset != OMAP_MUX_TERMINATOR) {
> diff --git a/arch/arm/mach-omap2/mux.h b/arch/arm/mach-omap2/mux.h
> index dad32f6..6656043 100644
> --- a/arch/arm/mach-omap2/mux.h
> +++ b/arch/arm/mach-omap2/mux.h
> @@ -186,6 +186,40 @@ u16 omap_mux_get_gpio(int gpio);
>   void omap_mux_set_gpio(u16 val, int gpio);
>
>   /**
> + * omap_mux_get() - get a mux partition by name
> + * @name:		Name of the mux partition
> + *
> + */
> +struct omap_mux_partition * omap_mux_get(const char *name);
> +
> +/**
> + * omap_mux_read() - read mux register
> + * @partition:		Mux partition
> + * @mux_offset:		Offset of the mux register
> + *
> + */
> +u16 omap_mux_read(struct omap_mux_partition *p, u16 mux_offset);
> +
> +/**
> + * omap_mux_write() - write mux register
> + * @partition:		Mux partition
> + * @val:		New mux register value
> + * @mux_offset:		Offset of the mux register
> + *
> + * This should be only needed for dynamic remuxing of non-gpio signals.
> + */
> +void omap_mux_write(struct omap_mux_partition *p, u16 val, u16 mux_offset);
> +
> +/**
> + * omap_mux_write_array() - write an array of mux registers
> + * @partition:		Mux partition
> + * @board_mux:		Array of mux registers terminated by MAP_MUX_TERMINATOR
> + *
> + * This should be only needed for dynamic remuxing of non-gpio signals.
> + */
> +void omap_mux_write_array(struct omap_mux_partition *p, struct omap_board_mux *board_mux);
> +
> +/**
>    * omap2420_mux_init() - initialize mux system with board specific set
>    * @board_mux:		Board specific mux table
>    * @flags:		OMAP package type used for the board

