From: Kevin Hilman <khilman@baylibre.com>
Subject: Re: [PATCH 1/4] ARM: omap2: avoid section mismatch warning
Date: Tue, 11 Dec 2018 10:12:57 -0800
Message-ID: <7h1s6oue3a.fsf@baylibre.com>
References: <20181210215856.2238253-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181210215856.2238253-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: arm@kernel.org, Kevin Hilman <khilman@kernel.org>, Tony Lindgren <tony@atomide.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Dave Gerlach <d-gerlach@ti.com>, Keerthy <j-keerthy@ti.com>, Tero Kristo <t-kristo@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Arnd Bergmann <arnd@arndb.de> writes:

> WARNING: vmlinux.o(.text+0x27530): Section mismatch in reference from the function am43xx_suspend_init() to the function .init.text:am43xx_map_scu()
> The function am43xx_suspend_init() references
> the function __init am43xx_map_scu().
> This is often because am43xx_suspend_init lacks a __init
> annotation or the annotation of am43xx_map_scu is wrong.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Kevin Hilman <khilman@baylibre.com>
