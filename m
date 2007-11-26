From: "Girish" <girishsg@ti.com>
Subject: RE: [RFC][PATCH] ARM: OMAP: Always enable the R/W access to
	allinitiators in sram
Date: Mon, 26 Nov 2007 21:18:34 +0530
Message-ID: <003401c83043$ce6385b0$988818ac@ent.ti.com>
References: <20071126020738.GA32424@party>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-reply-to: <20071126020738.GA32424@party>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: 'Kyungmin Park' <kyungmin.park@samsung.com>, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

 

>-----Original Message-----
>From: linux-omap-open-source-bounces@linux.omap.com 
>[mailto:linux-omap-open-source-bounces@linux.omap.com] On 
>Behalf Of Kyungmin Park
>Sent: Monday, November 26, 2007 7:38 AM
>To: linux-omap-open-source@linux.omap.com
00
>
>Also we get the 'type' from CONTROL_STATUS(0x2F0) instead 
>previous (0x2F8).
>
>Please let me know what is the right way.
>
It seems like the CONTROL_STATUS which was defined earlier in omap[2/3]4xx.h has been moved somewhere else.

Well, just a quick look it seems that CONTROL_STATUS definition has been moved to asm/arch/control.h, here CONTROL_STATUS has been
defined only for 3430 and doesn't handle for 24xx, so 3430 CONTROL_STATUS value is getting included for 24xx. This is breaking code
on 24xx guess. 

Regards,
girish
>Any comments are welcome.
>
>Thank you,
>Kyungmin Park
>---
>diff --git a/arch/arm/plat-omap/sram.c 
>b/arch/arm/plat-omap/sram.c index dd8dc04..f1e0af3 100644
>--- a/arch/arm/plat-omap/sram.c
>+++ b/arch/arm/plat-omap/sram.c
>@@ -97,15 +97,16 @@ static int is_sram_locked(void)
> 		type = ctrl_read_reg(CONTROL_STATUS) & 
>TYPE_MASK;  #endif
> 
>-	if (type == GP_DEVICE) {
>-		/* RAMFW: R/W access to all initiators for all 
>qualifier sets */
>-		if (cpu_is_omap242x()) {
>-			__raw_writel(0xFF, VA_REQINFOPERM0); /* 
>all q-vects */
>-			__raw_writel(0xCFDE, VA_READPERM0);  /* 
>all i-read */
>-			__raw_writel(0xCFDE, VA_WRITEPERM0); /* 
>all i-write */
>-		}
>+	/* RAMFW: R/W access to all initiators for all qualifier sets */
>+	if (cpu_is_omap242x()) {
>+		__raw_writel(0xFF, VA_REQINFOPERM0); /* all q-vects */
>+		__raw_writel(0xCFDE, VA_READPERM0);  /* all i-read */
>+		__raw_writel(0xCFDE, VA_WRITEPERM0); /* all i-write */
>+	}
>+
>+	if (type == GP_DEVICE)
> 		return 0;
>-	} else
>+	else
> 		return 1; /* assume locked with no PPA or 
>security driver */  }
> 
>diff --git a/include/asm-arm/arch-omap/control.h 
>b/include/asm-arm/arch-omap/control.h
>index 5f42725..9f9075e 100644
>--- a/include/asm-arm/arch-omap/control.h
>+++ b/include/asm-arm/arch-omap/control.h
>@@ -38,6 +38,7 @@
> #define CONTROL_DEVCONF0		(CONTROL_GENERAL + 0x04)
> #define CONTROL_DEVCONF1		(CONTROL_GENERAL + 
>0x68) /* > 242x */
> #define CONTROL_STATUS			(CONTROL_GENERAL + 0x80)
>+#define CONTROL_STAT			(CONTROL_GENERAL + 0x88)
> 
> 
> /*
>_______________________________________________
>Linux-omap-open-source mailing list
>Linux-omap-open-source@linux.omap.com
>http://linux.omap.com/mailman/listinfo/linux-omap-open-source
>
