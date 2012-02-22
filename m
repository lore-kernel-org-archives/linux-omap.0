From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 04/16] OMAPFB: Remove video SRAM support (old omapfb)
Date: Wed, 22 Feb 2012 10:06:58 -0800
Message-ID: <20120222180658.GY18185@atomide.com>
References: <1327399231-20826-1-git-send-email-tomi.valkeinen@ti.com>
 <1327399231-20826-5-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:13086 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754088Ab2BVSHA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 22 Feb 2012 13:07:00 -0500
Content-Disposition: inline
In-Reply-To: <1327399231-20826-5-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, archit@ti.com

* Tomi Valkeinen <tomi.valkeinen@ti.com> [120124 01:30]:
> OMAP SRAM can be used as video memory on OMAP1 and 2. However, there
> usually is very little SRAM available, thus limiting its use, and no
> board supported by the kernel currently uses it.
> 
> This patch removes the use of SRAM as video ram for the old omapfb
> driver to simplify memory handling.
> 
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>

Acked-by: Tony Lindgren <tony@atomide.com>
