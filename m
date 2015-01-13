From: Amit Virdi <amit.virdi-qxv4g6HH51o@public.gmane.org>
Subject: [PATCH RESEND(2) 0/2] usb: dwc3: gadget: Bug fixes
Date: Tue, 13 Jan 2015 14:27:19 +0530
Message-ID: <cover.1421138825.git.amit.virdi@st.com>
References: <54B4DB57.4020009@st.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <54B4DB57.4020009-qxv4g6HH51o@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: balbi-l0cyMroinI0@public.gmane.org, pratyush.anand-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, ajay.khandelwal-qxv4g6HH51o@public.gmane.org, Amit Virdi <amit.virdi-qxv4g6HH51o@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

This is a re-submission of patches [1/4] and [2/4] from:
	http://www.spinics.net/lists/linux-usb/msg118841.html

Commit log of both these patches has been modified for aided clarity. These
patches have been rebased on Balbi's testing/next.

Patches [3/4] and [4/4] were accepted as they were. 

Amit Virdi (2):
  usb: dwc3: gadget: Fix TRB preparation during SG
  usb: dwc3: gadget: Stop TRB preparation after limit is reached

 drivers/usb/dwc3/gadget.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

-- 
1.8.0

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
