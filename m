From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2 5/5] regulator: map consumer regulator based on device
	tree
Date: Mon, 10 Oct 2011 18:35:07 +0100
Message-ID: <20111010173506.GH3607@opensource.wolfsonmicro.com>
References: <1318263578-7407-1-git-send-email-rnayak@ti.com>
	<1318263578-7407-6-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1318263578-7407-6-git-send-email-rnayak@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: b-cousson@ti.com, patches@linaro.org, tony@atomide.com, devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org, grant.likely@secretlab.ca, linux-omap@vger.kernel.org, lrg@ti.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Mon, Oct 10, 2011 at 09:49:38PM +0530, Rajendra Nayak wrote:

> Device nodes in DT can associate themselves with one or more
> regulators/supply by providing a list of phandles (to regulator nodes)
> and corresponding supply names.

Mostly looks good.

> +/**
> + * of_get_regulator - get a regulator device node based on supply name
> + * @dev: Device pointer for the consumer (of regulator) device
> + * @supply: regulator supply name
> + *
> + * Extract the regulator device node corresponding to the supply name.
> + * retruns the device node corresponding to the regulator if found, else
> + * returns NULL.
> + */
> +struct device_node *of_get_regulator(struct device *dev, const char *supply)
> +{

Should be static.

> @@ -1178,6 +1225,10 @@ static struct regulator *_regulator_get(struct device *dev, const char *id,
>  			goto found;
>  		}
>  	}
> +	if (!dev)
> +		list_for_each_entry(rdev, &regulator_list, list)
> +			if (strcmp(rdev_get_name(rdev), id))
> +				goto found;
>  

This looks really strange, we didn't remove any old lookup code and the
DT lookup jumps to found by iself so why are we adding code here?

> +	if (supply) {
> +		struct regulator_dev *r;
> +		struct device_node *node;
> +
> +		/* first do a dt based lookup */
> +		if (dev) {
> +			node = of_get_regulator(dev, supply);
> +			if (node)
> +				list_for_each_entry(r, &regulator_list, list)
> +					if (node == r->dev.parent->of_node)
> +						goto found;
>  		}
>  
> -		if (!found) {
> -			dev_err(dev, "Failed to find supply %s\n",
> -				init_data->supply_regulator);
> -			ret = -ENODEV;
> -			goto scrub;
> -		}
> +		/* next try doing it non-dt way */
> +		list_for_each_entry(r, &regulator_list, list)
> +			if (strcmp(rdev_get_name(r), supply) == 0)
> +				goto found;
>  
> +		dev_err(dev, "Failed to find supply %s\n", supply);
> +		ret = -ENODEV;
> +		goto scrub;
> +
> +found:

This is all getting *really* complicated and illegible.  I'm not sure
what the best way to structure is but erroring out early looks useful.
