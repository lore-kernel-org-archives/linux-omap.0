From: Lokesh Vutla <lokeshvutla@ti.com>
Subject: Re: [PATCH 3/3] ARM: dts: AM33xx: Add RNG node
Date: Wed, 7 Aug 2013 11:47:01 +0530
Message-ID: <5201E65D.8070906@ti.com>
References: <1375777984-6267-1-git-send-email-lokeshvutla@ti.com>
 <1375777984-6267-4-git-send-email-lokeshvutla@ti.com>
 <CA+Bv8XZ0SqtCJQszrpVcRuksJU+GNBoJD7FaP+NuQrbshnnBpg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CA+Bv8XZ0SqtCJQszrpVcRuksJU+GNBoJD7FaP+NuQrbshnnBpg@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Russ Dill <Russ.Dill@ti.com>
Cc: devicetree@vger.kernel.org, paul@pwsan.com, tony@atomide.com, rnayak@ti.com, rob@landley.net, benoit.cousson@linaro.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Tuesday 06 August 2013 11:47 PM, Russ Dill wrote:
> On Tue, Aug 6, 2013 at 1:33 AM, Lokesh Vutla <lokeshvutla@ti.com> wrote:
>> Add the generic AM33xx RNG module's device tree data and
>> enable it for the am335x-evm, am335x-evmsk, and am335x-bone
>> platforms.  Also add Documentation file describing the data
>> for the RNG module.
>>
>> Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
>> ---
>>  .../devicetree/bindings/hwrng/omap_rng.txt         |   22 ++++++++++++++++++++
>>  arch/arm/boot/dts/am335x-bone.dts                  |    4 ++++
>>  arch/arm/boot/dts/am335x-evm.dts                   |    4 ++++
>>  arch/arm/boot/dts/am335x-evmsk.dts                 |    4 ++++
>>  arch/arm/boot/dts/am33xx.dtsi                      |    8 +++++++
>>  5 files changed, 42 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/hwrng/omap_rng.txt
>>
>> diff --git a/Documentation/devicetree/bindings/hwrng/omap_rng.txt b/Documentation/devicetree/bindings/hwrng/omap_rng.txt
>> new file mode 100644
>> index 0000000..6a62acd
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/hwrng/omap_rng.txt
>> @@ -0,0 +1,22 @@
>> +OMAP SoC HWRNG Module
>> +
>> +Required properties:
>> +
>> +- compatible : Should contain entries for this and backward compatible
>> +  RNG versions:
>> +  - "ti,omap2-rng" for OMAP2.
>> +  - "ti,omap4-rng" for OMAP4, OMAP5 and AM33XX.
>> +  Note that these two versions are incompatible.
>> +- ti,hwmods: Name of the hwmod associated with the RNG module
>> +- reg : Offset and length of the register set for the module
>> +- interrupts : the interrupt number for the RNG module.
>> +               Only used for "ti,omap4-rng".
>> +
>> +Example:
>> +/* AM335x */
>> +rng: rng@48310000 {
>> +       compatible = "ti,omap4-rng";
>> +       ti,hwmods = "rng";
>> +       reg = <0x48310000 0x2000>;
>> +       interrupts = <111>;
>> +};
>> diff --git a/arch/arm/boot/dts/am335x-bone.dts b/arch/arm/boot/dts/am335x-bone.dts
>> index 444b4ed..46a3887 100644
>> --- a/arch/arm/boot/dts/am335x-bone.dts
>> +++ b/arch/arm/boot/dts/am335x-bone.dts
>> @@ -234,3 +234,7 @@
>>         pinctrl-0 = <&davinci_mdio_default>;
>>         pinctrl-1 = <&davinci_mdio_sleep>;
>>  };
>> +
>> +&rng {
>> +       status = "okay";
>> +};
>> diff --git a/arch/arm/boot/dts/am335x-evm.dts b/arch/arm/boot/dts/am335x-evm.dts
>> index 3aee1a4..ebfbebe1 100644
>> --- a/arch/arm/boot/dts/am335x-evm.dts
>> +++ b/arch/arm/boot/dts/am335x-evm.dts
>> @@ -488,3 +488,7 @@
>>                 ti,adc-channels = <4 5 6 7>;
>>         };
>>  };
>> +
>> +&rng {
>> +       status = "okay";
>> +};
>> diff --git a/arch/arm/boot/dts/am335x-evmsk.dts b/arch/arm/boot/dts/am335x-evmsk.dts
>> index 0c8ad17..6610a05 100644
>> --- a/arch/arm/boot/dts/am335x-evmsk.dts
>> +++ b/arch/arm/boot/dts/am335x-evmsk.dts
>> @@ -402,3 +402,7 @@
>>         phy_id = <&davinci_mdio>, <1>;
>>         phy-mode = "rgmii-txid";
>>  };
>> +
>> +&rng {
>> +       status = "okay";
>> +};
>> diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
>> index 38b446b..b1e6205 100644
>> --- a/arch/arm/boot/dts/am33xx.dtsi
>> +++ b/arch/arm/boot/dts/am33xx.dtsi
>> @@ -530,5 +530,13 @@
>>                         #size-cells = <1>;
>>                         status = "disabled";
>>                 };
>> +
>> +               rng: rng@48310000 {
>> +                       compatible = "ti,omap4-rng";
>> +                       ti,hwmods = "rng";
>> +                       reg = <0x48310000 0x2000>;
>> +                       interrupts = <111>;
>> +                       status = "disabled";
> 
> Is there any point in making this default to "disabled"? Are there any
> am335x platforms where the trng doesn't function?
Yes, you are correct. Just followed how aes and sha are done.
ll update and send a v2.

Thanks and regards,
Lokesh
> 
>> +               };
>>         };
>>  };
>> --
>> 1.7.9.5
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
