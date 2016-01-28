From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 6/7] usb: musb: use %pad format string from dma_addr_t
Date: Thu, 28 Jan 2016 09:50:37 -0800
Message-ID: <20160128175036.GF19432@atomide.com>
References: <1453997722-3489596-1-git-send-email-arnd@arndb.de>
 <1453998206-3490016-1-git-send-email-arnd@arndb.de>
 <1453998206-3490016-2-git-send-email-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1453998206-3490016-2-git-send-email-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Felipe Balbi <balbi@kernel.org>, linux-arm-kernel@lists.infradead.org, Felipe Balbi <balbi@ti.com>, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, Robert Jarzmik <robert.jarzmik@free.fr>, Haojian Zhuang <haojian.zhuang@gmail.com>, Daniel Mack <daniel@zonque.org>, Imre Kaloz <kaloz@openwrt.org>, Krzysztof Halasa <khalasa@piap.pl>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Arnd Bergmann <arnd@arndb.de> [160128 08:26]:
> The musb driver prints DMA addresses in a few places, using the
> 0x%x format string. This is wrong on 64-bit architectures (which
> need %lx) and 32-bit ARM with CONFIG_LPAE set (which needs
> %llx), otherwise we print the wrong data, as gcc warns:
> 
> musb/musbhsdma.c: In function 'configure_channel':
> musb/musbhsdma.c:120:53: error: format '%x' expects argument of type 'unsigned int', but argument 6 has type 'dma_addr_t {aka long long unsigned int}' [-Werror=format=]
>   dev_dbg(musb->controller, "%p, pkt_sz %d, addr 0x%x, len %d, mode %d\n",
> musb/musbhsdma.c: In function 'dma_channel_program':
> musb/musbhsdma.c:155:53: error: format '%x' expects argument of type 'unsigned int', but argument 7 has type 'dma_addr_t {aka long long unsigned int}' [-Werror=format=]
>   dev_dbg(musb->controller, "ep%d-%s pkt_sz %d, dma_addr 0x%x length %d, mode %d\n",
> musb/tusb6010_omap.c: In function 'tusb_omap_dma_program':
> musb/tusb6010_omap.c:313:53: error: format '%x' expects argument of type 'unsigned int', but argument 7 has type 'dma_addr_t {aka long long unsigned int}' [-Werror=format=]
>   dev_dbg(musb->controller, "ep%i %s dma ch%i dma: %08x len: %u(%u) packet_sz: %i(%i)\n",
> 
> This uses the %pad format string, which prints a dma_addr_t that
> gets passed by reference, which works for all combinations.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Looks good to me:

Acked-by: Tony Lindgren <tony@atomide.com>
