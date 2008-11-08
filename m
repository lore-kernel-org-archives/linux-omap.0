From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: Re: [FYI] TI dspbridge rebase against latest l-o
Date: Sat, 08 Nov 2008 06:27:08 +0200 (EET)
Message-ID: <20081108.062708.175770463.Hiroshi.DOYU@nokia.com>
References: <E1KyeIa-0001sk-2k@amazonia.comcast.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:41621 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752058AbYKHE1W (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Nov 2008 23:27:22 -0500
In-Reply-To: <E1KyeIa-0001sk-2k@amazonia.comcast.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: rick@efn.org
Cc: linux-omap@vger.kernel.org, x00omar@ti.com

Hi Rick, thank you for comments.

From: "ext Rick Bronson" <rick@efn.org>
Subject: Re: [FYI] TI dspbridge rebase against latest l-o
Date: Fri, 07 Nov 2008 19:15:44 -0800

> Hi Hiroshi,
> 
>   I just tried this on my beagleboard and I'm not sure if it worked.
> First, did you forget to add that you need "mem=122m" in the
> bootargs?  Also do you need to add in the addresses like:

I don't think that it's mandatory. Without phys_* parameters, just
dynamic allocation from non-reserved area would be used. This may
sometimes suffer from memory allocation, especially in the case that
the target board has small amount of memory(RAM).

> sudo modprobe bridgedriver phys_mempool_base=0x87a00000 phys_mempool_size=0x600000 base_img=/home/rick/dspbridge_binaries/ddspbase_tiomap3430.dof64P
> 
>   Anyway, when I followed the instructions (except for above) I get:
> 
> > sudo modprobe bridgedriver phys_mempool_base=0x87a00000 phys_mempool_size=0x60
> 0000 base_img=/home/rick/dspbridge_binaries/ddspbase_tiomap3430.dof64P
> > lsmod                                                                         
> Module                  Size  Used by                                           
> bridgedriver          356488  0                                                 
> > cat /proc/interrupts | grep Dsp
>  26:          3        INTC  DspBridge                                          
>  28:          0        INTC  DspBridge                                          
> > /home/rick/dspbridge_binaries/ping.out                                        
> >
> > cat /proc/interrupts | grep Dsp                                               
>  26:          4        INTC  DspBridge                                          
>  28:          0        INTC  DspBridge                                          
>
>   After this, no matter how many times I run ping, I get the same
> number of interrupts.  How do I know ping is really working?

The above is a bit different from mine as below, where the count of
mailbox interrupt are incremented reasonably.

bridge:~$ modprobe bridgedriver base_img=ddspbase_tiomap3430.dof64P 
bridge:~$ grep DspBridge /proc/interrupts 
 26:          3        INTC  DspBridge  mailbox
 28:          0        INTC  DspBridge  iommu fault
bridge:~$ ./ping.out > /dev/null
bridge:~$ grep DspBridge /proc/interrupts 
 26:        169        INTC  DspBridge  mailbox
 28:          0        INTC  DspBridge  iommu fault
bridge:~$ ./ping.out > /dev/null
bridge:~$ grep DspBridge /proc/interrupts 
 26:        334        INTC  DspBridge  mailbox
 28:          0        INTC  DspBridge  iommu fault
bridge:~$ 

You can see how it's working by appending GT_str="**=01234567" on
module parameter to investigate further.

       Hiroshi DOYU

>From f9331a0c1b04cf812624b0e1d96ce491ddb0d7d1 Mon Sep 17 00:00:00 2001
From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Date: Sat, 8 Nov 2008 06:17:08 +0200
Subject: [PATCH 1/1] BRIDGE: use more detail name for interrupt claiming device

Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
---
 drivers/dsp/bridge/wmd/io_sm.c  |    2 +-
 drivers/dsp/bridge/wmd/ue_deh.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dsp/bridge/wmd/io_sm.c b/drivers/dsp/bridge/wmd/io_sm.c
index 08bc4d3..6843a42 100644
--- a/drivers/dsp/bridge/wmd/io_sm.c
+++ b/drivers/dsp/bridge/wmd/io_sm.c
@@ -341,7 +341,7 @@ DSP_STATUS WMD_IO_Create(OUT struct IO_MGR **phIOMgr,
 		if (devType == DSP_UNIT) {
 			/* Plug the channel ISR:. */
                        if ((request_irq(INT_MAIL_MPU_IRQ, IO_ISR, 0,
-                                           "DspBridge", (void *)pIOMgr)) == 0)
+                                           "DspBridge\tmailbox", (void *)pIOMgr)) == 0)
                                status = DSP_SOK;
                        else
                                status = DSP_EFAIL;
diff --git a/drivers/dsp/bridge/wmd/ue_deh.c b/drivers/dsp/bridge/wmd/ue_deh.c
index 7e450b3..2110353 100644
--- a/drivers/dsp/bridge/wmd/ue_deh.c
+++ b/drivers/dsp/bridge/wmd/ue_deh.c
@@ -121,7 +121,7 @@ DSP_STATUS WMD_DEH_Create(OUT struct DEH_MGR **phDehMgr,
 			pDehMgr->errInfo.dwVal3 = 0L;
 			/* Install ISR function for DSP MMU fault */
                        if ((request_irq(INT_DSP_MMU_IRQ, MMU_FaultIsr, 0,
-                                           "DspBridge", (void *)pDehMgr)) == 0)
+                                           "DspBridge\tiommu fault", (void *)pDehMgr)) == 0)
                                status = DSP_SOK;
                        else
                                status = DSP_EFAIL;
-- 
1.5.5.1.357.g1af8b

