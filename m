From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCHv2 2/3] EDAC: ti: add support for TI keystone and DRA7xx
 EDAC
Date: Sat, 11 Nov 2017 11:46:50 +0100
Message-ID: <20171111104650.ypcfvo4lzfvn5jzv@pd.tnic>
References: <1510087139-21885-2-git-send-email-t-kristo@ti.com>
 <1510302337-31663-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1510302337-31663-1-git-send-email-t-kristo@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, tony@atomide.com, ssantosh@kernel.org, mchehab@kernel.org, linux-arm-kernel@lists.infradead.org, linux-edac@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Fri, Nov 10, 2017 at 10:25:37AM +0200, Tero Kristo wrote:
> TI Keystone and DRA7xx SoCs have support for EDAC on DDR3 memory that can
> correct one bit errors and detect two bit errors. Add EDAC driver for this
> feature which plugs into the generic kernel EDAC framework.

...

> +static int ti_edac_probe(struct platform_device *pdev)
> +{
> +	int error_irq = 0, ret = -ENODEV;
> +	struct device *dev = &pdev->dev;
> +	struct resource *res;
> +	void __iomem *reg;
> +	struct mem_ctl_info *mci;
> +	struct edac_mc_layer layers[1];
> +	const struct of_device_id *id;
> +	struct ti_edac *edac;
> +	int my_id;
> +
> +	id = of_match_device(ti_edac_of_match, &pdev->dev);
> +	if (!id)
> +		return -ENODEV;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	reg = devm_ioremap_resource(dev, res);
> +	if (IS_ERR(reg)) {
> +		edac_printk(KERN_ERR, EDAC_MOD_NAME,
> +			    "EMIF controller regs not defined\n");
> +		return PTR_ERR(reg);
> +	}
> +
> +	layers[0].type = EDAC_MC_LAYER_ALL_MEM;
> +	layers[0].size = 1;
> +
> +	/* Allocate ID number for our EMIF controller */
> +	my_id = atomic_inc_return(&edac_id) - 1;

You can do ATOMIC_INIT(-1) and then you don't need that silly - 1.

But there's something else wrong with this ID generation:

> +
> +	mci = edac_mc_alloc(my_id, 1, layers, sizeof(*edac));
> +	if (!mci)
> +		return -ENOMEM;

<--- if you return here due to error, the next one which succeeds will
get the next number and you'd have a hole in the numbering and wonder
where did instance 0 go.

So I'm wondering if instead you could derive the ID from some controller
registers which are specific to the instance. Or some hardware detail
which is instance-specific.

In my driver, for example, the 0th instance has PCI device functions
00:18.x which is node 0, then node 1 has 00:19.x and so on, and this is
a stable numbering. If you could do that for your hw you'll be able to
pinpoint which instance and which DIMMs we're talking about reliably.

> +
> +	mci->pdev = &pdev->dev;
> +	edac = mci->pvt_info;
> +	edac->reg = reg;
> +	platform_set_drvdata(pdev, mci);
> +
> +	mci->mtype_cap = MEM_FLAG_DDR3 | MEM_FLAG_DDR2;
> +	mci->edac_ctl_cap = EDAC_FLAG_SECDED | EDAC_FLAG_NONE;
> +	mci->mod_name = EDAC_MOD_NAME;
> +	mci->ctl_name = id->compatible;
> +	mci->dev_name = dev_name(&pdev->dev);
> +
> +	/* Setup memory layout */
> +	ti_edac_setup_dimm(mci, (u32)(id->data));
> +
> +	ret = edac_mc_add_mc(mci);

Do that...

> +	if (ret) {
> +		edac_printk(KERN_ERR, EDAC_MOD_NAME,
> +			    "Failed to register mci: %d.\n", ret);
> +		goto err;
> +	}
> +
> +	/* add EMIF ECC error handler */
> +	error_irq = platform_get_irq(pdev, 0);
> +	if (!error_irq) {
> +		edac_printk(KERN_ERR, EDAC_MOD_NAME,
> +			    "EMIF irq number not defined.\n");
> +		goto err2;
> +	}
> +
> +	ret = devm_request_irq(dev, error_irq, ti_edac_isr, 0,
> +			       "emif-edac-irq", mci);
> +	if (ret) {
> +		edac_printk(KERN_ERR, EDAC_MOD_NAME,
> +			    "request_irq fail for EMIF EDAC irq\n");
> +		goto err2;
> +	}

... here, after you've requested IRQs successfully and you can save
yourself the err2 error path.

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
