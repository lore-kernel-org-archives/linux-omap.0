From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 15/15] tty: serial: 8250: omap: add dma support
Date: Tue, 2 Sep 2014 09:55:18 -0700
Message-ID: <20140902165518.GB11766@atomide.com>
References: <53FE3779.5090908@linutronix.de>
 <20140827202313.GF16006@atomide.com>
 <20140828082348.GA5413@linutronix.de>
 <20140828164645.GG16006@atomide.com>
 <53FF84DF.7080406@linutronix.de>
 <20140828225454.GM16006@atomide.com>
 <540048B4.7010807@linutronix.de>
 <20140829161221.GO16006@atomide.com>
 <5404B149.6010400@linutronix.de>
 <20140902030546.GB6724@earth.universe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20140902030546.GB6724@earth.universe>
Sender: linux-serial-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, balbi@ti.com, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Vinod Koul <vinod.koul@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Paul Walmsley <paul@pwsan.com>
List-Id: linux-omap@vger.kernel.org

* Sebastian Reichel <sre@kernel.org> [140901 20:06]:
> Hi,
> 
> On Mon, Sep 01, 2014 at 07:47:53PM +0200, Sebastian Andrzej Siewior wrote:
> > On 08/29/2014 06:12 PM, Tony Lindgren wrote:
> > > Looks like the paste bug is there for sure, doing off idle and pasting
> > > 240 characters to the console can hang the UART RX after few attempts,
> > > and pasting 16 charactes won't show up at all if the system is idling.
> > > So you may want to play with that too a bit :)
> > 
> > One character wakes it up. After that you can send 16, 64 and you see
> > them. Right away. No delay.
> > 
> > If you send "a lot" data in one-go it takes approx 152 characters until
> > the first one is displayed properly at 115200,8N1. That is approx 13ms.
> > Could it take that long to get up and be ready?
> 
> I noticed the same behaviour when I tested the runtime PM stuff on
> my N900 with the existing serial-omap driver and I also assumed,
> that the chip needs that long to get up.

OK yeah I've confirmed that serial-omap also won't do anything with the
pasted data until woken up. It takes some time to get things powered up
again, there's nothing we can do beyond having the autoidle disabled by
default.
 
> > Comparing it with serial-omap I see the same thing: I takes approx the
> > same amount of data until the first one is displayed. After a lot of
> > "long" writes which wake the chip up from idle I manage to freeze both,
> > the serial-omap driver and mine driver.

Hmm I have not seen the RX hang with serial-omap when pasting data to
the console to wake it up.
 
> > One thing that is probably a dumb idea is that printk in
> > omap_8250_mdr1_errataset().
> > Would it be possible that when I hit a printk in the resume path that I
> > may deadlock and box will freeze?

I guess yeah. You may want to use pstore as console to debug that. You
need to use this patch to prevent pstore from hanging:

https://lkml.org/lkml/2013/4/9/831

Then enable:

CONFIG_PSTORE=y
CONFIG_PSTORE_CONSOLE=y
CONFIG_PSTORE_RAM=y
CONFIG_FUNCTION_TRACER=y
CONFIG_DEBUG_FS=y
CONFIG_PSTORE_FTRACE=y

Then at kernel cmdline, specify something like this:

memmap=2M$0x88000000 ramoops.mem_address=0x88000000 ramoops.mem_size=0x200000 ramoops.record_size=0x40000

And leave out console=ttyS line and spin up a getty on the serial
line.

After booting, you should just need to do:

# mount -t pstore - /sys/fs/pstore

And then you see dmesg in /sys/fs/pstore. To debug hangs, set up the
PMIC watchdog and do not set up omap watchdog, and you should see the
last dmesg in /sys/fs/pstore after a warm reset.

Regards,

Tony
