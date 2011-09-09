From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [RFC PATCH 10/10] documentation/dt: Add OMAP GPIO properties
Date: Fri, 9 Sep 2011 03:51:46 +0200
Message-ID: <4E697132.9070505@ti.com>
References: <1314191356-10963-1-git-send-email-b-cousson@ti.com> <1314191356-10963-11-git-send-email-b-cousson@ti.com> <20110908181819.GI2967@ponder.secretlab.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:45393 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932067Ab1IIBv5 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 8 Sep 2011 21:51:57 -0400
In-Reply-To: <20110908181819.GI2967@ponder.secretlab.ca>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: "tony@atomide.com" <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Hilman, Kevin" <khilman@ti.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "G, Manjunath Kondaiah" <manjugk@ti.com>, Randy Dunlap <rdunlap@xenotime.net>

On 9/8/2011 8:18 PM, Grant Likely wrote:
> On Wed, Aug 24, 2011 at 03:09:16PM +0200, Benoit Cousson wrote:
>> Add documentation for GPIO properties specific to OMAP.
>>
>> Signed-off-by: Benoit Cousson<b-cousson@ti.com>
>> Cc: Randy Dunlap<rdunlap@xenotime.net>
>> ---
>>   .../devicetree/bindings/gpio/gpio-omap.txt         |   33 ++++++++++++++++++++
>>   1 files changed, 33 insertions(+), 0 deletions(-)
>>   create mode 100644 Documentation/devicetree/bindings/gpio/gpio-omap.txt
>>
>> diff --git a/Documentation/devicetree/bindings/gpio/gpio-omap.txt b/Documentation/devicetree/bindings/gpio/gpio-omap.txt
>> new file mode 100644
>> index 0000000..692b1c7
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/gpio/gpio-omap.txt
>> @@ -0,0 +1,33 @@
>> +OMAP GPIO controller
>> +
>> +Required properties:
>> +- compatible:
>> +  - "ti,omap2-gpio" for OMAP2 and OMAP3 controllers
>> +  - "ti,omap4-gpio" for OMAP4 controller
>> +- #gpio-cells : Should be two.
>> +  - first cell is the pin number
>> +  - second cell is used to specify optional parameters (unused)
>> +- gpio-controller : Marks the device node as a GPIO controller.
>> +
>> +OMAP specific properties:
>> +- hwmods: Name of the hwmod associated to the GPIO
>> +- id: 32 bits to identify the id (1 based index)
>
> id should not be necessary.  Linux GPIO numbers are to be dynamically
> assigned when using DT.
>
>> +- bank_width: number of pin supported by the controller (16 or 32)
>> +- debounce: set if the controller support the debouce funtionnality
>> +- bank_count: number of controller support by the SoC. This is a temporary
>> +  hack until the bank_count is removed from the driver.
>
> All these properties should be prefixed with "ti,".
> Use '-' instead of '_' in property names

I'll fix that.

Thanks,
Benoit
