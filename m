From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] arm: omap: hwmod: drop unnecessary list initialization
Date: Mon, 28 Jul 2014 05:24:34 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1407280524160.24161@utopia.booyaka.com>
References: <1405455492-1087-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:52559 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750953AbaG1FYf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 28 Jul 2014 01:24:35 -0400
In-Reply-To: <1405455492-1087-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>

On Tue, 15 Jul 2014, Felipe Balbi wrote:

> ml->node and sl->node are currently initialized
> by means of INIT_LIST_HEAD(). That initialiation
> is followed by a list_add() call.
> 
> Looking at what both these functions do we will have:
> 
> 	ml->node.next = &ml->node;
> 	ml->node.prev = &ml->node;
> 	oi->master->master_ports.next.prev = &ml->node;
> 	ml->node.next = &oi->master->master_ports.next;
> 	ml->node.prev = &oi->master->master_ports;
> 	oi->master->master_ports.next = &ml->node;
> 
> from this, it's clear that both INIT_LIST_HEAD() calls
> are unnecessary and can be safely removed.
> 
> Signed-off-by: Felipe Balbi <balbi@ti.com>
> ---
> 
> found by code inspection, boot tested on am437x SK on today's
> linux-next + pending patches.

Thanks, queued for v3.18.

- Paul
