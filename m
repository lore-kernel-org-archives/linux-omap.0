From: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Subject: Re: [PATCH v7 net-next 5/5] net: ethernet: ti: cpsw: add XDP support
Date: Fri, 5 Jul 2019 15:01:16 +0300
Message-ID: <20190705120114.GA3587@khorivan>
References: <20190704231406.27083-1-ivan.khoronzhuk@linaro.org>
 <20190704231406.27083-6-ivan.khoronzhuk@linaro.org>
 <20190705131354.15a9313c@carbon>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <netdev-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190705131354.15a9313c@carbon>
Sender: netdev-owner@vger.kernel.org
To: Jesper Dangaard Brouer <brouer@redhat.com>
Cc: grygorii.strashko@ti.com, davem@davemloft.net, ast@kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, ilias.apalodimas@linaro.org, netdev@vger.kernel.org, daniel@iogearbox.net, jakub.kicinski@netronome.com, john.fastabend@gmail.com
List-Id: linux-omap@vger.kernel.org

On Fri, Jul 05, 2019 at 01:13:54PM +0200, Jesper Dangaard Brouer wrote:
>On Fri,  5 Jul 2019 02:14:06 +0300
>Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org> wrote:
>
>> +static int cpsw_xdp_tx_frame(struct cpsw_priv *priv, struct xdp_frame *xdpf,
>> +			     struct page *page)
>> +{
>> +	struct cpsw_common *cpsw = priv->cpsw;
>> +	struct cpsw_meta_xdp *xmeta;
>> +	struct cpdma_chan *txch;
>> +	dma_addr_t dma;
>> +	int ret, port;
>> +
>> +	xmeta = (void *)xdpf + CPSW_XMETA_OFFSET;
>> +	xmeta->ndev = priv->ndev;
>> +	xmeta->ch = 0;
>> +	txch = cpsw->txv[0].ch;
>> +
>> +	port = priv->emac_port + cpsw->data.dual_emac;
>> +	if (page) {
>> +		dma = page_pool_get_dma_addr(page);
>> +		dma += xdpf->data - (void *)xdpf;
>
>This code is only okay because this only happens for XDP_TX, where you
>know this head-room calculation will be true.  The "correct"
>calculation of the head-room would be:
>
>  dma += xdpf->headroom + sizeof(struct xdp_frame);
>
>The reason behind not using xdpf pointer itself as "data_hard_start",
>is to allow struct xdp_frame to be located in another memory area.

My assumption was based on:

struct xdp_frame *convert_to_xdp_frame(struct xdp_buff *xdp)
{
	...
	xdp_frame = xdp->data_hard_start;
	...

	xdp_frame->headroom = headroom - sizeof(*xdp_frame);
	...
}

But agree, it doesn't contradict the reason in question.
So, better use proposed variant. Will check and do this in v8 a little later:

dma += xdpf->headroom + sizeof(struct xdp_frame);

>This will be useful for e.g. AF_XDP transmit, or other zero-copy
>transmit to go through ndo_xdp_xmit() (as we don't want userspace to
>be-able to e.g. "race" change xdpf->len during transmit/DMA-completion).
>
>
>> +		ret = cpdma_chan_submit_mapped(txch, cpsw_xdpf_to_handle(xdpf),
>> +					       dma, xdpf->len, port);
>> +	} else {
>> +		if (sizeof(*xmeta) > xdpf->headroom) {
>> +			xdp_return_frame_rx_napi(xdpf);
>> +			return -EINVAL;
>> +		}
>> +
>> +		ret = cpdma_chan_submit(txch, cpsw_xdpf_to_handle(xdpf),
>> +					xdpf->data, xdpf->len, port);
>> +	}
>
>
>
>-- 
>Best regards,
>  Jesper Dangaard Brouer
>  MSc.CS, Principal Kernel Engineer at Red Hat
>  LinkedIn: http://www.linkedin.com/in/brouer

-- 
Regards,
Ivan Khoronzhuk
