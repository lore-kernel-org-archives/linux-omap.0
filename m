From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH v8 net-next 0/5] net: ethernet: ti: cpsw: Add XDP
 support
Date: Sun, 07 Jul 2019 18:31:46 -0700 (PDT)
Message-ID: <20190707.183146.1123763637704790378.davem@davemloft.net>
References: <20190705150502.6600-1-ivan.khoronzhuk@linaro.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190705150502.6600-1-ivan.khoronzhuk@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: ivan.khoronzhuk@linaro.org
Cc: grygorii.strashko@ti.com, hawk@kernel.org, ast@kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, xdp-newbies@vger.kernel.org, ilias.apalodimas@linaro.org, netdev@vger.kernel.org, daniel@iogearbox.net, jakub.kicinski@netronome.com, john.fastabend@gmail.com
List-Id: linux-omap@vger.kernel.org

From: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Date: Fri,  5 Jul 2019 18:04:57 +0300

> This patchset adds XDP support for TI cpsw driver and base it on
> page_pool allocator. It was verified on af_xdp socket drop,
> af_xdp l2f, ebpf XDP_DROP, XDP_REDIRECT, XDP_PASS, XDP_TX.
> 
> It was verified with following configs enabled:
 ...

I'm applying this to net-next, please deal with whatever follow-ups are
necessary.

Thanks!
