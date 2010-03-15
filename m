From: Tony Lindgren <tony@atomide.com>
Subject: Re: Commit 0c8219f0... breaks omap7xx support
Date: Mon, 15 Mar 2010 12:08:43 -0700
Message-ID: <20100315190842.GZ2900@atomide.com>
References: <6cb013311003062056v3ed83a53u2636838348bf4845@mail.gmail.com>
 <20100309004832.GK2900@atomide.com>
 <6cb013311003081751u2c7cd8c6v59472ee85ac90e77@mail.gmail.com>
 <20100309024602.GQ2900@atomide.com>
 <6cb013311003081906n751bedb4k2794ed40ed68d7ec@mail.gmail.com>
 <20100309155636.GS2900@atomide.com>
 <6cb013311003091541k6a18c16bv4bb3d35f101e5bab@mail.gmail.com>
 <20100315182939.GV2900@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="zq44+AAfm4giZpo5"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:53323 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965673Ab0COTHS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 15 Mar 2010 15:07:18 -0400
Content-Disposition: inline
In-Reply-To: <20100315182939.GV2900@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Cory Maccarrone <darkstar6262@gmail.com>
Cc: linux-omap@vger.kernel.org, miknix@gmail.com, a.j.buxton@gmail.com, linwizard-devel@lists.sf.net


--zq44+AAfm4giZpo5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

* Tony Lindgren <tony@atomide.com> [100315 11:35]:
> * Cory Maccarrone <darkstar6262@gmail.com> [100309 15:38]:
> > On Tue, Mar 9, 2010 at 7:56 AM, Tony Lindgren <tony@atomide.com> wrote:
> > >
> > > Does your system boot without any patches if DEBUG_LL is not set
> > > in your .config?
> > 
> > No, it doesn't.  Seems like the debugging code is still trying to run,
> > even disabled.  If I add in that check, it'll boot with DEBUG_LL not
> > set, but won't without that.
> 
> Sorry for the delay on this. How about with the following patch with
> DEBUG_LL not set?
> 
> Note that this is using the shift register now too.

Then we may want to do this too for the boards that don't have any UART.

Tony

--zq44+AAfm4giZpo5
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: inline; filename="debug-ll-no-serial.patch"

>From b33f67e61cc45558cfbda86b3e2032ffbcb2f99c Mon Sep 17 00:00:00 2001
From: Tony Lindgren <tony@atomide.com>
Date: Mon, 15 Mar 2010 10:47:08 -0700
Subject: [PATCH] omap: Fix uncompress code for boards with no UART

With the recent DEBUG_LL and uncompress code changes, boards
with no UART configured fail to boot as pointed out by
Cory Maccarrone <darkstar6262@gmail.com>.

Some boards may not have UARTs available at all, so add
DEBUG_LL_NONE option for that.

Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/plat-omap/include/plat/uncompress.h b/arch/arm/plat-omap/include/plat/uncompress.h
index dc37b2c..7d69d39 100644
--- a/arch/arm/plat-omap/include/plat/uncompress.h
+++ b/arch/arm/plat-omap/include/plat/uncompress.h
@@ -66,6 +66,13 @@ static inline void flush(void)
 /*
  * Macros to configure UART1 and debug UART
  */
+
+#define DEBUG_LL_NONE(mach)						\
+	if (machine_is_##mach()) {					\
+		uart_base = 0;						\
+		break;							\
+	}
+
 #define _DEBUG_LL_ENTRY(mach, uart1_phys, uart1_shft,			\
 			dbg_uart, dbg_shft, dbg_id)			\
 	if (machine_is_##mach()) {					\

--zq44+AAfm4giZpo5--
