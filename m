From: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Subject: Re: [PATCH v3 net-next] net: ethernet: ti: cpsw: replace
 unnecessarily macroses on functions
Date: Sat, 28 Jul 2018 17:41:26 +0300
Message-ID: <20180728144125.GA7561@khorivan>
References: <20180727225725.3843-1-ivan.khoronzhuk@linaro.org>
 <c2b3f36b8e7e1a2799580e76f19a267351da5491.camel@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <c2b3f36b8e7e1a2799580e76f19a267351da5491.camel@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Joe Perches <joe@perches.com>
Cc: grygorii.strashko@ti.com, davem@davemloft.net, linux-omap@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, andrew@lunn.ch
List-Id: linux-omap@vger.kernel.org

On Fri, Jul 27, 2018 at 04:30:54PM -0700, Joe Perches wrote:
>On Sat, 2018-07-28 at 01:57 +0300, Ivan Khoronzhuk wrote:
>> Replace ugly macroses on functions.
>
>trivia:
>
>As cpsw_src_port_detect is only used once, and is a
>very small function, it might make the code more
>intelligible to just directly code it where it's used.
>
>> diff --git a/drivers/net/ethernet/ti/cpsw.c b/drivers/net/ethernet/ti/cpsw.c
>[]
>> @@ -565,40 +565,40 @@ static const struct cpsw_stats cpsw_gstrings_ch_stats[] = {
>[]
>> +static void cpsw_src_port_detect(struct cpsw_common *cpsw, int status,
>> +				 struct sk_buff *skb)
>> +{
>> +	if (!cpsw->data.dual_emac)
>> +		return;
>> +
>> +	if (CPDMA_RX_SOURCE_PORT(status) == 1)
>> +		skb->dev = cpsw->slaves[0].ndev;
>> +	else if (CPDMA_RX_SOURCE_PORT(status) == 2)
>> +		skb->dev = cpsw->slaves[1].ndev;
>> +}
>[]
>> @@ -801,7 +801,8 @@ static void cpsw_rx_handler(void *token, int len, int status)
>>  	int			ret = 0;
>>  	struct cpsw_common	*cpsw = ndev_to_cpsw(ndev);
>>
>> -	cpsw_dual_emac_src_port_detect(cpsw, status, ndev, skb);
>> +	cpsw_src_port_detect(cpsw, status, skb);
>
>here
Can put here, instead of function, the following:
	if (cpsw->data.dual_emac) {
		port = CPDMA_RX_SOURCE_PORT(status);
		if (port) {
			ndev = cpsw->slaves[--port].ndev;
			skb->dev = ndev;
		}
	}

if no objection ofc.

>
>> +	ndev = skb->dev;

-- 
Regards,
Ivan Khoronzhuk
