From: Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH net-next 1/6] net: core: dev_addr_lists: add VID to device
 address
Date: Wed, 27 Feb 2019 20:24:00 -0800
Message-ID: <462e8b28-fc15-9321-2144-038a18e37170@gmail.com>
References: <20190226184556.16082-1-ivan.khoronzhuk@linaro.org>
 <20190226184556.16082-2-ivan.khoronzhuk@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190226184556.16082-2-ivan.khoronzhuk@linaro.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>, davem@davemloft.net, grygorii.strashko@ti.com
Cc: linux-omap@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, jiri@mellanox.com, ilias.apalodimas@linaro.org
List-Id: linux-omap@vger.kernel.org

On 2/26/2019 10:45 AM, Ivan Khoronzhuk wrote:
> Despite this is supposed to be used for Ethernet VLANs, not Ethernet
> addresses with space for VID also can reuse this, so VID is considered
> as virtual ID extension, not belonging strictly to Ethernet VLAN VIDs,
> and overall change can be named individual virtual device filtering
> (IVDF).
> 
> This patch adds VID tag at the end of each address. The actual
> reserved address size is 32 bytes. For Ethernet addresses with 6 bytes
> long that's possible to add tag w/o increasing address size. Thus,
> each address for the case has 32 - 6 = 26 bytes to hold additional
> info, say VID for virtual device addresses.
> 
> Therefore, when addresses are synced to the address list of parent
> device the address list of latter can contain separate addresses for
> virtual devices. It allows to track separate address tables for
> virtual devices if they present and the device can be placed on
> any place of device tree as the address is propagated to to the end
> real device thru *_sync()/ndo_set_rx_mode() APIs. Also it simplifies
> handling VID addresses at real device when it supports IVDF.
> 
> If parent device doesn't want to have virtual addresses in its address
> space the vid_len has to be 0, thus its address space is "shrunk" to
> the state as before this patch. For now it's 0 for every device. It
> allows two devices with and w/o IVDF to be part of same bond device
> for instance.
> 
> The end real device supporting IVDF can retrieve VID tag from an
> address and set it for a given virtual device only. By default, vid 0
> is used for real devices to distinguish it from virtual addresses.
> 
> See next patches to see how it's used.
> 
> Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
> ---

[snip]


> @@ -1889,6 +1890,7 @@ struct net_device {
>  	unsigned char		perm_addr[MAX_ADDR_LEN];
>  	unsigned char		addr_assign_type;
>  	unsigned char		addr_len;
> +	unsigned char		vid_len;

Have not compiled or tested this patch series yet, but did you check
that adding this member does not change the structure layout (you can
use pahole for that purpose).

>  	unsigned short		neigh_priv_len;
>  	unsigned short          dev_id;
>  	unsigned short          dev_port;
> @@ -4141,8 +4143,10 @@ int dev_addr_init(struct net_device *dev);
>  
>  /* Functions used for unicast addresses handling */
>  int dev_uc_add(struct net_device *dev, const unsigned char *addr);
> +int dev_vid_uc_add(struct net_device *dev, const unsigned char *addr);
>  int dev_uc_add_excl(struct net_device *dev, const unsigned char *addr);
>  int dev_uc_del(struct net_device *dev, const unsigned char *addr);
> +int dev_vid_uc_del(struct net_device *dev, const unsigned char *addr);
>  int dev_uc_sync(struct net_device *to, struct net_device *from);
>  int dev_uc_sync_multiple(struct net_device *to, struct net_device *from);
>  void dev_uc_unsync(struct net_device *to, struct net_device *from);
> diff --git a/net/core/dev_addr_lists.c b/net/core/dev_addr_lists.c
> index a6723b306717..e3c80e044b8c 100644
> --- a/net/core/dev_addr_lists.c
> +++ b/net/core/dev_addr_lists.c
> @@ -545,6 +545,26 @@ int dev_addr_del(struct net_device *dev, const unsigned char *addr,
>  }
>  EXPORT_SYMBOL(dev_addr_del);
>  
> +static int get_addr_len(struct net_device *dev)
> +{
> +	return dev->addr_len + dev->vid_len;
> +}
> +
> +static int set_vid_addr(struct net_device *dev, const unsigned char *addr,
> +			unsigned char *naddr)

Having some kernel doc comments here would be nice to indicate that the
return value is dev->addr_len, it was not obvious until I saw in the
next function how you used it.

> +{
> +	int i;
> +
> +	if (!dev->vid_len)
> +		return dev->addr_len;
> +
> +	memcpy(naddr, addr, dev->addr_len);
> +	for (i = 0; i < dev->vid_len; i++)
> +		naddr[dev->addr_len + i] = 0;

memset(naddr + dev->addr_len, 0, dev->vid_len) would be more compact and
maybe a little less error prone too?
-- 
Florian
