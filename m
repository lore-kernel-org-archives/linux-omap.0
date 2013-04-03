From: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v4 1/6] drivers: phy: add generic PHY framework
Date: Wed, 3 Apr 2013 11:02:39 +0530
Message-ID: <515BBEF7.2030404@ti.com>
References: <1364449408-9510-1-git-send-email-kishon@ti.com>
 <1364449408-9510-2-git-send-email-kishon@ti.com>
 <5154658A.3080209@wwwdotorg.org> <515A98B3.7090405@ti.com>
 <515AFC06.8000502@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <515AFC06.8000502-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
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

On Tuesday 02 April 2013 09:10 PM, Stephen Warren wrote:
> On 04/02/2013 02:37 AM, Kishon Vijay Abraham I wrote:
>> Hi,
>>
>> On Thursday 28 March 2013 09:15 PM, Stephen Warren wrote:
>>> On 03/27/2013 11:43 PM, Kishon Vijay Abraham I wrote:
>>>> The PHY framework provides a set of APIs for the PHY drivers to
>>>> create/destroy a PHY and APIs for the PHY users to obtain a reference
>>>> to the
>>>
>>>> diff --git a/Documentation/devicetree/bindings/phy/phy-bindings.txt
>
>>>> +PHY subsystem refer Documentation/phy.txt
>>>> +
>>>> +PHY device node
>>>> +===============
>>>> +
>>>> +Optional Properties:
>>>> +#phy-cells:    Number of cells in a PHY specifier;  The meaning of all those
>>>> +        cells is defined by the binding for the phy node. However
>>>> +        in-order to return the correct PHY, the PHY susbsystem
>>>> +        requires the first cell always refers to the port.
>>>
>>> Why impose that restriction? Other DT bindings do not.
>>>
>>> This is typically implemented by having each provider driver implement a
>>> .of_xlate() operation, which parses all of the specifier cells, and
>>> returns the ID of the object it represents. This allows bindings to use
>>> whatever arbitrary representation they want.
>>
>> Do you mean something like this
>>
>> struct phy *of_phy_get(struct device *dev, int index)
>> {
>>      struct phy *phy = NULL;
>>      struct phy_bind *phy_map = NULL;
>>      struct of_phandle_args args;
>>      struct device_node *node;
>>
>>      if (!dev->of_node) {
>>          dev_dbg(dev, "device does not have a device node entry\n");
>>          return ERR_PTR(-EINVAL);
>>      }
>>
>>      ret = of_parse_phandle_with_args(dev->of_node, "phys", "#phy-cells",
>>          index, &args);
>>      if (ret) {
>>          dev_dbg(dev, "failed to get phy in %s node\n",
>>              dev->of_node->full_name);
>>          return ERR_PTR(-ENODEV);
>>      }
>
> Looks good.
>
>> //Here we have to get a reference to the phy in order to call of_xlate
>> which seems a little hacky to me. I'm not sure how else can we call the
>> provider driver :-(
>>      phy = of_phy_lookup(dev, node);
>>      if (IS_ERR(phy) || !try_module_get(phy->ops->owner)) {
>>          phy = ERR_PTR(-EPROBE_DEFER);
>>          goto err0;
>>      }
>
> I think the concept of a "PHY provider" and a "PHY instance" are different.
>
> of_xlate should be called on a "PHY provider", and return a "PHY
> instance". Hence, above you want to only look up a "PHY provider", so
> there's no hackiness involved.

Cool. That makes it a lot clearer.

Thanks
Kishon
