From: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH 1/4] ARM: omap2: avoid section mismatch warning
Date: Wed, 12 Dec 2018 14:05:30 -0800
Message-ID: <20181212220530.m2o3njrvjcja5pfu@localhost>
References: <20181210215856.2238253-1-arnd@arndb.de>
 <20181210220926.GF6707@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181210220926.GF6707@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Arnd Bergmann <arnd@arndb.de>, arm@kernel.org, Kevin Hilman <khilman@kernel.org>, Dave Gerlach <d-gerlach@ti.com>, Keerthy <j-keerthy@ti.com>, Tero Kristo <t-kristo@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Mon, Dec 10, 2018 at 02:09:26PM -0800, Tony Lindgren wrote:
> * Arnd Bergmann <arnd@arndb.de> [181210 21:59]:
> > WARNING: vmlinux.o(.text+0x27530): Section mismatch in reference from the function am43xx_suspend_init() to the function .init.text:am43xx_map_scu()
> > The function am43xx_suspend_init() references
> > the function __init am43xx_map_scu().
> > This is often because am43xx_suspend_init lacks a __init
> > annotation or the annotation of am43xx_map_scu is wrong.
> 
> Acked-by: Tony Lindgren <tony@atomide.com>

Applied, thanks!


-Olof
