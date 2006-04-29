From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 00/32] Convert ARM to generic irq subsystem
Date: Sat, 29 Apr 2006 12:08:28 +0200
Message-ID: <1146305308.1322.657.camel@localhost.localdomain>
References: <20060407095850.690110000@localhost.localdomain>
	<20060426230543.GA28908@flint.arm.linux.org.uk>
	<44529239.2060409@mvista.com>
	<1146263927.1322.640.camel@localhost.localdomain>
	<4452A282.4050909@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk>
In-Reply-To: <4452A282.4050909@mvista.com>
List-Unsubscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=unsubscribe>
List-Archive: <http://lists.arm.linux.org.uk/pipermail/linux-arm-kernel>
List-Post: <mailto:linux-arm-kernel@lists.arm.linux.org.uk>
List-Help: <mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=help>
List-Subscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.arm.linux.org.uk
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk
To: Kevin Hilman <khilman@mvista.com>
Cc: linux-omap-open-source@linux.omap.com, LAK <linux-arm-kernel@lists.arm.linux.org.uk>
List-Id: linux-omap@vger.kernel.org

On Fri, 2006-04-28 at 16:17 -0700, Kevin Hilman wrote:
> ok, I tried with -rc3 and I still dont see any GPIO interrupts.
> 
> After looking closer at the IRQ_TYPE_* flags, I noticed that they didn't match 
> the SA_TRIGGER_* flags for _FALLING or _RISING.  The following patch swaps the 
> two and make OMAP happy.  It's now booting, and things seem sane.  Will do some 
> more intensive testing
> 
> Kevin

Sigh. I knew I'd screw that one up.

Applied and released -rc3-armirq2.

Thanks,

	tglx

> Index: linux-omap-2.6/include/linux/irq.h
> ===================================================================
> --- linux-omap-2.6.orig/include/linux/irq.h
> +++ linux-omap-2.6/include/linux/irq.h
> @@ -39,8 +39,8 @@
>    * IRQ types, see also include/linux/interrupt.h
>    */
>   #define IRQ_TYPE_NONE		0x0000		/* Default, unspecified type */
> -#define IRQ_TYPE_EDGE_FALLING	0x0001		/* Edge falling type */
> -#define IRQ_TYPE_EDGE_RISING	0x0002		/* Edge rising type */
> +#define IRQ_TYPE_EDGE_RISING	0x0001		/* Edge rising type */
> +#define IRQ_TYPE_EDGE_FALLING	0x0002		/* Edge falling type */
>   #define IRQ_TYPE_EDGE_BOTH (IRQ_TYPE_EDGE_FALLING | IRQ_TYPE_EDGE_RISING)
>   #define IRQ_TYPE_LEVEL_HIGH	0x0004		/* Level high type */
>   #define IRQ_TYPE_LEVEL_LOW	0x0008		/* Level low type */
> 


-------------------------------------------------------------------
List admin: http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel
FAQ:        http://www.arm.linux.org.uk/mailinglists/faq.php
Etiquette:  http://www.arm.linux.org.uk/mailinglists/etiquette.php
