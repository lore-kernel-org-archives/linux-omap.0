From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 08/16] OMAPFB: remove early mem alloc from old omapfb
Date: Wed, 22 Feb 2012 10:09:02 -0800
Message-ID: <20120222180902.GC18185@atomide.com>
References: <1327399231-20826-1-git-send-email-tomi.valkeinen@ti.com>
 <1327399231-20826-9-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:16596 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752884Ab2BVSJE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 22 Feb 2012 13:09:04 -0500
Content-Disposition: inline
In-Reply-To: <1327399231-20826-9-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, archit@ti.com

* Tomi Valkeinen <tomi.valkeinen@ti.com> [120124 01:30]:
> arch/arm/plat-omap/fb.c contains code to alloc omapfb buffers at early
> boot time according to information given from the bootloader or board
> file.
> 
> This code isn't currently used by any board, and is anyway something
> that the newer vram.c could handle. So remove the alloc code and in
> later patches make old omapfb driver use vram.c.
> 
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>

Acked-by: Tony Lindgren <tony@atomide.com>
