From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: OMAP: RX51: fix 'KEY_10' compile breakage
Date: Tue, 27 Jul 2010 09:43:25 -0700
Message-ID: <20100727164325.GA4302@core.coreip.homeip.net>
References: <alpine.DEB.2.00.1007261625470.1906@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1007261625470.1906@utopia.booyaka.com>
Sender: linux-input-owner@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Tony Lindgren <tony@atomide.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Amit Kucheria <amit.kucheria@verdurent.com>, linux-input@vger.kernel.org, linux-omap@vger.kernel.org, stable@kernel.org
List-Id: linux-omap@vger.kernel.org

Hi Paul,

On Mon, Jul 26, 2010 at 04:28:12PM -0600, Paul Walmsley wrote:
> 
> Commit 3fea60261e73dbf4a51130d40cafcc8465b0f2c3 replaces KEY_F10 and 
> KEY_F11 macro references with 'KEY_10' and 'KEY_11'.  This breaks 
> v2.6.35-rc6 compiles with omap3_defconfig:
> 
>   CC      arch/arm/mach-omap2/board-rx51-peripherals.o
> arch/arm/mach-omap2/board-rx51-peripherals.c:223: error: 'KEY_10' undeclared here (not in a function)
> arch/arm/mach-omap2/board-rx51-peripherals.c:226: error: 'KEY_11' undeclared here (not in a function)
> 
> Fix by renaming the macro references back to KEY_F10 and KEY_F11.
> 
> Compile-tested only.
> 

Thank you for the patch however Linus managed to fish off LKML and apply
another version that I posted earlier.

-- 
Dmitry
