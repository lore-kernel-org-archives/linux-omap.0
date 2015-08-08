From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 1/3] tty: serial: 8250_omap: do not use RX DMA if pause
 is not supported
Date: Sat, 8 Aug 2015 10:57:54 +0100
Message-ID: <20150808095753.GB7576@n2100.arm.linux.org.uk>
References: <1438977619-15488-1-git-send-email-bigeasy@linutronix.de>
 <1438977619-15488-2-git-send-email-bigeasy@linutronix.de>
 <55C54D49.3090406@hurleysoftware.com>
 <55C5CC95.6030901@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <55C5CC95.6030901@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Peter Hurley <peter@hurleysoftware.com>, Vinod Koul <vinod.koul@intel.com>, Dan Williams <dan.j.williams@intel.com>, dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, nsekhar@ti.com, linux-omap@vger.kernel.org, linux-serial@vger.kernel.org, john.ogness@linutronix.de, Peter Ujfalusi <peter.ujfalusi@ti.com>
List-Id: linux-omap@vger.kernel.org

On Sat, Aug 08, 2015 at 11:32:05AM +0200, Sebastian Andrzej Siewior wrote:
> This might not happen at all. At 115200 I *never* encouraged this. Once
> the FIFO is filled with less than RX-trigger size than the UART sends
> the time-out interrupt and the DMA *never* completes.

Careful with statements like that, they have a habbit of backfiring :)

It just needs the right timing - you need a character sequence which
has a pause long enough to trigger the timeout, but short enough to
get characters in between the UART deciding to report a timeout, and
the DMA being terminated.

You'll then be in the situation where the UART is receiving characters
and using the DMA, but you've been interrupted to handle the RX timeout
event.  Whether the UART resets the IIR in that situation to indicate
something other than a RX timeout, I'm not sure - if it doesn't, then
there's a race there (which from your behaviour at faster rates seems
likely.)

The more loaded the system, the longer an IRQ may take to be serviced
(especially if there are interrupt handlers which aren't fast) and the
bigger the window is for that to happen.  I've seen some long service
times with USB with HID in older kernels (milliseconds), but that seems
to have been fixed now - longest IRQ handling I'm now seeing is around
500us.  Given 115200 baud, the character time is 87us, that's probably
more than enough if you get the timing just right.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
