From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH v2 net-next] net: ethernet: ti: davinci_mdio: switch to
 readl/writel()
Date: Mon, 01 Apr 2019 15:03:11 -0700 (PDT)
Message-ID: <20190401.150311.1479407310371625393.davem@davemloft.net>
References: <1553875114-14249-1-git-send-email-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1553875114-14249-1-git-send-email-grygorii.strashko@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: grygorii.strashko@ti.com
Cc: netdev@vger.kernel.org, nsekhar@ti.com, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, arnd@arndb.de
List-Id: linux-omap@vger.kernel.org

From: Grygorii Strashko <grygorii.strashko@ti.com>
Date: Fri, 29 Mar 2019 17:58:34 +0200

> Switch to readl/writel() APIs, because this is recommended
> API and the MDIO block is reused on Keystone 2 SoCs
> where LE/BE modes are supported.
> 
> Cc: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
> ---
> changes in v2:
> - use readl/writel() as recommended

Applied, thanks.
