From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCH 0/3] omap3/omap4: add device tree support for wdt
Date: Tue, 29 May 2012 12:47:14 -0500
Message-ID: <4FC50BA2.4070404@ti.com>
References: <1337942552-28218-1-git-send-email-jgq516@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1337942552-28218-1-git-send-email-jgq516@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: jgq516@gmail.com
Cc: linux@arm.linux.org.uk, b-cousson@ti.com, rob.herring@calxeda.com, grant.likely@secretlab.ca, rnayak@ti.com, tony@atomide.com, wim@iguana.be, devicetree-discuss@lists.ozlabs.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-watchdog@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi Xiao Jiang,

On 05/25/2012 05:42 AM, jgq516@gmail.com wrote:
> From: Xiao Jiang <jgq516@gmail.com>
> 
> This series can be applied to dt branch of linux-omap tree.

Thanks for sending this!

> Since omap24xx series has different wdt base addr (omap2420: 0x48022000 and
> omap2430: 0x49016000) per commit 2817142f31bfbf26c216bf4f9192540c81b2d071, so
> I don't add wdt node in omap2.dtsi just like omap3 and omap4, maybe different
> dts files are needed for omap2420 and omap2430.

Good point. I am wondering if we can simple drop the address from the
wdt2 node for omap2. It is not really being used. May be Benoit can comment.

Cheers
Jon

> Tested with omap4430 blaze board.
> 
> Xiao Jiang (3):
>   arm/dts: add wdt node for omap3 and omap4
>   OMAP: wdt: add device tree support
>   watchdog: omap_wdt: add device tree support
> 
>  arch/arm/boot/dts/omap3.dtsi  |    5 +++++
>  arch/arm/boot/dts/omap4.dtsi  |    5 +++++
>  arch/arm/mach-omap2/devices.c |    2 +-
>  drivers/watchdog/omap_wdt.c   |    8 ++++++++
>  4 files changed, 19 insertions(+), 1 deletions(-)
> 
