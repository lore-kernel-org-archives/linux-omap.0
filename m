From: George Cherian <george.cherian@ti.com>
Subject: Re: [PATCH] arm: dts: AM43x: Add usb_otg_hs node
Date: Mon, 8 Jul 2013 10:50:35 +0530
Message-ID: <51DA4C23.6050604@ti.com>
References: <1372401887-19422-1-git-send-email-george.cherian@ti.com>
 <20130707083558.GA12992@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20130707083558.GA12992@arwen.pp.htv.fi>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: balbi@ti.com
Cc: afzal@ti.com, linux@arm.linux.org.uk, linux-kernel@vger.kernel.org, a-kishore@ti.com, benoit.cousson@linaro.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 7/7/2013 2:05 PM, Felipe Balbi wrote:
> Hi,
>
> On Fri, Jun 28, 2013 at 12:14:47PM +0530, George Cherian wrote:
>> diff --git a/arch/arm/boot/dts/am4372.dtsi b/arch/arm/boot/dts/am4372.dtsi
>> index ddc1df7..e4f5eb8 100644
>> --- a/arch/arm/boot/dts/am4372.dtsi
>> +++ b/arch/arm/boot/dts/am4372.dtsi
>> @@ -64,5 +64,24 @@
>>   			compatible = "ti,am4372-counter32k","ti,omap-counter32k";
>>   			reg = <0x44e86000 0x40>;
>>   		};
>> +
>> +		usb_otg_hs1: am4372_dwc3@48380000 {
>> +			compatible = "ti,am437x-dwc3";
>> +			reg = <0x48380000 0x1ff>;
>> +			interrupts = <GIC_SPI 172 IRQ_TYPE_LEVEL_HIGH>;
>> +			#address-cells = <1>;
>> +			#size-cells = <1>;
>> +			utmi-mode = <1>;
>> +			ranges;
>> +
>> +			dwc3@48390000 {
>> +				compatible = "synopsys,dwc3";
> let's us snps,dwc3. I recently posted a patch converting synopsys to
> snps like all other DesignWare drivers. Support for synopsys,dwc3 is
> still there, but shouldn't be used.
okay
>
>> +				reg = <0x48390000 0xcfff>;
>> +				interrupts = <GIC_SPI  168 IRQ_TYPE_LEVEL_HIGH>;
>> +				tx-fifo-resize;
> is this flag *really* necessary, I asked you and didn't get an answer.
We will not be needing this flag , since each EP has 3K tx fifo size. 
Also given the fact that we will be operating only
in 2.0 mode the default values are only sufficient.
I will re-send the patch with above changes.

Regards,
-George
