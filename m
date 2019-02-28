From: Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH net-next 5/6] net: ethernet: ti: cpsw: update mc filtering
 to use IVDF
Date: Wed, 27 Feb 2019 20:17:34 -0800
Message-ID: <1f68e415-e022-e4a2-6123-b3ebc2ff797b@gmail.com>
References: <20190226184556.16082-1-ivan.khoronzhuk@linaro.org>
 <20190226184556.16082-6-ivan.khoronzhuk@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190226184556.16082-6-ivan.khoronzhuk@linaro.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>, davem@davemloft.net, grygorii.strashko@ti.com
Cc: linux-omap@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, jiri@mellanox.com, ilias.apalodimas@linaro.org
List-Id: linux-omap@vger.kernel.org



On 2/26/2019 10:45 AM, Ivan Khoronzhuk wrote:
> The cpsw can filter multicast addresses only per vlan. Thus if mcast
> address is set for one of them or only for real device it must be
> added for every created vlan consuming ALE table w/o reason. In order to
> simplify dispatching vlan filters, the IVDF recently added is resused.
> 
> In case IVDF is disabled - mc is updated only for real device as before.
> The previous method is harder to reuse and vlan filtering is limited
> only for vlans directly connected to real netdev, so drop it in flavor
> of IVDF decision.
> 
> Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
> ---
>  drivers/net/ethernet/ti/Kconfig |   1 +
>  drivers/net/ethernet/ti/cpsw.c  | 113 ++++----------------------------
>  2 files changed, 13 insertions(+), 101 deletions(-)

Nice diffstat!
-- 
Florian
