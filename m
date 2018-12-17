From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH 12/16] dt-bindings: remoteproc: ti-pruss: Document
 application node bindings
Date: Mon, 17 Dec 2018 18:03:49 +0200
Message-ID: <5C17C8E5.5050301@ti.com>
References: <1543218769-5507-1-git-send-email-rogerq@ti.com>
 <1543218769-5507-13-git-send-email-rogerq@ti.com>
 <20181211220637.GA32460@bogus>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181211220637.GA32460@bogus>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: ohad@wizery.com, bjorn.andersson@linaro.org, tony@atomide.com, bcousson@baylibre.com, ssantosh@kernel.org, s-anna@ti.com, nsekhar@ti.com, t-kristo@ti.com, nsaulnier@ti.com, jreeder@ti.com, m-karicheri2@ti.com, woods.technical@gmail.com, linux-omap@vger.kernel.org, linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 12/12/18 00:06, Rob Herring wrote:
> On Mon, Nov 26, 2018 at 09:52:45AM +0200, Roger Quadros wrote:
>> From: Tero Kristo <t-kristo@ti.com>
>>
>> Add documentation for the Texas Instruments PRU application nodes.
>> These are used to configure specific user applications for PRU instances.
>>
>> Signed-off-by: Tero Kristo <t-kristo@ti.com>
>> [s-anna@ti.com: some binding updates]
>> Signed-off-by: Suman Anna <s-anna@ti.com>
>> Signed-off-by: Roger Quadros <rogerq@ti.com>
>> ---
>>  .../devicetree/bindings/soc/ti/ti,pruss.txt        | 43 ++++++++++++++++++++++
>>  1 file changed, 43 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/soc/ti/ti,pruss.txt b/Documentation/devicetree/bindings/soc/ti/ti,pruss.txt
>> index 3e5f32f..94c91ee 100644
>> --- a/Documentation/devicetree/bindings/soc/ti/ti,pruss.txt
>> +++ b/Documentation/devicetree/bindings/soc/ti/ti,pruss.txt
>> @@ -210,6 +210,38 @@ used in TI Davinci SoCs. Please refer to the corresponding binding document,
>>  Documentation/devicetree/bindings/net/davinci-mdio.txt for details.
>>  
>>  
>> +Application/User Nodes
>> +=======================
>> +A PRU application/user node typically uses one or more PRU device nodes to
>> +implement a PRU application/functionality. Each application/client node would
>> +need a reference to at least a PRU node, and optionally pass some configuration
>> +parameters.
>> +
>> +Required Properties:
>> +--------------------
>> +- prus                 : phandles to the PRU nodes used
>> +
>> +Optional Properties:
>> +--------------------
>> +- firmware-name        : firmwares for the PRU cores, the default firmware
>> +                         for the core from the PRU node will be used if not
>> +                         provided. The firmware names should correspond to
>> +                         the PRU cores listed in the 'prus' property
>> +- ti,pruss-gp-mux-sel  : array of values for the GP_MUX_SEL under PRUSS_GPCFG
>> +                         register for a PRU. This selects the internal muxing
>> +                         scheme for the PRU instance. If not provided, the
>> +                         default out-of-reset value (0) for the PRU core is
>> +                         used. Values should correspond to the PRU cores listed
>> +                         in the 'prus' property
>> +- ti,pru-interrupt-map : PRU interrupt mappings, containing an array of entries
>> +                         with each entry consisting of 4 cell-values. First one
>> +                         is an index towards the "prus" property to identify the
>> +                         PRU core for the interrupt map, second is the PRU
>> +                         System Event id, third is the PRU interrupt channel id
>> +                         and fourth is the PRU host interrupt id. If provided,
>> +                         this map will supercede any other configuration
>> +                         provided through firmware
> 
> Can't you use 'interrupt-map' or use more cells for the PRU intc cells. 
> Or use interrupts-extended if you need more than 1 parent.
> 

We don't need more then one parent.

Using more cells for PRU INTC sounds like doable. Although we should be able to support
2 formats (i.e. 4 cells when mapping is provided in DT and 1 cell when mapping information
comes from firmware via resource table)

I'm not sure how 'interrupt-map' can be used as we're not really translating between
2 interrupt domains.

>> +
>>  Example:
>>  ========
>>  1.	/* AM33xx PRU-ICSS */
>> @@ -397,3 +429,14 @@ Example:
>>  			...
>>  		};
>>  	};
>> +
>> +3:	/* PRU application node example */
>> +	app_node: app_node {
>> +		prus = <&pru1_0>, <&pru1_1>;
>> +		firmware-name = "pruss-app-fw", "pruss-app-fw-2";
>> +		ti,pruss-gp-mux-sel = <2>, <1>;
>> +		/* setup interrupts for prus:
>> +		   prus[0] => pru1_0: ev=16, chnl=2, host-irq=7,
>> +		   prus[1] => pru1_1: ev=19, chnl=1, host-irq=3 */
>> +		ti,pru-interrupt-map = <0 16 2 7 >, <1 19 1 3>;
>> +	}

cheers,
-roger
-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
