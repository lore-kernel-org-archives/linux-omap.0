From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/5] gpiolib: introduce set_debounce method
Date: Thu, 20 May 2010 20:45:10 +0100
Message-ID: <20100520194509.GB10739@sirena.org.uk>
References: <1274090554-19420-1-git-send-email-felipe.balbi@nokia.com> <1274090554-19420-2-git-send-email-felipe.balbi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1274090554-19420-2-git-send-email-felipe.balbi@nokia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: felipe.balbi@nokia.com
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, David Brownell <david-b@pacbell.net>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-omap@vger.kernel.org

On Mon, May 17, 2010 at 01:02:30PM +0300, felipe.balbi@nokia.com wrote:
> From: Felipe Balbi <felipe.balbi@nokia.com>
> 
> Few architectures, like OMAP, allow you to set
> a debouncing time for the gpio before generating
> the IRQ. Teach gpiolib about that.
> 
> Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>

Reviewed-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

This would be generally useful for embedded systems, especially where
the interrupt concerned is a wake source.  It allows drivers to avoid
spurious interrupts from noisy sources so if the hardware supports it
the driver can avoid having to explicitly wait for the signal to become
stable and software has to cope with fewer events.  We've lived without
it for quite some time, though.
