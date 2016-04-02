From: Felipe Balbi <balbif-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 0/6] usb: dwc3: DMA API usage
Date: Sat,  2 Apr 2016 11:28:53 +0300
Message-ID: <1459585739-21204-1-git-send-email-felipe.balbi@linux.intel.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linux USB Mailing List <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Santosh Shilimkar <ssantosh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Srinivas Kandagatla <srinivas.kandagatla-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Maxime Coquelin <maxime.coquelin-qxv4g6HH51o@public.gmane.org>, Patrice Chotard <patrice.chotard-qxv4g6HH51o@public.gmane.org>, Andy Gross <andy.gross-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "Ivan T . Ivanov" <ivan.ivanov-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Felipe Balbi <felipe.balbi-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi,

this should make dwc3's DMA API usage more
compliant. This is still *UNTESTED* patches but I'd
like people to give it a round of review to make
sure I didn't miss anything.

I have questions about dev->dma_parms, what should
be done with that ?

If there's anything I missed, please _do_ let me
know. Also, I think Keystone's DMA mask could be
more than 32 bits. IIRC, Keystone's DMA can address
more than 32-bits, right Santosh ?

patches are also available in my k.org tree on
branch dwc3-dma-mask for those of you willing to
give it a go on real HW.

Felipe Balbi (6):
  usb: dwc3: st: fix dma initialization
  usb: dwc3: omap: don't access DMA bits directly
  usb: dwc3: keystone: initialize dma_mask and coherent
  usb: dwc3: of-simple: initialize dma_mask and coherent
  usb: dwc3: core: don't access DMA bits directly
  usb: dwc3: host: don't access DMA bits directly

 drivers/usb/dwc3/core.c           | 6 +-----
 drivers/usb/dwc3/dwc3-keystone.c  | 5 +----
 drivers/usb/dwc3/dwc3-of-simple.c | 1 +
 drivers/usb/dwc3/dwc3-omap.c      | 4 +---
 drivers/usb/dwc3/dwc3-st.c        | 3 ++-
 drivers/usb/dwc3/host.c           | 5 +----
 6 files changed, 7 insertions(+), 17 deletions(-)

-- 
2.7.0

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
