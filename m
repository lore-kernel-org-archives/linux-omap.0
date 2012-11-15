From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP4: PM: fix errata handling when CONFIG_PM=n
Date: Wed, 14 Nov 2012 17:20:25 -0800
Message-ID: <20121115012025.GE6801@atomide.com>
References: <1352940867-8806-1-git-send-email-khilman@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:52512 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S964820Ab2KOBU3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 14 Nov 2012 20:20:29 -0500
Content-Disposition: inline
In-Reply-To: <1352940867-8806-1-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Santosh Shilimkar <santosh.shilimkar@ti.com>, Tero Kristo <t-kristo@ti.com>

* Kevin Hilman <khilman@deeprootsystems.com> [121114 16:56]:
> From: Kevin Hilman <khilman@ti.com>
> 
> commit c9621844 (ARM: OMAP4: PM: add errata support) introduced errata
> handling for OMAP4, but was broken when CONFIG_PM=n.
> 
> When CONFIG_PM=n, pm44xx.c is not compiled, yet that is where pm44xx_errata
> is defined.  However, these errata are needed for the SMP boot/hotplug case
> also, and are primarily used in omap-smp.c.
> 
> Move the definition of pm44xx_errata to omap-smp.c so that it's available
> even in the CONFIG_PM=n case.
> 
> Cc: Tero Kristo <t-kristo@ti.com>
> Signed-off-by: Kevin Hilman <khilman@ti.com>
> ---
> This patch applies on top of Tony's fixes-non-critical-part-2.
> The bug was introduced in my for_3.8-fixes-pm tag (now included in Tony's fixes-non-critical-part2.)

Thanks applied to omap-for-v3.8/fixes-non-critical-v2 and
pushed out.

Tony
