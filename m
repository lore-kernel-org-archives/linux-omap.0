From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] OMAP: Exporting functions doing common register access
Date: Mon, 16 Nov 2009 14:16:20 -0700 (MST)
Message-ID: <alpine.DEB.2.00.0911161408260.29213@utopia.booyaka.com>
References: <1258384836-24854-1-git-send-email-anuj.aggarwal@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:39390 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752613AbZKPVQO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 16 Nov 2009 16:16:14 -0500
In-Reply-To: <1258384836-24854-1-git-send-email-anuj.aggarwal@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Anuj Aggarwal <anuj.aggarwal@ti.com>
Cc: linux-omap@vger.kernel.org

Hello Anuj,

On Mon, 16 Nov 2009, Anuj Aggarwal wrote:

> These functions need to be exported so that drivers (e.g. McBSP) can
> be configured as modules.
> 
> McBSP driver gets built as a module when ASoC driver for OMAP3 EVM
> is configured as module. McBSP driver uses functions like
> omap_ctrl_readl/omap_ctrl_writel, which are defined in control.c
> file but not exported. Without that, McBSP driver fails to build as
> a module.
> 
> Signed-off-by: Anuj Aggarwal <anuj.aggarwal@ti.com>

This will prevent the McBSP driver from being usable across chips.  For 
example, if a future OMAP comes out with McBSP clock source switching 
implemented in a different way, or if a DaVinci chip comes out with a 
McBSP block but no SCM block, this either won't build or won't run.

A better approach would be to move the OMAP2/3-specific functions from the 
McBSP driver into the OMAP McBSP integration code, 
arch/arm/*omap*/mcbsp.c, and to define function pointers in 
struct platform_data for these functions, and to pass them from the 
integration code into the device driver code.  That will make these 
drivers independent of chip integration details.


- Paul
