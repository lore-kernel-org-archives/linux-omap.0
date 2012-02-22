From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 16/16] OMAPFB: remove remaining OMAP arch checks
Date: Wed, 22 Feb 2012 10:11:48 -0800
Message-ID: <20120222181147.GH18185@atomide.com>
References: <1327399231-20826-1-git-send-email-tomi.valkeinen@ti.com>
 <1327399231-20826-17-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:47687 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754798Ab2BVSLt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 22 Feb 2012 13:11:49 -0500
Content-Disposition: inline
In-Reply-To: <1327399231-20826-17-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, archit@ti.com

* Tomi Valkeinen <tomi.valkeinen@ti.com> [120124 01:30]:
> Now that the old omapfb driver is only omap1 display driver, there's no
> need to check if the arch is omap1. This patch removes the few remaining
> checks for the arch.
> 
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>

Acked-by: Tony Lindgren <tony@atomide.com>
