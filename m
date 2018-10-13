From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: [PATCH net-next] net: ethernet: ti: cpsw: use for mcast entries
 only host port
Date: Fri, 12 Oct 2018 19:41:32 -0500
Message-ID: <79601c11-8160-fe8e-f824-8b19d539bb76@ti.com>
References: <20181012160629.7245-1-ivan.khoronzhuk@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181012160629.7245-1-ivan.khoronzhuk@linaro.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>, davem@davemloft.net
Cc: linux-omap@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org



On 10/12/2018 11:06 AM, Ivan Khoronzhuk wrote:
> In dual-emac mode the cpsw driver sends directed packets, that means
> that packets go to the directed port, but an ALE lookup is performed
> to determine untagged egress only. It means that on tx side no need
> to add port bit for ALE mcast entry mask, and basically ALE entry
> for port identification is needed only on rx side.
> 
> So, add only host port in dual_emac mode as used directed
> transmission, and no need in one more port. For single port boards
> and switch mode all ports used, as usual, so no changes for them.
> Also it simplifies farther changes.
> 
> In other words, mcast entries for dual-emac should behave exactly
> like unicast. It also can help avoid leaking packets between ports
> with same vlan on h/w level if ports could became members of same vid.
> 
> So now, for instance, if mcast address 33:33:00:00:00:01 is added then
> entries in ALE table:
> 
> vid = 1, addr = 33:33:00:00:00:01, port_mask = 0x1
> vid = 2, addr = 33:33:00:00:00:01, port_mask = 0x1
> 
> Instead of:
> vid = 1, addr = 33:33:00:00:00:01, port_mask = 0x3
> vid = 2, addr = 33:33:00:00:00:01, port_mask = 0x5
> 
> With the same considerations, set only host port for unregistered
> mcast for dual-emac mode in case of IFF_ALLMULTI is set, exactly like
> it's done in cpsw_ale_set_allmulti().
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
