From: Benoit Cousson <b-cousson@ti.com>
Subject: Re: [PATCH v3 1/8] ARM/dts: omap2: Add McBSP entries for OMAP2420
 and OMAP2430 SoC
Date: Mon, 10 Sep 2012 10:07:24 +0200
Message-ID: <504D9FBC.9030609@ti.com>
References: <1346846336-27321-1-git-send-email-peter.ujfalusi@ti.com> <1346846336-27321-2-git-send-email-peter.ujfalusi@ti.com> <20120907222953.GS1303@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:46252 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753136Ab2IJIHt (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 10 Sep 2012 04:07:49 -0400
In-Reply-To: <20120907222953.GS1303@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org

Hi Tony,

On 09/08/2012 12:29 AM, Tony Lindgren wrote:
> * Peter Ujfalusi <peter.ujfalusi@ti.com> [120905 04:59]:
>> +
>> +	ocp {
>> +		mcbsp1: mcbsp@48074000 {
>> +			compatible = "ti,omap2420-mcbsp";
>> +			reg = <0x48074000 0xff>;
>> +			reg-names = "mpu";
>> +			interrupts = <59>, /* TX interrupt */
>> +				     <60>; /* RX interrupt */
>> +			interrupt-names = "tx", "rx";
>> +			interrupt-parent = <&intc>;
>> +			ti,hwmods = "mcbsp1";
>> +		};
>> +
>> +		mcbsp2: mcbsp@48076000 {
>> +			compatible = "ti,omap2420-mcbsp";
>> +			reg = <0x48076000 0xff>;
>> +			reg-names = "mpu";
>> +			interrupts = <62>, /* TX interrupt */
>> +				     <63>; /* RX interrupt */
>> +			interrupt-names = "tx", "rx";
>> +			interrupt-parent = <&intc>;
>> +			ti,hwmods = "mcbsp2";
>> +		};
>> +	};
> 
> Hmm don't you need to specify the interrupt chip and offset for
> the interrupts here?

Mmm, I'm not sure to get your question, there is the link to the
interrupt-parent.

The interrupt number is relative to the parent interrupt domain. So even
if the INTC IRQ offset start at 32 instead of 0, DT IRQ mechanism will
convert that to the proper hwirq thanks to irqdomain.
In that case we should always provide interrupt number relative to the
interrupt controller HW number and not assuming any Linux IRQ number
offset like before.


And in fact the interrupt-parent is not even needed, by default if will
look to the parent to get the interrupt-controller.

Extract from [1]

interrupt-parent:
"Because the hierarchy of the nodes in the interrupt tree might not
match the device tree, the interrupt-parent property is available to
make the definition of an interrupt parent explicit.
The value is the phandle to the interrupt parent. If this property is
missing from a device, its interrupt parent is assumed to be its device
tree parent."

[1] http://www.power.org/resources/downloads/Power_ePAPR_APPROVED_v1.0.pdf

Regards,
Benoit

