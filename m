From: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v4 1/6] drivers: phy: add generic PHY framework
Date: Tue, 2 Apr 2013 14:07:07 +0530
Message-ID: <515A98B3.7090405@ti.com>
References: <1364449408-9510-1-git-send-email-kishon@ti.com>
 <1364449408-9510-2-git-send-email-kishon@ti.com>
 <5154658A.3080209@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <5154658A.3080209-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, mchehab-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, javier-0uQlZySMnqxg9hUCZPvPmw@public.gmane.org, cesarb-PWySMVKUnqmsTnJN9+BGXg@public.gmane.org, eballetbo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, sylvester.nawrocki-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, santosh.shilimkar-l0cyMroinI0@public.gmane.org, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi,

On Thursday 28 March 2013 09:15 PM, Stephen Warren wrote:
> On 03/27/2013 11:43 PM, Kishon Vijay Abraham I wrote:
>> The PHY framework provides a set of APIs for the PHY drivers to
>> create/destroy a PHY and APIs for the PHY users to obtain a reference to the
>
>> diff --git a/Documentation/devicetree/bindings/phy/phy-bindings.txt b/Documentation/devicetree/bindings/phy/phy-bindings.txt
>
>> +This document explains only the dt data binding. For general information about
>> +PHY subsystem refer Documentation/phy.txt
>> +
>> +PHY device node
>> +===============
>> +
>> +Optional Properties:
>> +#phy-cells:	Number of cells in a PHY specifier;  The meaning of all those
>> +		cells is defined by the binding for the phy node. However
>> +		in-order to return the correct PHY, the PHY susbsystem
>> +		requires the first cell always refers to the port.
>
> Why impose that restriction? Other DT bindings do not.
>
> This is typically implemented by having each provider driver implement a
> .of_xlate() operation, which parses all of the specifier cells, and
> returns the ID of the object it represents. This allows bindings to use
> whatever arbitrary representation they want.

Do you mean something like this

struct phy *of_phy_get(struct device *dev, int index)
{
	struct phy *phy = NULL;
	struct phy_bind *phy_map = NULL;
	struct of_phandle_args args;
	struct device_node *node;

	if (!dev->of_node) {
		dev_dbg(dev, "device does not have a device node entry\n");
		return ERR_PTR(-EINVAL);
	}

	ret = of_parse_phandle_with_args(dev->of_node, "phys", "#phy-cells",
		index, &args);
	if (ret) {
		dev_dbg(dev, "failed to get phy in %s node\n",
			dev->of_node->full_name);
		return ERR_PTR(-ENODEV);
	}

//Here we have to get a reference to the phy in order to call of_xlate 
which seems a little hacky to me. I'm not sure how else can we call the 
provider driver :-(
	phy = of_phy_lookup(dev, node);
	if (IS_ERR(phy) || !try_module_get(phy->ops->owner)) {
		phy = ERR_PTR(-EPROBE_DEFER);
		goto err0;
	}

//here we are checking if the phy has additional specifiers and if so 
call of_xlate using the phy we just obtained. The provider driver should 
check the args and return the appropriate *phy in this case.
	if (args.args_count > 0) {
		phy = phy->of_xlate(&args);
		if (IS_ERR(phy))
			goto err0;
	}

	phy_map = phy_bind(dev_name(dev), index, dev_name(&phy->dev));
	if (!IS_ERR(phy_map)) {
		phy_map->phy = phy;
		phy_map->auto_bind = true;
	}

	get_device(&phy->dev);

err0:
	of_node_put(node);

	return phy;
}
EXPORT_SYMBOL_GPL(of_phy_get);
>
> For the common/simple cases where #phy-cells==0, or #phy-cells==1 and
> directly represents the PHY ID, the PHY core can provide an
> implementation of that common .of_xlate() function, which PHY provider
> drivers can simply plug in as their .of_xlate() function.
>
>> +This property is optional because it is needed only for the case where a
>> +single IP implements multiple PHYs.
>
> The property should always exist so that the DT-parsing code in the PHY
> core can always validate exactly how many cells are present in the PHY
> specifier.
>
>> +
>> +For example:
>> +
>> +phys: phy {
>> +    compatible = "xxx";
>> +    reg1 = <...>;
>> +    reg2 = <...>;
>> +    reg3 = <...>;
>
> 3 separate reg values should be 3 separate entries in a single reg
> property, not 3 separate reg properties, with non-standard names.
>
>> +    .
>> +    .
>> +    #phy-cells = <1>;
>> +    .
>> +    .
>> +};
>> +
>> +That node describes an IP block that implements 3 different PHYs. In order to
>> +differentiate between these 3 PHYs, an additonal specifier should be given
>> +while trying to get a reference to it. (The PHY subsystem assumes the
>> +specifier is port id).
>
> A single DT node would typically represent a single HW IP block, and
> hence typically have a single reg property. If there are 3 separate HW
> IP blocks, and their register aren't interleaved, and hence can be
> represented by 3 separate reg values, then I'd typically expect to see 3
> separate DT nodes, one for each independent register range.
>
> The only case where I'd expect a single DT node to provide multipe PHYs,
> is when a single HW IP block actually implements multiple PHYs /and/ the
> registers for those 3 PHYs are interleaved (or share bits in the same
> registers) such that each PHY can't be represented by a separate
> non-overlapping reg property.
>
>> +example1:
>> +phys: phy {
>
> How about:
>
> Example 1:
>
> usb1: usb@xxx {
>
>> +};
>> +This node represents a controller that uses two PHYs one for usb2 and one for
>
> Blank line after }?
>
>> +usb3. The controller driver can get the appropriate PHY either by using
>> +devm_of_phy_get/of_phy_get by passing the correct index or by using
>> +of_phy_get_byname/devm_of_phy_get_byname by passing the names given in
>> +*phy-names*.
>
> Discussions of Linux-specific driver APIs should be in the Linux API
> documentation, not the DT binding documentation, which is supposed to be
> OS-agnostic. Instead, perhaps say:
>
> Individual bindings must specify the required set of entries the phys
> property. Bindings must also specify either a required order for those
> entries in the phys property, or specify required set of names that must
> be present in the phy-names property, in which case the order is arbitrary.
>
>> +example2:
>> +phys: phy {
>
> How about:
>
> Example 2:
>
> usb2: usb@yyy {
>
>> +This node represents a controller that uses one of the PHYs which is defined
>> +previously. Note that the phy handle has an additional specifier "1" to
>> +differentiate between the three PHYs. For this case, the controller driver
>> +should use of_phy_get_with_args/devm_of_phy_get_with_args.
>
> I think tha last sentence should be removed, and perhaps the previous
> sentence extended with:
>
> , as required by #phy-cells = <1> in the PHY provider node.
>
>> diff --git a/drivers/phy/phy-core.c b/drivers/phy/phy-core.c
>
>> +subsys_initcall(phy_core_init);
>
> Why not make that module_init(); device probe() ordering should be
> handled using -EPROBE_DEFER these days, so the exact initcall used
> doesn't really matter, and hence it'd be best to use the most common one
> rather than something unusual.

hmm.. ok.

Thanks
Kishon
