From: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Subject: Re: [PATCH net-next] net: ethernet: ti: cpsw: replace unnecessarily
 macroses on functions
Date: Fri, 27 Jul 2018 23:49:51 +0300
Message-ID: <20180727204950.GD2619@khorivan>
References: <20180727191318.18698-1-ivan.khoronzhuk@linaro.org>
 <20180727203203.GB17441@lunn.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180727203203.GB17441@lunn.ch>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Lunn <andrew@lunn.ch>
Cc: grygorii.strashko@ti.com, davem@davemloft.net, linux-omap@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Fri, Jul 27, 2018 at 10:32:03PM +0200, Andrew Lunn wrote:
>> +static inline void cpsw_src_port_detect(struct cpsw_common *cpsw, int status,
>> +					struct sk_buff *skb)
>
>Please don't use inline. Let the compiler decide.
>
>       Andrew

Corrected in v2

-- 
Regards,
Ivan Khoronzhuk
