From: Amit Virdi <amit.virdi-qxv4g6HH51o@public.gmane.org>
Subject: [PATCH 0/4] usb: dwc3: Fixes and code cleanup
Date: Fri, 19 Dec 2014 12:40:14 +0530
Message-ID: <cover.1418972323.git.amit.virdi@st.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: balbi-l0cyMroinI0@public.gmane.org, pratyush.anand-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, ajay.khandelwal-qxv4g6HH51o@public.gmane.org, Amit Virdi <amit.virdi-qxv4g6HH51o@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

The first two patches are bug fixes in TRB preparation when scatter gather is
used. The next two patches are basically trivial and part of code cleanup.

The patches are rebased on Balbi's testing/next branch.

Amit Virdi (4):
  usb: dwc3: gadget: Fix TRB preparation during SG
  usb: dwc3: gadget: Stop TRB preparation after limit is reached
  usb: dwc3: gadget: Remove redundant check
  usb: dwc3: Remove current_trb as it is unused

 drivers/usb/dwc3/core.h   | 3 ---
 drivers/usb/dwc3/gadget.c | 9 ++++-----
 2 files changed, 4 insertions(+), 8 deletions(-)

-- 
1.8.0

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
