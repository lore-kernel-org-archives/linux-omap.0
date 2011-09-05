From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH 2/7] arm/dts: OMAP3: Add mpu and iva nodes
Date: Mon, 5 Sep 2011 17:05:11 +0200
Message-ID: <4E64E527.4040409@ti.com>
References: <1314897912-18178-1-git-send-email-b-cousson@ti.com> <1314897912-18178-3-git-send-email-b-cousson@ti.com> <1377915.IaVE5xAurc@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:34361 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753528Ab1IEPF3 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 5 Sep 2011 11:05:29 -0400
In-Reply-To: <1377915.IaVE5xAurc@wuerfel>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "grant.likely@secretlab.ca" <grant.likely@secretlab.ca>, "tony@atomide.com" <tony@atomide.com>, "Hilman, Kevin" <khilman@ti.com>, "G, Manjunath Kondaiah" <manjugk@ti.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi Arnd,

On 9/1/2011 8:17 PM, Arnd Bergmann wrote:
> On Thursday 01 September 2011 19:25:07 Benoit Cousson wrote:
>>
>>          /*
>> +        * XXX: The cpus node is mandatory, but since the CPUs are as well part
>> +        * of the mpu subsystem below, it is not clear where the information
>> +        * should be. Maybe here with a phandle inside the mpu?
>> +        */
>> +       cpus {
>> +       };
>> +
>> +       /*
>>           * The soc node represents the soc top level view. It is uses for IPs
>>           * that are not memory mapped in the MPU view or for the MPU itself.
>>           */
>>          soc {
>>                  compatible = "ti,omap-infra";
>> +               mpu {
>> +                       compatible = "ti,omap3-mpu";
>> +                       hwmods = "mpu";
>> +                       cpu@0 {
>> +                               compatible = "arm,cortex-a8";
>> +                       };
>> +               };
>> +
>
> I would always put the cpu nodes in the top-level, even if that's
> a slight misrepresentation of the truth. The point is basically
> that CPU nodes are special (you cannot have device drivers for them)
> and that the device tree is basically laid out from the perspective
> of the CPU, which may be different from the perspective that a
> hardware designer has.

Yeah, I saw that in the "cpus" node documentation. My point here is that 
I do need to represent the MPU subsystem that will contain the cpus. And 
thus the Cortex is inside the MPU subsystem.

I can potentially keep the CPUs inside the cpus node, and just represent 
the mpu node inside the soc, with potentially some phandle to the real 
cpu nodes.

Something like that:

cpus {
	cpu0: cpu@0 {
			compatible = "arm,cortex-a8";
	};
};

[...]

soc {
	compatible = "ti,omap-infra";
	mpu {
		compatible = "ti,omap3-mpu";
		hwmods = "mpu";
		cpu@0 {
			phandle = <&cpu0>;
			[...]
		};
	};
};


Does that look better?

Thanks,
Benoit
