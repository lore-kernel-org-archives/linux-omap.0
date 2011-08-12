From: Shawn Guo <shawn.guo@freescale.com>
Subject: Re: [PATCH 11/13] ARM: gpio: consolidate trivial gpiolib
 implementations
Date: Fri, 12 Aug 2011 13:54:47 +0800
Message-ID: <20110812055446.GB6618@S2100-06.ap.freescale.net>
References: <20110809080411.GA1831@n2100.arm.linux.org.uk>
 <E1QqhM1-0003af-U5@rmk-PC.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <E1QqhM1-0003af-U5@rmk-PC.arm.linux.org.uk>
Sender: linux-sh-owner@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-sh@vger.kernel.org, linux-tegra@vger.kernel.org, Grant Likely <grant.likely@secretlab.ca>, Nicolas Pitre <nico@fluxnic.net>
List-Id: linux-omap@vger.kernel.org

On Tue, Aug 09, 2011 at 09:08:01AM +0100, Russell King - ARM Linux wrote:
> Consolidate 24 trivial gpiolib implementions out of mach/gpio.h
> into asm/gpio.h.  This is basically the include of asm-generic/gpio.h
> and the definition of gpio_get_value, gpio_set_value, and gpio_cansleep
> as described in Documentation/gpio.txt
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
>  arch/arm/include/asm/gpio.h                 |   10 ++++++++++
>  arch/arm/mach-at91/include/mach/gpio.h      |    5 +----
>  arch/arm/mach-ep93xx/include/mach/gpio.h    |    7 +------
>  arch/arm/mach-exynos4/include/mach/gpio.h   |    5 +----
>  arch/arm/mach-gemini/include/mach/gpio.h    |    5 +----
>  arch/arm/mach-ks8695/include/mach/gpio.h    |   11 ++---------
>  arch/arm/mach-lpc32xx/include/mach/gpio.h   |   17 +----------------
>  arch/arm/mach-msm/include/mach/gpio.h       |    5 +----
>  arch/arm/mach-mxs/include/mach/gpio.h       |    6 +-----
>  arch/arm/mach-realview/include/mach/gpio.h  |    6 +-----
>  arch/arm/mach-s3c2410/include/mach/gpio.h   |    5 +----
>  arch/arm/mach-s3c64xx/include/mach/gpio.h   |    6 +-----
>  arch/arm/mach-s5p64x0/include/mach/gpio.h   |    6 +-----
>  arch/arm/mach-s5pc100/include/mach/gpio.h   |    6 +-----
>  arch/arm/mach-s5pv210/include/mach/gpio.h   |    6 +-----
>  arch/arm/mach-shmobile/include/mach/gpio.h  |   15 +--------------
>  arch/arm/mach-tegra/include/mach/gpio.h     |    6 +-----
>  arch/arm/mach-versatile/include/mach/gpio.h |    6 +-----
>  arch/arm/mach-vt8500/include/mach/gpio.h    |    6 +-----
>  arch/arm/mach-w90x900/include/mach/gpio.h   |    5 +----
>  arch/arm/plat-mxc/include/mach/gpio.h       |    5 +----
>  arch/arm/plat-nomadik/include/plat/gpio.h   |   11 +----------
>  arch/arm/plat-omap/include/plat/gpio.h      |   15 +--------------
>  arch/arm/plat-orion/include/plat/gpio.h     |    6 ++----
>  arch/arm/plat-spear/include/plat/gpio.h     |    6 +-----
>  25 files changed, 36 insertions(+), 151 deletions(-)
> 
For mxs and mxc:

Tested-by: Shawn Guo <shawn.guo@linaro.org>

-- 
Regards,
Shawn

