From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: [PATCH 8/9] regulator: helper to extract regulator node based
 on supply name
Date: Wed, 28 Sep 2011 16:26:46 +0530
Message-ID: <4E82FD6E.6030606@ti.com>
References: <1317118372-17052-1-git-send-email-rnayak@ti.com> <1317118372-17052-9-git-send-email-rnayak@ti.com> <20110927122155.GE4289@opensource.wolfsonmicro.com> <4E81E281.505@ti.com> <20110927185913.GU4289@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:59729 "EHLO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751499Ab1I1K4y (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 28 Sep 2011 06:56:54 -0400
Received: by gyd12 with SMTP id 12so7580851gyd.31
        for <linux-omap@vger.kernel.org>; Wed, 28 Sep 2011 03:56:53 -0700 (PDT)
In-Reply-To: <20110927185913.GU4289@opensource.wolfsonmicro.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: grant.likely@secretlab.ca, devicetree-discuss@lists.ozlabs.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com, lrg@ti.com, b-cousson@ti.com, patches@linaro.org

On Wednesday 28 September 2011 12:29 AM, Mark Brown wrote:
> On Tue, Sep 27, 2011 at 08:19:37PM +0530, Rajendra Nayak wrote:
>> On Tuesday 27 September 2011 05:51 PM, Mark Brown wrote:
>>> On Tue, Sep 27, 2011 at 03:42:51PM +0530, Rajendra Nayak wrote:
>
>>>> +	if (!dev)
>>>> +		return NULL;
>
>>> So how do we handle CPUs?  cpufreq is one of the most active users of
>>> regulators...
>
>> Hmm, never thought of it :(
>> Maybe I should associate a supply name with all
>> regulators and then lookup from the global registered
>> list.
>
> I'm not sure how this should work in a device tree world, I'd *hope*
> we'd get a device tree node for the CPU and could then just make this a
> regular consumer thing but then the cpufreq drivers would need to be
> updated to make use of it.  The only reason we allow null devices right
> now is the fact that cpufreq doesn't have a struct device it can use.
>
>>>> +	snprintf(prop_name, 32, "%s-supply", supply);
>>>> +
>>>> +	prop = of_get_property(dev->of_node, prop_name,&sz);
>>>> +	if (!prop || sz<   4)
>>>> +		return NULL;
>
>>> sz<   4?  Magic!  :)
>
>> Its the valid phandle size.
>> I guess I need a sz != 4
>
> I think we need an of_get_phandle(), it'd be clearer what the check is,
> more type safe and would avoid needing to replicate the check.

Yes, there already seems to be one, of_parse_phandle() which I should
have used. thanks.

