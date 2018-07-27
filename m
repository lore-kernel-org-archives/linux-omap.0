From: Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH net-next] net: ethernet: ti: cpsw: replace unnecessarily
 macroses on functions
Date: Fri, 27 Jul 2018 22:32:03 +0200
Message-ID: <20180727203203.GB17441@lunn.ch>
References: <20180727191318.18698-1-ivan.khoronzhuk@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180727191318.18698-1-ivan.khoronzhuk@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Cc: grygorii.strashko@ti.com, davem@davemloft.net, linux-omap@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

> +static inline void cpsw_src_port_detect(struct cpsw_common *cpsw, int status,
> +					struct sk_buff *skb)

Please don't use inline. Let the compiler decide.

       Andrew
