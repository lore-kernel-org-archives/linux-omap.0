From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH] davinci_emac: always build in CONFIG_OF code
Date: Thu, 07 Mar 2019 09:29:35 -0800 (PST)
Message-ID: <20190307.092935.672404980902324009.davem@davemloft.net>
References: <20190307093135.3354493-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190307093135.3354493-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: arnd@arndb.de
Cc: ndesaulniers@google.com, grygorii.strashko@ti.com, bgolaszewski@baylibre.com, linux-omap@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>
Date: Thu,  7 Mar 2019 10:31:20 +0100

> clang warns about what seems to be an unintended use of an obscure C
> language feature where a forward declaration of an array remains usable
> when the final definition is never seen:
> 
> drivers/net/ethernet/ti/davinci_emac.c:1694:34: error: tentative array definition assumed to have one element [-Werror]
> static const struct of_device_id davinci_emac_of_match[];
> 
> There is no harm in always enabling the device tree matching code here,
> and it makes the code behave in a more conventional way aside from
> avoiding the warning.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Applied.
