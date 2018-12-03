From: Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [RFC PATCH net-next 2/5] net: 8021q: vlan_dev: add vid tag for uc
 and mc address lists
Date: Mon, 3 Dec 2018 14:17:00 -0800
Message-ID: <b2a7baa7-b334-0f6f-c119-a2f30ac68c7b@gmail.com>
References: <20181203184023.3430-1-ivan.khoronzhuk@linaro.org>
 <20181203184023.3430-3-ivan.khoronzhuk@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181203184023.3430-3-ivan.khoronzhuk@linaro.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>, davem@davemloft.net, grygorii.strashko@ti.com
Cc: linux-omap@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, jiri@mellanox.com, andrew@lunn.ch
List-Id: linux-omap@vger.kernel.org

On 12/3/18 10:40 AM, Ivan Khoronzhuk wrote:
> Update vlan mc and uc addresses with VID tag while propagating address
> set to lower devices, do this only if address is not synched. It allows
> on end driver level to distinguish address belonging to vlans.

Underlying driver for the real device would be able to properly identify
that you are attempting to add an address to a virtual device, which
happens to be of VLAN kind so I am really not sure this is the right
approach here.

>From there, it seems to me that we have two situations:

- each of your network devices expose VLAN devices directly on top of
the real device, in which case your driver should support
ndo_vlan_rx_add_vid and ndo_vlan_rx_kill_vid to know when VLAN devices
are create and maintain a VLAN device to VID correspondence if it needs
to when being called while setting the addresses

- you are setting up a bridge that is VLAN aware on one of your bridge
ports, and there you can use switchdev to learn about such events and
know about both addresses as well as VIDs that must be programmed into
your real device

It seems to me that what you need may be something like either:

- notifications on slave devices when addresses are added via
ndo_set_rxmode()

or

- dev_{uc,mc}_sync() should be augmented with a "source net_device"
argument which allows you to differentiate which network device is the
source of the address programming. That way, no need to "hash" the MAC
address with a VID, any network device specific information can be
provided and in the real device driver you can do: if
(netif_is_vlan()... etc.)

Hopefully someone else will chime in.

> 
> Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
> ---
>  include/linux/if_vlan.h |  1 +
>  net/8021q/vlan_core.c   | 10 ++++++++++
>  net/8021q/vlan_dev.c    | 26 ++++++++++++++++++++++++++
>  3 files changed, 37 insertions(+)
> 
> diff --git a/include/linux/if_vlan.h b/include/linux/if_vlan.h
> index 4cca4da7a6de..94657f3c483a 100644
> --- a/include/linux/if_vlan.h
> +++ b/include/linux/if_vlan.h
> @@ -136,6 +136,7 @@ extern struct net_device *__vlan_find_dev_deep_rcu(struct net_device *real_dev,
>  extern int vlan_for_each(struct net_device *dev,
>  			 int (*action)(struct net_device *dev, int vid,
>  				       void *arg), void *arg);
> +extern u16 vlan_dev_get_addr_vid(struct net_device *dev, const u8 *addr);
>  extern struct net_device *vlan_dev_real_dev(const struct net_device *dev);
>  extern u16 vlan_dev_vlan_id(const struct net_device *dev);
>  extern __be16 vlan_dev_vlan_proto(const struct net_device *dev);
> diff --git a/net/8021q/vlan_core.c b/net/8021q/vlan_core.c
> index a313165e7a67..5d17947d6988 100644
> --- a/net/8021q/vlan_core.c
> +++ b/net/8021q/vlan_core.c
> @@ -454,6 +454,16 @@ bool vlan_uses_dev(const struct net_device *dev)
>  }
>  EXPORT_SYMBOL(vlan_uses_dev);
>  
> +u16 vlan_dev_get_addr_vid(struct net_device *dev, const u8 *addr)
> +{
> +	u16 vid = 0;
> +
> +	vid = addr[dev->addr_len];
> +	vid |= (addr[dev->addr_len + 1] & 0xf) << 8;
> +	return vid;
> +}
> +EXPORT_SYMBOL(vlan_dev_get_addr_vid);
> +
>  static struct sk_buff *vlan_gro_receive(struct list_head *head,
>  					struct sk_buff *skb)
>  {
> diff --git a/net/8021q/vlan_dev.c b/net/8021q/vlan_dev.c
> index b2d9c8f27cd7..c05b313314b7 100644
> --- a/net/8021q/vlan_dev.c
> +++ b/net/8021q/vlan_dev.c
> @@ -250,6 +250,14 @@ void vlan_dev_get_realdev_name(const struct net_device *dev, char *result)
>  	strncpy(result, vlan_dev_priv(dev)->real_dev->name, 23);
>  }
>  
> +static void vlan_dev_set_addr_vid(struct net_device *vlan_dev, u8 *addr)
> +{
> +	u16 vid = vlan_dev_vlan_id(vlan_dev);
> +
> +	addr[vlan_dev->addr_len] = vid & 0xff;
> +	addr[vlan_dev->addr_len + 1] = (vid >> 8) & 0xf;
> +}
> +
>  bool vlan_dev_inherit_address(struct net_device *dev,
>  			      struct net_device *real_dev)
>  {
> @@ -481,8 +489,26 @@ static void vlan_dev_change_rx_flags(struct net_device *dev, int change)
>  	}
>  }
>  
> +static void vlan_dev_align_addr_vid(struct net_device *vlan_dev)
> +{
> +	struct net_device *real_dev = vlan_dev_real_dev(vlan_dev);
> +	struct netdev_hw_addr *ha;
> +
> +	if (!real_dev->vid_len)
> +		return;
> +
> +	netdev_for_each_mc_addr(ha, vlan_dev)
> +		if (!ha->sync_cnt)
> +			vlan_dev_set_addr_vid(vlan_dev, ha->addr);
> +
> +	netdev_for_each_uc_addr(ha, vlan_dev)
> +		if (!ha->sync_cnt)
> +			vlan_dev_set_addr_vid(vlan_dev, ha->addr);
> +}
> +
>  static void vlan_dev_set_rx_mode(struct net_device *vlan_dev)
>  {
> +	vlan_dev_align_addr_vid(vlan_dev);
>  	dev_mc_sync(vlan_dev_priv(vlan_dev)->real_dev, vlan_dev);
>  	dev_uc_sync(vlan_dev_priv(vlan_dev)->real_dev, vlan_dev);
>  }
> 


-- 
Florian
