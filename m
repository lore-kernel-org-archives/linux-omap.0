From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: [RFC PATCH net-next 2/4] net: 8021q: vlan_core: allow use list of
 vlans for real device
Date: Tue, 16 Oct 2018 14:39:43 -0500
Message-ID: <2242102f-bfc8-e334-e9ae-93edd26587eb@ti.com>
References: <20181016182035.18234-1-ivan.khoronzhuk@linaro.org>
 <20181016182035.18234-3-ivan.khoronzhuk@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181016182035.18234-3-ivan.khoronzhuk@linaro.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>, davem@davemloft.net
Cc: linux-omap@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, alexander.h.duyck@intel.com
List-Id: linux-omap@vger.kernel.org



On 10/16/2018 01:20 PM, Ivan Khoronzhuk wrote:
> It's redundancy for the drivers to hold the list of vlans when
> absolutely the same list exists in vlan core. In most cases it's
> needed only to traverse the vlan devices, their vids and sync some
> settings with h/w, so add API to simplify this.
> 

below has to be under ---.

> At least some of these drivers also can benefit:
> grep "for_each.*vid" -r drivers/net/ethernet/
> 
> drivers/net/ethernet/hisilicon/hns3/hns3_enet.c:
> drivers/net/ethernet/synopsys/dwc-xlgmac-hw.c:
> drivers/net/ethernet/qlogic/qlge/qlge_main.c:
> drivers/net/ethernet/qlogic/qlcnic/qlcnic_main.c:
> drivers/net/ethernet/via/via-rhine.c:
> drivers/net/ethernet/via/via-velocity.c:
> drivers/net/ethernet/intel/igb/igb_main.c:
> drivers/net/ethernet/intel/ice/ice_main.c:
> drivers/net/ethernet/intel/e1000/e1000_main.c:
> drivers/net/ethernet/intel/i40e/i40e_main.c:
> drivers/net/ethernet/intel/e1000e/netdev.c:
> drivers/net/ethernet/intel/igbvf/netdev.c:
> drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c:
> drivers/net/ethernet/intel/ixgb/ixgb_main.c:
> drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:
> drivers/net/ethernet/amd/xgbe/xgbe-dev.c:
> drivers/net/ethernet/emulex/benet/be_main.c:
> drivers/net/ethernet/neterion/vxge/vxge-main.c:
> drivers/net/ethernet/adaptec/starfire.c:
> drivers/net/ethernet/brocade/bna/bnad.c:
> 
> Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
> ---
>   include/linux/if_vlan.h | 10 ++++++++++
>   net/8021q/vlan_core.c   | 27 +++++++++++++++++++++++++++
>   2 files changed, 37 insertions(+)
> 
> diff --git a/include/linux/if_vlan.h b/include/linux/if_vlan.h
> index 83ea4df6ab81..4ae3993f7166 100644
> --- a/include/linux/if_vlan.h
> +++ b/include/linux/if_vlan.h
> @@ -133,6 +133,9 @@ struct vlan_pcpu_stats {
>   
>   extern struct net_device *__vlan_find_dev_deep_rcu(struct net_device *real_dev,
>   					       __be16 vlan_proto, u16 vlan_id);
> +extern int vlan_for_each(struct net_device *dev,
> +			 int (*action)(struct net_device *dev, int vid,
> +				       void *arg), void *arg);
>   extern struct net_device *vlan_dev_real_dev(const struct net_device *dev);
>   extern u16 vlan_dev_vlan_id(const struct net_device *dev);
>   extern __be16 vlan_dev_vlan_proto(const struct net_device *dev);
> @@ -236,6 +239,13 @@ __vlan_find_dev_deep_rcu(struct net_device *real_dev,
>   	return NULL;
>   }
>   
> +static inline int
> +vlan_for_each(struct net_device *dev,
> +	      int (*action)(struct net_device *dev, int vid, void *arg),
> +	      void *arg)
> +{
> +}
> +
>   static inline struct net_device *vlan_dev_real_dev(const struct net_device *dev)
>   {
>   	BUG();
> diff --git a/net/8021q/vlan_core.c b/net/8021q/vlan_core.c
> index 4f60e86f4b8d..6308b5427a66 100644
> --- a/net/8021q/vlan_core.c
> +++ b/net/8021q/vlan_core.c
> @@ -223,6 +223,33 @@ static int vlan_kill_rx_filter_info(struct net_device *dev, __be16 proto, u16 vi
>   		return -ENODEV;
>   }
>   
> +int vlan_for_each(struct net_device *dev,
> +		  int (*action)(struct net_device *dev, int vid, void *arg),
> +		  void *arg)
> +{
> +	struct vlan_vid_info *vid_info;
> +	struct vlan_info *vlan_info;
> +	struct net_device *vdev;
> +	int ret;
> +
> +	ASSERT_RTNL();
> +
> +	vlan_info = rtnl_dereference(dev->vlan_info);
> +	if (!vlan_info)
> +		return 0;
> +
> +	list_for_each_entry(vid_info, &vlan_info->vid_list, list) {
> +		vdev = vlan_group_get_device(&vlan_info->grp, vid_info->proto,
> +					     vid_info->vid);
> +		ret = action(vdev, vid_info->vid, arg);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(vlan_for_each);
> +
>   int vlan_filter_push_vids(struct vlan_info *vlan_info, __be16 proto)
>   {
>   	struct net_device *real_dev = vlan_info->real_dev;
> 

-- 
regards,
-grygorii
