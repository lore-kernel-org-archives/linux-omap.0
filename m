From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: [PATCH 0/2] net: ethernet: ti: cpsw: fix runtime pm while add/del
 reserved vid
Date: Fri, 10 Aug 2018 12:53:17 -0500
Message-ID: <877f6057-70e2-c13b-7937-334ebfef6889@ti.com>
References: <20180810124709.25089-1-ivan.khoronzhuk@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180810124709.25089-1-ivan.khoronzhuk@linaro.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>, davem@davemloft.net
Cc: linux-omap@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org



On 08/10/2018 07:47 AM, Ivan Khoronzhuk wrote:
> Here 2 not critical fixes for:
> - vlan ale table leak while error if deleting vlan (simplifies next fix)
> - runtime pm while try to set reserved vlan
> 
> Based on net/master
> 
> Ivan Khoronzhuk (2):
>    net: ethernet: ti: cpsw: clear all entries when delete vid
>    net: ethernet: ti: cpsw: fix runtime_pm while add/kill vlan
> 
>   drivers/net/ethernet/ti/cpsw.c     | 25 +++++++++++--------------
>   drivers/net/ethernet/ti/cpsw_ale.c |  2 +-
>   2 files changed, 12 insertions(+), 15 deletions(-)
> 

Thank you.
Reviewed-by: Grygorii Strashko <grygorii.strashko@ti.com>

-- 
regards,
-grygorii
