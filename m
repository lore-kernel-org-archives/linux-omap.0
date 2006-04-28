From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 00/32] Convert ARM to generic irq subsystem
Date: Sat, 29 Apr 2006 00:38:46 +0200
Message-ID: <1146263927.1322.640.camel@localhost.localdomain>
References: <20060407095850.690110000@localhost.localdomain>
	<20060426230543.GA28908@flint.arm.linux.org.uk>
	<44529239.2060409@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk>
In-Reply-To: <44529239.2060409@mvista.com>
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

On Fri, 2006-04-28 at 15:07 -0700, Kevin Hilman wrote:
> R am testing these on OMAP.
> 
> First pass shows that smc91x interrupts are getting lost.  They are GPIO 
> interrupts on most OMAP platforms and pass through a chained gpio handler.  I'm 
> still investigating, but I'm guessing it as something to do with SA_TRIGGER_* 
> flags used in the smc91x driver for OMAP.
> 
> I don't see handling of SA_TRIGGER_* in the generic layer.  Is there a new way 
> of handling these?

No. That chunk got lost unfortunately. Can you retry with the new patch
against -rc3 please ?

http://www.tglx.de/projects/armirq/2.6.17-rc3/patch-2.6.17-rc3-armirq1.patches.tar.bz2

Thanks,

	tglx


-------------------------------------------------------------------
List admin: http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel
FAQ:        http://www.arm.linux.org.uk/mailinglists/faq.php
Etiquette:  http://www.arm.linux.org.uk/mailinglists/etiquette.php
