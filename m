From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH] ARM: dts: omap3-ldp: fix mmc configuration
Date: Tue, 4 Feb 2014 09:16:29 -0600
Message-ID: <52F1044D.2020004@ti.com>
References: <1390260873-22354-1-git-send-email-nm@ti.com>
 <52F0E109.30801@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <52F0E109.30801@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Balaji T K <balajitk@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, =?ISO-8859-1?Q?Beno=EEt_Cousson?= <bcousson@baylibre.com>
List-Id: linux-omap@vger.kernel.org

On 02/04/2014 06:46 AM, Balaji T K wrote:
> On Tuesday 21 January 2014 05:04 AM, Nishanth Menon wrote:
>> MMC1 is the only MMC interface available on the platform. Further,
>> since the platform is based on older revision of SoC which is not
>> capable of doing multi-block writes, mark it so and add pinmux
> 
> s/writes/read
arrgh.. yes.

> 
> Thanks and Regards,
> Balaji T K
> 
>> to ensure that all relevant pins are configured for non-MMC boot
>> mode.
>>
>> Signed-off-by: Nishanth Menon <nm@ti.com>
>> ---
>> ti,erratum-2.1.1.128 introduced in https://patchwork.kernel.org/patch/3514851/
>> hence depends on the same.
>>   arch/arm/boot/dts/omap3-ldp.dts |   22 ++++++++++++++++++++++
>>   1 file changed, 22 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/omap3-ldp.dts b/arch/arm/boot/dts/omap3-ldp.dts
>> index ddce0d8..bc0cc66 100644
>> --- a/arch/arm/boot/dts/omap3-ldp.dts
>> +++ b/arch/arm/boot/dts/omap3-ldp.dts
>> @@ -176,6 +176,17 @@
>>   &mmc1 {
>>   	vmmc-supply = <&vmmc1>;
>>   	bus-width = <4>;
>> +	ti,erratum-2.1.1.128;
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&mmc1_pins>;
>> +};
>> +
>> +&mmc2 {
>> +	status="disabled";
>> +};
>> +
>> +&mmc3 {
>> +	status="disabled";
>>   };
>>
>>   &omap3_pmx_core {
>> @@ -209,6 +220,17 @@
>>   			0x174 (PIN_OUTPUT | MUX_MODE0)	/* hsusb0_stp.hsusb0_stp */
>>   		>;
>>   	};
>> +
>> +	mmc1_pins: pinmux_mmc1_pins {
>> +		pinctrl-single,pins = <
>> +			OMAP3_CORE1_IOPAD(0x2144, PIN_INPUT_PULLUP | MUX_MODE0)	/* mmc1_clk.mmc1_clk */
>> +			OMAP3_CORE1_IOPAD(0x2146, PIN_INPUT_PULLUP | MUX_MODE0)	/* mmc1_cmd.mmc1_cmd */
>> +			OMAP3_CORE1_IOPAD(0x2148, PIN_INPUT_PULLUP | MUX_MODE0)	/* mmc1_dat0.mmc1_dat0 */
>> +			OMAP3_CORE1_IOPAD(0x214A, PIN_INPUT_PULLUP | MUX_MODE0)	/* mmc1_dat1.mmc1_dat1 */
>> +			OMAP3_CORE1_IOPAD(0x214C, PIN_INPUT_PULLUP | MUX_MODE0)	/* mmc1_dat2.mmc1_dat2 */
>> +			OMAP3_CORE1_IOPAD(0x214e, PIN_INPUT_PULLUP | MUX_MODE0)	/* mmc1_dat3.mmc1_dat3 */
>> +		>;
>> +	};
>>   };
>>
>>   &usb_otg_hs {
>>
> 


-- 
Regards,
Nishanth Menon
