From: Tony Lindgren <tony@atomide.com>
Subject: Re: arm-soc + rmk's tree boot failure on OMAP4430SDP
Date: Fri, 16 Mar 2012 17:47:06 -0700
Message-ID: <20120317004706.GF7276@atomide.com>
References: <20120316231158.GA9970@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:15609 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946007Ab2CQArK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 Mar 2012 20:47:10 -0400
Content-Disposition: inline
In-Reply-To: <20120316231158.GA9970@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Russell King - ARM Linux <linux@arm.linux.org.uk>

Hi,

Adding Tomi to this thread.

* Russell King - ARM Linux <linux@arm.linux.org.uk> [120316 16:14]:
> Sometime during the last week, the OMAP4430SDP stopped booting - it now
> stops with no kernel messages output:
> 
> http://www.arm.linux.org.uk/developer/build/result.php?type=boot&idx=69
> 
> The previously booted version:
> 
> http://www.arm.linux.org.uk/developer/build/result.php?type=boot&idx=57
> 
> worked fine - though this log will only be available for about 3 hours.
> 
> I've re-checked my tree, and the OMAP4430SDP boots fine, so it's either
> breakage coming from arm-soc or a result of merging the two trees
> together.

Based on initcall_debug with current linux-next, it seems to hang at
omap_dss_init2. And leaving out CONFIG_OMAP2_DSS makes devices boot
again.

Tomi, can you please investigate?

To reproduce this problem, just set CONFIG_OMAP2_DSS=y in
omap2plus_defconfig, and try to boot. It hangs at least on
blaze and zoom3.

Regards,

Tony
