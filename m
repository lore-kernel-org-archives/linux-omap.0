From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: omap2+: make omap4_get_cpu1_ns_pa_addr declaration
 usable
Date: Fri, 21 Apr 2017 15:21:59 -0700
Message-ID: <20170421222159.GA3780@atomide.com>
References: <20170421215556.2244576-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170421215556.2244576-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Santosh Shilimkar <ssantosh@kernel.org>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Nishanth Menon <nm@ti.com>, Tero Kristo <t-kristo@ti.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Arnd Bergmann <arnd@arndb.de> [170421 14:59]:
> When CONFIG_PM is disabled, we get a build error:
> 
> arch/arm/mach-omap2/omap-smp.c: In function 'omap4_smp_maybe_reset_cpu1':
> arch/arm/mach-omap2/omap-smp.c:309:20: error: implicit declaration of function 'omap4_get_cpu1_ns_pa_addr'; did you mean 'omap4_get_scu_base'? [-Werror=implicit-function-declaration]
> 
> We need to fix this in multiple files, to ensure the declaration is visible,
> to actually build the function without CONFIG_PM, and to only call it
> when OMAP4 and/or OMAP5 are enabled.
> 
> Fixes: 351b7c490700 ("ARM: omap2+: Revert omap-smp.c changes resetting CPU1 during boot")

Oops, sorry about that. Looks like I never hit that with my
randconfig builds earlier probably as we have at least CPU_IDLE and
ARCH_OMAP2PLUS_TYPICAL select PM. Thanks for fixing it:

Acked-by: Tony Lindgren <tony@atomide.com>
