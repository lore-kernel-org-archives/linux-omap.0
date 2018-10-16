From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH net-next] net: ethernet: ti: cpsw: use for mcast
 entries only host port
Date: Mon, 15 Oct 2018 22:22:48 -0700 (PDT)
Message-ID: <20181015.222248.2263887975438589835.davem@davemloft.net>
References: <20181012160629.7245-1-ivan.khoronzhuk@linaro.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181012160629.7245-1-ivan.khoronzhuk@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: ivan.khoronzhuk@linaro.org
Cc: grygorii.strashko@ti.com, linux-omap@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

From: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Date: Fri, 12 Oct 2018 19:06:29 +0300

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

Applied.
