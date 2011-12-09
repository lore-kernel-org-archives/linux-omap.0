From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCHv4 11/15] omap3+: voltage/pwrdm/clkdm/clock add recursive usecount tracking
Date: Fri, 09 Dec 2011 11:37:42 -0800
Message-ID: <8762hpedtl.fsf@ti.com>
References: <1322236188-19456-1-git-send-email-t-kristo@ti.com>
	<1322236188-19456-12-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog120.obsmtp.com ([74.125.149.140]:47296 "EHLO
	na3sys009aog120.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750761Ab1LIThp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 9 Dec 2011 14:37:45 -0500
Received: by mail-gx0-f181.google.com with SMTP id r1so4348987ggn.26
        for <linux-omap@vger.kernel.org>; Fri, 09 Dec 2011 11:37:44 -0800 (PST)
In-Reply-To: <1322236188-19456-12-git-send-email-t-kristo@ti.com> (Tero
	Kristo's message of "Fri, 25 Nov 2011 17:49:44 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>, Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, nm@ti.com

+Paul

Tero Kristo <t-kristo@ti.com> writes:

> This patch fixes the usecount tracking for omap3+, previously the
> usecount numbers were rather bogus and were not really useful for
> any purpose. Now usecount numbers track the number of really active
> clients on each domain. 

Excellent!  

This dramatically improves the usefulness of <debugfs>/pm_debug/count.
Adding the voltage domains to that debugfs would help even more.

Also, the changelog should be a bit more verbose about the new clk->autoidle
field, it's usage, and how it affects usecounting.  

Speaking of debugfs: not a requirement for this series, but another
"nice to have" (which you can do while waiting for the slow maintainers
to review :) would be for this debugfs to show the clkdomains under the
powerdomains they are in, and the powerdomains under the voltage domains
(instead of the current list of pwrdms followed by clkdms.)  Maybe using
voltdm_for_each_pwrdm() + pwrdm_for_each_clkdm() might help there.

> This patch also adds support for usecount tracking on powerdomain and
> voltagedomain levels.

The clock/clkdm/pwrdm changes should probably be split separate patch
for review/merge by Paul.  Then the voltdm changes can included in this
series.  Although, with Paul's ack on the clock/clkdm/powerdomain
changes, I'll be happy to queue this as well.

[...]

> diff --git a/arch/arm/plat-omap/include/plat/clock.h b/arch/arm/plat-omap/include/plat/clock.h
> index df4b968..f18dd5f 100644
> --- a/arch/arm/plat-omap/include/plat/clock.h
> +++ b/arch/arm/plat-omap/include/plat/clock.h
> @@ -254,6 +254,7 @@ struct clk {
>  	void			(*init)(struct clk *);
>  	u8			enable_bit;
>  	s8			usecount;
> +	u8			autoidle;

should be bool, and assignments using true | false.

Kevin
