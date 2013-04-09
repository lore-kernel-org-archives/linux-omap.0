From: CF Adad <cfadad@rocketmail.com>
Subject: Re: AM3517 DaVinci EMAC Ethernet performance issues
Date: Mon, 8 Apr 2013 22:45:43 -0700 (PDT)
Message-ID: <1365486343.94427.YahooMailNeo@web160506.mail.bf1.yahoo.com>
References: <1365042051.84279.YahooMailNeo@web160501.mail.bf1.yahoo.com> <515D3A86.6000504@ti.com> <1365085105.58314.YahooMailNeo@web160505.mail.bf1.yahoo.com> <1365105688.76437.YahooMailNeo@web160502.mail.bf1.yahoo.com>
Reply-To: CF Adad <cfadad@rocketmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from nm17.bullet.mail.bf1.yahoo.com ([98.139.212.176]:29407 "HELO
	nm17.bullet.mail.bf1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752931Ab3DIFpp convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 9 Apr 2013 01:45:45 -0400
In-Reply-To: <1365105688.76437.YahooMailNeo@web160502.mail.bf1.yahoo.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mugunthan V N <mugunthanvnm@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "davem@davemloft.net" <davem@davemloft.net>

Mugunthan and all,

We have essentially proven our theory, but have yet to solve the proble=
m.=A0 Our theory was that the driver was essentially taking a few secon=
d nap during transmission, despite there being plenty more work to do.=A0=
 We further theorized that our custom userspace application was somehow=
 preventing the driver from taking this nap, and that's why our RX perf=
ormance is perfect all the time while our TX is so spotty unless that a=
pplication is running.

Over the last few days, we've went through several test patches and hav=
e essentially tracked the issue back to our emac_poll() function not be=
ing called.=A0 By inserting the following patch snippet, and snippets l=
ike it, into various functions in the emac driver, we were able to prov=
e that from time to time these functions sleep for several seconds, des=
pite iperf certainly having given them something to do.=A0 (Note: the p=
atch has changed a bit since the output pasted below was captured, as w=
e were looking for more detail, but the core functionality is the same.=
)

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
[[ ---- patch snippet ---- ]]
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D

--- linux/drivers/net/ethernet/ti/davinci_emac.c=A0=A0 =A02013-04-08 16=
:20:19.202550042 -0400
+++ linux_emac_tst/drivers/net/ethernet/ti/davinci_emac.c=A0=A0 =A02013=
-04-08 18:45:37.000000000 -0400
@@ -64,6 +64,12 @@
=A0
=A0#include "davinci_cpdma.h"
=A0
+//// DEBUGGING ONLY!!!!
+#include <linux/jiffies.h>
+static unsigned long qstopped_jifs =3D 0;
+static unsigned long poll_func_jifs =3D 0;
+static u32 last_num_rx_pkts =3D 0, last_num_tx_pkts =3D 0;
+
=A0static int debug_level;
=A0module_param(debug_level, int, 0);
=A0MODULE_PARM_DESC(debug_level, "DaVinci EMAC debug level (NETIF_MSG b=
its)");
@@ -1055,7 +1061,19 @@
=A0=A0=A0 =A0 * queue is stopped then start the queue as we have free d=
esc for tx
=A0=A0=A0 =A0 */
=A0=A0=A0 =A0if (unlikely(netif_queue_stopped(ndev)))
+=A0=A0 =A0{
=A0=A0=A0 =A0=A0=A0 =A0netif_wake_queue(ndev);
+=A0=A0 =A0=A0=A0 =A0if (qstopped_jifs > 0)
+=A0=A0 =A0=A0=A0 =A0{
+=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0// we've been stopped, measure how long
+=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0if ( time_after_eq(jiffies, (qstopped_ji=
fs + HZ/2)) )
+=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0{
+=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0// we've been stopped >=3D 1/2=
 second!!!
+=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0printk(KERN_ERR "=3D=3D=3DEMAC=
: TX queue has been stopped for > 1/2 second!!!\n");
+=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0}
+=A0=A0 =A0=A0=A0 =A0}
+=A0=A0 =A0=A0=A0 =A0qstopped_jifs =3D 0;
+=A0=A0 =A0}=A0=A0 =A0
=A0=A0=A0 =A0ndev->stats.tx_packets++;
=A0=A0=A0 =A0ndev->stats.tx_bytes +=3D len;
=A0=A0=A0 =A0dev_kfree_skb_any(skb);
@@ -1105,7 +1123,11 @@
=A0=A0=A0 =A0 * tell the kernel to stop sending us tx frames.
=A0=A0=A0 =A0 */
=A0=A0=A0 =A0if (unlikely(!cpdma_check_free_tx_desc(priv->txchan)))
+=A0=A0 =A0{
=A0=A0=A0 =A0=A0=A0 =A0netif_stop_queue(ndev);
+=A0=A0 =A0=A0=A0 =A0// we just stopped, record the time
+=A0=A0 =A0=A0=A0 =A0qstopped_jifs =3D jiffies;
+=A0=A0 =A0}
=A0
=A0=A0=A0 =A0return NETDEV_TX_OK;
=A0
@@ -1374,6 +1396,15 @@
=A0=A0=A0 =A0u32 status =3D 0;
=A0=A0=A0 =A0u32 num_tx_pkts =3D 0, num_rx_pkts =3D 0;
=A0
+
+unsigned long tmp =3D jiffies;
+if ( time_after_eq(tmp, (poll_func_jifs + HZ/2)) )
+{
+=A0=A0 =A0// we've been stopped >=3D 1/2 second!!!
+=A0=A0 =A0printk(KERN_ERR "=3D=3D=3DEMAC: POLL FUNCTION, last RX/TX=3D=
[%d][%d]\n", last_num_rx_pkts, last_num_tx_pkts);
+}
+poll_func_jifs =3D tmp;
+
=A0=A0=A0 =A0/* Check interrupt vectors and call packet processing */
=A0=A0=A0 =A0status =3D emac_read(EMAC_MACINVECTOR);
=A0
@@ -1385,6 +1416,10 @@
=A0=A0=A0 =A0if (status & mask) {
=A0=A0=A0 =A0=A0=A0 =A0num_tx_pkts =3D cpdma_chan_process(priv->txchan,
=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0=A0=A0=A0 EM=
AC_DEF_TX_MAX_SERVICE);
+=A0=A0 =A0=A0=A0 =A0if (num_tx_pkts < 0)
+=A0=A0 =A0=A0=A0 =A0{
+printk(KERN_ERR "=3D=3D=3D ERR!!! num_tx_pkts=3D%d\n", num_tx_pkts);=A0=
=A0 =A0=A0=A0 =A0
+=A0=A0 =A0=A0=A0 =A0}
=A0=A0=A0 =A0} /* TX processing */
=A0
=A0=A0=A0 =A0mask =3D EMAC_DM644X_MAC_IN_VECTOR_RX_INT_VEC;
@@ -1394,8 +1429,17 @@
=A0
=A0=A0=A0 =A0if (status & mask) {
=A0=A0=A0 =A0=A0=A0 =A0num_rx_pkts =3D cpdma_chan_process(priv->rxchan,=
 budget);
+=A0=A0 =A0=A0=A0 =A0if (num_rx_pkts < 0)
+=A0=A0 =A0=A0=A0 =A0{
+printk(KERN_ERR "=3D=3D=3D ERR!!! num_rx_pkts=3D%d\n", num_rx_pkts);
+=A0=A0 =A0=A0=A0 =A0}
=A0=A0=A0 =A0} /* RX processing */
=A0
+
+last_num_tx_pkts =3D num_tx_pkts;
+last_num_rx_pkts =3D num_rx_pkts;
+
+
=A0=A0=A0 =A0mask =3D EMAC_DM644X_MAC_IN_VECTOR_HOST_INT;
=A0=A0=A0 =A0if (priv->version =3D=3D EMAC_VERSION_2)
=A0=A0=A0 =A0=A0=A0 =A0mask =3D EMAC_DM646X_MAC_IN_VECTOR_HOST_INT;

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
[[ ---- patch snippet ---- ]]
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D


It appears from our debugging that somehow the emac_poll() function is =
not being called despite there being work to do.=A0 As before however, =
when we start our custom application (which presently does very little =
from a system calls' perspective), our performance stabilizes greatly.=A0=
 Please see below.

Has anyone else seen anything like this with the EMAC, or have any idea=
 why or how this could be happening?=A0 We initially thought it could j=
ust be a failure to properly reschedule the emac_wait(), but after play=
ing with various items there for a while, we're convinced that's not it=
=2E=A0 Now we're guessing that perhaps softirqs or something within the=
 DMA world is to blame here, but we're certainly not experts in this ar=
ea.=A0 Again, we've passed in 'nohlt' and have worked to remove power m=
anagement.=A0 So we don't think that plays a role.=A0 Likewise, we neve=
r see a packet error -- even in our Wireshark traces.=A0 We just see th=
e system take a split-second to multi-second break.

What specifically causes the emac_poll() and emac_tx_handler() function=
s to fire, and is there a way to debug that cleanly?

Can anyone imagine how a userspace application would be able to improve=
 this behavior so much?

Again, thank you so very much for your time.
CF


Boot log:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
=46resh boot with no network activity, we see this with our debugging i=
n there.
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D

[=A0=A0 22.815582] =3D=3D=3DEMAC: POLL FUNCTION has not been called for=
 > 1/2 second!!!
[=A0=A0 22.822937] =3D=3D=3DEMAC: TX FUNCTION has not been called for >=
 1/2 second!!!
[=A0=A0 23.817993] =3D=3D=3DEMAC: POLL FUNCTION has not been called for=
 > 1/2 second!!!
[=A0=A0 23.825378] =3D=3D=3DEMAC: TX FUNCTION has not been called for >=
 1/2 second!!!
[=A0=A0 24.817810] =3D=3D=3DEMAC: POLL FUNCTION has not been called for=
 > 1/2 second!!!
[=A0=A0 24.825225] =3D=3D=3DEMAC: TX FUNCTION has not been called for >=
 1/2 second!!!
[=A0=A0 30.793365] =3D=3D=3DEMAC: POLL FUNCTION has not been called for=
 > 1/2 second!!!
[=A0=A0 30.800811] =3D=3D=3DEMAC: TX FUNCTION has not been called for >=
 1/2 second!!!
[=A0=A0 31.427093] =3D=3D=3DEMAC: POLL FUNCTION has not been called for=
 > 1/2 second!!!
[=A0=A0 31.434661] =3D=3D=3DEMAC: TX FUNCTION has not been called for >=
 1/2 second!!!
[=A0=A0 32.426879] =3D=3D=3DEMAC: POLL FUNCTION has not been called for=
 > 1/2 second!!!
[=A0=A0 32.434387] =3D=3D=3DEMAC: TX FUNCTION has not been called for >=
 1/2 second!!!

root@test:~# iperf-i 5 -t 30000 -c 10.22.255.254
[=A0=A0 43.093078] =3D=3D=3DEMAC: POLL FUNCTION has not been called for=
 > 1/2 second!!!
[=A0=A0 43.100463] =3D=3D=3DEMAC: TX FUNCTION has not been called for >=
 1/2 second!!!

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
Starting iperf with 4x instances of <Custom App> stuff running.=A0 See?=
=A0 It's very happy for a long time.
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D

------------------------------------------------------------
Client connecting to 10.22.255.254, TCP port 5001
TCP window size: 19.6 KByte (default)
------------------------------------------------------------
[=A0 3] local 10.22.0.2 port 44102 connected with 10.22.255.254 port 50=
01
[ ID] Interval=A0=A0=A0=A0=A0=A0 Transfer=A0=A0=A0=A0 Bandwidth
[=A0 3]=A0 0.0- 5.0 sec=A0 56.8 MBytes=A0 95.3 Mbits/sec
[=A0 3]=A0 5.0-10.0 sec=A0 56.0 MBytes=A0 94.0 Mbits/sec
[[ ---- SNIP ---- ]]
[=A0 3] 615.0-620.0 sec=A0 56.4 MBytes=A0 94.6 Mbits/sec
[=A0 3] 620.0-625.0 sec=A0 55.3 MBytes=A0 92.9 Mbits/sec

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
Stopping all 4 <Custom App> instances from running...
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
=A0=A0=A0=A0=A0=A0=A0=A0 Stopping <Custom App>1...
[=A0 OK=A0 ] Stopped <Custom App>1.
=A0=A0=A0=A0=A0=A0=A0=A0 Stopping <Custom App>2...
[=A0 OK=A0 ] Stopped <Custom App>2.
=A0=A0=A0=A0=A0=A0=A0=A0 Stopping <Custom App>3...
[=A0 OK=A0 ] Stopped <Custom App>3.
[=A0 3] 625.0-630.0 sec=A0 55.1 MBytes=A0 92.4 Mbits/sec
=A0=A0=A0=A0=A0=A0=A0=A0 Stopping <Custom App>4...
[=A0 OK=A0 ] Stopped <Custom App>4.

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
Instantaneously, we see the POLL (and therefore the TX handler) warning=
s getting called
and the performance is slipping and/or timing out all together.
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D

[=A0 681.469207] =3D=3D=3DEMAC: POLL FUNCTION has not been called for >=
 1/2 second!!!
[=A0 681.476501] =3D=3D=3DEMAC: TX FUNCTION has not been called for > 1=
/2 second!!!
[=A0 3] 630.0-635.0 sec=A0 8.59 MBytes=A0 14.4 Mbits/sec
[=A0 692.489929] =3D=3D=3DEMAC: POLL FUNCTION has not been called for >=
 1/2 second!!!
[=A0 692.497222] =3D=3D=3DEMAC: TX FUNCTION has not been called for > 1=
/2 second!!!
[=A0 692.504272] =3D=3D=3DEMAC: TX queue has been stopped for > 1/2 sec=
ond!!!
[=A0 3] 635.0-640.0 sec=A0 11.4 MBytes=A0 19.1 Mbits/sec
[=A0 3] 640.0-645.0 sec=A0 0.00 Bytes=A0 0.00 bits/sec
[=A0 3] 645.0-650.0 sec=A0 5.71 MBytes=A0 9.58 Mbits/sec
[=A0 3] 650.0-655.0 sec=A0 29.6 MBytes=A0 49.6 Mbits/sec
[=A0 3] 655.0-660.0 sec=A0 46.7 MBytes=A0 78.3 Mbits/sec
[=A0 714.523315] =3D=3D=3DEMAC: POLL FUNCTION has not been called for >=
 1/2 second!!!
[=A0 714.530609] =3D=3D=3DEMAC: TX FUNCTION has not been called for > 1=
/2 second!!!
[=A0 3] 660.0-665.0 sec=A0 42.3 MBytes=A0 71.0 Mbits/sec
[=A0 3] 665.0-670.0 sec=A0 0.00 Bytes=A0 0.00 bits/sec
[=A0 3] 670.0-675.0 sec=A0 37.5 MBytes=A0 62.9 Mbits/sec
[=A0 3] 675.0-680.0 sec=A0 53.1 MBytes=A0 89.1 Mbits/sec
[=A0 3] 680.0-685.0 sec=A0 44.8 MBytes=A0 75.2 Mbits/sec
[=A0 3] 685.0-690.0 sec=A0 49.2 MBytes=A0 82.6 Mbits/sec
[=A0 3] 690.0-695.0 sec=A0 49.0 MBytes=A0 82.2 Mbits/sec
[=A0 747.616729] =3D=3D=3DEMAC: POLL FUNCTION has not been called for >=
 1/2 second!!!
[=A0 747.624023] =3D=3D=3DEMAC: TX FUNCTION has not been called for > 1=
/2 second!!!
[=A0 3] 695.0-700.0 sec=A0 40.2 MBytes=A0 67.4 Mbits/sec
[=A0 3] 700.0-705.0 sec=A0 5.38 MBytes=A0 9.03 Mbits/sec
[=A0 3] 705.0-710.0 sec=A0 51.8 MBytes=A0 86.9 Mbits/sec
=A0=A0=A0=A0=A0=A0=A0=A0 Starting <Custom App>2...
[=A0 OK=A0 ] Started <Custom App>2.
[=A0 3] 710.0-715.0 sec=A0 51.9 MBytes=A0 87.1 Mbits/sec
[=A0 3] 715.0-720.0 sec=A0 54.1 MBytes=A0 90.8 Mbits/sec
[=A0 3] 720.0-725.0 sec=A0 53.6 MBytes=A0 89.9 Mbits/sec
[=A0 3] 725.0-730.0 sec=A0 53.3 MBytes=A0 89.4 Mbits/sec
[=A0 3] 730.0-735.0 sec=A0 53.2 MBytes=A0 89.3 Mbits/sec
[=A0 3] 735.0-740.0 sec=A0 56.1 MBytes=A0 94.1 Mbits/sec
[=A0 3] 740.0-745.0 sec=A0 52.0 MBytes=A0 87.3 Mbits/sec
[=A0 3] 745.0-750.0 sec=A0 52.5 MBytes=A0 88.1 Mbits/sec
[=A0 3] 750.0-755.0 sec=A0 55.9 MBytes=A0 93.8 Mbits/sec
[=A0 3] 755.0-760.0 sec=A0 55.9 MBytes=A0 93.9 Mbits/sec
[=A0 3] 760.0-765.0 sec=A0 53.3 MBytes=A0 89.5 Mbits/sec
^C[=A0 3]=A0 0.0-765.9 sec=A0 7.93 GBytes=A0 88.9 Mbits/sec
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
Shut down iperf and drop back to the default idling
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
root@test:~# [=A0 809.822906] =3D=3D=3DEMAC: POLL FUNCTION has not been=
 called for > 1/2 second!!!
[=A0 809.960937] =3D=3D=3DEMAC: TX FUNCTION has not been called for > 1=
/2 second!!!
[=A0 810.822845] =3D=3D=3DEMAC: POLL FUNCTION has not been called for >=
 1/2 second!!!
[=A0 810.960937] =3D=3D=3DEMAC: TX FUNCTION has not been called for > 1=
/2 second!!!
[=A0 813.143280] =3D=3D=3DEMAC: POLL FUNCTION has not been called for >=
 1/2 second!!!
[=A0 813.355712] =3D=3D=3DEMAC: TX FUNCTION has not been called for > 1=
/2 second!!!
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
