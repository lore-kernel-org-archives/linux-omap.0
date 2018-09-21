From: YueHaibing <yuehaibing@huawei.com>
Subject: Re: [PATCH net-next 17/22] hv_netvsc: fix return type of
 ndo_start_xmit function
Date: Fri, 21 Sep 2018 09:35:13 +0800
Message-ID: <1dfae517-640a-fa56-34e8-52964c29a15f@huawei.com>
References: <20180920123306.14772-1-yuehaibing@huawei.com>
 <20180920123306.14772-18-yuehaibing@huawei.com>
 <20180920074341.3acef75c@xeon-e3>
 <BN6PR21MB016180C794F26A279345A17FCA130@BN6PR21MB0161.namprd21.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
In-Reply-To: <BN6PR21MB016180C794F26A279345A17FCA130@BN6PR21MB0161.namprd21.prod.outlook.com>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
To: Haiyang Zhang <haiyangz@microsoft.com>, Stephen Hemminger <stephen@networkplumber.org>
Cc: "dmitry.tarnyagin@lockless.no" <dmitry.tarnyagin@lockless.no>, "madalin.bucur@nxp.com" <madalin.bucur@nxp.com>, "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>, "linux@armlinux.org.uk" <linux@armlinux.org.uk>, "pantelis.antoniou@gmail.com" <pantelis.antoniou@gmail.com>, "t.sailer@alumni.ethz.ch" <t.sailer@alumni.ethz.ch>, "dev@openvswitch.org" <dev@openvswitch.org>, "f.fainelli@gmail.com" <f.fainelli@gmail.com>, "arvid.brodin@alten.se" <arvid.brodin@alten.se>, "michal.simek@xilinx.com" <michal.simek@xilinx.com>, "pshelar@ovn.org" <pshelar@ovn.org>, "m-karicheri2@ti.com" <m-karicheri2@ti.com>, "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>, "jreuter@yaina.de" <jreuter@yaina.de>, "sammy@sammy.net" <sammy@sammy.net>, "grygorii.strashko@ti.com" <grygorii.strashko@ti.com>, "w-kwok2@ti.com" <w-kwok2@ti.com>, "steve.glendinning@shawell.net" <steve.>
List-Id: linux-omap@vger.kernel.org

On 2018/9/20 22:50, Haiyang Zhang wrote:
> 
> 
>> -----Original Message-----
>> From: Stephen Hemminger <stephen@networkplumber.org>
>> Sent: Thursday, September 20, 2018 10:44 AM
>> To: YueHaibing <yuehaibing@huawei.com>
>> Cc: davem@davemloft.net; dmitry.tarnyagin@lockless.no;
>> wg@grandegger.com; mkl@pengutronix.de; michal.simek@xilinx.com;
>> hsweeten@visionengravers.com; madalin.bucur@nxp.com;
>> pantelis.antoniou@gmail.com; claudiu.manoil@nxp.com; leoyang.li@nxp.com;
>> linux@armlinux.org.uk; sammy@sammy.net; ralf@linux-mips.org;
>> nico@fluxnic.net; steve.glendinning@shawell.net; f.fainelli@gmail.com;
>> grygorii.strashko@ti.com; w-kwok2@ti.com; m-karicheri2@ti.com;
>> t.sailer@alumni.ethz.ch; jreuter@yaina.de; KY Srinivasan <kys@microsoft.com>;
>> Haiyang Zhang <haiyangz@microsoft.com>; wei.liu2@citrix.com;
>> paul.durrant@citrix.com; arvid.brodin@alten.se; pshelar@ovn.org;
>> dev@openvswitch.org; linux-mips@linux-mips.org; xen-
>> devel@lists.xenproject.org; netdev@vger.kernel.org; linux-usb@vger.kernel.org;
>> linux-kernel@vger.kernel.org; linux-can@vger.kernel.org;
>> devel@linuxdriverproject.org; linux-hams@vger.kernel.org; linux-
>> omap@vger.kernel.org; linuxppc-dev@lists.ozlabs.org; linux-arm-
>> kernel@lists.infradead.org
>> Subject: Re: [PATCH net-next 17/22] hv_netvsc: fix return type of
>> ndo_start_xmit function
>>
>> On Thu, 20 Sep 2018 20:33:01 +0800
>> YueHaibing <yuehaibing@huawei.com> wrote:
>>> int netvsc_start_xmit(struct sk_buff *skb, struct net_device *net)
>>>  	 */
>>>  	vf_netdev = rcu_dereference_bh(net_device_ctx->vf_netdev);
>>>  	if (vf_netdev && netif_running(vf_netdev) &&
>>> -	    !netpoll_tx_running(net))
>>> -		return netvsc_vf_xmit(net, vf_netdev, skb);
>>> +	    !netpoll_tx_running(net)) {
>>> +		ret = netvsc_vf_xmit(net, vf_netdev, skb);
>>> +		if (ret)
>>> +			return NETDEV_TX_BUSY;
>>> +	}
>>
>> Sorry, the new code is wrong. It will fall through if ret == 0 (NETDEV_TX_OK)
>> Please review and test your patches.
> 
> Plus consideration of -- For error case, please just return NETDEV_TX_OK. We 
> are not sure if the error can go away after retrying, returning NETDEV_TX_BUSY 
> may cause infinite retry from the upper layer.
> 
> So, let's just always return NETDEV_TX_OK like this:
> 		netvsc_vf_xmit(net, vf_netdev, skb);
> 		return NETDEV_TX_OK;

Thank you for review.

Will do that in v2.

> 
> Thanks,
> - Haiyang
> 
> .
> 
