From: Benoit Cousson <b-cousson@ti.com>
Subject: Re: [PATCH v2] ARM: dts: AM33XX: Add usbss node
Date: Tue, 6 Nov 2012 16:32:31 +0100
Message-ID: <50992D8F.1000200@ti.com>
References: <1352212178-8472-1-git-send-email-afzal@ti.com> <20121106142950.GA3056@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:59226 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752116Ab2KFPcy (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 6 Nov 2012 10:32:54 -0500
In-Reply-To: <20121106142950.GA3056@arwen.pp.htv.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: Afzal Mohammed <afzal@ti.com>, Russell King <linux@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>, Rob Herring <rob.herring@calxeda.com>, Vaibhav Hiremath <hvaibhav@ti.com>, AnilKumar Ch <anilkumar@ti.com>, Ravi Babu <ravibabu@ti.com>, Santhapuri Damodar <damodar.santhapuri@ti.com>, Daniel Mack <zonque@gmail.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org

On 11/06/2012 03:29 PM, Felipe Balbi wrote:
> Hi,
> 
> On Tue, Nov 06, 2012 at 07:59:38PM +0530, Afzal Mohammed wrote:
>> From: Ajay Kumar Gupta <ajay.gupta@ti.com>
>>
>> Device tree node for usbss on AM33XX. There are two musb
>> controllers on am33xx platform so have port0-mode and
>> port1-mode data.
>>
>> [afzal@ti.com: reg & interrupt property addition]
>>
>> Signed-off-by: Ajay Kumar Gupta <ajay.gupta@ti.com>
>> Signed-off-by: Santhapuri, Damodar <damodar.santhapuri@ti.com>
>> Signed-off-by: Ravi Babu <ravibabu@ti.com>
>> Signed-off-by: Afzal Mohammed <afzal@ti.com>
> 
> to my eyes, this looks ok.
> 
> Reviewed-by: Felipe Balbi <balbi@ti.com>

Thanks Felipe. Patch applied in for_3.8/dts_part2 branch.

Regards,
Benoit

> 
>> ---
>>
>> v2: node named as "usb"
>>
>> Depends on "usb: musb: dsps: dt binding - add resources, example"
>> (https://patchwork.kernel.org/patch/1704691/)
>>
>>  arch/arm/boot/dts/am33xx.dtsi | 17 +++++++++++++++++
>>  1 file changed, 17 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
>> index 5dfd682..20a3f29 100644
>> --- a/arch/arm/boot/dts/am33xx.dtsi
>> +++ b/arch/arm/boot/dts/am33xx.dtsi
>> @@ -321,5 +321,22 @@
>>  			ti,hwmods = "spi1";
>>  			status = "disabled";
>>  		};
>> +
>> +		usb@47400000 {
>> +			compatible = "ti,musb-am33xx";
>> +			reg = <0x47400000 0x1000	/* usbss */
>> +			       0x47401000 0x800		/* musb instance 0 */
>> +			       0x47401800 0x800>;	/* musb instance 1 */
>> +			interrupts = <17		/* usbss */
>> +				      18		/* musb instance 0 */
>> +				      19>;		/* musb instance 1 */
>> +			multipoint = <1>;
>> +			num-eps = <16>;
>> +			ram-bits = <12>;
>> +			port0-mode = <3>;
>> +			port1-mode = <3>;
>> +			power = <250>;
>> +			ti,hwmods = "usb_otg_hs";
>> +		};
>>  	};
>>  };
>> -- 
>> 1.7.12
>>
> 

