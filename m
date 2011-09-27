From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: [PATCH 9/9] regulator: map consumer regulator based on device
 tree
Date: Tue, 27 Sep 2011 20:19:45 +0530
Message-ID: <4E81E289.5060904@ti.com>
References: <1317118372-17052-1-git-send-email-rnayak@ti.com> <1317118372-17052-10-git-send-email-rnayak@ti.com> <20110927122357.GF4289@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:45268 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751242Ab1I0Otx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 27 Sep 2011 10:49:53 -0400
Received: by gyg13 with SMTP id 13so6329584gyg.36
        for <linux-omap@vger.kernel.org>; Tue, 27 Sep 2011 07:49:52 -0700 (PDT)
In-Reply-To: <20110927122357.GF4289@opensource.wolfsonmicro.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: grant.likely@secretlab.ca, devicetree-discuss@lists.ozlabs.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com, lrg@ti.com, b-cousson@ti.com, patches@linaro.org

On Tuesday 27 September 2011 05:53 PM, Mark Brown wrote:
> On Tue, Sep 27, 2011 at 03:42:52PM +0530, Rajendra Nayak wrote:
>> Look up the regulator for a given consumer from device tree, during
>> a regulator_get(). If not found fallback and lookup through
>> the regulator_map_list instead.
>
> As with the fixed voltage regulator patch just use the code along with
> adding it, no need to split it just makes it harder to review.

Ok.

>
>> +	if (dev->of_node) {
>> +		node = of_get_regulator(dev, id);
>> +		if (!node)
>> +			goto retry; /* fallback and chk regulator_map_list */
>> +		list_for_each_entry(rdev,&regulator_list, list)
>> +			if (node == rdev->node)
>> +				goto found;
>> +	}
>> +retry:
>
> retry is a confusing name for the target, we don't ever actually retry
> using it.  Given the simplicity of the code I'd be inclined to just
> intert the if (!node) check.

Ok.

