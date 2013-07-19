From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH] ARM: OMAP3: Beagle: Fix USB Host on beagle xM Ax/Bx
Date: Fri, 19 Jul 2013 16:04:15 +0300
Message-ID: <51E9394F.8040004@ti.com>
References: <1366024808-4691-1-git-send-email-rogerq@ti.com> <51DC09E7.1070302@denx.de> <51DC164B.5010608@ti.com> <51DC1B47.7070504@denx.de> <51DE87D3.5030600@ti.com> <51DEA7F1.1050902@denx.de> <51DEC2CE.70400@ti.com> <51DED076.3040000@denx.de> <51DEF0DE.4050607@denx.de> <51DFC92F.1050701@ti.com> <51DFDFD4.3040900@denx.de> <51E3AFF4.7060607@ti.com> <51E3B1B1.3060202@denx.de> <51E55AAE.3000209@ti.com> <51E5727B.2010500@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:59390 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760378Ab3GSNEr (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 19 Jul 2013 09:04:47 -0400
In-Reply-To: <51E5727B.2010500@denx.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Stefan Roese <sr@denx.de>
Cc: tony@atomide.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, balbi@ti.com, Alan Stern <stern@rowland.harvard.edu>

On 07/16/2013 07:19 PM, Stefan Roese wrote:
> Hi Roger,
> 
> On 07/16/2013 04:37 PM, Roger Quadros wrote:
>> On 07/15/2013 11:24 AM, Stefan Roese wrote:
>>> On 07/15/2013 10:16 AM, Roger Quadros wrote:
>>>>>> I can only test on beagle-xm (which is also rev. C2) with integrated SMSC ethernet chip
>>>>>> as I don't have an external USB-ethernet adapter.
>>>>>
>>>>> Too bad. This difference in boards makes the tests a bit less
>>>>> meaningful. Is there really no USB-ethernet adapter somewhere in your
>>>>> department (perhaps a non-SMSC95xx might serve as well?)? I might
>>>>> send/order you one if necessary. ;)
>>>>
>>>> Thanks for the offer :). I'll just get one for myself by today/tomorrow.
>>>> The one available here uses this driver "drivers/net/usb/asix.c"
>>>
>>> Great.
>>>
>>
>> OK. Finally managed to reproduce the problem.
> 
> Ahh, great. Thanks for the effort.
> 
>> Don't know the root cause yet. Will need to investigate.
> 
> Thanks. Just let me know if I can be of any assistance (testing etc).
> 

For the record, not resetting the OMAP USB Host Module (UHH) from u-boot seems to solve
the issue.

Patch for u-boot below.

From: Roger Quadros <rogerq@ti.com>
Date: Fri, 19 Jul 2013 15:26:14 +0300
Subject: [PATCH] usb: ehci-omap: Don't softreset USB High-speed Host (UHH) Module

Fixes NFS root problems with Beagle (3530 ES1.0) when used with
external USB-ethernet adapter and "USB start" command used within
u-boot.

Soft resetting the UHH module causes instability issues on
all OMAPs so we just avoid it.

See OMAP36xx Errata
  i571: USB host EHCI may stall when entering smart-standby mode
  i660: USBHOST Configured In Smart-Idle Can Lead To a Deadlock

On OMAP4/5, soft-resetting the UHH module can put it into
Smart-Idle mode and lead to a deadlock.

On OMAP3 this doesn't seem to be the case but still instabilities
are observed on beagle (3530 ES1.0) if soft-reset is used.
 e.g. NFS root failures with Linux kernel.

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 drivers/usb/host/ehci-omap.c |   17 +++++++++++++++++
 1 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/drivers/usb/host/ehci-omap.c b/drivers/usb/host/ehci-omap.c
index 086c697..628e86c 100644
--- a/drivers/usb/host/ehci-omap.c
+++ b/drivers/usb/host/ehci-omap.c
@@ -42,6 +42,22 @@ static struct omap_ehci *const ehci = (struct omap_ehci *)OMAP_EHCI_BASE;
 
 static int omap_uhh_reset(void)
 {
+/*
+ * Soft resetting the UHH module causes instability issues on
+ * all OMAPs so we just avoid it.
+ *
+ * See OMAP36xx Errata
+ *  i571: USB host EHCI may stall when entering smart-standby mode
+ *  i660: USBHOST Configured In Smart-Idle Can Lead To a Deadlock
+ *
+ * On OMAP4/5, soft-resetting the UHH module will put it into
+ * Smart-Idle mode and lead to a deadlock.
+ *
+ * On OMAP3 this doesn't seem to be the case but still instabilities
+ * are observed on beagle (3530 ES1.0) if soft-reset is used.
+ * e.g. NFS root failures with Linux kernel.
+ */
+#if 0
 	unsigned long init = get_timer(0);
 
 	/* perform UHH soft reset, and wait until reset is complete */
@@ -53,6 +69,7 @@ static int omap_uhh_reset(void)
 			debug("OMAP UHH error: timeout resetting ehci\n");
 			return -EL3RST;
 		}
+#endif
 
 	return 0;
 }
-- 
1.7.4.1



