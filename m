From: Haiyang Zhang via dev <ovs-dev-yBygre7rU0TnMu66kgdUjQ@public.gmane.org>
Subject: Re: [PATCH net-next 17/22] hv_netvsc: fix return type of
 ndo_start_xmit function
Date: Thu, 20 Sep 2018 14:50:23 +0000
Message-ID: <BN6PR21MB016180C794F26A279345A17FCA130@BN6PR21MB0161.namprd21.prod.outlook.com>
References: <20180920123306.14772-1-yuehaibing@huawei.com>
	<20180920123306.14772-18-yuehaibing@huawei.com>
	<20180920074341.3acef75c@xeon-e3>
Reply-To: Haiyang Zhang <haiyangz-0li6OtcxBFHby3iVrkZq2A@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ovs-dev-bounces-yBygre7rU0TnMu66kgdUjQ@public.gmane.org>
In-Reply-To: <20180920074341.3acef75c@xeon-e3>
Content-Language: en-US
List-Unsubscribe: <https://mail.openvswitch.org/mailman/options/ovs-dev>,
	<mailto:ovs-dev-request-yBygre7rU0TnMu66kgdUjQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://mail.openvswitch.org/pipermail/ovs-dev/>
List-Post: <mailto:ovs-dev-yBygre7rU0TnMu66kgdUjQ@public.gmane.org>
List-Help: <mailto:ovs-dev-request-yBygre7rU0TnMu66kgdUjQ@public.gmane.org?subject=help>
List-Subscribe: <https://mail.openvswitch.org/mailman/listinfo/ovs-dev>,
	<mailto:ovs-dev-request-yBygre7rU0TnMu66kgdUjQ@public.gmane.org?subject=subscribe>
Sender: ovs-dev-bounces-yBygre7rU0TnMu66kgdUjQ@public.gmane.org
Errors-To: ovs-dev-bounces-yBygre7rU0TnMu66kgdUjQ@public.gmane.org
To: Stephen Hemminger <stephen-OTpzqLSitTUnbdJkjeBofR2eb7JE58TQ@public.gmane.org>, YueHaibing <yuehaibing-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Cc: "dmitry.tarnyagin-0TCahj4L2NoXWF+eFR7m5Q@public.gmane.org" <dmitry.tarnyagin-0TCahj4L2NoXWF+eFR7m5Q@public.gmane.org>, "madalin.bucur-3arQi8VN3Tc@public.gmane.org" <madalin.bucur-3arQi8VN3Tc@public.gmane.org>, "linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org" <linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>, "linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org" <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, "pantelis.antoniou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <pantelis.antoniou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, KY Srinivasan <kys-0li6OtcxBFHby3iVrkZq2A@public.gmane.org>, "t.sailer-aAjG49QhEdKVRmA6MYkXiA@public.gmane.org" <t.sailer-aAjG49QhEdKVRmA6MYkXiA@public.gmane.org>, "dev-yBygre7rU0TnMu66kgdUjQ@public.gmane.org" <dev-yBygre7rU0TnMu66kgdUjQ@public.gmane.org>, "f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "arvid.brodin-SVm98a2vdck@public.gmane.org" <arvid.brodin-SVm98a2vdck@public.gmane.org>, "michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org" <michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>, "m-karicheri2-l0cyMroinI0@public.gmane.org" <m-karicheri2-l0cyMroinI0@public.gmane.org>, "xen-devel-GuqFBffKawtpuQazS67q72D2FQJk+8+b@public.gmane.org" <xen-devel-GuqFBffKawtpuQazS67q72D2FQJk+8+b@public.gmane.org>, "jreuter-K7Hl1MveuGQ@public.gmane.org" <jreuter-K7Hl1MveuGQ@public.gmane.org>, "sammy-4OGMY2YDKIVeoWH0uzbU5w@public.gmane.org" <sammy-4OGMY2YDKIVeoWH0uzbU5w@public.gmane.org>, "grygorii.strashko-l0cyMroinI0@public.gmane.org" <grygorii.strashko-l0cyMroinI0@public.gmane.org>, "w-kwok2-l0cyMroinI0@public.gmane.org" <w-kwok2-l0cyMroinI0@public.gmane.org>, "steve.glendinning-nksJyM/082jR7s880joybQ@public.gmane.org" <steve.gl>
List-Id: linux-omap@vger.kernel.org



> -----Original Message-----
> From: Stephen Hemminger <stephen-OTpzqLSitTUnbdJkjeBofR2eb7JE58TQ@public.gmane.org>
> Sent: Thursday, September 20, 2018 10:44 AM
> To: YueHaibing <yuehaibing-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
> Cc: davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org; dmitry.tarnyagin-0TCahj4L2NoXWF+eFR7m5Q@public.gmane.org;
> wg-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org; mkl-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org; michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org;
> hsweeten-3FF4nKcrg1dE2c76skzGb0EOCMrvLtNR@public.gmane.org; madalin.bucur-3arQi8VN3Tc@public.gmane.org;
> pantelis.antoniou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org; claudiu.manoil-3arQi8VN3Tc@public.gmane.org; leoyang.li-3arQi8VN3Tc@public.gmane.org;
> linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org; sammy-4OGMY2YDKIVeoWH0uzbU5w@public.gmane.org; ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org;
> nico-vtqb6HGKxmzR7s880joybQ@public.gmane.org; steve.glendinning-nksJyM/082jR7s880joybQ@public.gmane.org; f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org;
> grygorii.strashko-l0cyMroinI0@public.gmane.org; w-kwok2-l0cyMroinI0@public.gmane.org; m-karicheri2-l0cyMroinI0@public.gmane.org;
> t.sailer-aAjG49QhEdKVRmA6MYkXiA@public.gmane.org; jreuter-K7Hl1MveuGQ@public.gmane.org; KY Srinivasan <kys-0li6OtcxBFHby3iVrkZq2A@public.gmane.org>;
> Haiyang Zhang <haiyangz-0li6OtcxBFHby3iVrkZq2A@public.gmane.org>; wei.liu2-Sxgqhf6Nn4DQT0dZR+AlfA@public.gmane.org;
> paul.durrant-Sxgqhf6Nn4DQT0dZR+AlfA@public.gmane.org; arvid.brodin-SVm98a2vdck@public.gmane.org; pshelar-LZ6Gd1LRuIk@public.gmane.org;
> dev-yBygre7rU0TnMu66kgdUjQ@public.gmane.org; linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org; xen-
> devel-GuqFBffKawtpuQazS67q72D2FQJk+8+b@public.gmane.org; netdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org;
> linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-can-u79uwXL29TY76Z2rM5mHXA@public.gmane.org;
> devel-tBiZLqfeLfOHmIFyCCdPziST3g8Odh+X@public.gmane.org; linux-hams-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-
> omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org; linux-arm-
> kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
> Subject: Re: [PATCH net-next 17/22] hv_netvsc: fix return type of
> ndo_start_xmit function
> 
> On Thu, 20 Sep 2018 20:33:01 +0800
> YueHaibing <yuehaibing-hv44wF8Li93QT0dZR+AlfA@public.gmane.org> wrote:
> > int netvsc_start_xmit(struct sk_buff *skb, struct net_device *net)
> >  	 */
> >  	vf_netdev = rcu_dereference_bh(net_device_ctx->vf_netdev);
> >  	if (vf_netdev && netif_running(vf_netdev) &&
> > -	    !netpoll_tx_running(net))
> > -		return netvsc_vf_xmit(net, vf_netdev, skb);
> > +	    !netpoll_tx_running(net)) {
> > +		ret = netvsc_vf_xmit(net, vf_netdev, skb);
> > +		if (ret)
> > +			return NETDEV_TX_BUSY;
> > +	}
> 
> Sorry, the new code is wrong. It will fall through if ret == 0 (NETDEV_TX_OK)
> Please review and test your patches.

Plus consideration of -- For error case, please just return NETDEV_TX_OK. We 
are not sure if the error can go away after retrying, returning NETDEV_TX_BUSY 
may cause infinite retry from the upper layer.

So, let's just always return NETDEV_TX_OK like this:
		netvsc_vf_xmit(net, vf_netdev, skb);
		return NETDEV_TX_OK;

Thanks,
- Haiyang
