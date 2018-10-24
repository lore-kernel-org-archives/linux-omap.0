From: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Subject: Re: [RFC PATCH net-next 3/4] net: ethernet: ti: cpsw: fix vlan mcast
Date: Wed, 24 Oct 2018 14:36:10 +0300
Message-ID: <20181024113609.GC4892@khorivan>
References: <20181016182035.18234-1-ivan.khoronzhuk@linaro.org>
 <20181016182035.18234-4-ivan.khoronzhuk@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181016182035.18234-4-ivan.khoronzhuk@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: grygorii.strashko@ti.com, davem@davemloft.net
Cc: linux-omap@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, alexander.h.duyck@intel.com
List-Id: linux-omap@vger.kernel.org

On Tue, Oct 16, 2018 at 09:20:34PM +0300, Ivan Khoronzhuk wrote:
>At this moment, mcast addresses are added only for real device only
>(reserved vlans for dual-emac mode), even if a mcast address was added
>for some vlan only, thus ALE doesn't have corresponding vlan mcast
>entries after vlan socket joined multicast group. So ALE drops vlan
>frames with mcast addresses intended for vlans and potentially can
>receive mcast frames for base ndev. That's not correct. So, fix it by
>creating only vlan/mcast entries as requested. Patch doesn't use any
>additional lists and is based on device mc address list and cpsw ALE
>table entries.
>
>Also, move device to allmulti state if no space for new mcast entries.
>
>Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>

I won't update allmulti state on v2, will do that separately as it
requires also splitting allmulti between interfaces in dual-mac mode.
Would be nice to move allmulti and promisc to ndo_change_rx_flags()
and do updates only if flag is changed, not for every address change.

Also there is an ability to set allmulti per vlan device and even
dev->allmulti counter can be used for that and it works, but in case
of allmulti flag there is no event from dev core if it's already set
(only allmuilti counter is changed w/o event). Thus no event to
segregate it between vlans. Adding update to dev core can lead to
more frequent rx_mode event and w/o reason for those devices who
doesn't care. I'm just wondering, why not to add smth like
IFF_VLAN_MCAST_FLT to dev->priv_flags and based on it generate
event differently or even do more stuff ....

Or leave it as is and set allmulti for every vlan, that seems
like a stub.

[...]

-- 
Regards,
Ivan Khoronzhuk
