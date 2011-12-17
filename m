From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH-V2] arm:omap: cleanup & split omap2/3/4_check_revision
 function
Date: Fri, 16 Dec 2011 17:27:31 -0800
Message-ID: <20111217012730.GD6464@atomide.com>
References: <1324037006-31984-1-git-send-email-hvaibhav@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:51275 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752745Ab1LQB1d (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 Dec 2011 20:27:33 -0500
Content-Disposition: inline
In-Reply-To: <1324037006-31984-1-git-send-email-hvaibhav@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vaibhav Hiremath <hvaibhav@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@ti.com

* Vaibhav Hiremath <hvaibhav@ti.com> [111216 03:32]:
> This patch doesn't change functionality or behavior of the code
> execution; it barely cleans up the code and splits into SoC
> specific implementation for Rev ID and feature detection.
> 
> Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
> ---
> Changes from V1:
> 	- Incorporated suggessions from Tony to split the function

Thanks for working on this, the end result looks much better.

Can you please split it into two or more patches as this patch
is pretty much unreadable unfortunately?

Maybe add empty check_revision functions first or something
like that so the diff stays readable?

Also..

> +static void __init omap3_cpuinfo(const char *cpu_rev)
> +{
> +	const char *cpu_name;

..the _cpuinfo functions can now be void as the cpu_rev
is already set globally?
 
Regards,

Tony
