From: Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH net-next 4/6] ethernet: eth: add default vid len for all
 ehternet kind devices
Date: Wed, 27 Feb 2019 20:29:20 -0800
Message-ID: <30890ef3-7da8-8399-7388-cc22e000a67f@gmail.com>
References: <20190226184556.16082-1-ivan.khoronzhuk@linaro.org>
 <20190226184556.16082-5-ivan.khoronzhuk@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190226184556.16082-5-ivan.khoronzhuk@linaro.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>, davem@davemloft.net, grygorii.strashko@ti.com
Cc: linux-omap@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, jiri@mellanox.com, ilias.apalodimas@linaro.org
List-Id: linux-omap@vger.kernel.org



On 2/26/2019 10:45 AM, Ivan Khoronzhuk wrote:
> IVDF - individual virtual device filtering. Allows to set per vlan
> l2 address filters on end real network device (for unicast and for
> multicast) and drop redundant not expected packet income.
> 
> If CONFIG_VLAN_8021Q_IVDF is enabled the following changes are
> applied, and only for ethernet network devices.
> 
> By default every ethernet netdev needs vid len = 2 bytes to be able to
> hold up to 4096 vids. So set it for every eth device to be correct,
> except vlan devs.
> 
> In order to shrink all addresses of devices above vlan, the vid_len
> for vlan dev = 0, as result all suckers sync their addresses to common
> base not taking in to account vid part (vid_len of "to" devices is
> important only). And only vlan device is the source of addresses with
> actual its vid set, propagating it to parent devices while rx_mode().
> 
> Also, don't bother those ethernet devices that at this moment are not
> moved to vlan addressing scheme, so while end ethernet device is
> created - set vid_len to 0, thus, while syncing, its address space is
> concatenated to one dimensional like usual, and who needs IVDF - set
> it to NET_8021Q_VID_TSIZE.
> 
> There is another decision - is to inherit vid_len or some feature flag
> from end root device in order to all upper devices have vlan extended
> address space only if exact end real device have such capability. But
> I didn't, because it requires more changes and probably I'm not
> familiar with all places where it should be inherited, I would
> appreciate if someone can guid where it's applicable, then it could
> become a little bit more limited.

I would think that a call to vlan_dev_ivdf_set() would be enough to
indicate that the underlying network device driver supports IVDF and
wants to make use of it. The infrastructure itself that you added costs
little memory, it is once the call to vlan_dev_ivdf_set() is made that
the memory consumption increases which is fine, since we want to make
use of that feature.

While I appreciate the thoughts given to making this a configurable
option, I feel that enabling it unconditionally and having the
underlying driver decide would be more manageable.

We have had that conversation before, but let me ask again when we call
dev_{uc,mc}_sync() and ultimately the network device's
ndo_set_rx_mode(), by the time the ndo_set_rx_mode() function is called,
we lost track of the call chain, like which virtual device was it
originating from. If we somehow added a notification information about
the network device stack (and we could use netdevice notifiers for
that), then maybe we don't really need to add all of this code and we
can just derive the necessary bits of information we want by checking:
is this a VLAN network device? It is, okay what's your VLAN ID, etc.?

Either approach would get us our cookie anyway :)

> 
> Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
> ---

[snip]

> @@ -404,8 +405,13 @@ EXPORT_SYMBOL(ether_setup);
>  struct net_device *alloc_etherdev_mqs(int sizeof_priv, unsigned int txqs,
>  				      unsigned int rxqs)
>  {
> -	return alloc_netdev_mqs(sizeof_priv, "eth%d", NET_NAME_UNKNOWN,
> -				ether_setup, txqs, rxqs);
> +	struct net_device *dev;
> +
> +	dev = alloc_netdev_mqs(sizeof_priv, "eth%d", NET_NAME_UNKNOWN,
> +			       ether_setup, txqs, rxqs);

You need to check the return value of alloc_netdev_mqs() now, otherwise
you could be doing a NPD in the call right under. Since that is the
default though, do you really need to call vlan_dev_ivdf_set() below?
-- 
Florian
