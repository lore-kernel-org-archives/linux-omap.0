From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 02/16] ARM: omap: fix oops in
 drivers/video/omap2/dss/dpi.c
Date: Wed, 8 Feb 2012 10:36:07 -0800
Message-ID: <20120208183607.GB29796@atomide.com>
References: <20120208163546.GA15849@n2100.arm.linux.org.uk>
 <E1RvAVQ-0006Gp-Is@rmk-PC.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:55223 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755315Ab2BHSgW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 8 Feb 2012 13:36:22 -0500
Content-Disposition: inline
In-Reply-To: <E1RvAVQ-0006Gp-Is@rmk-PC.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-omap@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, linux-fbdev@vger.kernel.org

* Russell King - ARM Linux <linux@arm.linux.org.uk> [120208 08:05]:
> When a PMIC is not found, this driver is unable to obtain its
> 'vdds_dsi_reg' regulator.  Even through its initialization function
> fails, other code still calls its enable function, which fails to
> check whether it has this regulator before asking for it to be enabled.
> 
> This fixes the oops, however a better fix would be to sort out the
> upper layers to prevent them calling into a module which failed to
> initialize.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Tomi can look into fixing this properly for v3.4:

Acked-by: Tony Lindgren <tony@atomide.com>
