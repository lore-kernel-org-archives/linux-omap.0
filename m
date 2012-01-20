From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/6] OMAPDSS: HDMI PHY burnout fix
Date: Fri, 20 Jan 2012 06:49:18 -0800
Message-ID: <20120120144918.GM22818@atomide.com>
References: <1326804542-22285-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:28476 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752830Ab2ATOtV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 20 Jan 2012 09:49:21 -0500
Content-Disposition: inline
In-Reply-To: <1326804542-22285-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, mythripk@ti.com, archit@ti.com, x0132446@ti.com

* Tomi Valkeinen <tomi.valkeinen@ti.com> [120117 04:16]:
> The main patch in this set is the last one, which implements a fix for the HW
> bug on OMAP4 which causes physical damage to the board if the HDMI cable is not
> connected but HDMI output is enabled.
> 
> The preceding patches are small cleanups/fixes for HDMI GPIOs so that the fix
> can be implemented.
> 
> Note that I haven't gotten a confirmation that using LDO_ON for the HDMI PHY
> power fixes the issue. So whether the fix works or not is unclear.

Feel free to merge via fb tree. For the arch/arm/*omap*/* parts:

Acked-by: Tony Lindgren <tony@atomide.com>
