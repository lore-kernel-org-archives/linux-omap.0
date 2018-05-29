From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: [RFTv3 0/6] Runtime PM support for wlcore
Date: Tue, 29 May 2018 11:05:59 -0700
Message-ID: <20180529180605.73622-1-tony@atomide.com>
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kalle Valo <kvalo-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Cc: Eyal Reizer <eyalr-l0cyMroinI0@public.gmane.org>, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>, Guy Mishol <guym-l0cyMroinI0@public.gmane.org>, Luca Coelho <luciano.coelho-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Maital Hahn <maitalm-l0cyMroinI0@public.gmane.org>, Maxim Altshul <maxim.altshul-l0cyMroinI0@public.gmane.org>, Shahar Patury <shaharp-l0cyMroinI0@public.gmane.org>, linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi all,

Here's the third version of wlcore runtime PM changes. Things
seem to be working for me just fine now after few fixes listed
below. Please do test again though, and then I'll post this
series and one more patch after v4.18-rc1 to enable runtime PM
autosuspend support. So hopefully we can have these merged early
on for v4.19.

For testing, please make sure you have also applied patch
"[PATCHv2] wlcore: sdio: Fix flakey SDIO runtime PM handling"
to avoid bogus errors.

Regards,

Tony

Changes since v2:

- Add fix "wclore: Fix timout errors after recovery" that is not needed
  before runtime PM conversion

- Add fix from Eyal for "wlcore: Use generic runtime pm calls for wowlan
  elp configuration" that is also not needed before runtime PM conversion

- Return early from wlcore_runtime_resume() on ELP timeout to avoid
  clearing WL1271_FLAG_IN_ELP bit

- Tag as RFT as we still need to do more testing and add runtime PM
  autosuspend support before merging

- Drop "wlcore: sdio: Warn about runtime PM suspend errors" that should
  no longer be needed

Changes since v1:

- Fix issues reported by Eyal for recovery

- Add few patches for enable/disable issues found when using runtime PM

- Remove unused ps.h includes


Eyal Reizer (1):
  wlcore: Use generic runtime pm calls for wowlan elp configuration

Tony Lindgren (5):
  wlcore: Add missing PM call for wlcore_cmd_wait_for_event_or_timeout()
  wlcore: Make sure PM calls are paired
  wlcore: Add support for runtime PM
  wlcore: Fix misplaced PM call for scan_complete_work()
  wclore: Fix timout errors after recovery

 drivers/net/wireless/ti/wl18xx/debugfs.c    |  26 +-
 drivers/net/wireless/ti/wlcore/acx.c        |   1 -
 drivers/net/wireless/ti/wlcore/cmd.c        |   9 +
 drivers/net/wireless/ti/wlcore/debugfs.c    |  79 ++--
 drivers/net/wireless/ti/wlcore/main.c       | 464 +++++++++++++-------
 drivers/net/wireless/ti/wlcore/ps.c         | 146 ------
 drivers/net/wireless/ti/wlcore/ps.h         |   3 -
 drivers/net/wireless/ti/wlcore/scan.c       |  12 +-
 drivers/net/wireless/ti/wlcore/sysfs.c      |  12 +-
 drivers/net/wireless/ti/wlcore/testmode.c   |  18 +-
 drivers/net/wireless/ti/wlcore/tx.c         |   9 +-
 drivers/net/wireless/ti/wlcore/vendor_cmd.c |  27 +-
 drivers/net/wireless/ti/wlcore/wlcore.h     |   1 -
 drivers/net/wireless/ti/wlcore/wlcore_i.h   |   1 -
 14 files changed, 436 insertions(+), 372 deletions(-)

-- 
2.17.0
