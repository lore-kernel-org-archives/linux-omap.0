From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL] ARM: OMAP: omap_device updates for v3.7
Date: Wed, 12 Sep 2012 22:05:49 -0700
Message-ID: <20120913050548.GD4521@atomide.com>
References: <87oblbvvp4.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:11905 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751992Ab2IMFFv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 13 Sep 2012 01:05:51 -0400
Content-Disposition: inline
In-Reply-To: <87oblbvvp4.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>

* Kevin Hilman <khilman@ti.com> [120912 13:22]:
> Tony,
> 
> Please pull the following omap_device changes for v3.7.  This was a
> collaboration between myself and Paul.
> 
> Thanks,
> 
> Kevin
> 
> The following changes since commit 0d7614f09c1ebdbaa1599a5aba7593f147bf96ee:
> 
>   Linux 3.6-rc1 (2012-08-02 16:38:10 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm.git tags/for_3.7-omap_device
> 
> for you to fetch changes up to 9634c8dd6a729406e89aed4e29470e3ffb3cd060:
> 
>   ARM: OMAP: omap_device: idle devices with no driver bound (2012-09-12 10:52:03 -0700)
> 
> ----------------------------------------------------------------
> Updates for omap_device layer for v3.7.
> 
> Allows omap_device layer to keep track of driver bound status in order
> to make more intelligent decisions about idling unused devices.

Thanks pulling into devel-omap-device.

Regards,

Tony
