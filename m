From: Paul Walmsley <paul@pwsan.com>
Subject: RE: [PATCH] OMAP: Exporting functions doing common register access
Date: Wed, 18 Nov 2009 03:40:40 -0700 (MST)
Message-ID: <alpine.DEB.2.00.0911180324350.25515@utopia.booyaka.com>
References: <1258384836-24854-1-git-send-email-anuj.aggarwal@ti.com> <alpine.DEB.2.00.0911161408260.29213@utopia.booyaka.com> <5A47E75E594F054BAF48C5E4FC4B92AB030A8C8EC2@dbde02.ent.ti.com> <5A47E75E594F054BAF48C5E4FC4B92AB030A9CA8F7@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:58813 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752973AbZKRKke (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 18 Nov 2009 05:40:34 -0500
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB030A9CA8F7@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Aggarwal, Anuj" <anuj.aggarwal@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>

On Wed, 18 Nov 2009, Aggarwal, Anuj wrote:

> [Aggarwal, Anuj] Any comments on this patch? Do I have to re-work this?

Yes.  omap_ctrl_*() should not be exported, as mentioned earlier.

A lot of rework will be needed at some point in sound/soc/omap/ to get all 
of the chip- and board-integration details out of these files.  DMA 
channels, IRQs, board data, etc. should all go into arch/arm/*omap*.  
plat-omap/mcbsp.c needs to be moved to somewhere under drivers/ at some 
point, but the platform_device setup for it should be kept under 
arch/arm/*omap*.

In the interim, I would suggest that you remove the the clock source and 
receiver source change functions from omap-mcbsp.c, split them into OMAP1 
and OMAP2/3 variants, and place them into arch/arm/mach-omap*/mcbsp.c.  
Expand struct omap_mcbsp_ops to add function pointers to those functions.  
Call those from soc/omap-mcbsp.c via mcbsp->pdata->ops. That way you won't 
need those exports.

I don't understand how this code compiled on OMAP1 in any case, since it 
doesn't have a System Control Module.


- Paul
