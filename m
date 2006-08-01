From: Arnold <abo_gwapo@yahoo.com>
Subject: NETDEV WATCHDOG: eth0: transmit timed out
Date: Tue, 1 Aug 2006 03:25:18 -0700 (PDT)
Message-ID: <20060801102518.61191.qmail@web55814.mail.re3.yahoo.com>
References: <20060801091826.19862.qmail@web55804.mail.re3.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <20060801091826.19862.qmail@web55804.mail.re3.yahoo.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Arnold <abo_gwapo@yahoo.com>, Dirk Behme <dirk.behme@googlemail.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org



--- Arnold <abo_gwapo@yahoo.com> wrote:

> 
> Hi,
> 
> I've been playing around the gpio. writing to pins.
> I
> encountered an error that is weird. Im not sure if
> this is cause by writing to a gpio. I tried several
> gpio pins but I still encountered an error. below is
> the error encountered:
> # ./gpio_test
> Opening gpio driver
> (OJ) Writing at pin = 49
> (OJ) Value of pin = 1
> 
> ~ #
> ~ #
> ~ #
> ~ #
> ~ # ./gpio_test
> nfs: server 157.184.66.86 not responding, still
> trying
> NETDEV WATCHDOG: eth0: transmit timed out
> NETDEV WATCHDOG: eth0: transmit timed out
> 
> Do Anyone knows whats wrong here? I have no idea why
> Im encountering this error.
> 
> Regards,
> OJ
> 
> 
> --- Dirk Behme <dirk.behme@googlemail.com> wrote:
> 
> > Arnold wrote:
> > > Anybody knows what interrupt number a gpio on
> > omap5912
> > > uses?
> > 
> > AFAIK interrupt numbers for GPIO start with 160
> and
> > then are 
> > numbered starting with first GPIO bank and so on.
> > 
> > See include/asm-arm/arch-omap/irqs.h:
> > 
> > #define IH2_BASE           32
> > 
> > /* Max. 128 level 2 IRQs (OMAP1610), 192 GPIOs
> > (OMAP730) and
> >   * 16 MPUIO lines */
> > #define OMAP_MAX_GPIO_LINES     192
> > #define IH_GPIO_BASE            (128 + IH2_BASE)
> > #define IH_MPUIO_BASE          
> (OMAP_MAX_GPIO_LINES
> > + 
> > IH_GPIO_BASE)
> > #define IH_BOARD_BASE           (16 +
> IH_MPUIO_BASE)
> > 
> > Have a look to GPIO framework in gpio.c and its
> > usage in 
> > various files which can help you programming GPIO
> > stuff.
> > 
> > Cheers
> > 
> > Dirk
> > 
> 
> 
> __________________________________________________
> Do You Yahoo!?
> Tired of spam?  Yahoo! Mail has the best spam
> protection around 
> http://mail.yahoo.com 
> _______________________________________________
> Linux-omap-open-source mailing list
> Linux-omap-open-source@linux.omap.com
>
http://linux.omap.com/mailman/listinfo/linux-omap-open-source
> 


__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
