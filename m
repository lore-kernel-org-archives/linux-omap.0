From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 13/16] omap: mux: Mux Apollon LCD power in
 board-apollon.c
Date: Thu, 1 Jul 2010 13:33:59 +0300
Message-ID: <20100701103359.GI2822@atomide.com>
References: <20100630120226.2637.31198.stgit@baageli.muru.com>
 <20100630120719.2637.65586.stgit@baageli.muru.com>
 <1277967954.2474.269.camel@tubuntu.research.nokia.com>
 <004d01cb18f5$ff27be80$fd773b80$%park@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:63269 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755044Ab0GAKdz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 1 Jul 2010 06:33:55 -0400
Content-Disposition: inline
In-Reply-To: <004d01cb18f5$ff27be80$fd773b80$%park@samsung.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kyungmin Park <kyungmin.park@samsung.com>
Cc: 'Tomi Valkeinen' <tomi.valkeinen@nokia.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

* Kyungmin Park <kyungmin.park@samsung.com> [100701 11:12]:
> Hi,
> 
> This value is set from bootloader, and kernel side only change the mode.
> Right it runs by luck.

So should we just drop the omap_cfg_reg for now, then add it back
later with proper gpio_request etc?

Tony
