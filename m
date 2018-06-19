From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 4/8] wlcore: Fix misplaced PM call for scan_complete_work()
Date: Tue, 19 Jun 2018 02:43:38 -0700
Message-ID: <20180619094342.81831-5-tony@atomide.com>
References: <20180619094342.81831-1-tony@atomide.com>
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20180619094342.81831-1-tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kalle Valo <kvalo-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Cc: Eyal Reizer <eyalr-l0cyMroinI0@public.gmane.org>, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>, Guy Mishol <guym-l0cyMroinI0@public.gmane.org>, Luca Coelho <luciano.coelho-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Maital Hahn <maitalm-l0cyMroinI0@public.gmane.org>, Maxim Altshul <maxim.altshul-l0cyMroinI0@public.gmane.org>, Shahar Patury <shaharp-l0cyMroinI0@public.gmane.org>, linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

With runtime PM enabled, we now need to have wlcore enabled longer
until after we're done calling wlcore_cmd_regdomain_config_locked():

scan_complete_work()
 wlcore_cmd_regdomain_config_locked()
   wlcore_cmd_send_failsafe()
     wl12xx_sdio_raw_read()

Note that this is not needed before runtime PM support as the
custom PM code had it's own timer. We have not yet enabled runtime
PM autosuspend for wlcore and this is why this issue now shows up.

Let's fix the issues first before we enable runtime PM autosuspend.

Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
---
 drivers/net/wireless/ti/wlcore/scan.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ti/wlcore/scan.c b/drivers/net/wireless/ti/wlcore/scan.c
--- a/drivers/net/wireless/ti/wlcore/scan.c
+++ b/drivers/net/wireless/ti/wlcore/scan.c
@@ -78,8 +78,6 @@ void wl1271_scan_complete_work(struct work_struct *work)
 		wl1271_cmd_build_ap_probe_req(wl, wlvif, wlvif->probereq);
 	}
 
-	pm_runtime_put(wl->dev);
