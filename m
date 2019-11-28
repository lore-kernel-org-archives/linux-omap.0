From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: [PATCH v7 net-next 06/13] dt-bindings: net: ti: add new cpsw
 switch driver bindings
Date: Thu, 28 Nov 2019 13:55:32 +0200
Message-ID: <9dc06cb7-c875-6fc1-e755-3832e9f39a52@ti.com>
References: <20191119221925.28426-1-grygorii.strashko@ti.com>
 <20191119221925.28426-7-grygorii.strashko@ti.com>
 <CAL_JsqKfWOZeXXxqyKtH98cbccXUoV7djRtxzyoq0hA_qx-bpQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAL_JsqKfWOZeXXxqyKtH98cbccXUoV7djRtxzyoq0hA_qx-bpQ@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh+dt@kernel.org>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc: netdev <netdev@vger.kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, Andrew Lunn <andrew@lunn.ch>, "David S . Miller" <davem@davemloft.net>, Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>, Jiri Pirko <jiri@resnulli.us>, Florian Fainelli <f.fainelli@gmail.com>, Sekhar Nori <nsekhar@ti.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-omap <linux-omap@vger.kernel.org>, Murali Karicheri <m-karicheri2@ti.com>, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi Rob,

On 21/11/2019 21:24, Rob Herring wrote:
> On Tue, Nov 19, 2019 at 4:19 PM Grygorii Strashko
> <grygorii.strashko@ti.com> wrote:
>>
>> Add bindings for the new TI CPSW switch driver. Comparing to the legacy
>> bindings (net/cpsw.txt):
>> - ports definition follows DSA bindings (net/dsa/dsa.txt) and ports can be
>> marked as "disabled" if not physically wired.
>> - all deprecated properties dropped;
>> - all legacy propertiies dropped which represent constant HW cpapbilities
>> (cpdma_channels, ale_entries, bd_ram_size, mac_control, slaves,
>> active_slave)
>> - TI CPTS DT properties are reused as is, but grouped in "cpts" sub-node
>> - TI Davinci MDIO DT bindings are reused as is, because Davinci MDIO is
>> reused.
>>
>> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
>> ---
>>   .../bindings/net/ti,cpsw-switch.yaml          | 240 ++++++++++++++++++
>>   1 file changed, 240 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/net/ti,cpsw-switch.yaml
> 
> I see David has applied this already, but it still has numerous
> problems. Please send a follow-up.
> 
>>
>> diff --git a/Documentation/devicetree/bindings/net/ti,cpsw-switch.yaml b/Documentation/devicetree/bindings/net/ti,cpsw-switch.yaml
>> new file mode 100644
>> index 000000000000..81ae8cafabc1
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/net/ti,cpsw-switch.yaml
>> @@ -0,0 +1,240 @@
>> +# SPDX-License-Identifier: GPL-2.0
> 
> For new bindings, please dual license:
> 
> (GPL-2.0-only OR BSD-2-Clause)
> 
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/net/ti,cpsw-switch.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: TI SoC Ethernet Switch Controller (CPSW) Device Tree Bindings
>> +
>> +maintainers:
>> +  - Grygorii Strashko <grygorii.strashko@ti.com>
>> +  - Sekhar Nori <nsekhar@ti.com>
>> +
>> +description:
>> +  The 3-port switch gigabit ethernet subsystem provides ethernet packet
>> +  communication and can be configured as an ethernet switch. It provides the
>> +  gigabit media independent interface (GMII),reduced gigabit media
>> +  independent interface (RGMII), reduced media independent interface (RMII),
>> +  the management data input output (MDIO) for physical layer device (PHY)
>> +  management.
>> +
>> +properties:
>> +  compatible:
>> +    oneOf:
>> +      - const: ti,cpsw-switch
>> +      - items:
>> +         - const: ti,am335x-cpsw-switch
>> +         - const: ti,cpsw-switch
>> +      - items:
>> +        - const: ti,am4372-cpsw-switch
>> +        - const: ti,cpsw-switch
>> +      - items:
>> +        - const: ti,dra7-cpsw-switch
>> +        - const: ti,cpsw-switch
>> +
>> +  reg:
>> +    maxItems: 1
>> +    description:
>> +       The physical base address and size of full the CPSW module IO range
>> +
>> +  ranges: true
>> +
>> +  clocks:
>> +    maxItems: 1
>> +    description: CPSW functional clock
>> +
>> +  clock-names:
>> +    maxItems: 1
>> +    items:
>> +      - const: fck
>> +
>> +  interrupts:
>> +    items:
>> +      - description: RX_THRESH interrupt
>> +      - description: RX interrupt
>> +      - description: TX interrupt
>> +      - description: MISC interrupt
>> +
>> +  interrupt-names:
>> +    items:
>> +      - const: "rx_thresh"
>> +      - const: "rx"
>> +      - const: "tx"
>> +      - const: "misc"
>> +
>> +  pinctrl-names: true
>> +
>> +  syscon:
>> +    $ref: /schemas/types.yaml#definitions/phandle
>> +    description:
>> +      Phandle to the system control device node which provides access to
>> +      efuse IO range with MAC addresses
> 
> Can't you use nvmem binding for this?
> 
I've sent patch to fix other comments except this one.

About nvmem,I've been thinking about it for a long time already, but in our case
MAC address is encoded in eFuse register in a different way for different SoCs.

So even if I'll try to use nvmem and define some MAC cell:

	efuse: efuse {
		compatible = "...";
		#address-cells = <1>;
		#size-cells = <1>;

		eth_mac: eth_mac@34 {
			reg = <0x34 0x10>;
		};
	};

	portX {
		...
		nvmem-cells = <&eth_mac>;
		nvmem-cell-names = "mac-address";
	};

the of_get_mac_address() will finally call
   nvmem->reg_read(priv, offset, val, bytes);

and at this point nvmem driver will have no knowledge about the type of the cell
(MAC address), so no decoding can not be done and returned mac will be incorrect.

Not sure how to proceed here. One of the ways is to pass cell info in
struct nvmem_device .reg_read()/.reg_write() callbacks, cell name could be use
to perform some actions.

Another thing which need to be considered is - MAC can be assigned per port,
so dev->of_node != port_of_node (and of_get_mac_addr_nvmem() will fail).



-- 
Best regards,
grygorii
