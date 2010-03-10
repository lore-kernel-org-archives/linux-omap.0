From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/2] OMAP4: fix temporary hacks that break multi-omap PM
Date: Wed, 10 Mar 2010 13:42:32 -0800
Message-ID: <20100310214231.GO2900@atomide.com>
References: <1268241391-26312-1-git-send-email-khilman@deeprootsystems.com>
 <1268241391-26312-3-git-send-email-khilman@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:62080 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932381Ab0CJVlN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 10 Mar 2010 16:41:13 -0500
Content-Disposition: inline
In-Reply-To: <1268241391-26312-3-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-omap@vger.kernel.org, Santosh Shilimkar <santosh.shilimkar@ti.com>

* Kevin Hilman <khilman@deeprootsystems.com> [100310 09:16]:
> When building for multi-omap, and OMAP4 is enabled, CONFIG_ARCH_OMAP4
> will be true and prevent included code from building/running for
> OMAP2/3 as well.
> 
> This problem exists in io.c where some hwmod/PM/SDRC init code is
> prevented from running even on OMAP2/3 when OMAP4 is included in a
> multi-OMAP build.
> 
> A quick glance suggests that this #ifndef is no longer needed in most
> of the cases.  In the remaining cases, the function is wrapped with
> "if (cpu_is_omap24xx() || cpu_is_omap34xx())" which will be optimized
> out for OMAP4-only builds.
> 
> Note that this is only a short-term fix.  Longer-term, OMAP4
> needs to create init functions for SDRC and hwmod late-init.

Good to get rid of the temporary hacks. Santosh, maybe grep
to see if there are other hacks left that can be now removed?

Regards,

Tony
