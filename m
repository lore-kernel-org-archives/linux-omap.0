From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH 08/17] ARM: dts: dra7: Add dt node for the sycon pcie
Date: Wed, 24 Jun 2015 18:59:13 +0530
Message-ID: <558AB0A9.5020400@ti.com>
References: <1435060743-5511-1-git-send-email-kishon@ti.com>	<1435060743-5511-9-git-send-email-kishon@ti.com> <20150624145017.9b70a1fba477d8b99ce85702@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150624145017.9b70a1fba477d8b99ce85702@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: bcousson@baylibre.com, tony@atomide.com, balbi@ti.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, linux@arm.linux.org.uk, gregkh@linuxfoundation.org, nsekhar@ti.com
List-Id: linux-omap@vger.kernel.org

Hi,

On Wednesday 24 June 2015 05:20 PM, Roger Quadros wrote:
> On Tue, 23 Jun 2015 17:28:53 +0530
> Kishon Vijay Abraham I <kishon@ti.com> wrote:
> 
>> Add new device tree node for the control module register space where
>> PCIe registers are present.
>>
>> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
>> ---
>>  arch/arm/boot/dts/dra7.dtsi |    5 +++++
>>  1 file changed, 5 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
>> index 260f300..3f434f7 100644
>> --- a/arch/arm/boot/dts/dra7.dtsi
>> +++ b/arch/arm/boot/dts/dra7.dtsi
>> @@ -291,6 +291,11 @@
>>  			reg = <0x4a002e00 0x7c>;
>>  		};
>>  
>> +		dra7_ctrl_pcie: tisyscon@4a003c00 {
>> +			compatible = "syscon";
>> +			reg = <0x4a003c00 0x48>;
>> +		};
>> +
> 
> Why do you need to start from 0x4a003c00?
> CTRL_CORE_PCIESS1_PCS1 is at 0x4a003c24

Actually wanted to have minimum number of syscon dt nodes. So thought even
others can use dra7_ctrl_pcie phandle. But I looked only at dra7_ctrl_core and
dra7_ctrl_general and not scm_conf :-(

Thanks
Kishon
