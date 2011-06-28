From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH 2/7] OMAP: omap_device: Create clkdev entry for hwmod
 main_clk
Date: Tue, 28 Jun 2011 22:09:38 +0200
Message-ID: <4E0A3502.6020605@ti.com>
References: <1309192391-12410-1-git-send-email-b-cousson@ti.com> <1309192391-12410-3-git-send-email-b-cousson@ti.com> <20110627185604.GB6187@google.com> <4E09E0EF.9040600@ti.com> <20110628182142.GA13018@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:40599 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751047Ab1F1UJn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 28 Jun 2011 16:09:43 -0400
In-Reply-To: <20110628182142.GA13018@google.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Todd Poynor <toddpoynor@google.com>
Cc: "paul@pwsan.com" <paul@pwsan.com>, "Nayak, Rajendra" <rnayak@ti.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Hilman, Kevin" <khilman@ti.com>

On 6/28/2011 8:21 PM, Todd Poynor wrote:
> On Tue, Jun 28, 2011 at 04:10:55PM +0200, Cousson, Benoit wrote:
>> On 6/27/2011 8:56 PM, Todd Poynor wrote:
>>> On Mon, Jun 27, 2011 at 06:33:06PM +0200, Benoit Cousson wrote:
>>> ...
>>>> +	r = clk_get_sys(dev_name(&od->pdev.dev), clk_alias);
>>>> +	if (!IS_ERR(r)) {
>>>> +		pr_warning("omap_device: %s: %s already exist\n",
>>>> +			   dev_name(&od->pdev.dev), clk_alias);
>>>
>>> I believe a clk_put(r) is appropriate here.
>>
>> Appropriate I don't know, but useless for sure :-)
>> This clk_put is a no-op for every ARM platforms (I found one exception).
>
> I haven't followed the design of common struct clk closely, but it
> probably will do ref counting on these, so it's best to keep these
> matched up.

I didn't follow the design either, but it was posted in 2008, and still 
nobody is doing any reference counting...

That being said we can expect the common clock fmwk to use that and even 
Paul might want to do some stuff with that.

Let's start using it.

>
>>>> +	r = omap_clk_get_by_name(clk_name);
>>>> +	if (IS_ERR(r)) {
>>>> +		pr_err("omap_device: %s: omap_clk_get_by_name for %s failed\n",
>>>> +		       dev_name(&od->pdev.dev), clk_name);
>>>> +		return;
>>>> +	}
>>>> +
>>>> +	l = clkdev_alloc(r, clk_alias, dev_name(&od->pdev.dev));
>>>> +	if (!l) {
>>>> +		pr_err("omap_device: %s: clkdev_alloc for %s failed\n",
>>>> +		       dev_name(&od->pdev.dev), clk_alias);
>>>
>>> And here.
>>
>> No, it is not needed in that case because the omap_clk_get_by_name
>> is not using the clk_get API.
>
> Ah, didn't check that one, sorry.  That's an unfortunate use of "get"
> in the API name IMO.  When common struct clk takes over, this may need
> some tweaking.

Yep, I do agree.

Benoit
