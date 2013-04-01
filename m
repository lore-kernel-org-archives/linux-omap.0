From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: Re: [PATCH v4 1/6] drivers: phy: add generic PHY framework
Date: Mon, 01 Apr 2013 16:38:40 -0600
Message-ID: <515A0C70.90201@wwwdotorg.org>
References: <1364449408-9510-1-git-send-email-kishon@ti.com>
 <1364449408-9510-2-git-send-email-kishon@ti.com> <515A09D8.7040703@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <515A09D8.7040703-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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
To: Sylwester Nawrocki <sylvester.nawrocki-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, mchehab-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>, javier-0uQlZySMnqxg9hUCZPvPmw@public.gmane.org, cesarb-PWySMVKUnqmsTnJN9+BGXg@public.gmane.org, eballetbo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, santosh.shilimkar-l0cyMroinI0@public.gmane.org, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 04/01/2013 04:27 PM, Sylwester Nawrocki wrote:
> On 03/28/2013 06:43 AM, Kishon Vijay Abraham I wrote:
>> diff --git a/Documentation/devicetree/bindings/phy/phy-bindings.txt

>> +example2:
>> +phys: phy {
>> +    compatible = "xxx";
>> +    reg =<...>;
>> +    .
>> +    .
>> +    phys =<&phys 1>;
>> +    .
>> +    .
>> +};
>> +
>> +This node represents a controller that uses one of the PHYs which is defined
>> +previously. Note that the phy handle has an additional specifier "1" to
>> +differentiate between the three PHYs. For this case, the controller driver
>> +should use of_phy_get_with_args/devm_of_phy_get_with_args.
> 
> This means a PHY user needs to know indexes at the PHY driver ?

The client node's DT has to specify which of the provider's PHYs it
references, yes. Presumably the device driver for the client node knows
absolutely nothing about this.

> I have been thinking of using this for an IP which has 4 video PHYs: 2 MIPI
> CSI-2 and 2 MIPI DSI. The IP has just 2 registers, each of which is shared
> between one MIPI CSI-2 DPHY and one MIPI DSI DPHY. So I thought about creating
> a single device node for this IP and using 4 indexes for the PHYs, e.g. 0...3.

That sounds right.

> Then users of each PHY type would use only indexes 0..1 (to select their
> corresponding port).

I don't follow that. If the provider exports PHYs 0..3, then the client
nodes would refer to PHYS 0..3 not 0..1.

> However I fail to see how this could now be represented in the bindings.

Exactly like the example you gave below, I would expect.

> I assume struct phy::type could be used to differentiate between CSI-2 and DSI.
> And struct phy::port could be used to select specific CSI-2 or DSI channel
> (0, 1). Ideally the phy users should not care about index of a PHY at the PHY
> device tree node. E.g. there are 2 MIPI CSI-2 receivers and each has only
> one PHY assigned to it. I'm just wondering how the binding should look like,
> so a PHY could be associated with a receiver automatically by the phy-core,
> e.g.

Details such as phy::type and phy::port sounds like internal driver
implementation details which would have no effect on the bindings.

> /* DPHY IP node */
> video-phy {
>       reg = <0x10000000 8>;
> };
> 
> /* MIPI DSI nodes */
> dsi_0 {
>      phys = <&video-phy 0>;
> };
> 
> dsi_1 {
>      phys = <&video-phy 1>;
> };
> 
> /* MIPI CSI-2 nodes */
> csi_0 {
>      phys = <&video-phy 2>;
> };
> 
> csi_1 {
>      phys = <&video-phy 3>;
> };

That looks correct to me.

> I'm not sure if it is not an overkill to use this the PHY framework with
> a device which has only 2 registers. Perhaps something less heavy could
> be designed for it. However, if the PHY framework is commonly used there
> should be no issue wrt enabling the whole big infrastructure for a simple
> device like this.

I don't think the number of registers should really makes any
difference; the whole point of the PHY framework is to decouple to
providers and consumers, so doing anything custom for special cases
would completely destroy the ability of the PHY framework to do that.
