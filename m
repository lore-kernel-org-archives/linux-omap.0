From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH 2/7] OMAP: omap_device: Create clkdev entry for hwmod
 main_clk
Date: Tue, 28 Jun 2011 16:10:55 +0200
Message-ID: <4E09E0EF.9040600@ti.com>
References: <1309192391-12410-1-git-send-email-b-cousson@ti.com> <1309192391-12410-3-git-send-email-b-cousson@ti.com> <20110627185604.GB6187@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:44359 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757542Ab1F1OLD (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 28 Jun 2011 10:11:03 -0400
In-Reply-To: <20110627185604.GB6187@google.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Todd Poynor <toddpoynor@google.com>
Cc: "paul@pwsan.com" <paul@pwsan.com>, "Nayak, Rajendra" <rnayak@ti.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Hilman, Kevin" <khilman@ti.com>

On 6/27/2011 8:56 PM, Todd Poynor wrote:
> On Mon, Jun 27, 2011 at 06:33:06PM +0200, Benoit Cousson wrote:
> ...
>> +	r = clk_get_sys(dev_name(&od->pdev.dev), clk_alias);
>> +	if (!IS_ERR(r)) {
>> +		pr_warning("omap_device: %s: %s already exist\n",
>> +			   dev_name(&od->pdev.dev), clk_alias);
>
> I believe a clk_put(r) is appropriate here.

Appropriate I don't know, but useless for sure :-)
This clk_put is a no-op for every ARM platforms (I found one exception).

I do not know why it was originally done like that, but that api is 
clearly not a put/get kind of API.

I'm OK to add that, but I think it is a little bit misleading.

>
>> +		return;
>> +	}
>> +
>> +	r = omap_clk_get_by_name(clk_name);
>> +	if (IS_ERR(r)) {
>> +		pr_err("omap_device: %s: omap_clk_get_by_name for %s failed\n",
>> +		       dev_name(&od->pdev.dev), clk_name);
>> +		return;
>> +	}
>> +
>> +	l = clkdev_alloc(r, clk_alias, dev_name(&od->pdev.dev));
>> +	if (!l) {
>> +		pr_err("omap_device: %s: clkdev_alloc for %s failed\n",
>> +		       dev_name(&od->pdev.dev), clk_alias);
>
> And here.

No, it is not needed in that case because the omap_clk_get_by_name is 
not using the clk_get API.

>
>> +		return;
>> +	}
>> +
>> +	clkdev_add(l);
>
> And here.

Not needed either, no clk_get used.

Benoit
