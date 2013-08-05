From: Afzal Mohammed <afzal@ti.com>
Subject: Re: [PATCH 2/2] ARM: dts: AM4372: add few nodes
Date: Mon, 5 Aug 2013 10:38:45 +0530
Message-ID: <51FF335D.4050803@ti.com>
References: <ffa2f76fcac54bfe76c234ffce0394fd2c25fe52.1375450395.git.afzal@ti.com> <6f0f838176ab93aac8dab4c3ab9d9f95a3027ff7.1375450395.git.afzal@ti.com> <51FCEE60.7080809@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:45494 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752075Ab3HEFJ3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 5 Aug 2013 01:09:29 -0400
In-Reply-To: <51FCEE60.7080809@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mugunthan V N <mugunthanvnm@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, Rob Herring <rob.herring@calxeda.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, Ian Campbell <ian.campbell@citrix.com>, Russell King <linux@arm.linux.org.uk>, Benoit Cousson <benoit.cousson@linaro.org>, benoit.cousson@gmail.com, Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>

Hi Muguthan,

On Saturday 03 August 2013 05:19 PM, Mugunthan V N wrote:
> On 8/2/2013 7:16 PM, Afzal Mohammed wrote:

>> +		mac: ethernet@4a100000 {
>> +			compatible = "ti,am4372-cpsw","ti,cpsw";

> compatibility "ti,am4372-cpsw" is not needed as driver has only "ti,cpsw"
> compatibility

No, please read device tree documentation [1].

DT is a pure hardware description, it does not depend on driver, 
dependency is only vice versa.

>> +			reg = <0x4a100000 0x800
>> +			       0x4a101200 0x100>;
>> +			interrupts = <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH
>> +				      GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH
>> +				      GIC_SPI 42 IRQ_TYPE_LEVEL_HIGH
>> +				      GIC_SPI 43 IRQ_TYPE_LEVEL_HIGH>;
>> +			ti,hwmods = "cpgmac0";
>> +			status = "disabled";
>> +		};

> There are many other parameters which are missed here.

Reason has been mentioned in the commit message, quoting relevant here 
again,

 >> For i2c, spi, cpsw & pwm - only the properties that were sure to be
 >> correct has been added (main intention is to make hwmod happy and
 >> avoid any later modification to here added properties).

I really wanted to avoid a later patch that has a line starting with 
minus on DTS.

Since you are working on cpsw support, can you help here with a patch 
for other properties.

Regards
Afzal

[1] 
http://devicetree.org/Device_Tree_Usage#Understanding_the_compatible_Property
