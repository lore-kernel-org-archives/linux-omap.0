From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: OMAP: DSS2: Common IRQ handler for all OMAPs
Date: Mon, 14 Feb 2011 16:21:47 +0200
Message-ID: <1297693307.2951.25.camel@deskari>
References: <1296636990-24775-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:49704 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755401Ab1BNOVt (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 14 Feb 2011 09:21:49 -0500
Received: from dlep33.itg.ti.com ([157.170.170.112])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id p1EELnnE021861
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Mon, 14 Feb 2011 08:21:49 -0600
Received: from dlep26.itg.ti.com (localhost [127.0.0.1])
	by dlep33.itg.ti.com (8.13.7/8.13.7) with ESMTP id p1EELncw001468
	for <linux-omap@vger.kernel.org>; Mon, 14 Feb 2011 08:21:49 -0600 (CST)
Received: from dlee73.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id p1EELnOd006932
	for <linux-omap@vger.kernel.org>; Mon, 14 Feb 2011 08:21:49 -0600 (CST)
In-Reply-To: <1296636990-24775-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: archit taneja <archit@ti.com>
Cc: linux-omap@vger.kernel.org

Hi,

On Wed, 2011-02-02 at 08:56 +0000, archit taneja wrote:
> OMAP2 has an irq line dedicated for DISPC interrupts, there is no DSI
> on omap2.
> OMAP3 has a common irq line for DISPC and DSI interrupts.
> OMAP4 has seperate irq lines for DISPC and DSI Interrupts.
> 
> Use dss_features to have a common DSS irq handler for all OMAP revisions.
> 
> Also, use a member of the global dss structure to store the irq number
> as it is used in 2 functions.

It's good to remove the cpu_is_xxxx() calls, but I'm not quite sure
about this patch...

Could we use shared interrupt handlers here, so that dss.c would handle
only DISPC interrupts (or should it be even in dispc.c?) and dsi.c would
handle DSI interrupts?

On OMAP3 both dss.c and dsi.c would register to the same interrupt, and
they would need to check if the interrupt was really for them. On OMAP4
the code could be the same, even though the check is unnecessary.

Also, as I mentioned in the email I sent some minutes ago, this patch
fixes the free_irq call in dss_exit. Things like that should never be
fixed silently, even if it's trivial like in this case.

 Tomi


