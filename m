From: Keshava Munegowda <keshava_mgowda-l0cyMroinI0@public.gmane.org>
Subject: [RFC] [PATCH 0/5] usb: ohci: omap: Add OMAP4 Support
Date: Fri, 20 Aug 2010 00:48:05 +0530
Message-ID: <1282245490-24339-1-git-send-email-keshava_mgowda@ti.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Keshava Munegowda <keshava_mgowda-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

The OMAP4 OHCI supports only two ports and hence two TLL channels.
Each port is driven by seperate clocks. The OHCI controller is operated
with the following two serial interface modes.
- External PHY mode 
- USBTLL mode

The PHY mode with Unidirectional 6-pin encoding (TX: DAT/SE0 mode) 
is validated  with these patches.

patch summary:

	1/5	formats the code of ehci-omap.c so that omap4 specific 
		changes can be easily inserted.  
	2/5 	implements OMAP4 support
	3/5 	This is hack to do the mux setting for OHCI pad configuration;
		This patch will be replaced when the mux framework for omap4
		is introduced.
	4/5	Adds the OHCI IRQ number and base address resources in 
		ehci initialization.
	5/5	registering OHCI controller in 4430 sdp board file.

-keshava
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
