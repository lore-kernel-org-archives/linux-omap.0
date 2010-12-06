From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RFC/PATCH v3 5/7] ARM: OMAP3: Update Camera ISP definitions
 for OMAP3630
Date: Mon, 6 Dec 2010 11:30:51 -0800
Message-ID: <20101206193051.GM8345@atomide.com>
References: <1290653678-15556-1-git-send-email-laurent.pinchart@ideasonboard.com>
 <1290653678-15556-6-git-send-email-laurent.pinchart@ideasonboard.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:10278 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753073Ab0LFTa5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 6 Dec 2010 14:30:57 -0500
Content-Disposition: inline
In-Reply-To: <1290653678-15556-6-git-send-email-laurent.pinchart@ideasonboard.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: linux-omap@vger.kernel.org, sakari.ailus@maxwell.research.nokia.com

* Laurent Pinchart <laurent.pinchart@ideasonboard.com> [101124 18:45]:
> From: Tuukka Toivonen <tuukka.o.toivonen@nokia.com>
> 
> Add new/changed base address definitions and resources for
> OMAP3630 ISP.
> 
> The OMAP3430 CSI2PHY block is same as the OMAP3630 CSIPHY2
> block. But the later name is chosen as it gives more symmetry
> to the names.
> 
> Signed-off-by: Tuukka Toivonen <tuukka.o.toivonen@nokia.com>
> Signed-off-by: Vimarsh Zutshi <vimarsh.zutshi@nokia.com>

This looks safe to queue along with the other camera patches
when they're ready:

Acked-by: Tony Lindgren <tony@atomide.com>
