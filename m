From: CF Adad <cfadad@rocketmail.com>
Subject: Re: Problems in the DaVinci EMAC driver & AM35xx?
Date: Thu, 28 Jun 2012 15:36:52 -0700 (PDT)
Message-ID: <1340923012.30754.YahooMailNeo@web125204.mail.ne1.yahoo.com>
References: <1339627132.52592.YahooMailNeo@web125204.mail.ne1.yahoo.com> <1339788533.89799.YahooMailNeo@web125202.mail.ne1.yahoo.com> <1340396573.68079.YahooMailNeo@web125202.mail.ne1.yahoo.com> <1340398244.35574.YahooMailNeo@web125202.mail.ne1.yahoo.com> <87fw9fpbgi.fsf@ti.com>
Reply-To: CF Adad <cfadad@rocketmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from nm22-vm3.bullet.mail.ne1.yahoo.com ([98.138.91.152]:34079 "HELO
	nm22-vm3.bullet.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751995Ab2F1Wgx convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 28 Jun 2012 18:36:53 -0400
In-Reply-To: <87fw9fpbgi.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "mgreer@animalcreek.com" <mgreer@animalcreek.com>, "afzal@ti.com" <afzal@ti.com>, "jp.francois@cynove.com" <jp.francois@cynove.com>, "tony@atomide.com" <tony@atomide.com>, "santosh.shilimkar@ti.com" <santosh.shilimkar@ti.com>

Hi Kevin,

Thanks for the message!=A0 I did not realize the issue with the wake-up=
s affected the EMAC, but I have been running my kernel with 'nohlt' sin=
ce we transitioned to linux-omap-3.4rcX several weeks back. It was requ=
ired to keep the kernel from crashing on boot.=A0 Running with that opt=
ion does not appear to have altered my EMAC performance really at all, =
but I suppose I could be missing something else somewhere...


To try to debug this myself, I did spend a bit of time diving into the =
driver.=A0 I found several things that caused an eyebrow to raise, but =
I do not believe any of them are "smoking guns".=A0 I believe there are=
 a few places where skb's could leak or simply be dropped from the RX p=
ool. So I put some prints there, but I've been testing for a few days a=
nd have never seen any of my prints hit.=A0 I suspect they are holes in=
 the code, but clearly not my problem.=A0 I'm a novice with the EMAC an=
d CPDMA drivers. I could not even find where the "rx_dropped" stat was =
being incremented, so obviously this was not a thorough review.

Below is a patch I've been using to test these areas with.=A0 My main "=
discoveries", if valid, are:

1.) emac_rx_alloc() is redundant to netdev_alloc_skb_ip_align().=A0 So,=
 I swapped it out.

2.) skbs can be _leaked_ by "failed" cpdma_chan_submit()?
dma_map_single() is not checked for a valid return in cpdma_chan_submit=
(). So if it fails, the code continues to shove forward. I don't know w=
hat that would do. So my patch below calls dma_mapping_error() to check=
 that return, and returns an error back to the calling function if a dm=
a_map_single() failed. This lets the calling function, like emac_rx_han=
dler(), free the skb.


3.) losing skb's from our rx pool?
IF I'm understanding this correctly... I noticed that up front, in emac=
_dev_open(), EMAC_DEF_RX_NUM_DESC skb's are allocated and fed to cpdma.=
=A0 However, any errors in that loop do not appear to stop things from =
continuing on.=A0 I suspect this is a bug, albeit one that really never=
 gets hit.=A0 So I put a little code in there to not just bust out of t=
he loop, but rather clean up an dangling skbs and return an error code.


Once the driver is up and running, it looks to me like the emac_rx_hand=
ler() is supposed to basically replace every skb it processes with a ne=
w one.=A0 Sounds reasonable. However, I think there are gaps in the log=
ic that could allow this replacement to fail, presumably leaving the cp=
dma with less skbs than desired. In essence, if the repalcement fails, =
that skb is _never_ resubmitted to cpdma, so it operates forever with 1=
 less. The patch below just has dev_err() messages in there that I put =
in place to trap that if it occurs. My plan to fix this, if my prints s=
howed it was worth fixing, would be to insert a value into priv that to=
ld me how many skbs are presently submitted to cpdma. So, in that initi=
al loop, I'd increment that value up to the limit. Everytime  emac_rx_h=
andler() was called, I would initially decrement the value to record th=
e one I was pushing up the stack. Then, instead of just allocating 1 sk=
b to replace that packet, I would loop against
 that value (how many skbs *should* be in cpdma) and insert enough to g=
et my buffer count back up to where it should be. From a logic flow per=
spective, if I failed to either alloc or submit a replacement skb on th=
at particular emac_rx_handler() call, it would be noted and next time a=
round I would try to insert 2 to make up for the one lost previously.


Thoughts on this? Regardless, as I noted at the top, none of these twea=
ks or prints are showing. So I'm sure these are not core issues at the =
moment.=A0 I want to track down where the rx_dropped stat is being set =
so I can have a look there. Still, I suspect my performance issue is so=
mething DMA-related. I'm just not well-versed enough in all that to tra=
ck it down.


Thanks again for all your assistance!

-----------------------------------------------------------------------=
-------------------------------------

--- linux/drivers/net/ethernet/ti/davinci_emac.c=A0=A0=A0 2012-06-28 17=
:11:52.155508605 -0400
+++ linux-omap_3.5rc4/drivers/net/ethernet/ti/davinci_emac.c=A0=A0=A0 2=
012-06-26 22:39:57.000000000 -0400
@@ -991,6 +991,7 @@
=A0=A0=A0=A0 return IRQ_HANDLED;
=A0}
=A0
+/* SAME AS: netdev_alloc_skb_ip_align()
=A0static struct sk_buff *emac_rx_alloc(struct emac_priv *priv)
=A0{
=A0=A0=A0=A0 struct sk_buff *skb =3D netdev_alloc_skb(priv->ndev, priv-=
>rx_buf_size);
@@ -999,6 +1000,7 @@
=A0=A0=A0=A0 skb_reserve(skb, NET_IP_ALIGN);
=A0=A0=A0=A0 return skb;
=A0}
+*/
=A0
=A0static void emac_rx_handler(void *token, int len, int status)
=A0{
@@ -1028,10 +1030,12 @@
=A0=A0=A0=A0 ndev->stats.rx_packets++;
=A0
=A0=A0=A0=A0 /* alloc a new packet for receive */
-=A0=A0=A0 skb =3D emac_rx_alloc(priv);
-=A0=A0=A0 if (!skb) {
+//=A0=A0=A0 skb =3D emac_rx_alloc(priv);
+=A0=A0=A0 skb =3D netdev_alloc_skb_ip_align(priv->ndev, priv->rx_buf_s=
ize);
+=A0=A0=A0 if (unlikely(!skb)) {
=A0=A0=A0=A0 =A0=A0=A0 if (netif_msg_rx_err(priv) && net_ratelimit())
=A0=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 dev_err(emac_dev, "failed rx buffer al=
loc\n");
+dev_err(emac_dev, "(1) lost rx skb?\n");
=A0=A0=A0=A0 =A0=A0=A0 return;
=A0=A0=A0=A0 }
=A0
@@ -1041,7 +1045,10 @@
=A0
=A0=A0=A0=A0 WARN_ON(ret =3D=3D -ENOMEM);
=A0=A0=A0=A0 if (unlikely(ret < 0))
+=A0=A0=A0 {
=A0=A0=A0=A0 =A0=A0=A0 dev_kfree_skb_any(skb);
+dev_err(emac_dev, "(2) lost rx skb?\n");
+=A0=A0=A0 }
=A0}
=A0
=A0static void emac_tx_handler(void *token, int len, int status)
@@ -1053,7 +1060,7 @@
=A0=A0=A0=A0 atomic_dec(&priv->cur_tx);
=A0
=A0=A0=A0=A0 if (unlikely(netif_queue_stopped(ndev)))
-=A0=A0=A0 =A0=A0=A0 netif_start_queue(ndev);
+=A0=A0=A0 =A0=A0=A0 netif_start_queue(ndev);=A0=A0=A0 /* maybe conside=
r using 'netif_wake_queue(ndev);' here instead? */
=A0=A0=A0=A0 ndev->stats.tx_packets++;
=A0=A0=A0=A0 ndev->stats.tx_bytes +=3D len;
=A0=A0=A0=A0 dev_kfree_skb_any(skb);
@@ -1105,6 +1112,7 @@
=A0=A0=A0=A0 return NETDEV_TX_OK;
=A0
=A0fail_tx:
+dev_err(emac_dev, "(3) lost TX skb, queue stopped - needs restarted (t=
x_handler)?\n");
=A0=A0=A0=A0 ndev->stats.tx_dropped++;
=A0=A0=A0=A0 netif_stop_queue(ndev);
=A0=A0=A0=A0 return NETDEV_TX_BUSY;
@@ -1540,7 +1548,8 @@
=A0=A0=A0=A0 =A0=A0=A0 ndev->dev_addr[cnt] =3D priv->mac_addr[cnt];
=A0
=A0=A0=A0=A0 /* Configuration items */
-=A0=A0=A0 priv->rx_buf_size =3D EMAC_DEF_MAX_FRAME_SIZE + NET_IP_ALIGN=
;
+//=A0=A0=A0 priv->rx_buf_size =3D EMAC_DEF_MAX_FRAME_SIZE + NET_IP_ALI=
GN;
+=A0=A0=A0 priv->rx_buf_size =3D EMAC_DEF_MAX_FRAME_SIZE;
=A0
=A0=A0=A0=A0 priv->mac_hash1 =3D 0;
=A0=A0=A0=A0 priv->mac_hash2 =3D 0;
@@ -1548,15 +1557,29 @@
=A0=A0=A0=A0 emac_write(EMAC_MACHASH2, 0);
=A0
=A0=A0=A0=A0 for (i =3D 0; i < EMAC_DEF_RX_NUM_DESC; i++) {
-=A0=A0=A0 =A0=A0=A0 struct sk_buff *skb =3D emac_rx_alloc(priv);
+//=A0=A0=A0 =A0=A0=A0 struct sk_buff *skb =3D emac_rx_alloc(priv);
+=A0=A0=A0 =A0=A0=A0 struct sk_buff *skb =3D netdev_alloc_skb_ip_align(=
priv->ndev, priv->rx_buf_size);
=A0
-=A0=A0=A0 =A0=A0=A0 if (!skb)
+=A0=A0=A0 =A0=A0=A0 if (unlikely(!skb))
+=A0=A0=A0 =A0=A0=A0 {
+=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 ret =3D -ENOMEM;
=A0=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 break;
+=A0=A0=A0 =A0=A0=A0 }
=A0
=A0=A0=A0=A0 =A0=A0=A0 ret =3D cpdma_chan_submit(priv->rxchan, skb, skb=
->data,
=A0=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 skb_tailroom(skb),=
 GFP_KERNEL);
=A0=A0=A0=A0 =A0=A0=A0 if (WARN_ON(ret < 0))
+=A0=A0=A0 =A0=A0=A0 {
+=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 dev_kfree_skb_any(skb);
+=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 ret =3D -ENOMEM;
=A0=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 break;
+=A0=A0=A0 =A0=A0=A0 }
+=A0=A0=A0 }
+=A0=A0=A0=20
+=A0=A0=A0 if (unlikely(ret < 0))
+=A0=A0=A0 {
+=A0=A0=A0 =A0=A0=A0 dev_err(emac_dev, "failed prestaging rx skbs in cp=
dma");
+=A0=A0=A0 =A0=A0=A0 return ret;
=A0=A0=A0=A0 }
=A0
=A0=A0=A0=A0 /* Request IRQ */
@@ -1579,6 +1602,7 @@
=A0
=A0=A0=A0=A0 =A0=A0=A0 coal.rx_coalesce_usecs =3D (priv->coal_intvl << =
4);
=A0=A0=A0=A0 =A0=A0=A0 emac_set_coalesce(ndev, &coal);
+dev_info(emac_dev, "interrupt pacing enabled");
=A0=A0=A0=A0 }
=A0
=A0=A0=A0=A0 cpdma_ctlr_start(priv->dma);
--- linux/drivers/net/ethernet/ti/davinci_cpdma.c=A0=A0=A0 2012-06-28 1=
7:11:52.155508605 -0400
+++ linux-omap_3.5rc4/drivers/net/ethernet/ti/davinci_cpdma.c=A0=A0=A0 =
2012-06-26 17:15:31.000000000 -0400
@@ -679,6 +679,12 @@
=A0=A0=A0=A0 }
=A0
=A0=A0=A0=A0 buffer =3D dma_map_single(ctlr->dev, data, len, chan->dir)=
;
+=A0=A0=A0 if (dma_mapping_error(ctlr->dev, buffer)) {
+=A0=A0=A0 =A0=A0=A0 dev_err(ctlr->dev, "CPDMA: dma_map_single failed!"=
);
+=A0=A0=A0 =A0=A0=A0 ret =3D -EINVAL;
+=A0=A0=A0 =A0=A0=A0 goto unlock_ret;
+=A0=A0=A0 }
+=A0=A0=A0=20
=A0=A0=A0=A0 mode =3D CPDMA_DESC_OWNER | CPDMA_DESC_SOP | CPDMA_DESC_EO=
P;
=A0
=A0=A0=A0=A0 desc_write(desc, hw_next,=A0=A0 0);
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
