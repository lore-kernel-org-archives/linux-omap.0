From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 13/11] OMAP2+: GPIO: ensure bank wakeups are enabled by
 default
Date: Thu, 9 Dec 2010 16:07:50 -0800
Message-ID: <20101210000750.GM3054@atomide.com>
References: <1290689318-10191-1-git-send-email-charu@ti.com>
 <1291923226-10112-1-git-send-email-khilman@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:15933 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753408Ab0LJAH4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 9 Dec 2010 19:07:56 -0500
Content-Disposition: inline
In-Reply-To: <1291923226-10112-1-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Charulatha Varadarajan <charu@ti.com>

* Kevin Hilman <khilman@deeprootsystems.com> [101209 11:33]:
> As part of the GPIO conversion to platform_device/platform_driver,
> commit 2fae7fbed072705d91e09ed393b2e580b2d895fc (OMAP: GPIO: prepare
> for platform driver) removed hard-coded per-bank SYSCONFIG register
> values in favor of using omap_hwmod to manage the SYSCONFIG register.
> 
> In the previous code, bank-level wakeups were enabled by default using
> the SYSCONFIG.ENAWAKEUP bit, but omap_hwmod does not enable wakeups by
> default.  Thus the above commit effectively disabled GPIO bank wakeups.
> 
> This patch enables GPIO bank level wakeups by default to preserve
> previous functionality.

So this patch is no longer needed, right?

Tony
