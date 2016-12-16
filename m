From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] omap2: mark omap_init_rng as __init
Date: Fri, 16 Dec 2016 09:11:30 -0800
Message-ID: <20161216171130.GH4920@atomide.com>
References: <20161216090906.2313595-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20161216090906.2313595-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Javier Martinez Canillas <javier@osg.samsung.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Suman Anna <s-anna@ti.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Arnd Bergmann <arnd@arndb.de> [161216 01:10]:
> I found this section mismatch when building with an older
> compiler release:
> 
> WARNING: vmlinux.o(.text+0x3051c): Section mismatch in reference from the function omap_init_rng() to the function .init.text:omap_device_build()
> 
> Obviously this one function should be __init as well. Normally
> we don't get a warning as the function gets inlined into its
> caller.

Acked-by: Tony Lindgren <tony@atomide.com>
