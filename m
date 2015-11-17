From: Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v3 1/5] spi: introduce mmap read support for spi flash
 devices
Date: Tue, 17 Nov 2015 12:02:29 +0530
Message-ID: <564AC9FD.6090909@ti.com>
References: <1447133399-25658-1-git-send-email-vigneshr@ti.com>
 <1447133399-25658-2-git-send-email-vigneshr@ti.com>
 <20151110232341.GU12143@google.com> <5642E546.3040806@ti.com>
 <20151111072041.GA13174@localhost> <56460A4D.30303@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <56460A4D.30303-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Cyrille Pitchen <cyrille.pitchen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>, Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Cc: Michal Suchanek <hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi Brian,

On 11/13/2015 09:35 PM, Cyrille Pitchen wrote:

[...]

> 
> In September I've sent a series of patches to enhance the support of QSPI flash
> memories. Patch 4 was dedicated to the m25p80 driver and set the
> rx_nbits / tx_nbits fields of spi_transfer struct(s) in order to configure the
> number of I/O lines independently for the opcode, address and data parts.
> The work was done for m25p80_read() but also for _read_reg(), _write_reg() and
> _write().
> The patched m25p80 driver was then tested with an at25 memory to check non-
> regression.
> 
> This series of patches also added 4 enum spi_protocol fields inside struct
> spi_nor so the spi-nor framework can tell the (Q)SPI controller driver what SPI
> protocol should be use for erase, read, write and register read/write
> operations, depending on the memory manufacturer and the command opcode.
> This was done to better support Micron, Spansion and Macronix QSPI memories.
> 
> I have tested the series with Micron QSPI memories and Atmel QSPI controller
> and I guess Marek also tested it on his side with Spansion QSPI memories and
> another QSPI controller.
> 
> So if it can help other developers to develop QSPI controller drivers, the
> series is still available there:
> 
> for the whole series:
> http://lists.infradead.org/pipermail/linux-arm-kernel/2015-September/371170.html
> 
> for patch 4 (depends on patch 2 for enum spi_protocol):
> http://lists.infradead.org/pipermail/linux-arm-kernel/2015-September/371173.html
> 

Should I rebase my next version on top of above patches by Cyrille or
shall I post on top of 4.4-rc1?

-- 
Regards
Vignesh
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
