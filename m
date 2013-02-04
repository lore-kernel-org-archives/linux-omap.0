From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCH V2 3/7] ARM: OMAP2+: Remove hard-coded test on timer ID
Date: Mon, 4 Feb 2013 12:01:59 -0600
Message-ID: <510FF797.8000406@ti.com>
References: <1359999786-8740-1-git-send-email-jon-hunter@ti.com> <1359999786-8740-4-git-send-email-jon-hunter@ti.com> <20130204174612.GF2637@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:43456 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754293Ab3BDSCM (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 4 Feb 2013 13:02:12 -0500
In-Reply-To: <20130204174612.GF2637@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap <linux-omap@vger.kernel.org>, Vaibhav Bedia <vaibhav.bedia@ti.com>, linux-arm <linux-arm-kernel@lists.infradead.org>


On 02/04/2013 11:46 AM, Russell King - ARM Linux wrote:
> On Mon, Feb 04, 2013 at 11:43:02AM -0600, Jon Hunter wrote:
>> @@ -280,22 +281,22 @@ static int __init omap_dm_timer_init_one(struct omap_dm_timer *timer,
>>  	if (IS_ERR(timer->fclk))
>>  		return -ENODEV;
>>  
>> -	/* FIXME: Need to remove hard-coded test on timer ID */
>> -	if (gptimer_id != 12) {
>> -		struct clk *src;
>> -
>> -		src = clk_get(NULL, fck_source);
>> -		if (IS_ERR(src)) {
>> -			r = -EINVAL;
>> -		} else {
>> -			r = clk_set_parent(timer->fclk, src);
>> -			if (IS_ERR_VALUE(r))
>> -				pr_warn("%s: %s cannot set source\n",
>> -					__func__, oh->name);
>> +	src = clk_get(NULL, fck_source);
>> +	if (IS_ERR(src))
>> +		return -EINVAL;
> 
> This should be:
> 		return PTR_ERR(src);
> 
> and should've been there previously...

Thanks for the catch. I will include this and resend.

Cheers
Jon

