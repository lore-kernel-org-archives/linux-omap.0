From: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Subject: Re: [PATCH] [net-next] davinci_cpdma: don't cast dma_addr_t to
 pointer
Date: Wed, 10 Jul 2019 17:26:39 +0300
Message-ID: <20190710142637.GA5375@khorivan>
References: <20190710080106.24237-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <netdev-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190710080106.24237-1-arnd@arndb.de>
Sender: netdev-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: "David S. Miller" <davem@davemloft.net>, Grygorii Strashko <grygorii.strashko@ti.com>, Andrew Lunn <andrew@lunn.ch>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, linux-omap@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Wed, Jul 10, 2019 at 10:00:33AM +0200, Arnd Bergmann wrote:
>dma_addr_t may be 64-bit wide on 32-bit architectures, so it is not
>valid to cast between it and a pointer:
>
>drivers/net/ethernet/ti/davinci_cpdma.c: In function 'cpdma_chan_submit_si':
>drivers/net/ethernet/ti/davinci_cpdma.c:1047:12: error: cast from pointer to integer of different size [-Werror=pointer-to-int-cast]
>drivers/net/ethernet/ti/davinci_cpdma.c: In function 'cpdma_chan_idle_submit_mapped':
>drivers/net/ethernet/ti/davinci_cpdma.c:1114:12: error: cast to pointer from integer of different size [-Werror=int-to-pointer-cast]
>drivers/net/ethernet/ti/davinci_cpdma.c: In function 'cpdma_chan_submit_mapped':
>drivers/net/ethernet/ti/davinci_cpdma.c:1164:12: error: cast to pointer from integer of different size [-Werror=int-to-pointer-cast]
>
>Solve this by using two separate members in 'struct submit_info'.
>Since this avoids the use of the 'flag' member, the structure does
>not even grow in typical configurations.
>
>Fixes: 6670acacd59e ("net: ethernet: ti: davinci_cpdma: add dma mapped submit")
>Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Despite "flags" could be used for smth else (who knows), looks ok.
Reviewed-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>

-- 
Regards,
Ivan Khoronzhuk
