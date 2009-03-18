From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH A 09/15] tidspbridge: cleanup and remove HW_MBOX_IsFull
Date: Wed, 18 Mar 2009 09:29:03 +0200
Message-ID: <20090318072903.GA27135@annwn>
References: <1237339391-20543-1-git-send-email-felipe.contreras@gmail.com> <1237339391-20543-2-git-send-email-felipe.contreras@gmail.com> <1237339391-20543-3-git-send-email-felipe.contreras@gmail.com> <1237339391-20543-4-git-send-email-felipe.contreras@gmail.com> <1237339391-20543-5-git-send-email-felipe.contreras@gmail.com> <1237339391-20543-6-git-send-email-felipe.contreras@gmail.com> <1237339391-20543-7-git-send-email-felipe.contreras@gmail.com> <1237339391-20543-8-git-send-email-felipe.contreras@gmail.com> <1237339391-20543-9-git-send-email-felipe.contreras@gmail.com> <1237339391-20543-10-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f169.google.com ([209.85.218.169]:54653 "EHLO
	mail-bw0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752630AbZCRH3T (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 18 Mar 2009 03:29:19 -0400
Received: by bwz17 with SMTP id 17so380037bwz.37
        for <linux-omap@vger.kernel.org>; Wed, 18 Mar 2009 00:29:16 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1237339391-20543-10-git-send-email-felipe.contreras@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Hari Kanigeri <h-kanigeri2@ti.com>, Hiroshi DOYU <hiroshi.doyu@nokia.com>, Ameya Palande <ameya.palande@nokia.com>, Fernando Guzman Lugo <x0095840@ti.com>, Felipe Contreras <felipe.contreras@nokia.com>

On Wed, Mar 18, 2009 at 03:23:05AM +0200, Felipe Contreras wrote:
> From: Felipe Contreras <felipe.contreras@nokia.com>
> 
> HW_MBOX_IsFull has many convoluted macros and is used only once. Clean
> it up so it's easier to see what it's actually doing.

I probably should have integrated this too:

---
 drivers/dsp/bridge/hw/MLBAccInt.h |   18 ------------------
 drivers/dsp/bridge/hw/MLBRegAcM.h |   20 --------------------
 2 files changed, 0 insertions(+), 38 deletions(-)

diff --git a/drivers/dsp/bridge/hw/MLBAccInt.h b/drivers/dsp/bridge/hw/MLBAccInt.h
index 7a03c6a..1cc5fdd 100644
--- a/drivers/dsp/bridge/hw/MLBAccInt.h
+++ b/drivers/dsp/bridge/hw/MLBAccInt.h
@@ -33,10 +33,6 @@
 						(MLB_BASE_EASIL1 + 50)
 #define EASIL1_MLBMAILBOX_MESSAGE___0_15WriteRegister32  \
 						(MLB_BASE_EASIL1 + 51)
-#define EASIL1_MLBMAILBOX_FIFOSTATUS___0_15ReadRegister32  \
-						(MLB_BASE_EASIL1 + 56)
-#define EASIL1_MLBMAILBOX_FIFOSTATUS___0_15FifoFullMBmRead32 \
-						(MLB_BASE_EASIL1 + 57)
 #define EASIL1_MLBMAILBOX_MSGSTATUS___0_15NbOfMsgMBmRead32  \
 						(MLB_BASE_EASIL1 + 60)
 #define EASIL1_MLBMAILBOX_IRQSTATUS___0_3ReadRegister32  \
@@ -60,18 +56,6 @@
 #define MLB_MAILBOX_MESSAGE___0_15_OFFSET   (u32)(0x0)
 
 
-/* Register set MAILBOX_FIFOSTATUS___REGSET_0_15 address offset, bank address
- * increment and number of banks */
-
-#define MLB_MAILBOX_FIFOSTATUS___REGSET_0_15_OFFSET  (u32)(0x0080)
-#define MLB_MAILBOX_FIFOSTATUS___REGSET_0_15_STEP   (u32)(0x0004)
-
-/* Register offset address definitions relative to register set
- * MAILBOX_FIFOSTATUS___REGSET_0_15 */
-
-#define MLB_MAILBOX_FIFOSTATUS___0_15_OFFSET    (u32)(0x0)
-
-
 /* Register set MAILBOX_MSGSTATUS___REGSET_0_15 address offset, bank address
  * increment and number of banks */
 
@@ -124,8 +108,6 @@
 #define MLB_MAILBOX_SYSCONFIG_AutoIdle_OFFSET        (u32)(0)
 #define MLB_MAILBOX_SYSSTATUS_ResetDone_MASK         (u32)(0x1)
 #define MLB_MAILBOX_SYSSTATUS_ResetDone_OFFSET         (u32)(0)
-#define MLB_MAILBOX_FIFOSTATUS___0_15_FifoFullMBm_MASK   (u32)(0x1)
-#define MLB_MAILBOX_FIFOSTATUS___0_15_FifoFullMBm_OFFSET  (u32)(0)
 #define MLB_MAILBOX_MSGSTATUS___0_15_NbOfMsgMBm_MASK    (u32)(0x7f)
 #define MLB_MAILBOX_MSGSTATUS___0_15_NbOfMsgMBm_OFFSET    (u32)(0)
 
diff --git a/drivers/dsp/bridge/hw/MLBRegAcM.h b/drivers/dsp/bridge/hw/MLBRegAcM.h
index 747a2e1..004e10b 100644
--- a/drivers/dsp/bridge/hw/MLBRegAcM.h
+++ b/drivers/dsp/bridge/hw/MLBRegAcM.h
@@ -126,26 +126,6 @@
 }
 
 
-#define MLBMAILBOX_FIFOSTATUS___0_15ReadRegister32(baseAddress, bank)\
-    (_DEBUG_LEVEL_1_EASI(\
-      EASIL1_MLBMAILBOX_FIFOSTATUS___0_15ReadRegister32),\
-      RD_MEM_32_VOLATILE(((u32)(baseAddress))+\
-      (MLB_MAILBOX_FIFOSTATUS___REGSET_0_15_OFFSET +\
-      MLB_MAILBOX_FIFOSTATUS___0_15_OFFSET+\
-      ((bank)*MLB_MAILBOX_FIFOSTATUS___REGSET_0_15_STEP))))
-
-
-#define MLBMAILBOX_FIFOSTATUS___0_15FifoFullMBmRead32(baseAddress, bank)\
-    (_DEBUG_LEVEL_1_EASI(\
-      EASIL1_MLBMAILBOX_FIFOSTATUS___0_15FifoFullMBmRead32),\
-      (((RD_MEM_32_VOLATILE(((u32)(baseAddress))+\
-      (MLB_MAILBOX_FIFOSTATUS___REGSET_0_15_OFFSET +\
-      MLB_MAILBOX_FIFOSTATUS___0_15_OFFSET+\
-      ((bank)*MLB_MAILBOX_FIFOSTATUS___REGSET_0_15_STEP)))) &\
-      MLB_MAILBOX_FIFOSTATUS___0_15_FifoFullMBm_MASK) >>\
-      MLB_MAILBOX_FIFOSTATUS___0_15_FifoFullMBm_OFFSET))
-
-
 #define MLBMAILBOX_MSGSTATUS___0_15NbOfMsgMBmRead32(baseAddress, bank)\
     (_DEBUG_LEVEL_1_EASI(\
       EASIL1_MLBMAILBOX_MSGSTATUS___0_15NbOfMsgMBmRead32),\
-- 

-- 
Felipe Contreras
