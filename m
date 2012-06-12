From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCH v5 10/14] ARM: OMAP2+: gpmc: waitpin helper
Date: Tue, 12 Jun 2012 13:37:46 -0500
Message-ID: <4FD78C7A.8070107@ti.com>
References: <cover.1339419492.git.afzal@ti.com> <bba49a35f81f33fbdfeda78a71cbe4aa3417d6a2.1339419492.git.afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:36775 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751306Ab2FLShw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 12 Jun 2012 14:37:52 -0400
In-Reply-To: <bba49a35f81f33fbdfeda78a71cbe4aa3417d6a2.1339419492.git.afzal@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Afzal Mohammed <afzal@ti.com>
Cc: tony@atomide.com, paul@pwsan.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org


On 06/11/2012 09:27 AM, Afzal Mohammed wrote:
> Helper for configuring waitpin. There are two parts to it;
> configuring at CS level and the other at device level.
> A device embedding multiple CS has been provided the
> capability to use same waitpin (different waitpins has not
> been supported as presently there are no GPMC peripherals
> doing so)
> 
> Signed-off-by: Afzal Mohammed <afzal@ti.com>
> ---
>  arch/arm/mach-omap2/gpmc.c             |  122 ++++++++++++++++++++++++++++++++
>  arch/arm/plat-omap/include/plat/gpmc.h |    9 +++
>  2 files changed, 131 insertions(+)
> 
> diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
> index 5a6f708..9073a8a 100644
> --- a/arch/arm/mach-omap2/gpmc.c
> +++ b/arch/arm/mach-omap2/gpmc.c
> @@ -75,6 +75,8 @@
>  #define	GPMC_CONFIG6_CYCLE2CYCLEDIFFCSEN	BIT(6)
>  #define	GPMC_CONFIG6_CYCLE2CYCLESAMECSEN	BIT(7)
>  
> +#define	GPMC_CONFIG_WAITPIN_POLARITY_SHIFT	0x8
> +
>  #define GPMC_CS0_OFFSET		0x60
>  #define GPMC_CS_SIZE		0x30
>  
> @@ -93,6 +95,19 @@
>   */
>  #define	GPMC_NR_IRQ		2
>  
> +enum {
> +	GPMC_WAITPIN_IDX0,
> +	GPMC_WAITPIN_IDX1,
> +	GPMC_WAITPIN_IDX2,
> +	GPMC_WAITPIN_IDX3,
> +	GPMC_NR_WAITPIN
> +};
> +
> +enum {
> +	LOW,
> +	HIGH
> +};
> +
>  struct gpmc_client_irq	{
>  	unsigned		irq;
>  	u32			bitmask;
> @@ -140,6 +155,8 @@ struct gpmc_peripheral {
>  	struct platform_device	*pdev;
>  };
>  
> +static unsigned gpmc_waitpin_map;
> +
>  static struct gpmc_client_irq gpmc_client_irq[GPMC_NR_IRQ];
>  static struct irq_chip gpmc_irq_chip;
>  static unsigned gpmc_irq_start;
> @@ -1162,6 +1179,62 @@ static void gpmc_print_cs_timings(int cs)
>  			gpmc_get_one_timing(cs, GPMC_CS_CONFIG6, 7, 7));
>  }
>  
> +static int gpmc_setup_cs_waitpin(struct gpmc_peripheral *g_per, unsigned cs,
> +							unsigned conf)
> +{
> +	unsigned idx;
> +	bool polarity = 0;
> +	u32 l = gpmc_cs_read_reg(cs, GPMC_CS_CONFIG1);
> +
> +	switch (conf & GPMC_WAITPIN_MASK) {
> +	case GPMC_WAITPIN_0:
> +		idx =  GPMC_WAITPIN_IDX0;
> +		break;
> +	case GPMC_WAITPIN_1:
> +		idx =  GPMC_WAITPIN_IDX1;
> +		break;
> +	case GPMC_WAITPIN_2:
> +		idx =  GPMC_WAITPIN_IDX2;
> +		break;
> +	case GPMC_WAITPIN_3:
> +		idx =  GPMC_WAITPIN_IDX3;
> +		break;
> +	/* no waitpin */
> +	case 0:
> +		return 0;
> +		break;

Do you need the break and return?

> +	default:
> +		dev_err(gpmc_dev, "multiple waitpins selected on CS:%u\n", cs);
> +		return -EINVAL;
> +		break;

Same as above.

> +	}
> +
> +	polarity = !!(conf & GPMC_WAITPIN_ACTIVE_HIGH);
> +
> +	if (g_per->have_waitpin) {
> +		if (g_per->waitpin != idx ||
> +				g_per->waitpin_polarity != polarity) {
> +			dev_err(gpmc_dev, "error: conflict: waitpin %u with polarity %d on device %s.%d\n",
> +				g_per->waitpin, g_per->waitpin_polarity,
> +				g_per->name, g_per->id);
> +			return -EBUSY;
> +		}
> +	} else {
> +		g_per->have_waitpin = true;
> +		g_per->waitpin = idx;
> +		g_per->waitpin_polarity = polarity;
> +	}
> +
> +	l |= conf & GPMC_CONFIG1_WAIT_WRITE_MON;
> +	l |= conf & GPMC_CONFIG1_WAIT_READ_MON;
> +	l &= ~GPMC_CONFIG1_WAIT_PIN_SEL_MASK;
> +	l |= GPMC_CONFIG1_WAIT_PIN_SEL(idx);
> +
> +	gpmc_cs_write_reg(cs, GPMC_CS_CONFIG1, l);
> +
> +	return 0;
> +}
> +
>  static inline unsigned gpmc_bit_to_irq(unsigned bitmask)
>  {
>  	return bitmask;
> @@ -1185,6 +1258,55 @@ static __devinit int gpmc_setup_cs_irq(struct gpmc_cs_data *cs,
>  	return n;
>  }
>  
> +static inline int gpmc_waitpin_is_reserved(unsigned waitpin)
> +{
> +	return gpmc_waitpin_map & (0x1 << waitpin);
> +}
> +
> +static inline void gpmc_reserve_waitpin(unsigned waitpin)
> +{
> +	gpmc_waitpin_map &= ~(0x1 << waitpin);
> +	gpmc_waitpin_map |= (0x1 << waitpin);
> +}
> +
> +static int gpmc_waitpin_request(unsigned waitpin)
> +{
> +	if (!(waitpin < GPMC_NR_WAITPIN))
> +		return -ENODEV;
> +
> +	if (gpmc_waitpin_is_reserved(waitpin))
> +		return -EBUSY;
> +	else
> +		gpmc_reserve_waitpin(waitpin);
> +
> +	return 0;
> +}

I am wondering if we should combine all the gpmc_xxx_request pin
functions into one. For example ...

static int gpmc_pin_request(int type, int pin)
{
	int pin_num, pin_mask;

	switch(type) {
	case GPMC_PIN_TYPE_CS:
		pin_num = GPMC_CS_NUM;
		pin_mask = gpmc_cs_map;
		break;
	case GPMC_PIN_TYPE_WAIT:
		pin_num = GPMC_NR_WAITPN;
		pin_mask = gpmc_waitpin_map;
		break;
	case GPMC_PIN_TYPE_WRITEPROTECT:
		pin_num = GPMC_NR_WP;
		pin_mask = gpmc_wp_map;
		break;
	default:
		return -ENODEV;
	}

	if (pin >= pin_num)
		return -ENODEV;

	if (gpmc_pin_is_reserved(pin_mask, pin))
		return -EBUSY;

	gpmc_reserve_pin(pin_mask, pin);

	return 0;
}

Jon
