From: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v3 5/6] ARM: dts: omap: update usb_otg_hs data
Date: Fri, 22 Mar 2013 14:50:05 +0530
Message-ID: <514C2245.4080506@ti.com>
References: <1363770725-13717-1-git-send-email-kishon@ti.com>
 <1363770725-13717-6-git-send-email-kishon@ti.com>
 <514A233F.8010105@wwwdotorg.org> <514AA74D.9070506@ti.com>
 <514B3EEF.3080705@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <514B3EEF.3080705-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
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
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, mchehab-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, javier-0uQlZySMnqxg9hUCZPvPmw@public.gmane.org, cesarb-PWySMVKUnqmsTnJN9+BGXg@public.gmane.org, eballetbo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, santosh.shilimkar-l0cyMroinI0@public.gmane.org, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi,

On Thursday 21 March 2013 10:40 PM, Stephen Warren wrote:
> On 03/21/2013 12:23 AM, kishon wrote:
>> Hi,
>>
>> On Thursday 21 March 2013 02:29 AM, Stephen Warren wrote:
>>> On 03/20/2013 03:12 AM, Kishon Vijay Abraham I wrote:
>>>> Updated the usb_otg_hs dt data to include the *phy* and *phy-names*
>>>> binding in order for the driver to use the new generic PHY framework.
>>>> Also updated the Documentation to include the binding information.
>>>
>>>> diff --git a/Documentation/devicetree/bindings/usb/omap-usb.txt
>>>> b/Documentation/devicetree/bindings/usb/omap-usb.txt
>>>> index abce256..3d6f9f6 100644
>>>> --- a/Documentation/devicetree/bindings/usb/omap-usb.txt
>>>> +++ b/Documentation/devicetree/bindings/usb/omap-usb.txt
>>>> @@ -19,6 +19,9 @@ OMAP MUSB GLUE
>>>>     - power : Should be "50". This signifies the controller can supply
>>>> upto
>>>>       100mA when operating in host mode.
>>>>     - usb-phy : the phandle for the PHY device
>>>> + - phy : the phandle for the PHY device (used by generic PHY framework)
>>>> + - phy-names : the names of the PHY corresponding to the PHYs
>>>> present in the
>>>> +   *phy* phandle.
>>>
>>> If the intent is for those properties to be generic and used by any DT
>>> binding that refers to a PHY node, I think you'd want to define those
>>> properties in e.g. Documentation/devicetree/bindings/phy/phy.txt, just
>>> like common clock/GPIO/... properties are defined in standalone common
>>> files.
>>
>> Ok. Will add it.
>>>
>>> I think you want to require that DT nodes that represent PHYs have a
>>> #phy-cells property, and that the format of the phy property be
>>> <&phy_phandle phy_specifier*>, where #phy-cells in the referenced node
>>> defines how many cells are part of phy_specifier*, just like (almost)
>>> any other DT property that references another node by phandle. That way,
>>> if a single DT node represents a HW block that implements e.g. 3 PHYs,
>>> it can use #phy-cells = <1>, and the referencing phy property can
>>> include a cell that indicates which of those 3 PHYs is being referenced.
>>
>> Currently, if a single phandle have reference to multiple PHYs, we can
>> get PHY by passing index or by name as give in phy-names.
>> I'm not sure if we have <&phy_phandle phy_specifier*>, what could that
>> phy_specifier be? Maybe phy_type?
>
> I'm not talking about the case where a consumer node references multiple
> PHYs. As you say, that is indeed handled by the driver looking at a
> particular index in the phys property, or using phy-names.
>
> I'm talking about the case where a single provider provides multiple
> PHYs. For example, consider:
>
> phys: phy {
>      compatible = "xxx";
>      reg = <...>;
>      #phy-cells = <1>;
> };
>
> That node describes an IP block that implements 3 different PHYs. The
> registers are inter-mixed in such a way that you can't split it into 3
> separate nodes each with a separate device instance. If the consumers
> simply say:
>
> phys = <&phys>;
>
> then which of the 3 PHYs are you referring to?
>
> Instead, the consumer needs to say one of:
>
> phys = <&phys 0>;
> phys = <&phys 1>;
> phys = <&phys 2>;
>
> in order to specify which of the PHYs it refers to.
>
> The number of cells in the phy property after the phandle is specified
> by the #phy-cells property in the node referred to by the phandle. The
> meaning of all those cells is defined by the binding for the phy node.
> This could include both the PHY ID (as in my example here), or whatever
> configuration information or flags the provider needs. For example, both
> GPIOs and interrupts have specifiers than describe both of these things.

Thanks for the explanation. I'll add it in my next version.
>
> For more background, take a look at almost any other binding that uses
> phandles.
>
> By the way, the property in the consumer should probably be "phys" not
> "phy" to be consistent with other similar properties (e.g. gpios,
> interrupts, ... which are all plural).
>
Ok.

Thanks
Kishon
