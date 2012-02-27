From: Samuel Ortiz <sameo@linux.intel.com>
Subject: Re: [PATCH] MFD: TWL 6030: make twl6030_irq_set_wake static
Date: Mon, 27 Feb 2012 15:38:13 +0100
Message-ID: <20120227143813.GQ27687@sortiz-mobl>
References: <1329962639-29800-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1329962639-29800-1-git-send-email-nm@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

Hi Nishan,

On Wed, Feb 22, 2012 at 08:03:59PM -0600, Nishanth Menon wrote:
> twl6030_irq_set_wake is not used anywhere else in the kernel
> except as irq_chip.irq_set_wake. No reason for it to be exported.
> 
> Also fixes build warning:
> drivers/mfd/twl6030-irq.c:230:5: warning: symbol 'twl6030_irq_set_wake' was not declared. Should it be static?
> 
Applied as well, thanks.

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
