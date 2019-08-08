From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 13/22] input: omap: void using mach/*.h headers
Date: Thu, 8 Aug 2019 14:42:57 -0700
Message-ID: <20190808214257.GF178933@dtor-ws>
References: <20190808212234.2213262-1-arnd@arndb.de>
 <20190808212234.2213262-14-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190808212234.2213262-14-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Tony Lindgren <tony@atomide.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linus Walleij <linus.walleij@linaro.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi Arnd,

On Thu, Aug 08, 2019 at 11:22:22PM +0200, Arnd Bergmann wrote:
> By using the new linux/soc/ti/omap1-io.h header instead,
> compile-testing can be enabled, and a CONFIG_ARCH_MULTIPLATFORM
> conversion of omap1 may eventually be possible.
> 
> The warning in the header file gets removed in order to
> allow CONFIG_COMPILE_TEST.

Given that we want to migrate people off this driver everywhere but
OMAP1 I wonder why we would want to improve compile coverage of it.

Thanks.

-- 
Dmitry
