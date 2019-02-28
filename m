From: Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH net-next 2/6] net: 8021q: vlan_dev: add vid tag to
 addresses of uc and mc lists
Date: Wed, 27 Feb 2019 20:09:44 -0800
Message-ID: <72ecf925-f818-3d6b-4f96-b01daabd21f2@gmail.com>
References: <20190226184556.16082-1-ivan.khoronzhuk@linaro.org>
 <20190226184556.16082-3-ivan.khoronzhuk@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20190226184556.16082-3-ivan.khoronzhuk@linaro.org>
Content-Language: en-US
Sender: netdev-owner@vger.kernel.org
To: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>, davem@davemloft.net, grygorii.strashko@ti.com
Cc: linux-omap@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, jiri@mellanox.com, ilias.apalodimas@linaro.org
List-Id: linux-omap@vger.kernel.org



On 2/26/2019 10:45 AM, Ivan Khoronzhuk wrote:
> Update vlan mc and uc addresses with VID tag while propagating
> addresses to lower devices, do this only if address is not synced.
> It allows at end driver level to distinguish addresses belonging
> to vlan devices.
> 
> Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
> ---

[snip]

>  
> +u16 vlan_dev_get_addr_vid(struct net_device *dev, const u8 *addr)

Having some kernel doc comment here would also be nice.

> +{
> +	u16 vid = 0;
> +
> +	if (dev->vid_len != NET_8021Q_VID_TSIZE)
> +		return vid;
> +
> +	vid = addr[dev->addr_len];
> +	vid |= (addr[dev->addr_len + 1] & 0xf) << 8;

This uses knowledge of the maximum VLAN ID is 4095, which is fine, might
be a good idea to add a check on VID not exceeding the maximum VLAN ID
number instead of doing a silent truncation?

[snip]

> +static void vlan_dev_align_addr_vid(struct net_device *vlan_dev)
> +{
> +	struct net_device *real_dev = vlan_dev_real_dev(vlan_dev);
> +	struct netdev_hw_addr *ha;
> +
> +	if (!real_dev->vid_len)
> +		return;

Should not this check be moved to dev_{mc,uc}_sync? It does not seem to
me like this would scale really well across different stacked devices
(VLAN, bond, macvlan) as well as underlying drivers (cpsw, dsa, etc.).
Or maybe the check should be if vlan_dev->vid_len > real_dev->vid_len ->
error, right?
-- 
Florian
