From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 03/16] OMAPDSS: Remove video SRAM support
Date: Wed, 22 Feb 2012 10:06:01 -0800
Message-ID: <20120222180601.GX18185@atomide.com>
References: <1327399231-20826-1-git-send-email-tomi.valkeinen@ti.com>
 <1327399231-20826-4-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:42875 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754198Ab2BVSGE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 22 Feb 2012 13:06:04 -0500
Content-Disposition: inline
In-Reply-To: <1327399231-20826-4-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, archit@ti.com

* Tomi Valkeinen <tomi.valkeinen@ti.com> [120124 01:30]:
> OMAP SRAM can be used as video memory on OMAP1 and 2. However, there
> usually is very little SRAM available, thus limiting its use, and no
> board supported by the kernel currently uses it.
> 
> This patch removes the use of SRAM as video ram for the omapdss driver
> to simplify memory handling.
> 
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>

For the arch/arm/*omap*/* parts:

Acked-by: Tony Lindgren <tony@atomide.com>
