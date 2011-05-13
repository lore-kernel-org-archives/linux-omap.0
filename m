From: Samuel Ortiz <sameo@linux.intel.com>
Subject: Re: [PATCH v2 2/4] MFD: TWL6030: fix irq definitions
Date: Fri, 13 May 2011 16:48:08 +0200
Message-ID: <20110513144807.GH8970@sortiz-mobl>
References: <1305206878-18094-1-git-send-email-gg@slimlogic.co.uk>
 <1305206878-18094-3-git-send-email-gg@slimlogic.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1305206878-18094-3-git-send-email-gg@slimlogic.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Graeme Gregory <gg@slimlogic.co.uk>
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, balbi@ti.com, lrg@slimlogic.co.uk, broonie@opensource.wolfsonmicro.com
List-Id: linux-omap@vger.kernel.org

Hi Graeme

On Thu, May 12, 2011 at 02:27:56PM +0100, Graeme Gregory wrote:
> The charger fault IRQs from the twl will in future patches be handled
> by a seperate IRQ handler in the charger driver than the general charger
> IRQ. Give them different IRQ numbers now to allow the charger driver to
> be merged in the future.
Thanks, patch applied as well.

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
