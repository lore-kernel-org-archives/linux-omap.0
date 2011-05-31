From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2] ARM: OMAP2: Add missing include of linux/gpio.h
Date: Tue, 31 May 2011 06:18:12 -0700
Message-ID: <20110531131812.GP11352@atomide.com>
References: <1306846544.30148.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1306846544.30148.1.camel@phoenix>
Sender: linux-kernel-owner@vger.kernel.org
To: Axel Lin <axel.lin@gmail.com>
Cc: linux-kernel@vger.kernel.org, Syed Mohammed Khasim <x0khasim@ti.com>, Grazvydas Ignotas <notasas@gmail.com>, Steve Sakoman <steve@sakoman.com>, Russell King <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Axel Lin <axel.lin@gmail.com> [110531 05:51]:
> I got some build error like below while executing "make omap2plus_defconfig".
> 
>   CC      arch/arm/mach-omap2/board-2430sdp.o
> arch/arm/mach-omap2/board-2430sdp.c: In function 'omap_2430sdp_init':
> arch/arm/mach-omap2/board-2430sdp.c:247: error: 'GPIOF_OUT_INIT_LOW' undeclared (first use in this function)
> arch/arm/mach-omap2/board-2430sdp.c:247: error: (Each undeclared identifier is reported only once
> arch/arm/mach-omap2/board-2430sdp.c:247: error: for each function it appears in.)
> 
> This patch fixes the build error by include linux/gpio.h instead of mach/gpio.h.

Does this happen with next?

Will queue as a fix anyways.

Tony
