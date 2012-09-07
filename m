From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/8] OMAPDSS: HDMI: Move GPIO handling to HDMI driver
Date: Fri, 7 Sep 2012 09:21:37 -0700
Message-ID: <20120907162137.GS1303@atomide.com>
References: <1345729514-2441-1-git-send-email-tomi.valkeinen@ti.com>
 <1345729514-2441-2-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:52353 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750777Ab2IGQVk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Sep 2012 12:21:40 -0400
Content-Disposition: inline
In-Reply-To: <1345729514-2441-2-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: archit@ti.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org

* Tomi Valkeinen <tomi.valkeinen@ti.com> [120823 06:46]:
> We currently manage HDMI GPIOs in the board files via
> platform_enable/disable calls. This won't work with device tree, and in
> any case the correct place to manage the GPIOs is in the HDMI driver.
> 
> This patch moves the handling of the GPIOs to the HDMI driver. The GPIO
> handling is moved to the common hdmi.c file, and this probably needs to
> be revisited when adding OMAP5 HDMI support to see if the GPIO handling
> needs to be moved to IP specific files.
> 
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> Cc: Tony Lindgren <tony@atomide.com>

This too looks safe to merge via fb tree:

Acked-by: Tony Lindgren <tony@atomide.com>
