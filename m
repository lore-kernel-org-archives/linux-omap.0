From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP: convert omap_device_build() and callers to
 __init
Date: Wed, 15 Feb 2012 14:14:08 -0800
Message-ID: <20120215221408.GZ1426@atomide.com>
References: <1329343522-15759-1-git-send-email-khilman@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:44817 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753103Ab2BOWOM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 15 Feb 2012 17:14:12 -0500
Content-Disposition: inline
In-Reply-To: <1329343522-15759-1-git-send-email-khilman@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Russell King <rmk+kernel@arm.linux.org.uk>

* Kevin Hilman <khilman@ti.com> [120215 13:33]:
> Building omap_devices should only be done at init time, and since
> omap_device_build() is using early_platform calls which are also
> __init, this ensures that omap_device isn't trying to use functions
> that disappear.
> 
> Signed-off-by: Kevin Hilman <khilman@ti.com>
> ---
> Tony, I tested this on top of your MMC series, and it gets rid of the
> rest of the section mismatch warnings except the
> omap_secondary_startup() one which is unrelated to this patch.

OK thanks, I'll apply them all with your patch into hsmmc branch once
they're done because this depends on the hsmmc changes.

Regards,

Tony
