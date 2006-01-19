From: Tony Lindgren <tony@atomide.com>
Subject: Re: Ethernet issue in most recent git?
Date: Thu, 19 Jan 2006 15:21:24 -0800
Message-ID: <20060119232124.GQ4425@atomide.com>
References: <43CFD135.4090604@de.bosch.com> <20060119181207.GI4425@atomide.com>
	<43CFF2C8.6090307@de.bosch.com> <20060119215802.GN4425@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="CE+1k2dSO48ffgeK"
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <20060119215802.GN4425@atomide.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Dirk Behme <dirk.behme@de.bosch.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org


--CE+1k2dSO48ffgeK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

* Tony Lindgren <tony@atomide.com> [060119 14:08]:
> * Dirk Behme <dirk.behme@de.bosch.com> [060119 12:13]:
> > 
> > the meaning of __IRQT_RISEDGE and __IRQT_FALEDGE was inverted :( So I
> > think we have to exchange _all_ places in OMAP code where these are used?
> 
> We should be able to just remap them in gpio.c. I believe there's a note
> there somewhere saying that by coincidence the bits are the same in omap
> hw as in irq.h...

I'll push the following patch today:



--CE+1k2dSO48ffgeK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename=patch-gpio-irqtype

diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
index efba093..cf5ad29 100644
--- a/arch/arm/plat-omap/gpio.c
+++ b/arch/arm/plat-omap/gpio.c
@@ -448,11 +448,14 @@ static int _set_gpio_triggering(struct g
 		/* We allow only edge triggering, i.e. two lowest bits */
 		if (trigger & ~IRQT_BOTHEDGE)
 			BUG();
-		/* NOTE: knows __IRQT_{FAL,RIS}EDGE match OMAP hardware */
-		trigger &= 0x03;
 		l = __raw_readl(reg);
 		l &= ~(3 << (gpio << 1));
-		l |= trigger << (gpio << 1);
+		if (trigger == IRQT_RISING)
+			l |= 2 << gpio;
+		else if (trigger == IRQT_FALLING)
+			l |= 1 << gpio;
+		else
+			goto bad;
 		break;
 	case METHOD_GPIO_730:
 		reg += OMAP730_GPIO_INT_CONTROL;

--CE+1k2dSO48ffgeK
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--CE+1k2dSO48ffgeK--
