From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH 00/13] Clean up mach/gpio.h headers
Date: Tue, 9 Aug 2011 15:00:55 -0600
Message-ID: <20110809210055.GF11568@ponder.secretlab.ca>
References: <20110809080411.GA1831@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20110809080411.GA1831-l+eeeJia6m9vn6HldHNs0ANdhmdF6hFW@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Nicolas Pitre <nico-vtqb6HGKxmzR7s880joybQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Tue, Aug 09, 2011 at 09:04:12AM +0100, Russell King - ARM Linux wrote:
> This is a preliminary posting of my gpio patch set.
> 
> This patch series moves the trivial gpiolib implementations out of
> mach/gpio.h and into asm/gpio.h.
> 
> As a side effect of that, most of this patch series is about fixing up
> direct includes of mach/gpio.h - this is something I've been on at
> people over the last year or more about ensuring that they use
> linux/gpio.h in preference.  While I've blindly converted all arch/arm
> to use linux/gpio.h (with the exception of mach/ includes which are
> converted to asm/gpio.h), drivers were only converted to asm/gpio.h.
> These should be reviewed and changed to linux/gpio.h.
> 
> As a result of this patch series, several mach/gpio.h end up being
> empty.
> 
> Many others just contain platform private GPIO APIs and definitions.
> 
> The last thing which mach/gpio.h is used for is to provide a definition
> for ARCH_GPIO_NR to asm-generic/gpio.h.  I've not attempted to solve
> that issue yet.
> 
> A small number of platforms optimize the gpio accessors for on-SoC
> GPIOs.  In the interests of consolidation, these will have to be killed
> but this patch set does not do that yet.
> 
> Lastly, several {mach,plat}/gpio.h needs to be looked at with a view to
> deleting the direct include of asm-generic/gpio.h.

Looks good to me, though I haven't looked closely.  I imagine this
should get merged via a branch in the arm-soc tree?

g.
