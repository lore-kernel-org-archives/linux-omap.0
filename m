From: Frans Klaver <frans.klaver@xsens.com>
Subject: Re: [PATCH 09/16] tty: serial: 8250_dma: Add a TX trigger workaround
 for AM33xx
Date: Fri, 12 Sep 2014 12:28:16 +0200
Message-ID: <20140912102816.GF28458@ci00147.xsens-tech.local>
References: <20140911111721.GB17476@xps8300>
 <54118AAB.2010205@linutronix.de>
 <5411967A.6090406@hurleysoftware.com>
 <54119AAA.9080907@linutronix.de>
 <20140911151114.GD28458@ci00147.xsens-tech.local>
 <5411C810.7070906@linutronix.de>
 <2cf997d9-e7de-465b-915d-3a0a5e7b95f7@email.android.com>
 <54129F6C.7040508@linutronix.de>
 <20140912094010.GE28458@ci00147.xsens-tech.local>
 <5412C21A.8020203@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Return-path: <linux-serial-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5412C21A.8020203@linutronix.de>
Sender: linux-serial-owner@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>, Peter Hurley <peter@hurleysoftware.com>, tony@atomide.com, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, balbi@ti.com, linux-serial@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Alan Cox <alan@linux.intel.com>
List-Id: linux-omap@vger.kernel.org

On Fri, Sep 12, 2014 at 11:51:22AM +0200, Sebastian Andrzej Siewior wrote:
> On 09/12/2014 11:40 AM, Frans Klaver wrote:
> 
> > I'm not sure. I just reproduced this on a boneblack, using your uart_v9
> > branch.
> > 
> >> This problem only pops-up if you use DMA. With disabled DMA you don't
> >> see this, right?
> > 
> > I get the lockup both with and without DMA enabled. Here's the 8250
> > config I use. Our full .config is attached in case it may provide
> > something relevant.
> 
> Hmm. I have a bone black here. Can you tell what you did to get this
> lockup? The port configuration (unless 115200 8N1) and what you did to
> get this lockup.

port config is 115200 8N1. I don't recall doing anything special. I
boot, login, less file and get a lock.


> > Something that may also help: when I have a lockup on the boneblack, dma
> > is enabled and something is written to console like I described earlier,
> > I get the following bad irq:
> 
> > Full dmesg is also attached.
> 
> This one should be stuffed by this:
> 	"[RFC] ARM: edma: unconditionally ack the error interrupt"
> 	https://lkml.org/lkml/2014/9/10/714

OK, that makes the console usable again after I write something to kmsg.

> > Hope you find something useful in there.
> 
> > Thanks,
> > Frans
> 
> Sebastian
