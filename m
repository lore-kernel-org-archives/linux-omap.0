From: Lee Schermerhorn <Lee.Schermerhorn@hp.com>
Subject: Re: Boot Hang - mmotm 090716 - serial 8250 irq flags support
Date: Thu, 23 Jul 2009 10:52:07 -0400
Message-ID: <1248360727.5674.86.camel@useless.americas.hpqcorp.net>
References: <1248291948.4490.67.camel@useless.americas.hpqcorp.net>
	 <20090723113353.7da8f6f9@lxorguk.ukuu.org.uk>
	 <1248353462.5674.80.camel@useless.americas.hpqcorp.net>
	 <20090723145754.3f001c4e@lxorguk.ukuu.org.uk>
	 <FCCFB4CDC6E5564B9182F639FC35608702F57AD326@dbde02.ent.ti.com>
	 <20090723154657.184a12ab@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753954AbZGWOx1@vger.kernel.org>
In-Reply-To: <20090723154657.184a12ab@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "Pandita, Vikram" <vikram.pandita@ti.com>, Andrew Morton <akpm@linux-foundation.org>, Alan Cox <alan@linux.intel.com>, linux-kernel <linux-kernel@vger.kernel.org>, Bjorn Helgaas <bjorn.helgaas@hp.com>, Eric Whitney <eric.whitney@hp.com>, Rich Freiss <richard.freiss@hp.com>, Linux OMAP Users <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Thu, 2009-07-23 at 15:46 +0100, Alan Cox wrote:
> > Are you referring to serial-add-irqflags-support patch.
> > Do let me know in case any respin of this patch is needed.
> 
> The old_serial_port structure just needed the irqflags field moving to
> the end so it didn't break some existing initialisers (eg
> arch/x86/include/asm/serial.h)
> 

Alan:  the alternate patch you sent works fine.

Thanks,
Lee
