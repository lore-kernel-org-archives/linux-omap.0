From: Samuel Ortiz <sameo@linux.intel.com>
Subject: Re: [PATCH] MFD: TWL 6030: clear IRQ status register only once
Date: Mon, 27 Feb 2012 15:38:06 +0100
Message-ID: <20120227143806.GP27687@sortiz-mobl>
References: <1329962625-29767-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1329962625-29767-1-git-send-email-nm@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

Hi Nishan,

On Wed, Feb 22, 2012 at 08:03:45PM -0600, Nishanth Menon wrote:
> TWL6030 family of PMIC use a shadow interrupt status register
> while kernel processes the current interrupt event.
> However, any write(0 or 1) to register INT_STS_A, INT_STS_B or
> INT_STS_C clears all 3 interrupt status registers.
> 
> Since clear of the interrupt is done on 32k clk, depending on I2C
> bus speed, we could in-adverently clear the status of a interrupt
> status pending on shadow register in the current implementation.
> This is due to the fact that multi-byte i2c write operation into
> three seperate status register could result in multiple load
> and clear of status and result in lost interrupts.
> 
> Instead, doing a single byte write to INT_STS_A register with 0x0
> will clear all three interrupt status registers without the related
> risk.
Applied, thanks.

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
