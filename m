From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] omapfb: rename omap2 module to omap2fb.ko
Date: Mon, 9 Jul 2018 00:02:16 -0700
Message-ID: <20180709070216.GE112168@atomide.com>
References: <20180706123528.2729378-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180706123528.2729378-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Mauro Carvalho Chehab <mchehab@s-opensource.com>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Arnd Bergmann <arnd@arndb.de> [180706 12:39]:
> In a kernel configuration with both CONFIG_FB_OMAP=m and CONFIG_FB_OMAP2=m,
> Kbuild fails to point out that we have two modules with the same name (omapfb.ko),
> but instead fails with a cryptic error message like:
> 
> ERROR: "omapfb_register_panel" [drivers/video/fbdev/omap/lcd_osk.ko] undefined!
> 
> This can now happen when building a randconfig kernel with CONFIG_ARCH_OMAP1,
> as the omap1 fbdev driver depends on that, whiel the omap2 fbdev driver can
> now be built anywhere with CONFIG_COMPILE_TEST.
> 
> The solution is to rename one of the two modules, so for consistency with
> the directory naming I decided to rename the omap2 version to omap2fb.ko.

Sounds good to me:

Acked-by: Tony Lindgren <tony@atomide.com>
