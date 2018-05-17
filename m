From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCHv2 0/5] Runtime PM support for wlcore
Date: Thu, 17 May 2018 11:50:24 -0700
Message-ID: <20180517185029.71716-1-tony@atomide.com>
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kalle Valo <kvalo-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Cc: Eyal Reizer <eyalr-l0cyMroinI0@public.gmane.org>, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>, Guy Mishol <guym-l0cyMroinI0@public.gmane.org>, Luca Coelho <luciano.coelho-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Maital Hahn <maitalm-l0cyMroinI0@public.gmane.org>, Maxim Altshul <maxim.altshul-l0cyMroinI0@public.gmane.org>, Shahar Patury <shaharp-l0cyMroinI0@public.gmane.org>, linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi all,

Here's a series of patches to add runtime PM support for wlcore. It does not
yet implement autosuspend support, but let's get this tested first as the
autosuspend can mask enable/disable issues easily.

Regards,

Tony

Changes since v1:

- Fix issues reported by Eyal for recovery

- Add few patches for enable/disable issues found when using runtime PM

- Remove unused ps.h includes

Tony Lindgren (5):
  wlcore: Add missing PM call for wlcore_cmd_wait_for_event_or_timeout()
  wlcore: Make sure PM calls are paired
  wlcore: Add support for runtime PM
  wlcore: Fix misplaced PM call for scan_complete_work()
  wlcore: sdio: Warn about runtime PM suspend errors

 drivers/net/wireless/ti/wl18xx/debugfs.c    |  26 +-
 drivers/net/wireless/ti/wlcore/acx.c        |   1 -
 drivers/net/wireless/ti/wlcore/cmd.c        |   9 +
 drivers/net/wireless/ti/wlcore/debugfs.c    |  79 ++--
 drivers/net/wireless/ti/wlcore/main.c       | 404 ++++++++++++++------
 drivers/net/wireless/ti/wlcore/ps.c         | 146 -------
 drivers/net/wireless/ti/wlcore/ps.h         |   3 -
 drivers/net/wireless/ti/wlcore/scan.c       |  12 +-
 drivers/net/wireless/ti/wlcore/sdio.c       |   7 +
 drivers/net/wireless/ti/wlcore/sysfs.c      |  12 +-
 drivers/net/wireless/ti/wlcore/testmode.c   |  18 +-
 drivers/net/wireless/ti/wlcore/tx.c         |   9 +-
 drivers/net/wireless/ti/wlcore/vendor_cmd.c |  27 +-
 drivers/net/wireless/ti/wlcore/wlcore.h     |   1 -
 drivers/net/wireless/ti/wlcore/wlcore_i.h   |   1 -
 15 files changed, 421 insertions(+), 334 deletions(-)

-- 
2.17.0
