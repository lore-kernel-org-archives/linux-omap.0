From: Brian Norris <computersforpeace@gmail.com>
Subject: Re: [PATCH v3 1/5] spi: introduce mmap read support for spi flash
 devices
Date: Tue, 17 Nov 2015 09:48:56 -0800
Message-ID: <20151117174856.GB8456@google.com>
References: <1447133399-25658-1-git-send-email-vigneshr@ti.com>
 <1447133399-25658-2-git-send-email-vigneshr@ti.com>
 <20151110232341.GU12143@google.com>
 <5642E546.3040806@ti.com>
 <20151111072041.GA13174@localhost>
 <56460A4D.30303@atmel.com>
 <564AC9FD.6090909@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <564AC9FD.6090909@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vignesh R <vigneshr@ti.com>
Cc: Cyrille Pitchen <cyrille.pitchen@atmel.com>, Marek Vasut <marex@denx.de>, Michal Suchanek <hramrach@gmail.com>, Russell King <linux@arm.linux.org.uk>, devicetree@vger.kernel.org, Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>, linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi,

On Tue, Nov 17, 2015 at 12:02:29PM +0530, Vignesh R wrote:
> On 11/13/2015 09:35 PM, Cyrille Pitchen wrote:
> > 
> > In September I've sent a series of patches to enhance the support of QSPI flash
> > memories. Patch 4 was dedicated to the m25p80 driver and set the
> > rx_nbits / tx_nbits fields of spi_transfer struct(s) in order to configure the
> > number of I/O lines independently for the opcode, address and data parts.
> > The work was done for m25p80_read() but also for _read_reg(), _write_reg() and
> > _write().
> > The patched m25p80 driver was then tested with an at25 memory to check non-
> > regression.
> > 
> > This series of patches also added 4 enum spi_protocol fields inside struct
> > spi_nor so the spi-nor framework can tell the (Q)SPI controller driver what SPI
> > protocol should be use for erase, read, write and register read/write
> > operations, depending on the memory manufacturer and the command opcode.
> > This was done to better support Micron, Spansion and Macronix QSPI memories.
> > 
> > I have tested the series with Micron QSPI memories and Atmel QSPI controller
> > and I guess Marek also tested it on his side with Spansion QSPI memories and
> > another QSPI controller.
> > 
> > So if it can help other developers to develop QSPI controller drivers, the
> > series is still available there:
> > 
> > for the whole series:
> > http://lists.infradead.org/pipermail/linux-arm-kernel/2015-September/371170.html
> > 
> > for patch 4 (depends on patch 2 for enum spi_protocol):
> > http://lists.infradead.org/pipermail/linux-arm-kernel/2015-September/371173.html
> > 
> 
> Should I rebase my next version on top of above patches by Cyrille or
> shall I post on top of 4.4-rc1?

I'm sorry to say I really haven't had the time to review that properly.
I'm also not sure it is a true dependency for your series, as you're
tackling different pieces of the puzzle. So it's mostly just a conflict,
not a real direct help.

So unless I'm misunderstanding, I'd suggest submitting MTD stuff against
the latest l2-mtd.git (or linux-next.git; l2-mtd.git is included there),
and I'll let you know if conflicts come up that need fixing.

Brian
