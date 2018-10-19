From: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Subject: Re: [PATCH net-next] net: ethernet: ti: cpsw: don't flush mcast
 entries while switch promisc mode
Date: Fri, 19 Oct 2018 15:04:09 +0300
Message-ID: <20181019120408.GA3909@khorivan>
References: <20181018180006.7065-1-ivan.khoronzhuk@linaro.org>
 <6c34a3ce-dbee-538e-bda7-8dd485315267@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <6c34a3ce-dbee-538e-bda7-8dd485315267@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: davem@davemloft.net, linux-omap@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Thu, Oct 18, 2018 at 07:03:06PM -0500, Grygorii Strashko wrote:
>
>
>On 10/18/18 1:00 PM, Ivan Khoronzhuk wrote:
>>No need now to flush mcast entries in switch mode while toggling to
>>promiscuous mode. It's not needed as vlan reg_mcast = ALL_PORTS
>>and mcast/vlan ports = ALL_PORTS, the same happening for vlan
>>unreg_mcast, it's set to ALL_PORT_MASK just after calling promisc
>>mode routine by calling set allmulti. I suppose main reason to flush
>>them is to use unreg_mcast to receive all to host port. Thus, now, all
>>mcast packets are received anyway and no reason to flush mcast entries
>>unsafely, as they were synced with __dev_mc_sync() previously and are
>>not restored. Another way is to _dev_mc_unsync() them, but no need.
>
>User have possibility to add additional mcast entries or edit existing 
>in switch-mode, which is now done using custom tool. So, Host in 
>promisc
>mode will not receive packets for mcast address X if port mask for this
>addr set to (ALL_PORTS - HOST_PORT). Am I missing smth?

I didn't take into account the custom tool changing entries directly,
but even in this case there is at least a couple of interesting
questions:

1) Before the patch applied only several days ago -
   5da1948969bc1991920987ce4361ea56046e5a98
   "ti: cpsw: fix lost of mcast packets while rx_mode update"
   It was impossible to do correctly anyway, as all mcast entries not
   in the mc list were flushed (after rx_mode cb), by:
   cpsw_ale_flush_multicast(cpsw->ale, ALE_ALL_PORTS, vid);
   and those in mc, rewritten by adding them back in corrected form.
   ... or this cb was not supposed to be called at all ...

2) What is the reason to add mcast switch entires
   (ALL_PORTS - HOST_PORT) if its function is added anyway by
   unreq_mcast & (ALL_PORTS - HOST_PORT) ?
   So, doesn't matter it's added or not - it will work :-|.

3) Even so, toggling promisc mode will clear all these changes anyway,
   even I will call _dev_mc_unsync() after flushing them.

4) If user can tune ALE table by hand, what stops him do it after moving
   to promisc mode, seems he knows what he's doing?

5) It could be possible only for not default vlan entries, but mcast
   vlan support is not supported yet. Who is gona restore those
   entries after promisc off?

This behaviour is arguable, and flushing mcast entries can bring more
issues then leaving. For me it doesn't matter, I can archive the same
by adding after flush one line, it's even shorter:
__dev_mc_unsync(priv->ndev, NULL);


>
>>
>>Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
>>---
>>
>>Based on net-next/master
>>Tasted on am572x EVM and BBB
>>
>>  drivers/net/ethernet/ti/cpsw.c | 3 ---
>>  1 file changed, 3 deletions(-)
>>
>>diff --git a/drivers/net/ethernet/ti/cpsw.c b/drivers/net/ethernet/ti/cpsw.c
>>index 226be2a56c1f..0e475020a674 100644
>>--- a/drivers/net/ethernet/ti/cpsw.c
>>+++ b/drivers/net/ethernet/ti/cpsw.c
>>@@ -638,9 +638,6 @@ static void cpsw_set_promiscious(struct net_device *ndev, bool enable)
>>  			} while (time_after(timeout, jiffies));
>>  			cpsw_ale_control_set(ale, 0, ALE_AGEOUT, 1);
>>-			/* Clear all mcast from ALE */
>>-			cpsw_ale_flush_multicast(ale, ALE_ALL_PORTS, -1);
>>-
>>  			/* Flood All Unicast Packets to Host port */
>>  			cpsw_ale_control_set(ale, 0, ALE_P0_UNI_FLOOD, 1);
>>  			dev_dbg(&ndev->dev, "promiscuity enabled\n");
>>
>
>-- 
>regards,
>-grygorii

-- 
Regards,
Ivan Khoronzhuk
