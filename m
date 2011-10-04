From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH v6 04/16] OMAP2+: UART: cleanup 8250 console driver support
Date: Tue, 04 Oct 2011 14:42:57 -0700
Message-ID: <87lit077ry.fsf@ti.com>
References: <1317380495-584-1-git-send-email-govindraj.raja@ti.com>
	<1317380495-584-4-git-send-email-govindraj.raja@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <1317380495-584-4-git-send-email-govindraj.raja@ti.com>
	(Govindraj R.'s message of "Fri, 30 Sep 2011 16:31:30 +0530")
Sender: linux-serial-owner@vger.kernel.org
To: "Govindraj.R" <govindraj.raja@ti.com>
Cc: linux-omap@vger.kernel.org, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Partha Basak <p-basak2@ti.com>, Vishwanath Sripathy <vishwanath.bs@ti.com>, Rajendra Nayak <rnayak@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>
List-Id: linux-omap@vger.kernel.org

"Govindraj.R" <govindraj.raja@ti.com> writes:

> We had been using traditional 8250 driver as uart console driver
> prior to omap-serial driver. Since we have omap-serial driver
> in mainline kernel for some time now it has been used as default
> uart console driver on omap2+ platforms. Remove 8250 support for
> omap-uarts.

Nice to see the this disappearing.

> Serial_in and serial_out override for 8250 serial driver is also
> removed. Empty fifo read fix is already taken care with omap-serial
> driver with data ready bit check from LSR reg before reading RX fifo.

As stated in the previous review.  Patches that move code/features
should have the removal and the add-back in the same patch.  Doing so
makes it easy for reviewers to see whether it was simply moved, or if it
was modified when it was moved, etc.

> Also waiting for THRE(transmit hold reg empty) is done with wait_for_xmitr
> in omap-serial driver.

Again, remove it here in the patch that adds that support (the errata
patch I guess.)

> Remove headers that were necessary to support 8250 support
> and remove all config bindings done to keep 8250 backward compatibility
> while adding omap-serial driver. Remove omap_uart_reset needed for
> 8250 autoconf.
>
> Signed-off-by: Govindraj.R <govindraj.raja@ti.com>

So basically, this patch should only remove the legacy 8250 support (as
the subject says) and everything else should be done in the other
relevant patches.

Kevin
