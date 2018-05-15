From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 0/2] Runtime PM support for wlcore
Date: Tue, 15 May 2018 09:13:13 -0700
Message-ID: <20180515161315.1997-1-tony@atomide.com>
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kalle Valo <kvalo-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Cc: Eyal Reizer <eyalr-l0cyMroinI0@public.gmane.org>, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>, Guy Mishol <guym-l0cyMroinI0@public.gmane.org>, Luca Coelho <luciano.coelho-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Maital Hahn <maitalm-l0cyMroinI0@public.gmane.org>, Maxim Altshul <maxim.altshul-l0cyMroinI0@public.gmane.org>, Shahar Patury <shaharp-l0cyMroinI0@public.gmane.org>, linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi all,

Here are two patches to add runtime PM support for wlcore. I've
only lightly tested this so far, so some more testing sure would be
appreciated.I have no idea about the test mode for example.

You also want patch "[PATCH] wlcore: sdio: Fix flakey SDIO
runtime PM handling" that I posted earlier today as otherwise
you will get bogus errors.

Regards,

Tony


Tony Lindgren (2):
  wlcore: Make sure PM calls are paired
  wlcore: Add support runtime PM

 drivers/net/wireless/ti/wl18xx/debugfs.c    |  26 +-
 drivers/net/wireless/ti/wlcore/debugfs.c    |  79 ++--
 drivers/net/wireless/ti/wlcore/main.c       | 405 ++++++++++++++------
 drivers/net/wireless/ti/wlcore/ps.c         | 146 -------
 drivers/net/wireless/ti/wlcore/ps.h         |   3 -
 drivers/net/wireless/ti/wlcore/scan.c       |   9 +-
 drivers/net/wireless/ti/wlcore/sysfs.c      |  10 +-
 drivers/net/wireless/ti/wlcore/testmode.c   |  17 +-
 drivers/net/wireless/ti/wlcore/tx.c         |   9 +-
 drivers/net/wireless/ti/wlcore/vendor_cmd.c |  26 +-
 drivers/net/wireless/ti/wlcore/wlcore.h     |   1 -
 drivers/net/wireless/ti/wlcore/wlcore_i.h   |   1 -
 12 files changed, 405 insertions(+), 327 deletions(-)

-- 
2.17.0
