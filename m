From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 7/8] OMAP: 4430SDP: remove DSI clock config from board
 file
Date: Thu, 6 Sep 2012 13:11:55 -0700
Message-ID: <20120906201155.GD1303@atomide.com>
References: <1345729514-2441-1-git-send-email-tomi.valkeinen@ti.com>
 <1345729514-2441-8-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:48002 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1759656Ab2IFUL4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 6 Sep 2012 16:11:56 -0400
Content-Disposition: inline
In-Reply-To: <1345729514-2441-8-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: archit@ti.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org

* Tomi Valkeinen <tomi.valkeinen@ti.com> [120823 06:46]:
> DSI clocks are now configured dynamically by the DSI driver, so we can
> remove the hardcoded clock configuration from the board file.
> 
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> Cc: Tony Lindgren <tony@atomide.com>

This should be safe to merge via fb tree:

Acked-by: Tony Lindgren <tony@atomide.com>
