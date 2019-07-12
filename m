From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH] [net-next] davinci_cpdma: don't cast dma_addr_t to
 pointer
Date: Fri, 12 Jul 2019 15:19:59 -0700 (PDT)
Message-ID: <20190712.151959.494337984512463318.davem@davemloft.net>
References: <20190710080106.24237-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190710080106.24237-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: arnd@arndb.de
Cc: ivan.khoronzhuk@linaro.org, grygorii.strashko@ti.com, andrew@lunn.ch, ilias.apalodimas@linaro.org, linux-omap@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 10 Jul 2019 10:00:33 +0200

> dma_addr_t may be 64-bit wide on 32-bit architectures, so it is not
> valid to cast between it and a pointer:
> 
> drivers/net/ethernet/ti/davinci_cpdma.c: In function 'cpdma_chan_submit_si':
> drivers/net/ethernet/ti/davinci_cpdma.c:1047:12: error: cast from pointer to integer of different size [-Werror=pointer-to-int-cast]
> drivers/net/ethernet/ti/davinci_cpdma.c: In function 'cpdma_chan_idle_submit_mapped':
> drivers/net/ethernet/ti/davinci_cpdma.c:1114:12: error: cast to pointer from integer of different size [-Werror=int-to-pointer-cast]
> drivers/net/ethernet/ti/davinci_cpdma.c: In function 'cpdma_chan_submit_mapped':
> drivers/net/ethernet/ti/davinci_cpdma.c:1164:12: error: cast to pointer from integer of different size [-Werror=int-to-pointer-cast]
> 
> Solve this by using two separate members in 'struct submit_info'.
> Since this avoids the use of the 'flag' member, the structure does
> not even grow in typical configurations.
> 
> Fixes: 6670acacd59e ("net: ethernet: ti: davinci_cpdma: add dma mapped submit")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Applied.
