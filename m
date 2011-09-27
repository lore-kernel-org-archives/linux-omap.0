From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: [PATCH 8/9] regulator: helper to extract regulator node based
 on supply name
Date: Tue, 27 Sep 2011 20:19:37 +0530
Message-ID: <4E81E281.505@ti.com>
References: <1317118372-17052-1-git-send-email-rnayak@ti.com> <1317118372-17052-9-git-send-email-rnayak@ti.com> <20110927122155.GE4289@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog122.obsmtp.com ([74.125.149.147]:46773 "EHLO
	na3sys009aog122.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751242Ab1I0Otp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 27 Sep 2011 10:49:45 -0400
Received: by mail-pz0-f43.google.com with SMTP id 13so18484740pzd.2
        for <linux-omap@vger.kernel.org>; Tue, 27 Sep 2011 07:49:44 -0700 (PDT)
In-Reply-To: <20110927122155.GE4289@opensource.wolfsonmicro.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: grant.likely@secretlab.ca, devicetree-discuss@lists.ozlabs.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com, lrg@ti.com, b-cousson@ti.com, patches@linaro.org

On Tuesday 27 September 2011 05:51 PM, Mark Brown wrote:
> On Tue, Sep 27, 2011 at 03:42:51PM +0530, Rajendra Nayak wrote:
>
>> +	if (!dev)
>> +		return NULL;
>
> So how do we handle CPUs?  cpufreq is one of the most active users of
> regulators...

Hmm, never thought of it :(
Maybe I should associate a supply name with all
regulators and then lookup from the global registered
list.

>
>> +	snprintf(prop_name, 32, "%s-supply", supply);
>> +
>> +	prop = of_get_property(dev->of_node, prop_name,&sz);
>> +	if (!prop || sz<  4)
>> +		return NULL;
>
> sz<  4?  Magic!  :)

Its the valid phandle size.
I guess I need a sz != 4

>
>> +extern struct device_node *of_get_regulator(struct device *dev,
>> +	const char *supply);
>
> This shouldn't be part of the public API, it should be transparently
> handled within the core.

agreed.

