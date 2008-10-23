From: "Bright, Dan" <dan.bright@windriver.com>
Subject: Small patch for dsp bridge code
Date: Thu, 23 Oct 2008 15:03:31 -0700
Message-ID: <3DD728A3B927AA438D6367166CC67D0902B1DCFE@ala-mail10.corp.ad.wrs.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:54375 "EHLO mail.wrs.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752292AbYJWWD0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 23 Oct 2008 18:03:26 -0400
Received: from ALA-MAIL03.corp.ad.wrs.com (ala-mail03 [147.11.57.144])
	by mail.wrs.com (8.13.6/8.13.6) with ESMTP id m9NM3Ql2016937
	for <linux-omap@vger.kernel.org>; Thu, 23 Oct 2008 15:03:26 -0700 (PDT)
Content-class: urn:content-classes:message
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hello,

I'm not sure if this code ever get exercised, but I found a small
problem with the 
dsp bridge driver code while debugging the kernel, and thought I'd bring
it to 
someone's attention.

Thanks,
Dan Bright

diff --git a/drivers/dsp/bridge/services/mem.c
b/drivers/dsp/bridge/services/mem.c
index 565b0b8..fff1c4a 100644
--- a/drivers/dsp/bridge/services/mem.c
+++ b/drivers/dsp/bridge/services/mem.c
@@ -355,9 +355,14 @@ void *MEM_AllocPhysMem(u32 cBytes, u32 ulAlign, OUT
u32 *pPhysicalAddress)
 		if (extPhysMemPoolEnabled) {
 			pVaMem = MEM_ExtPhysMemAlloc(cBytes, ulAlign,
 						    (u32 *)&paMem);
-		} else
+		} else {
 			pVaMem = dma_alloc_coherent(NULL, cBytes,
&paMem,
 						   GFP_ATOMIC);
+			/* dma_alloc_coherent returns ~0 on error */
+			if(pVaMem == (void *)~0)
+				pVaMem = NULL;
+		}
+
 		if (pVaMem == NULL) {
 			*pPhysicalAddress = 0;
 			GT_1trace(MEM_debugMask, GT_6CLASS,


