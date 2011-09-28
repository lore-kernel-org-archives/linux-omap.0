From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: [PATCH 8/9] regulator: helper to extract regulator node based
 on supply name
Date: Wed, 28 Sep 2011 13:48:41 +0530
Message-ID: <4E82D861.6030303@ti.com>
References: <1317118372-17052-1-git-send-email-rnayak@ti.com> <1317118372-17052-9-git-send-email-rnayak@ti.com> <20110927122155.GE4289@opensource.wolfsonmicro.com> <4E81E281.505@ti.com> <20110927185913.GU4289@opensource.wolfsonmicro.com> <4E82D63A.7030207@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:57473 "EHLO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753239Ab1I1ISv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 28 Sep 2011 04:18:51 -0400
Received: by pzd13 with SMTP id 13so20563538pzd.2
        for <linux-omap@vger.kernel.org>; Wed, 28 Sep 2011 01:18:50 -0700 (PDT)
In-Reply-To: <4E82D63A.7030207@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, "grant.likely@secretlab.ca" <grant.likely@secretlab.ca>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "tony@atomide.com" <tony@atomide.com>, "Girdwood, Liam" <lrg@ti.com>, "patches@linaro.org" <patches@linaro.org>

On Wednesday 28 September 2011 01:39 PM, Cousson, Benoit wrote:
> On 9/27/2011 8:59 PM, Mark Brown wrote:
>> On Tue, Sep 27, 2011 at 08:19:37PM +0530, Rajendra Nayak wrote:
>>> On Tuesday 27 September 2011 05:51 PM, Mark Brown wrote:
>>>> On Tue, Sep 27, 2011 at 03:42:51PM +0530, Rajendra Nayak wrote:
>>
>>>>> + if (!dev)
>>>>> + return NULL;
>>
>>>> So how do we handle CPUs? cpufreq is one of the most active users of
>>>> regulators...
>>
>>> Hmm, never thought of it :(
>>> Maybe I should associate a supply name with all
>>> regulators and then lookup from the global registered
>>> list.
>>
>> I'm not sure how this should work in a device tree world, I'd *hope*
>> we'd get a device tree node for the CPU and could then just make this a
>> regular consumer thing but then the cpufreq drivers would need to be
>> updated to make use of it. The only reason we allow null devices right
>> now is the fact that cpufreq doesn't have a struct device it can use.
>
> That's why we do have a MPU node in OMAP dts, in order to build an
> omap_device that will be mainly used for the DVFS on the MPU.
>
> And even before DT migration, we used to build statically some
> omap_device to represent the various processors in the system (MPU, DSP,
> CortexM3...).

yes, but clearly not everyone seems to do this. and then there are
also these instances of board files requesting regulators without
associating them with any device :(

>
> Regards,
> Benoit

