From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH] OMAP: TI816X: Add SATA support
Date: Thu, 7 Apr 2011 17:55:24 +0200
Message-ID: <4D9DDE6C.8050905@ti.com>
References: <1302171887-3598-1-git-send-email-mansoor.ahamed@ti.com> <20110407112328.GX29038@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
In-Reply-To: <20110407112328.GX29038@legolas.emea.dhcp.ti.com>
Sender: linux-ide-owner@vger.kernel.org
To: "Basheer, Mansoor Ahamed" <mansoor.ahamed@ti.com>
Cc: "Balbi, Felipe" <balbi@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>, "linux-arm-kernel@lists.arm.linux.org.uk" <linux-arm-kernel@lists.arm.linux.org.uk>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On 4/7/2011 1:23 PM, Balbi, Felipe wrote:
> Hi,
>
> On Thu, Apr 07, 2011 at 03:54:47PM +0530, Basheer, Mansoor Ahamed wrote:
>> @@ -100,6 +102,129 @@ static int __init omap4_l3_init(void)
>>   }
>>   postcore_initcall(omap4_l3_init);
>>
>> +#if defined(CONFIG_SATA_AHCI_PLATFORM) || \
>> +	defined(CONFIG_SATA_AHCI_PLATFORM_MODULE)
>> +
>> +static struct ahci_platform_data omap_sata_pdata;
>> +static u64 omap_sata_dmamask = DMA_BIT_MASK(32);
>> +static struct clk *omap_sata_clk;
>> +
>> +/* SATA PHY control register offsets */
>> +#define SATA_P0PHYCR_REG	0x178
>> +#define SATA_P1PHYCR_REG	0x1F8
>
> prepend all with TI816X_
>
>> +#define SATA_PHY_ENPLL(x)	((x)<<  0)
>> +#define SATA_PHY_MPY(x)		((x)<<  1)
>> +#define SATA_PHY_LB(x)		((x)<<  5)
>> +#define SATA_PHY_CLKBYP(x)	((x)<<  7)
>> +#define SATA_PHY_RXINVPAIR(x)	((x)<<  9)
>> +#define SATA_PHY_LBK(x)		((x)<<  10)
>> +#define SATA_PHY_RXLOS(x)	((x)<<  12)
>> +#define SATA_PHY_RXCDR(x)	((x)<<  13)
>> +#define SATA_PHY_RXEQ(x)	((x)<<  16)
>> +#define SATA_PHY_RXENOC(x)	((x)<<  20)
>> +#define SATA_PHY_TXINVPAIR(x)	((x)<<  21)
>> +#define SATA_PHY_TXCM(x)	((x)<<  22)
>> +#define SATA_PHY_TXSWING(x)	((x)<<  23)
>
> the ones which are single bits, you define as:
>
> #define TI816X_SATA_PHY_TXINVPAIR	(1<<  21)
>
> or
>
> #define TI816X_SATA_PHY_TXINVPAIR	BIT(21)
>
>> +#define SATA_PHY_TXDE(x)	((x)<<  27)
>> +
>> +#define TI816X_SATA_BASE	0x4A140000
>
> you should probably define these on some header file. Also SATA_BASE
> should be an increment to the global base.

In fact, you should even use hwmod data for that.

>> +
>> +static int ti816x_ahci_plat_init(struct device *dev, void __iomem *base)
>> +{
>> +	unsigned int phy_val;
>> +	int ret;
>> +
>> +	omap_sata_clk = clk_get(dev, NULL);
>> +	if (IS_ERR(omap_sata_clk)) {
>> +		pr_err("ahci : Failed to get SATA clock\n");
>> +		return PTR_ERR(omap_sata_clk);
>> +	}
>
> can't you use pm_runtime do achieve this ?
>
>> +
>> +	if (!base) {
>> +		pr_err("ahci : SATA reg space not mapped, PHY enable failed\n");
>> +		ret = -ENOMEM;
>> +		goto err;
>> +	}
>> +
>> +	ret = clk_enable(omap_sata_clk);
>> +	if (ret) {
>> +		pr_err("ahci : Clock enable failed\n");
>> +		goto err;
>> +	}

As Felipe suggested, pm_runtime is probably the right API for that.
It should even potentially be done in the driver directly since it is a 
generic API and most platform should probably have to enable "something" 
at that time.

Benoit


>> +
>> +	phy_val = SATA_PHY_ENPLL(1) |
>> +			SATA_PHY_MPY(8) |
>> +			SATA_PHY_LB(0) |
>> +			SATA_PHY_CLKBYP(0) |
>> +			SATA_PHY_RXINVPAIR(0) |
>> +			SATA_PHY_LBK(0) |
>> +			SATA_PHY_RXLOS(1) |
>> +			SATA_PHY_RXCDR(4) |
>> +			SATA_PHY_RXEQ(1) |
>> +			SATA_PHY_RXENOC(1) |
>> +			SATA_PHY_TXINVPAIR(0) |
>> +			SATA_PHY_TXCM(0) |
>> +			SATA_PHY_TXSWING(7) |
>> +			SATA_PHY_TXDE(0);
>
> if it's 0, it's same as not even adding them. Please remove the ones
> which are 0.
>
>> +	writel(phy_val, base + SATA_P0PHYCR_REG);
>> +	writel(phy_val, base + SATA_P1PHYCR_REG);
>> +
>> +	return 0;
>> +err:
>> +	clk_put(omap_sata_clk);
>> +	return ret;
>> +}
>> +
>> +static void ti816x_ahci_plat_exit(struct device *dev)
>> +{
>> +	clk_disable(omap_sata_clk);
>> +	clk_put(omap_sata_clk);
>> +}
>> +
>> +/* resources will be filled by soc specific init routine */
>> +static struct resource omap_ahci_resources[] = {
>> +	{
>> +		.flags	= IORESOURCE_MEM,
>> +	},
>> +	{
>> +		.flags	= IORESOURCE_IRQ,
>> +	}
>> +};
>> +
>> +static struct platform_device omap_ahci_device = {
>> +	.name	= "ahci",
>> +	.dev	= {
>> +		.platform_data =&omap_sata_pdata,
>> +		.coherent_dma_mask	= DMA_BIT_MASK(32),
>> +		.dma_mask		=&omap_sata_dmamask,
>> +	},
>> +	.num_resources	= ARRAY_SIZE(omap_ahci_resources),
>> +	.resource	= omap_ahci_resources,
>> +};
>> +
>> +static void ti816x_ahci_init(void)
>> +{
>> +	/* fixup platform device info for TI816X */
>> +	omap_ahci_resources[0].start	= TI816X_SATA_BASE;
>> +	omap_ahci_resources[0].end	= TI816X_SATA_BASE + 0x10fff;
>
> weird resource size... 68k... Ok, anyway.. as long as it's correct :-p
>
>> +	omap_ahci_resources[1].start	= 16; /* SATA IRQ */
>> +	omap_sata_pdata.init		= ti816x_ahci_plat_init;
>> +	omap_sata_pdata.exit		= ti816x_ahci_plat_exit;
>
> why didn't you initialize these when defining the resources ?
>
> you could even drop this function altogether.
>
>> +}
>> +
>> +static inline void omap_init_ahci(void)
>> +{
>> +	if (cpu_is_ti816x()) {
>> +		ti816x_ahci_init();
>> +		platform_device_register(&omap_ahci_device);
>> +	}
>
> this is better the other way around:
>
> 	if (!cpu_is_ti816x())
> 		return;
>
> 	platform_device_register(&omap_ahci_device);
>

