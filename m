From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 0/5] Fix wlcore config firwmare annoyances
Date: Tue, 13 Sep 2016 14:50:38 -0700
Message-ID: <20160913215043.29454-1-tony@atomide.com>
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kalle Valo <kvalo-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Cc: Eyal Reizer <eyalr-l0cyMroinI0@public.gmane.org>, Guy Mishol <guym-l0cyMroinI0@public.gmane.org>, Maital Hahn <maitalm-l0cyMroinI0@public.gmane.org>, Maxim Altshul <maxim.altshul-l0cyMroinI0@public.gmane.org>, Shahar Patury <shaharp-l0cyMroinI0@public.gmane.org>, linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi all,

Here are some patches to fix the firmware loading for wl12xx/wl18xx
when the same rootfs is used on multiple WLAN chip variants.

Regards,

Tony

Tony Lindgren (5):
  wlcore: Prepare family to fix nvs file handling
  wlcore: sdio: Populate config firmware data
  wlcore: sdio: Populate config firmware data
  wlcore: Fix config firmware loading issues
  wlcore: wl18xx: Use chip specific configuration firmware

 drivers/net/wireless/ti/wl18xx/main.c     | 19 ++++----
 drivers/net/wireless/ti/wlcore/boot.c     | 15 ++++--
 drivers/net/wireless/ti/wlcore/main.c     | 34 +++++++++-----
 drivers/net/wireless/ti/wlcore/sdio.c     | 76 +++++++++++++++++++------------
 drivers/net/wireless/ti/wlcore/spi.c      | 48 +++++++++----------
 drivers/net/wireless/ti/wlcore/wlcore_i.h | 12 ++---
 6 files changed, 122 insertions(+), 82 deletions(-)

-- 
2.9.3
