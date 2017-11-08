From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] Kernel debugging: omap: print warning if CONFIG_DEBUG_LL
 is enabled
Date: Wed, 8 Nov 2017 14:27:55 -0800
Message-ID: <20171108222755.GW28152@atomide.com>
References: <b80b85cd6f26d02d698463b3dd5e9783081aa780.1510176592.git.hns@goldelico.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <b80b85cd6f26d02d698463b3dd5e9783081aa780.1510176592.git.hns@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, letux-kernel@openphoenux.org, kernel@pyra-handheld.com, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* H. Nikolaus Schaller <hns@goldelico.com> [171108 21:32]:
> commit d2b310b0234c ("ARM: debug: Use generic 8250 debug_ll for omap2 and omap3/4/5 common uarts")
> commit fc23beb8a577 ("ARM: debug: Use generic 8250 debug_ll for omap3/4/5")
> 
> switched to generic 8250 debug_ll code which seems to be incompatible
> with at least OMAP5 boards (OMAP5EVM, Pyra) if CONFIG_DEBUG_LL is
> still enabled in some legacy defconfig. Since this is very hard to
> relate to these patches and difficult to identify, let's have the
> compiler emit a warning.

Hmm the issue is the existing values in .config as Kconfig.debug
does default XXX if DEBUG_XXX, right?

I think we have this issue in general if you enable DEBUG_LL for
a SoC, then enable it for another SoC using the same .config?

Regards,

Tony
