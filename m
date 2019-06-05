From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH v3 net-next 0/7] net: ethernet: ti: cpsw: Add XDP
 support
Date: Wed, 05 Jun 2019 12:14:50 -0700 (PDT)
Message-ID: <20190605.121450.2198491088032558315.davem@davemloft.net>
References: <20190605132009.10734-1-ivan.khoronzhuk@linaro.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190605132009.10734-1-ivan.khoronzhuk@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: ivan.khoronzhuk@linaro.org
Cc: grygorii.strashko@ti.com, hawk@kernel.org, ast@kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, xdp-newbies@vger.kernel.org, ilias.apalodimas@linaro.org, netdev@vger.kernel.org, daniel@iogearbox.net, jakub.kicinski@netronome.com, john.fastabend@gmail.com
List-Id: linux-omap@vger.kernel.org

From: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Date: Wed,  5 Jun 2019 16:20:02 +0300

> This patchset adds XDP support for TI cpsw driver and base it on
> page_pool allocator. It was verified on af_xdp socket drop,
> af_xdp l2f, ebpf XDP_DROP, XDP_REDIRECT, XDP_PASS, XDP_TX.

Jesper et al., please give this a good once over.

Thank you.
