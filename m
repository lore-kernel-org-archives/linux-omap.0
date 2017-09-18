From: Santosh Shilimkar <santosh.shilimkar@oracle.com>
Subject: Re: [PATCH] gpio: omap: omap_gpio_show_rev is not __init
Date: Mon, 18 Sep 2017 11:18:23 -0700
Message-ID: <ffcec36b-f7b3-c03d-58fc-a2c9c5235350@oracle.com>
References: <20170916204234.725130-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170916204234.725130-1-arnd@arndb.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, Grygorii Strashko <grygorii.strashko@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>, Kevin Hilman <khilman@kernel.org>, Linus Walleij <linus.walleij@linaro.org>
Cc: linux-omap@vger.kernel.org, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


On 9/16/2017 1:42 PM, Arnd Bergmann wrote:
> The probe function calls omap_gpio_show_rev(), which on most
> compilers is inlined, but on the old gcc-4.6 is not, causing
> a valid warning about the incorrect __init annotation:
> 
> WARNING: vmlinux.o(.text+0x40f614): Section mismatch in reference from the function omap_gpio_probe() to the function .init.text:omap_gpio_show_rev()
> The function omap_gpio_probe() references
> the function __init omap_gpio_show_rev().
> This is often because omap_gpio_probe lacks a __init
> annotation or the annotation of omap_gpio_show_rev is wrong.
> 
> This removes the __init.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
Acked-by: Santosh Shilimkar <ssantosh@kernel.org>
