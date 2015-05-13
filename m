From: Eric Dumazet <eric.dumazet@gmail.com>
Subject: Re: regression with today's linux-next
Date: Wed, 13 May 2015 14:04:53 -0700
Message-ID: <1431551093.27831.5.camel@edumazet-glaptop2.roam.corp.google.com>
References: <20150513182738.GA28201@saruman.tx.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ie0-f181.google.com ([209.85.223.181]:33434 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965383AbbEMVEz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 13 May 2015 17:04:55 -0400
In-Reply-To: <20150513182738.GA28201@saruman.tx.rr.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: Alexander Duyck <alexander.h.duyck@redhat.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Tony Lindgren <tony@atomide.com>

On Wed, 2015-05-13 at 13:27 -0500, Felipe Balbi wrote:
> Hi Alexander,
> 
> your commit 9451980a6646 (net: Use cached copy of pfmemalloc to avoid
> accessing page) regresses most OMAP-based boards with a NULL pointer
> dereference.
> 
> Below you can find git bisect log and a serial console capture of the
> problem.

Are you using jumbo frames ?

Please try :

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index d67e612bf0ef..701318378142 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -414,9 +414,14 @@ struct sk_buff *__netdev_alloc_skb(struct net_device *dev, unsigned int len,
 	len += NET_SKB_PAD;
 
 	if ((len > SKB_WITH_OVERHEAD(PAGE_SIZE)) ||
-	    (gfp_mask & (__GFP_WAIT | GFP_DMA)))
-		return __alloc_skb(len, gfp_mask, SKB_ALLOC_RX, NUMA_NO_NODE);
-
+	    (gfp_mask & (__GFP_WAIT | GFP_DMA))) {
+		skb = __alloc_skb(len, gfp_mask, SKB_ALLOC_RX, NUMA_NO_NODE);
+		if (skb) {
+			skb_reserve(skb, NET_SKB_PAD);
+			skb->dev = dev;
+		}
+		return skb;
+	}
 	len += SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
 	len = SKB_DATA_ALIGN(len);
 




