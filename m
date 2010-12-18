From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH -next] omap2430: hwmod: remove stray declaration
Date: Fri, 17 Dec 2010 17:40:26 -0800
Message-ID: <20101218014026.GJ5941@atomide.com>
References: <1291403730-3165-1-git-send-email-gadiyar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:46931 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756779Ab0LRBkc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 17 Dec 2010 20:40:32 -0500
Content-Disposition: inline
In-Reply-To: <1291403730-3165-1-git-send-email-gadiyar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Anand Gadiyar <gadiyar@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Kevin Hilman <khilman@deeprootsystems.com>

* Anand Gadiyar <gadiyar@ti.com> [101203 11:05]:
> Patch "OMAP2xxx: hwmod: add I2C hwmods for OMAP2420, 2430"
> in linux-next as of 20101203 introduced the following build
> warning - fix this by removing the stray i2c_dev_attr.
> 
> arch/arm/mach-omap2/omap_hwmod_2430_data.c:483: warning: 'i2c_dev_attr' defined but not used

Thanks applying.

Tony
