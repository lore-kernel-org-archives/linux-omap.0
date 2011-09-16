From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: [RFC PATCH 06/11] DT: regulator: Helper routine to extract fixed_voltage_config
Date: Fri, 16 Sep 2011 12:49:17 +0530
Message-ID: <4E72F875.4090001@ti.com>
References: <1316085727-15023-1-git-send-email-rnayak@ti.com> <1316085727-15023-2-git-send-email-rnayak@ti.com> <1316085727-15023-3-git-send-email-rnayak@ti.com> <1316085727-15023-4-git-send-email-rnayak@ti.com> <1316085727-15023-5-git-send-email-rnayak@ti.com> <1316085727-15023-6-git-send-email-rnayak@ti.com> <1316085727-15023-7-git-send-email-rnayak@ti.com> <20110915135051.GL7988@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog105.obsmtp.com ([74.125.149.75]:54637 "EHLO
	na3sys009aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753396Ab1IPHTY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 16 Sep 2011 03:19:24 -0400
Received: by mail-gw0-f43.google.com with SMTP id 11so3815870gwm.16
        for <linux-omap@vger.kernel.org>; Fri, 16 Sep 2011 00:19:23 -0700 (PDT)
In-Reply-To: <20110915135051.GL7988@opensource.wolfsonmicro.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: grant.likely@secretlab.ca, devicetree-discuss@lists.ozlabs.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com, lrg@ti.com, b-cousson@ti.com

On Thursday 15 September 2011 07:20 PM, Mark Brown wrote:
> On Thu, Sep 15, 2011 at 04:52:02PM +0530, Rajendra Nayak wrote:
>
>>   .../devicetree/bindings/regulator/regulator.txt    |   19 ++++++++++++
>>   drivers/of/of_regulator.c                          |   31 ++++++++++++++++++++
>>   include/linux/of_regulator.h                       |    7 ++++
>>   3 files changed, 57 insertions(+), 0 deletions(-)
>
> Again, this should be part of the regulator API code not hidden away
> where it will only get reviewed by device tree people.

Ok, will do.

>
>>   Required properties:
>>   - compatible: Must be "regulator";
>> +or
>> +- compatible: Must be "regulator-fixed"; /* For Fixed volatge regulator */
>
> This seems at best confusing - the fixed voltage regulator is a
> particular regulator driver, and the general concept of a fixed voltage
> regulator is still a subset of regulators.

Yeah, I will be defining the compatible based on the different regulator
types, fixed being one of them.
so they would be something like
- compatible: Must be "regulator-twl" for twl regulators
- compatible: Must be "regulator-fixed" for fixed regulators

>
>> +# For fixed voltage regulators
>> +- supply-name: Name of the regulator supply
>> +- microvolts: Output voltage of regulator
>> +- gpio: gpio to use for enable control
>> +- startup-delay: startup time in microseconds
>> +- enable-high: Polarity of enable GPIO, 1 = Active High, 0 = Active low
>> +- enabled-at-boot: 1 = yes, 0 = no
>
> Much of this is specific to the Linux fixed voltage regulator driver
> rather than a generic regulator with a fixed voltage.

So how should these non-generic things be handled through device
tree? Should they never be part of dt or should the bindings just be
defined such that its clear they are linux specific?

