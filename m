From: Daniel Mack <zonque@gmail.com>
Subject: Re: [PATCH v6] ARM: omap: edma: add suspend suspend/resume hooks
Date: Wed, 27 Nov 2013 14:47:50 +0100
Message-ID: <5295F806.9030900@gmail.com>
References: <1384726754-27875-1-git-send-email-zonque@gmail.com> <5295F53C.8040101@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bk0-f53.google.com ([209.85.214.53]:40287 "EHLO
	mail-bk0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750907Ab3K0Nrx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 27 Nov 2013 08:47:53 -0500
Received: by mail-bk0-f53.google.com with SMTP id na10so3191078bkb.40
        for <linux-omap@vger.kernel.org>; Wed, 27 Nov 2013 05:47:51 -0800 (PST)
In-Reply-To: <5295F53C.8040101@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sekhar Nori <nsekhar@ti.com>, linux-omap@vger.kernel.org, joelf@ti.com, gururaja.hebbar@ti.com, balajitk@ti.com
Cc: s.neumann@raumfeld.com, Russ.Dill@ti.com, nm@ti.com, vaibhav.bedia@gmail.com, linux-arm-kernel@lists.infradead.org, Kevin Hilman <khilman@linaro.org>

Hi Sekhar,

On 11/27/2013 02:35 PM, Sekhar Nori wrote:
> On Monday 18 November 2013 03:49 AM, Daniel Mack wrote:

>> +static int edma_pm_suspend(struct device *dev)
>> +{
>> +	int j, r;
>> +
>> +	r = pm_runtime_get_sync(dev);
>> +	if (IS_ERR_VALUE(r)) {
> 
> So IS_ERR_VALUE() is only for functions which may return a negative
> number outside of MAX_ERRNO as a success indication.
> pm_runtime_get_sync() does not appear to be one of them so just use"
>
> if (r < 0) { .. }

That's true. Thanks for catching this, I'll fix it. However, grepping
through the tree, there are quite a lot places where the same mistake is
made.

>> +		/* Map the channel to param entry if channel mapping logic
>> +		 * exist
>> +		 */
> 
> Please follow the multi-line commenting style.

Can do. However, these lines in fact follow the style that is used
throughout the entire file ;)

> There are some checkpatch checks that result from lines like this.
> Please fix these as well.
> 
> CHECK: Alignment should match open parenthesis
> #179: FILE: arch/arm/common/edma.c:1841:
> +			map_queue_tc(j, queue_tc_mapping[i][0],
> +					queue_tc_mapping[i][1]);

If you say so, even though I disagree with checkpatch.pl here. The above
is actually more readable, right? :)


Thanks,
Daniel

