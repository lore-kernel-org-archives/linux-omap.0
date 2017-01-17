From: Alexandre Bailon <abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Subject: [PATCH v2 3/3] dmaengine: cppi41: Fix teardown warnings
Date: Tue, 17 Jan 2017 15:20:16 +0100
Message-ID: <20170117142016.11163-4-abailon@baylibre.com>
References: <20170117142016.11163-1-abailon@baylibre.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170117142016.11163-1-abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, ptitiano-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, b-liu-l0cyMroinI0@public.gmane.org, sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Alexandre Bailon <abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

During the teardown of a RX channel, because there is only one
completion queue available for RX channel, descriptor of another
channel may be popped which will cause 2 warnings:
- the first one because we popped a wrong descriptor
  (neither the channel's descriptor, nor the teardown descriptor).
- the second one happen during the teardown of another channel,
  because we can't find the channel descriptor
  (that is, the one that caused the first warning).
To avoid that, use one free queue instead of a transmit completion queue.

Note that fix doesn't fix all the teardown warnings:
I still get some when I run some corner case.

Signed-off-by: Alexandre Bailon <abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
---
 drivers/dma/cppi41.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/cppi41.c b/drivers/dma/cppi41.c
index aab1e5a..aba741c 100644
--- a/drivers/dma/cppi41.c
+++ b/drivers/dma/cppi41.c
@@ -630,7 +630,7 @@ static int cppi41_tear_down_chan(struct cppi41_channel *c)
 		if (!c->is_tx) {
 			reg |= GCR_STARV_RETRY;
 			reg |= GCR_DESC_TYPE_HOST;
-			reg |= c->q_comp_num;
+			reg |= cdd->td_queue.complete;
 		}
 		reg |= GCR_TEARDOWN;
 		cppi_writel(reg, c->gcr_reg);
@@ -641,7 +641,7 @@ static int cppi41_tear_down_chan(struct cppi41_channel *c)
 	if (!c->td_seen || !c->td_desc_seen) {
 
 		desc_phys = cppi41_pop_desc(cdd, cdd->td_queue.complete);
-		if (!desc_phys)
+		if (!desc_phys && c->is_tx)
 			desc_phys = cppi41_pop_desc(cdd, c->q_comp_num);
 
 		if (desc_phys == c->desc_phys) {
-- 
2.10.2

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
