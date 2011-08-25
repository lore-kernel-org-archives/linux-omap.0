From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [RFC PATCH 2/7] arm/dts: Add initial device tree support for
 OMAP4 SoC
Date: Thu, 25 Aug 2011 15:57:34 +0200
Message-ID: <4E5654CE.4000303@ti.com>
References: <1314181040-22807-1-git-send-email-b-cousson@ti.com> <1314181040-22807-3-git-send-email-b-cousson@ti.com> <4E565004.9050806@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:56731 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751025Ab1HYN5s (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 25 Aug 2011 09:57:48 -0400
In-Reply-To: <4E565004.9050806@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rob Herring <robherring2@gmail.com>
Cc: "grant.likely@secretlab.ca" <grant.likely@secretlab.ca>, "Hilman, Kevin" <khilman@ti.com>, "G, Manjunath Kondaiah" <manjugk@ti.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hi Rob,

On 8/25/2011 3:37 PM, Rob Herring wrote:
> Benoit,

[...]

>> +		gic: interrupt-controller@48241000 {
>> +			compatible = "ti,omap4-gic", "arm,gic";
>
> The gic binding is still being hashed out. This needs binding
> documentation and handling of PPIs. I'm planning on posting an updated
> series today with this.
>
> "arm,gic" should be dropped or replaced with "arm,cortex-a9-gic".
> Non-specific DT bindings are not well received. Is OMAP4 gic different
> from standard Cortex-A9?

Not at all. We named it like that based on Grant's comment:
http://permalink.gmane.org/gmane.linux.ports.arm.omap/60393

I'll update it with the new binding.

>> +			interrupt-controller;
>> +			#interrupt-cells =<1>;
>> +			reg =<0x48241000 0x1000>,
>> +			<0x48240100 0x0200>;
>
> Isn't the cpu interface register space 0x100 bytes long?

I've just checked the spec, and this is indeed 256 bytes. I'll fix that.

Thanks for the comments.

Regards,
Benoit

