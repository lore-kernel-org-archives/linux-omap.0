From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 10/22] usb: omap: avoid mach/*.h headers
Date: Fri, 9 Aug 2019 07:38:13 +0200
Message-ID: <20190809053813.GA29036@kroah.com>
References: <20190808212234.2213262-1-arnd@arndb.de>
 <20190808212234.2213262-11-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190808212234.2213262-11-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Tony Lindgren <tony@atomide.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Felipe Balbi <balbi@kernel.org>, Alan Stern <stern@rowland.harvard.edu>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Linus Walleij <linus.walleij@linaro.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Thu, Aug 08, 2019 at 11:22:19PM +0200, Arnd Bergmann wrote:
> The omap usb drivers still rely on mach/*.h headers that
> are explicitly or implicitly included, but all the required
> definitions are now in include/linux/soc/ti/, so use those
> instead and allow compile-testing on other architectures.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/usb/gadget/udc/Kconfig     | 2 +-
>  drivers/usb/gadget/udc/omap_udc.c  | 2 ++
>  drivers/usb/host/Kconfig           | 2 +-
>  drivers/usb/host/ohci-omap.c       | 7 +++----
>  drivers/usb/phy/Kconfig            | 3 ++-
>  drivers/usb/phy/phy-isp1301-omap.c | 4 ++--
>  6 files changed, 11 insertions(+), 9 deletions(-)

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
