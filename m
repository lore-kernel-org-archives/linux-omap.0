From: Jamie Iles <jamie@jamieiles.com>
Subject: Re: [PATCH 00/13] Clean up mach/gpio.h headers
Date: Tue, 9 Aug 2011 10:58:56 +0100
Message-ID: <20110809095856.GF3210@pulham.picochip.com>
References: <20110809080411.GA1831@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20110809080411.GA1831@n2100.arm.linux.org.uk>
Sender: linux-sh-owner@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-sh@vger.kernel.org, linux-tegra@vger.kernel.org, Grant Likely <grant.likely@secretlab.ca>, Nicolas Pitre <nico@fluxnic.net>
List-Id: linux-omap@vger.kernel.org

Hi Russell,

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

Nice series!  This gives me an empty gpio.h for picoxcell.

Tested-by: Jamie Iles <jamie@jamieiles.com>

Jamie
