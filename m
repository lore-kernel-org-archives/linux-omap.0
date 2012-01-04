From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH v2 03/10] mfd: twl-core: Add initial DT support for
 twl4030/twl6030
Date: Wed, 4 Jan 2012 11:12:24 -0700
Message-ID: <20120104181224.GJ15503@ponder.secretlab.ca>
References: <1323439361-1647-1-git-send-email-b-cousson@ti.com>
 <1323439361-1647-4-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1323439361-1647-4-git-send-email-b-cousson-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
To: Benoit Cousson <b-cousson-l0cyMroinI0@public.gmane.org>
Cc: Balaji T K <balajitk-l0cyMroinI0@public.gmane.org>, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, Graeme Gregory <gg-kDsPt+C1G03kYMGBc/C6ZA@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Fri, Dec 09, 2011 at 03:02:34PM +0100, Benoit Cousson wrote:
> Add initial device-tree support for twl familly chips.
> The current version is missing the regulator entries due
> to the lack of DT regulator bindings for the moment.
> Only the simple sub-modules that do not depend on
> platform_data information can be initialized properly.
> 
> Add documentation for the Texas Instruments TWL Integrated Chip.
> 
> Signed-off-by: Benoit Cousson <b-cousson-l0cyMroinI0@public.gmane.org>
> Cc: Balaji T K <balajitk-l0cyMroinI0@public.gmane.org>
> Cc: Graeme Gregory <gg-kDsPt+C1G03kYMGBc/C6ZA@public.gmane.org>
> Cc: Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> ---
>  .../devicetree/bindings/mfd/twl-familly.txt        |   47 +++++++++++++++++
>  drivers/mfd/twl-core.c                             |   53 ++++++++++++++++++--
>  2 files changed, 96 insertions(+), 4 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/mfd/twl-familly.txt
> 
> diff --git a/Documentation/devicetree/bindings/mfd/twl-familly.txt b/Documentation/devicetree/bindings/mfd/twl-familly.txt
> new file mode 100644
> index 0000000..ff4cacd
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/twl-familly.txt
> @@ -0,0 +1,47 @@
> +Texas Instruments TWL family
> +
> +The TWLs are Integrated Power Management Chips.
> +Some version might contain much more analog function like
> +USB transceiver or Audio amplifier.
> +These chips are connected to an i2c bus.
> +
> +
> +Required properties:
> +- compatible : Must be "ti,twl4030";
> +  For Integrated power-management/audio CODEC device used in OMAP3
> +  based boards
> +- compatible : Must be "ti,twl6030";
> +  For Integrated power-management used in OMAP4 based boards
> +- interrupts : This i2c device has an IRQ line connected to the main SoC
> +- interrupt-controller : Since the twl support several interrupts internally,
> +  it is considered as an interrupt controller cascaded to the SoC one.
> +- #interrupt-cells = <1>;
> +- interrupt-parent : The parent interrupt controller.
> +
> +Optional node:
> +- Child nodes contain in the twl. The twl family is made of severals variants
> +  that support a different number of features.
> +  The children nodes will thus depend of the capabilty of the variant.
> +
> +
> +Example:
> +/*
> + * Integrated Power Management Chip
> + * http://www.ti.com/lit/ds/symlink/twl6030.pdf
> + */
> +twl@48 {
> +    compatible = "ti,twl6030";
> +    reg = <0x48>;
> +    interrupts = <39>; /* IRQ_SYS_1N cascaded to gic */
> +    interrupt-controller;
> +    #interrupt-cells = <1>;
> +    interrupt-parent = <&gic>;
> +    #address-cells = <1>;
> +    #size-cells = <0>;
> +
> +    twl_rtc {
> +        compatible = "ti,twl_rtc";
> +        interrupts = <11>;
> +        reg = <0>;
> +    };
> +};
> diff --git a/drivers/mfd/twl-core.c b/drivers/mfd/twl-core.c
> index bfbd660..524d9d8 100644
> --- a/drivers/mfd/twl-core.c
> +++ b/drivers/mfd/twl-core.c
> @@ -34,6 +34,10 @@
>  #include <linux/platform_device.h>
>  #include <linux/clk.h>
>  #include <linux/err.h>
> +#include <linux/slab.h>
> +#include <linux/of_irq.h>
> +#include <linux/of_platform.h>
> +#include <linux/irqdomain.h>
>  
>  #include <linux/regulator/machine.h>
>  
> @@ -1183,22 +1187,53 @@ twl_probe(struct i2c_client *client, const struct i2c_device_id *id)
>  	int				status;
>  	unsigned			i;
>  	struct twl4030_platform_data	*pdata = client->dev.platform_data;
> +	struct device_node		*node = client->dev.of_node;
>  	u8 temp;
>  	int ret = 0;
>  
> +	if (node && !pdata) {
> +		/*
> +		 * XXX: Temporary fake pdata until the information
> +		 * is correctly retrieved by every TWL modules from DT.
> +		 */
> +		pdata = kzalloc(sizeof(struct twl4030_platform_data),
> +				GFP_KERNEL);

devm_kzalloc() so that it gets cleaned up on remove.

> +		if (!pdata) {
> +			status = -ENOMEM;
> +			goto exit;
> +		}
> +
> +		/*
> +		 * XXX: For the moment the IRQs for TWL seems to be encoded in
> +		 * the global OMAP space. That should be cleaned to allow
> +		 * dynamically adding a new IRQ controller.
> +		 */
> +		if ((id->driver_data) & TWL6030_CLASS) {
> +			pdata->irq_base = TWL6030_IRQ_BASE;
> +			pdata->irq_end = pdata->irq_base + TWL6030_BASE_NR_IRQS;
> +		} else {
> +			pdata->irq_base = TWL4030_IRQ_BASE;
> +			pdata->irq_end = pdata->irq_base + TWL4030_BASE_NR_IRQS;
> +		}
> +		irq_domain_add_simple(node, pdata->irq_base);

Yes, you'll want a follow-up patch to convert to dynamically allocated
irqs... but I've got to merge the final irq_domain work first.  :-)

Acked-by: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>

> +	}
> +
>  	if (!pdata) {
>  		dev_dbg(&client->dev, "no platform data?\n");
> -		return -EINVAL;
> +		status = -EINVAL;
> +		goto fail_free;
>  	}
>  
>  	if (i2c_check_functionality(client->adapter, I2C_FUNC_I2C) == 0) {
>  		dev_dbg(&client->dev, "can't talk I2C?\n");
> -		return -EIO;
> +		status = -EIO;
> +		goto fail_free;
>  	}
>  
>  	if (inuse) {
>  		dev_dbg(&client->dev, "driver is already in use\n");
> -		return -EBUSY;
> +		status = -EBUSY;
> +		goto fail_free;
>  	}
>  
>  	for (i = 0; i < TWL_NUM_SLAVES; i++) {
> @@ -1270,10 +1305,20 @@ twl_probe(struct i2c_client *client, const struct i2c_device_id *id)
>  		twl_i2c_write_u8(TWL4030_MODULE_INTBR, temp, REG_GPPUPDCTR1);
>  	}
>  
> -	status = add_children(pdata, id->driver_data);
> +#ifdef CONFIG_OF_DEVICE
> +	if (node)
> +		status = of_platform_populate(node, NULL, NULL, &client->dev);
> +	else
> +#endif
> +		status = add_children(pdata, id->driver_data);
> +
>  fail:
>  	if (status < 0)
>  		twl_remove(client);
> +fail_free:
> +	if (node)
> +		kfree(pdata);
> +exit:
>  	return status;
>  }
>  
> -- 
> 1.7.0.4
> 
