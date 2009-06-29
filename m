From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: get_irq_regs() from soft IRQ
Date: Mon, 29 Jun 2009 16:19:31 +0100
Message-ID: <20090629151931.GA9042@n2100.arm.linux.org.uk>
References: <200906291631.19562.jpihet@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk>
Content-Disposition: inline
In-Reply-To: <200906291631.19562.jpihet@mvista.com>
List-Unsubscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=unsubscribe>
List-Archive: <http://lists.arm.linux.org.uk/lurker/list/linux-arm-kernel.html>
List-Post: <mailto:linux-arm-kernel@lists.arm.linux.org.uk>
List-Help: <mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=help>
List-Subscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.arm.linux.org.uk
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk
To: Jean Pihet <jpihet@mvista.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.arm.linux.org.uk, oprofile-list@lists.sourceforge.net
List-Id: linux-omap@vger.kernel.org

On Mon, Jun 29, 2009 at 04:31:18PM +0200, Jean Pihet wrote:
> I am trying to get the latest IRQ registers from a timer or a work queue
> but I am running into problems:
> - get_irq_regs() returns NULL in some cases,

It will always return NULL outside of IRQ context - and only returns valid
pointers when used inside IRQ context.

It's one of these things that nests itself - when you have several IRQs
being processed on one CPU, there are several register contexts saved,
and get_irq_regs() returns the most recent one.

> The use case is that the performance unit (PMNC) of the Cortex A8 has some 
> serious bug, in short the performance counters overflow IRQ is to be avoided.

I don't follow.  None of the PMNC support code in the mainline kernel
uses get_irq_regs() outside of IRQ context.

> Some questions:
> - is there a way to get the last 'real' IRQ registers from a timer or work 
> queue handler?

No.  Outside of IRQ events, the saved IRQ context does not exist.

-------------------------------------------------------------------
List admin: http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel
FAQ:        http://www.arm.linux.org.uk/mailinglists/faq.php
Etiquette:  http://www.arm.linux.org.uk/mailinglists/etiquette.php
