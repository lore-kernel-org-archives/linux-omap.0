From: Tony Lindgren <tony@atomide.com>
Subject: Re: defconfig for panda
Date: Fri, 30 Mar 2012 11:48:59 -0700
Message-ID: <20120330184859.GB8240@atomide.com>
References: <1F91D012-8308-45BB-83AD-90E52D472AC2@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:44344 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756782Ab2C3StC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 30 Mar 2012 14:49:02 -0400
Content-Disposition: inline
In-Reply-To: <1F91D012-8308-45BB-83AD-90E52D472AC2@kernel.crashing.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kumar Gala <galak@kernel.crashing.org>
Cc: linux-omap@vger.kernel.org, Felipe Balbi <balbi@ti.com>

Hi,

* Kumar Gala <galak@kernel.crashing.org> [120329 12:24]:
> As I'm new to the OMAP community this might be a stupid question but trying to just build and run a stock v3.3 kernel on a pandaboard.  In doing so it seems as if some basic drivers are not enabled in omap2plus_defconfig for the board.  I'm trying to figure out if this is normal for some reason or just an oversight.
> 
> For example, USB and USB ethernet (SMC95xx).  I notice the linaro kernel tree introduces an omap4_defconfig, so just wondering should I send patches to omap2plus_defconfig or what?

We can add those to omap2plus_defconfig for sure, but let's have
them added as modules. Then distros can use that easily in a
standard way using initramfs-tools etc.

Let's not change the drivers that are currently built in if they're
needed for mounting mmc or nfsroot. Those can be changed later on.

Regards,

Tony
