From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] OMAP2+: UART: Make the SERIAL_OMAP depend on
	ARCH_OMAP2PLUS
Date: Tue, 15 Nov 2011 09:06:34 +0000
Message-ID: <20111115090634.GA31462@n2100.arm.linux.org.uk>
References: <1321338460-1421-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1321338460-1421-1-git-send-email-shubhrajyoti@ti.com>
Sender: linux-serial-owner@vger.kernel.org
To: Shubhrajyoti D <shubhrajyoti@ti.com>
Cc: linux-serial@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Tue, Nov 15, 2011 at 11:57:40AM +0530, Shubhrajyoti D wrote:
> Making  SERIAL_OMAP depend on ARCH_OMAP2PLUS instead of
> oring with ARCH2/3/4.
> 
> Acked-by: Felipe Balbi <balbi@ti.com>
> Suggested-by: Sricharan R <r.sricharan@ti.com>
> Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>

There's another one:

drivers/mtd/nand/Kconfig:     depends on ARM && (ARCH_OMAP2 || ARCH_OMAP3 || ARCH_OMAP4)

And the 'ARM &&' is redundant.
