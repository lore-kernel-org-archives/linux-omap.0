From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: omap2: set CONFIG_LIRC=y in defconfig
Date: Mon, 26 Feb 2018 13:25:15 -0800
Message-ID: <20180226212344.GA16043@atomide.com>
References: <20180226204105.2858838-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180226204105.2858838-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Lokesh Vutla <lokeshvutla@ti.com>, Sekhar Nori <nsekhar@ti.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Grygorii Strashko <grygorii.strashko@ti.com>, Sean Young <sean@mess.org>, Kishon Vijay Abraham I <kishon@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Arnd Bergmann <arnd@arndb.de> [180226 20:42]:
> The CONFIG_LIRC symbol has changed from 'tristate' to 'bool, so we now
> get a warning for omap2plus_defconfig:
> 
> arch/arm/configs/omap2plus_defconfig:322:warning: symbol value 'm' invalid for LIRC
> 
> This changes the file to mark the symbol as built-in to get rid of the
> warning.
> 
> Fixes: a60d64b15c20 ("media: lirc: lirc interface should not be a raw decoder")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Tony Lindgren <tony@atomide.com>
