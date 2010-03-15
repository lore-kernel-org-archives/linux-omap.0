From: Tony Lindgren <tony@atomide.com>
Subject: Re: Commit 0c8219f0... breaks omap7xx support
Date: Mon, 15 Mar 2010 11:29:39 -0700
Message-ID: <20100315182939.GV2900@atomide.com>
References: <6cb013311003062056v3ed83a53u2636838348bf4845@mail.gmail.com>
 <20100309004832.GK2900@atomide.com>
 <6cb013311003081751u2c7cd8c6v59472ee85ac90e77@mail.gmail.com>
 <20100309024602.GQ2900@atomide.com>
 <6cb013311003081906n751bedb4k2794ed40ed68d7ec@mail.gmail.com>
 <20100309155636.GS2900@atomide.com>
 <6cb013311003091541k6a18c16bv4bb3d35f101e5bab@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="RMedoP2+Pr6Rq0N2"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:59016 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965627Ab0COS2P (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 15 Mar 2010 14:28:15 -0400
Content-Disposition: inline
In-Reply-To: <6cb013311003091541k6a18c16bv4bb3d35f101e5bab@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Cory Maccarrone <darkstar6262@gmail.com>
Cc: linux-omap@vger.kernel.org, miknix@gmail.com, a.j.buxton@gmail.com, linwizard-devel@lists.sf.net


--RMedoP2+Pr6Rq0N2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

* Cory Maccarrone <darkstar6262@gmail.com> [100309 15:38]:
> On Tue, Mar 9, 2010 at 7:56 AM, Tony Lindgren <tony@atomide.com> wrote:
> >
> > Does your system boot without any patches if DEBUG_LL is not set
> > in your .config?
> 
> No, it doesn't.  Seems like the debugging code is still trying to run,
> even disabled.  If I add in that check, it'll boot with DEBUG_LL not
> set, but won't without that.

Sorry for the delay on this. How about with the following patch with
DEBUG_LL not set?

Note that this is using the shift register now too.

Regards,

Tony

--RMedoP2+Pr6Rq0N2
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: inline; filename="debug-ll.patch"

>From 240b34f7efbf26ad4f39438d055b0931e8e7496e Mon Sep 17 00:00:00 2001
From: Tony Lindgren <tony@atomide.com>
Date: Mon, 15 Mar 2010 10:47:08 -0700
Subject: [PATCH] omap: Add back UART MDR1 check into uncompress.h

Recent DEBUG_LL and uncompress.h changes removed the check_port()
as pointed out by Cory Maccarrone <darkstar6262@gmail.com>.

This causes some boards to not boot, so add back the MDR1 register
check. The MDR1 register tells the mode of omap uart. Based on
an earlier patch by Cory Maccarrone <darkstar6262@gmail.com>.

Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/plat-omap/include/plat/uncompress.h b/arch/arm/plat-omap/include/plat/uncompress.h
index 81d9ec5..dc37b2c 100644
--- a/arch/arm/plat-omap/include/plat/uncompress.h
+++ b/arch/arm/plat-omap/include/plat/uncompress.h
@@ -24,6 +24,8 @@
 
 #include <plat/serial.h>
 
+#define MDR1_MODE_MASK			0x07
+
 static volatile u8 *uart1_base;
 static int uart1_shift;
 
@@ -48,6 +50,10 @@ static void putc(int c)
 	if (!uart_base)
 		return;
 
+	/* Check for UART 16x mode */
+	if ((uart_base[UART_OMAP_MDR1 << uart_shift] & MDR1_MODE_MASK) != 0)
+		return;
+
 	while (!(uart_base[UART_LSR << uart_shift] & UART_LSR_THRE))
 		barrier();
 	uart_base[UART_TX << uart_shift] = c;

--RMedoP2+Pr6Rq0N2--
