From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/1] ARM: OMAP: Enable TSC2301 drivers in N800 defconfig
Date: Mon, 28 Apr 2008 16:23:07 -0700
Message-ID: <20080428232307.GD8449@atomide.com>
References: <1209370114-17007-1-git-send-email-jarkko.nikula@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:53709 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935249AbYD1XXK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 28 Apr 2008 19:23:10 -0400
Content-Disposition: inline
In-Reply-To: <1209370114-17007-1-git-send-email-jarkko.nikula@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@nokia.com>
Cc: linux-omap@vger.kernel.org, Felipe Balbi <felipe.balbi@nokia.com>

* Jarkko Nikula <jarkko.nikula@nokia.com> [080428 01:08]:
> Patch because N800 didn't work anymore with n800_defconfig...
> 
> Note that camera driver doesn't compile at the moment so please disable
> CONFIG_VIDEO_OMAP2 manually before trying.

I posted a fix for v4l in the other thread, have not tested it though.

Tony


> Felipe, can you test does this config still work on N810?
> 
> -- 
> Jarkko
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
