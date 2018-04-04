From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: omap2: fix am43xx build without L2X0
Date: Wed, 4 Apr 2018 10:12:22 -0700
Message-ID: <20180404171222.GH5700@atomide.com>
References: <20180404102550.3692501-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180404102550.3692501-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Russell King <linux@armlinux.org.uk>, Dave Gerlach <d-gerlach@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Arnd Bergmann <arnd@arndb.de> [180404 10:27]:
> When CONFIG_CACHE_L2X0 is disabled, the am43xx specific suspend
> implemnentation fails to link:
> 
> arch/arm/mach-omap2/sleep43xx.o: In function `get_l2cache_base':
> (.text+0x180): undefined reference to `omap4_get_l2cache_base'
> 
> This adds an #ifdef protection around the code, like we do for am44xx.
> 
> Fixes: 41d37e61372f ("ARM: OMAP2+: Introduce low-level suspend code for AM43XX")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Thanks, looks OK to me:

Acked-by: Tony Lindgren <tony@atomide.com>
