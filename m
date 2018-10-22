From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: [PATCH v2 net-next] net: ethernet: ti: cpsw: unsync mcast entries
 while switch promisc mode
Date: Mon, 22 Oct 2018 14:02:33 -0500
Message-ID: <f8cf706f-ee1c-f4a5-6a65-fad78d54c908@ti.com>
References: <20181022185136.8215-1-ivan.khoronzhuk@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181022185136.8215-1-ivan.khoronzhuk@linaro.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>, davem@davemloft.net
Cc: linux-omap@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org



On 10/22/18 1:51 PM, Ivan Khoronzhuk wrote:
> After flushing all mcast entries from the table, the ones contained in
> mc list of ndev are not restored when promisc mode is toggled off,
> because they are considered as synched with ALE, thus, in order to
> restore them after promisc mode - reset syncing info. This fix
> touches only switch mode devices, including single port boards
> like Beagle Bone.
> 
> Fixes: commit 5da1948969bc
> ("net: ethernet: ti: cpsw: fix lost of mcast packets while rx_mode update")
> 
> Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
> ---
> 
> Based on net-next/master


Thank you.
Reviewed-by: Grygorii Strashko <grygorii.strashko@ti.com>

-- 
regards,
-grygorii
