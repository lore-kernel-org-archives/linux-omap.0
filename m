From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 06/16] OMAP: N770: remove HWA742 platform data
Date: Wed, 22 Feb 2012 10:08:06 -0800
Message-ID: <20120222180806.GA18185@atomide.com>
References: <1327399231-20826-1-git-send-email-tomi.valkeinen@ti.com>
 <1327399231-20826-7-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:44715 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753022Ab2BVSII (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 22 Feb 2012 13:08:08 -0500
Content-Disposition: inline
In-Reply-To: <1327399231-20826-7-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, archit@ti.com

* Tomi Valkeinen <tomi.valkeinen@ti.com> [120124 01:30]:
> In an effort to clean up the old omapfb driver, this patch removes
> HWA742 (the display chip used in N770) platform data. This can be done
> as N770 is the only user of HWA742, and the platform data contains only
> one field, te_connected, which we can just presume to be true in the
> HWA742 driver.
> 
> This allows us to remove omapfb_set_ctrl_platform_data(), and the
> mechanism to pass the platform data, in a later patch.
> 
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>

Acked-by: Tony Lindgren <tony@atomide.com>
