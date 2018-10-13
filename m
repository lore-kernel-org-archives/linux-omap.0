From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: [PATCH 0/2] net: ethernet: ti: cpsw fix mcast packet lost
Date: Fri, 12 Oct 2018 19:38:20 -0500
Message-ID: <3eb5615f-936d-40ae-d80f-bc752a896584@ti.com>
References: <20181012152815.31320-1-ivan.khoronzhuk@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181012152815.31320-1-ivan.khoronzhuk@linaro.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>, davem@davemloft.net
Cc: linux-omap@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org



On 10/12/2018 10:28 AM, Ivan Khoronzhuk wrote:
> The patchset omits redundant refresh of mcast address table and
> prevents mcast packet lost.
> 
> Based on net-next/master
> tested on am572x evm
> 
> Ivan Khoronzhuk (2):
>    net: ethernet: ti: cpsw_ale: use const for API having pointer on mac
>      address
>    net: ethernet: ti: cpsw: fix lost of mcast packets while rx_mode
>      update
> 
>   drivers/net/ethernet/ti/cpsw.c     | 46 ++++++++++++++++++------------
>   drivers/net/ethernet/ti/cpsw_ale.c | 12 ++++----
>   drivers/net/ethernet/ti/cpsw_ale.h |  8 +++---
>   3 files changed, 38 insertions(+), 28 deletions(-)
> 


Thank you.
Reviewed-by: Grygorii Strashko <grygorii.strashko@ti.com>

-- 
regards,
-grygorii
