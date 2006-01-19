From: Dirk Behme <dirk.behme@de.bosch.com>
Subject: Re: Ethernet issue in most recent git?
Date: Thu, 19 Jan 2006 21:12:56 +0100
Message-ID: <43CFF2C8.6090307@de.bosch.com>
References: <43CFD135.4090604@de.bosch.com> <20060119181207.GI4425@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------030504070508030204060504"
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <20060119181207.GI4425@atomide.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

This is a multi-part message in MIME format.
--------------030504070508030204060504
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Tony Lindgren wrote:
>>Telnet and ping don't work as well. I imagine that I doesn't change any 
>>configuration, only kernel update form git. UBoots tftpboot works quite 
>>well.
> 
> Same problem here. I'd assume it's the recent "IRQ type flags" patch
> that does not work properly for omap gpio interrupts.

Thanks for the hint! Please try quick hack for OSK ethernet in the
attachment.

With

-- cut --
[PATCH] IRQ type flags
/include/asm-arm/irq.h
blob:59975ee43cf139138503288801c7d8758dada859 ->
blob:7772432d3fd7750506943eaf88ea7eda9e720a7d
--- include/asm-arm/irq.h
+++ include/asm-arm/irq.h
@@ -25,10 +25,14 @@ extern void disable_irq_nosync(unsigned
extern void disable_irq(unsigned int);
extern void enable_irq(unsigned int);
-#define __IRQT_FALEDGE (1 << 0)
-#define __IRQT_RISEDGE (1 << 1)
-#define __IRQT_LOWLVL (1 << 2)
-#define __IRQT_HIGHLVL (1 << 3)
+/*
+ * These correspond with the SA_TRIGGER_* defines, and therefore the
+ * IRQRESOURCE_IRQ_* defines.
+ */
+#define __IRQT_RISEDGE (1 << 0)
+#define __IRQT_FALEDGE (1 << 1)
+#define __IRQT_HIGHLVL (1 << 2)
+#define __IRQT_LOWLVL (1 << 3)
#define IRQT_NOEDGE (0)
#define IRQT_RISING (__IRQT_RISEDGE)
-- cut --

http://source.mvista.com/git/gitweb.cgi?p=linux-omap-2.6.git;a=blobdiff;h=7772432d3fd7750506943eaf88ea7eda9e720a7d;hp=59975ee43cf139138503288801c7d8758dada859;hb=9ded96f24c3a5fcbef954e88c443385a1af37eb9;f=include/asm-arm/irq.h

the meaning of __IRQT_RISEDGE and __IRQT_FALEDGE was inverted :( So I
think we have to exchange _all_ places in OMAP code where these are used?

Dirk



--------------030504070508030204060504
Content-Type: text/plain;
 name="osk_ethernet_quick_hack.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="osk_ethernet_quick_hack.patch"

--- ./arch/arm/plat-omap/gpio.c_orig	2006-01-19 20:32:07.709178640 +0100
+++ ./arch/arm/plat-omap/gpio.c	2006-01-19 20:58:59.275183368 +0100
@@ -448,8 +448,11 @@ static int _set_gpio_triggering(struct g
 		/* We allow only edge triggering, i.e. two lowest bits */
 		if (trigger & ~IRQT_BOTHEDGE)
 			BUG();
-		/* NOTE: knows __IRQT_{FAL,RIS}EDGE match OMAP hardware */
 		trigger &= 0x03;
+		if(trigger == 0x01)
+			trigger = 0x02;
+		else
+			trigger = 0x01;
 		l = __raw_readl(reg);
 		l &= ~(3 << (gpio << 1));
 		l |= trigger << (gpio << 1);


--------------030504070508030204060504
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------030504070508030204060504--
