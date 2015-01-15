From: Mugunthan V N <mugunthanvnm@ti.com>
Subject: Re: [patch-net-next v2 3/3] net: ethernet: cpsw: don't requests IRQs
 we don't use
Date: Thu, 15 Jan 2015 13:19:16 +0530
Message-ID: <54B770FC.6060003@ti.com>
References: <1421254729-10602-1-git-send-email-balbi@ti.com> <1421254729-10602-3-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:39995 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751256AbbAOHtW (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 15 Jan 2015 02:49:22 -0500
In-Reply-To: <1421254729-10602-3-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>, davem@davemloft.net
Cc: Tony Lindgren <tony@atomide.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, netdev@vger.kernel.org

On Wednesday 14 January 2015 10:28 PM, Felipe Balbi wrote:
> CPSW never uses RX_THRESHOLD or MISC interrupts. In
> fact, they are always kept masked in their appropriate
> IRQ Enable register.
> 
> Instead of allocating an IRQ that never fires, it's best
> to remove that code altogether and let future patches
> implement it if anybody needs those.
> 
> Signed-off-by: Felipe Balbi <balbi@ti.com>

Instead of introducing dummy ISR in previous patch and then removing in
this patch, both can be squashed into a single patch.

Regards
Mugunthan V N
