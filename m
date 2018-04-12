From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: [PATCH] net: ethernet: ti: cpsw: fix tx vlan priority mapping
Date: Thu, 12 Apr 2018 15:15:23 -0500
Message-ID: <d4456c5c-6746-dd57-303f-cc2174e5a2e7@ti.com>
References: <1523543140-20747-1-git-send-email-ivan.khoronzhuk@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1523543140-20747-1-git-send-email-ivan.khoronzhuk@linaro.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Cc: davem@davemloft.net, linux-omap@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org



On 04/12/2018 09:25 AM, Ivan Khoronzhuk wrote:
> The CPDMA_TX_PRIORITY_MAP in real is vlan pcp field priority mapping
> register and basically replaces vlan pcp field for tagged packets.
> So, set it to be 1:1 mapping.

"Otherwise, it will cause unexpected change of egress vlan tagged packets,
 like prio 2 -> prio 5"


> 
> Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
> ---
> Based on net/master

Fixes: e05 107 e6b 747 ("net: ethernet: ti: cpsw: add multi queue support")

Reviewed-by: Grygorii Strashko <grygorii.strashko@ti.com> 

> 
>   drivers/net/ethernet/ti/cpsw.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/ti/cpsw.c b/drivers/net/ethernet/ti/cpsw.c
> index 3037127..74f8284 100644
> --- a/drivers/net/ethernet/ti/cpsw.c
> +++ b/drivers/net/ethernet/ti/cpsw.c
> @@ -129,7 +129,7 @@ do {								\
>   
>   #define RX_PRIORITY_MAPPING	0x76543210
>   #define TX_PRIORITY_MAPPING	0x33221100
> -#define CPDMA_TX_PRIORITY_MAP	0x01234567
> +#define CPDMA_TX_PRIORITY_MAP	0x76543210
>   
>   #define CPSW_VLAN_AWARE		BIT(1)
>   #define CPSW_RX_VLAN_ENCAP	BIT(2)
> 

-- 
regards,
-grygorii
