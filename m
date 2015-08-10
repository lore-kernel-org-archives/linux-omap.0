From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 1/3] tty: serial: 8250_omap: do not use RX DMA if pause
 is not supported
Date: Mon, 10 Aug 2015 18:15:45 +0100
Message-ID: <20150810171545.GC7576@n2100.arm.linux.org.uk>
References: <1438977619-15488-1-git-send-email-bigeasy@linutronix.de>
 <1438977619-15488-2-git-send-email-bigeasy@linutronix.de>
 <55C890E2.50208@ti.com>
 <55C8A06D.20309@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <55C8A06D.20309@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Hurley <peter@hurleysoftware.com>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Vinod Koul <vinod.koul@intel.com>, Dan Williams <dan.j.williams@intel.com>, dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, nsekhar@ti.com, linux-omap@vger.kernel.org, linux-serial@vger.kernel.org, john.ogness@linutronix.de
List-Id: linux-omap@vger.kernel.org

On Mon, Aug 10, 2015 at 09:00:29AM -0400, Peter Hurley wrote:
> Russell seemed to think that the current dma operation was necessary information to
> differentiate types of pause support, but I don't think that's required.
> As Sebastian's omap-dma driver patch shows, partial pause support has more
> to do with how it's being used.

Do you think you can rewrite the first sentence above in gramatically
correct English please, I'm failing to understand what you're saying.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
