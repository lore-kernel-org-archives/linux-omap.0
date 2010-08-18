From: Keshava Munegowda <keshava_mgowda-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 0/7] usb: ehci: omap: Adding OMAP4 support
Date: Thu, 19 Aug 2010 05:19:30 +0530
Message-ID: <1282175377-2784-1-git-send-email-keshava_mgowda@ti.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Keshava Munegowda <keshava_mgowda-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

The OMAP4 EHCI supports only two ports and hence two TLL channels.
Each port is driven by seperate clocks. Following interface mode 
exists in EHCI controller of OMAP4.
- External PHY mode , with 12 pin ULPI
- USBTLL mode
- HSIC mode 
The External PHY mode is validated with these patches and other modes are TODOs
for later. 
The TLL clocks are enabled and channels are configuared only when
USBTLL mode is choosen.
 
The summary is of patches - 

	1/7  	Add the base address of EHCI controller
	2/7     based on omap3 and omap4 ; the processor specific clocks
		enabled. formats the code of ehci-omap.c so that OMAP4 specific 
		changes can be easily inserted.  
	3/7 	Adding OMAP4 support.
	4/7	Introduces the Kconfig macro to include the ehci driver
		as platform driver 
	5/7 	This is hack to do the mux setting for EHCI pad configuration;
		This patch will be replaced when the mux framework for omap4
		is introduced.
	6/7	Adds the EHCI IRQ number and base address resources in 
		ehci initialization.
	7/7	The EHCI init fuction invocation from 4430 sdp init.

diffstat is below:
 drivers/usb/host/Kconfig                       |    8 
 drivers/usb/host/ehci-hcd.c                    |    2 
 drivers/usb/host/ehci-omap.c                   |  539 +++++++++++++++++--------
 3 files changed 

-- keshava
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
