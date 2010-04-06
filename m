From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [RFC/PATCH 3/3] arm: omap1/2/3/4: convert clocksource to a platform_driver
Date: Tue, 06 Apr 2010 14:37:08 -0700
Message-ID: <87d3ycmfej.fsf@deeprootsystems.com>
References: <1270033995-12516-1-git-send-email-felipe.balbi@nokia.com>
	<1270033995-12516-4-git-send-email-felipe.balbi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f193.google.com ([209.85.222.193]:51949 "EHLO
	mail-pz0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754662Ab0DFVhN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 6 Apr 2010 17:37:13 -0400
Received: by pzk31 with SMTP id 31so436224pzk.33
        for <linux-omap@vger.kernel.org>; Tue, 06 Apr 2010 14:37:12 -0700 (PDT)
In-Reply-To: <1270033995-12516-4-git-send-email-felipe.balbi@nokia.com> (Felipe Balbi's message of "Wed\, 31 Mar 2010 14\:13\:15 +0300")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <felipe.balbi@nokia.com>, Benoit Cousson <b-cousson@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>

Felipe Balbi <felipe.balbi@nokia.com> writes:

> Convert the omap32k clocksource driver into a platform_driver
> and while at that, also remove the ifdeferry around the code.
>
> Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>

This looks mostly good to me.  One cosmetic request.

There is some standardized naming happening for devices based on
Benoits work of auto-generating hwmod data.  As part of this, this
device will now be called counter_32k instead of '32k sync timer'
since it's just a simple counter and nobody really knew what the 'sync'
was intended to mean.  To that end, renaming things to use counter_32k
instead of sync timer would be helpful.

[...]

>  
> +static struct resource omap_32k_resources[] = {
> +	{
> +		.start		= -EINVAL,	/* gets changed later */
> +		.end		= -EINVAL,	/* gets changed later */

It's more common to just not assign these and leave them as zero.

> +		.flags		= IORESOURCE_MEM,
> +	},
> +};

Kevin
