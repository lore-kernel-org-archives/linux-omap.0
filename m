From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RFC/PATCH 0/2] 32k-sync timer patches
Date: Tue, 4 May 2010 15:38:47 -0700
Message-ID: <20100504223847.GO29604@atomide.com>
References: <1270033549-26408-1-git-send-email-felipe.balbi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:52450 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758419Ab0EDWiu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 4 May 2010 18:38:50 -0400
Content-Disposition: inline
In-Reply-To: <1270033549-26408-1-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <felipe.balbi@nokia.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>

* Felipe Balbi <felipe.balbi@nokia.com> [100331 04:02]:
> The following patches convert 32k-sync timer into a platform_driver
> and also remove dead code from timer32k.c
> 
> If anyone has a good idea on how to fix-up timer-gp.c, I'll be
> glad to hear. Currently I can't move it to platform_driver
> because it's used the system timer during machine start so I can't
> find a proper location to register the platform_device. If we don't
> register a system timer, we will loop forever trying to calibrate
> the delay loop.
> 
> The patches were boot tested on rx51 and compile tested with
> omap_h2_1610_defconfig.

Ping, looks like this series is pretty close to being mergeable?

Marking as RFC and archived in patchwork, please repost to get
without RFC flags and the acks if you think we're should merge
these changes.

Regards,

Tony
