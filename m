From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: Re: [RFC PATCH 3/3] net: ethernet: ti: cpsw: add XDP support
Date: Fri, 19 Apr 2019 11:31:56 +0300
Message-ID: <20190419083156.GA6687@apalos>
References: <20190417174942.11811-1-ivan.khoronzhuk@linaro.org>
 <20190417174942.11811-4-ivan.khoronzhuk@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190417174942.11811-4-ivan.khoronzhuk@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Cc: grygorii.strashko@ti.com, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, hawk@kernel.org, xdp-newbies@vger.kernel.org, ast@kernel.org, aniel@iogearbox.net, jakub.kicinski@netronome.com, john.fastabend@gmail.com
List-Id: linux-omap@vger.kernel.org

Hi Ivan, 

> +static struct page *cpsw_alloc_page(struct cpsw_common *cpsw)
> +{
> +	struct page_pool *pool = cpsw->rx_page_pool;
> +	struct page *page;
> +	int i = 0;
> +
> +	do {
> +		page = page_pool_dev_alloc_pages(pool);
> +		if (!page)
> +			return NULL;
> +
> +		/* skip pages used by skb netstack */
I think the comment here is wrong and might confuse people.
The page ref cnt is 1, which means the packet was *processed* and netstack is
done with it, hence you can re-use it.
If it's !=1 then you correctly unmap the buffer and decrease the ref cnt, so it
will eventually be freed and not returned to the pool, right?
> +		if (page_ref_count(page) == 1)
> +			break;
> +
> +		/* it's a pitty, but free page */
> +		page_pool_recycle_direct(pool, page);
> +	} while (++i < descs_pool_size);
> +
> +	return page;
> +}
> +
 
 /Ilias
