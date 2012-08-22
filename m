From: Timo Kokkonen <timo.t.kokkonen@iki.fi>
Subject: [PATCH 8/8] ir-rx51: Remove useless variable from struct lirc_rx51
Date: Wed, 22 Aug 2012 22:50:41 +0300
Message-ID: <1345665041-15211-9-git-send-email-timo.t.kokkonen@iki.fi>
References: <1345665041-15211-1-git-send-email-timo.t.kokkonen@iki.fi>
Return-path: <linux-media-owner@vger.kernel.org>
In-Reply-To: <1345665041-15211-1-git-send-email-timo.t.kokkonen@iki.fi>
Sender: linux-media-owner@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-media@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

As clearly visible from the patch, this variable has no useful purpose
what so ever. Thus, it can be removed altogether without any side
effects.

Signed-off-by: Timo Kokkonen <timo.t.kokkonen@iki.fi>
---
 drivers/media/rc/ir-rx51.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/media/rc/ir-rx51.c b/drivers/media/rc/ir-rx51.c
index ac7d3f0..23bc8c0 100644
--- a/drivers/media/rc/ir-rx51.c
+++ b/drivers/media/rc/ir-rx51.c
@@ -55,7 +55,6 @@ struct lirc_rx51 {
 	unsigned int	freq;		/* carrier frequency */
 	unsigned int	duty_cycle;	/* carrier duty cycle */
 	unsigned int	irq_num;
-	unsigned int	match;
 	int		wbuf[WBUF_LEN];
 	int		wbuf_index;
 	unsigned long	device_is_open;
@@ -100,8 +99,6 @@ static int init_timing_params(struct lirc_rx51 *lirc_rx51)
 	omap_dm_timer_set_int_enable(lirc_rx51->pulse_timer, 0);
 	omap_dm_timer_start(lirc_rx51->pulse_timer);
 
-	lirc_rx51->match = 0;
-
 	return 0;
 }
 
@@ -111,11 +108,7 @@ static int pulse_timer_set_timeout(struct lirc_rx51 *lirc_rx51, int usec)
 
 	BUG_ON(usec < 0);
 
-	if (lirc_rx51->match == 0)
-		counter = omap_dm_timer_read_counter(lirc_rx51->pulse_timer);
-	else
-		counter = lirc_rx51->match;
-
+	counter = omap_dm_timer_read_counter(lirc_rx51->pulse_timer);
 	counter += (u32)(lirc_rx51->fclk_khz * usec / (1000));
 	omap_dm_timer_set_match(lirc_rx51->pulse_timer, 1, counter);
 	omap_dm_timer_set_int_enable(lirc_rx51->pulse_timer,
-- 
1.7.12
