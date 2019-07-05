From: Jesper Dangaard Brouer <brouer@redhat.com>
Subject: Re: [PATCH v7 net-next 5/5] net: ethernet: ti: cpsw: add XDP
 support
Date: Fri, 5 Jul 2019 10:36:42 +0200
Message-ID: <20190705103642.5489bc87@carbon>
References: <20190704231406.27083-1-ivan.khoronzhuk@linaro.org>
        <20190704231406.27083-6-ivan.khoronzhuk@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190704231406.27083-6-ivan.khoronzhuk@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Cc: grygorii.strashko@ti.com, davem@davemloft.net, ast@kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, ilias.apalodimas@linaro.org, netdev@vger.kernel.org, daniel@iogearbox.net, jakub.kicinski@netronome.com, john.fastabend@gmail.com, brouer@redhat.com
List-Id: linux-omap@vger.kernel.org

On Fri,  5 Jul 2019 02:14:06 +0300
Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org> wrote:

> Add XDP support based on rx page_pool allocator, one frame per page.
> Page pool allocator is used with assumption that only one rx_handler
> is running simultaneously. DMA map/unmap is reused from page pool
> despite there is no need to map whole page.
> 
> Due to specific of cpsw, the same TX/RX handler can be used by 2
> network devices, so special fields in buffer are added to identify
> an interface the frame is destined to. Thus XDP works for both
> interfaces, that allows to test xdp redirect between two interfaces
> easily. Aslo, each rx queue have own page pools, but common for both
          ^^^^
          Also

> netdevs.
> 
> XDP prog is common for all channels till appropriate changes are added
> in XDP infrastructure. Also, once page_pool recycling becomes part of
> skb netstack some simplifications can be added, like removing
> page_pool_release_page() before skb receive.
> 
> In order to keep rx_dev while redirect, that can be somehow used in
> future, do flush in rx_handler, that allows to keep rx dev the same
> while reidrect. It allows to conform with tracing rx_dev pointed
        ^^^^^^^^
        redirect

> by Jesper.
> 
> Also, there is probability, that XDP generic code can be extended to
> support multi ndev drivers like this one, using same rx queue for
> several ndevs, based on switchdev for instance or else. In this case,
> driver can be modified like exposed here:
> https://lkml.org/lkml/2019/7/3/243
> 
> Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>

Acked-by: Jesper Dangaard Brouer <brouer@redhat.com>

I didn't spot any issues, but I don't have access to this hardware, so
I've not tested it.

-- 
Best regards,
  Jesper Dangaard Brouer
  MSc.CS, Principal Kernel Engineer at Red Hat
  LinkedIn: http://www.linkedin.com/in/brouer
