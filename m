From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH] mfd: omap-usb-tll: fix register offsets
Date: Thu, 24 Aug 2017 09:46:23 +0100
Message-ID: <20170824084623.54d3iim56yqvgc4z@dell>
References: <20170823144501.2292044-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170823144501.2292044-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Tony Lindgren <tony@atomide.com>, Roger Quadros <rogerq@ti.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Wed, 23 Aug 2017, Arnd Bergmann wrote:

> gcc-8 notices that the register number calculation is wrong
> when the offset is an 'u8' but the number is larger than 256:
> 
> drivers/mfd/omap-usb-tll.c: In function 'omap_tll_init':
> drivers/mfd/omap-usb-tll.c:90:46: error: overflow in conversion from 'int' to 'u8 {aka unsigned char}' chages value from 'i * 256 + 2070' to '22' [-Werror=overflow]
> 
> This addresses it by always using a 32-bit offset number for
> the register. This is apparently an old problem that previous
> compilers did not find.
> 
> Fixes: 16fa3dc75c22 ("mfd: omap-usb-tll: HOST TLL platform driver")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/mfd/omap-usb-tll.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied, thanks.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
