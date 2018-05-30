From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH] net: davinci: fix building davinci mdio code without
 CONFIG_OF
Date: Wed, 30 May 2018 13:22:13 -0400 (EDT)
Message-ID: <20180530.132213.1979006919259696824.davem@davemloft.net>
References: <20180528155059.2736080-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180528155059.2736080-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: arnd@arndb.de
Cc: grygorii.strashko@ti.com, nsekhar@ti.com, f.fainelli@gmail.com, linux-omap@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 28 May 2018 17:50:20 +0200

> Test-building this driver on targets without CONFIG_OF revealed a build
> failure:
> 
> drivers/net/ethernet/ti/davinci_mdio.c: In function 'davinci_mdio_probe':
> drivers/net/ethernet/ti/davinci_mdio.c:380:9: error: implicit declaration of function 'davinci_mdio_probe_dt'; did you mean 'davinci_mdio_probe'? [-Werror=implicit-function-declaration]
> 
> This adjusts the #ifdef logic in the driver to make it build in
> all configurations.
> 
> Fixes: 2652113ff043 ("net: ethernet: ti: Allow most drivers with COMPILE_TEST")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Applied to net-next.
