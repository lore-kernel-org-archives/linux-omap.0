From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 00/32] Convert ARM to generic irq subsystem
Date: Tue, 02 May 2006 14:33:10 +0200
Message-ID: <1146573190.1322.678.camel@localhost.localdomain>
References: <20060407095850.690110000@localhost.localdomain>
	<20060426230543.GA28908@flint.arm.linux.org.uk>
	<44529239.2060409@mvista.com>
	<1146263927.1322.640.camel@localhost.localdomain>
	<4452A282.4050909@mvista.com>
	<1146305308.1322.657.camel@localhost.localdomain>
	<20060502115914.GF24728@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk>
In-Reply-To: <20060502115914.GF24728@atomide.com>
List-Unsubscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=unsubscribe>
List-Archive: <http://lists.arm.linux.org.uk/pipermail/linux-arm-kernel>
List-Post: <mailto:linux-arm-kernel@lists.arm.linux.org.uk>
List-Help: <mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=help>
List-Subscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.arm.linux.org.uk
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap-open-source@linux.omap.com, LAK <linux-arm-kernel@lists.arm.linux.org.uk>
List-Id: linux-omap@vger.kernel.org

On Tue, 2006-05-02 at 04:59 -0700, Tony Lindgren wrote:
> > Applied and released -rc3-armirq2.
> 
> Patches seem to work for me too on various omap boards. Also dyntick
> works.

Thanks for testing.

> Should this part in kernel/irq/handle.c be CONFIG_ARM for now?

Yes, until we find a unified solution for dynamic ticks.

	tglx




-------------------------------------------------------------------
List admin: http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel
FAQ:        http://www.arm.linux.org.uk/mailinglists/faq.php
Etiquette:  http://www.arm.linux.org.uk/mailinglists/etiquette.php
