From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: [PATCH 2/9] regulator: helper routine to extract regulator_init_data
Date: Fri, 30 Sep 2011 09:57:30 +0530
Message-ID: <4E854532.6080605@ti.com>
References: <1317118372-17052-1-git-send-email-rnayak@ti.com> <1317118372-17052-3-git-send-email-rnayak@ti.com> <20110927121003.GB4289@opensource.wolfsonmicro.com> <4E81E224.2070408@ti.com> <20110927150511.GM4289@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:51329 "EHLO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750745Ab1I3E1j (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 30 Sep 2011 00:27:39 -0400
Received: by mail-yx0-f174.google.com with SMTP id 31so1638452yxl.33
        for <linux-omap@vger.kernel.org>; Thu, 29 Sep 2011 21:27:37 -0700 (PDT)
In-Reply-To: <20110927150511.GM4289@opensource.wolfsonmicro.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: grant.likely@secretlab.ca, devicetree-discuss@lists.ozlabs.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com, lrg@ti.com, b-cousson@ti.com, patches@linaro.org

[]...
>
>>>> +	init_data->supply_regulator = (char *)of_get_property(dev->of_node,
>>>> +						"regulator-supplies", NULL);
>
>>> I'd expect that in the device tree world the supply regulator would
>>> reference the node for that regulator.
>
>> You mean using phandles? Thats what Grant proposed too but
>> I thought you instead had an inclination towards names? Or maybe
>> I misunderstood.
>
> They need both.  We need to reference the device that provides the
> supply and use a name to say which of the potentially multiple supplies
> on the consumer device is which.

Mark, I still seem to be a little confused with this one as to why
we would need a phandle *and* a supply-name to reference a parent
regulator/supply.
The phandle would point to a regulator dt node and that node internally
would have just one name associated with it.

>
>>> Hrm, I think loosing the signs here is bad karma - negative voltages do
>>> exist after all.
>
>> Oops.. they do? didn't know about that.
>
> Yup, ground is just a reference point.

