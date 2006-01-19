From: Hiroki Kaminaga <kaminaga@sm.sony.co.jp>
Subject: Re: Help me. Oops: 805 [#1]err using kernel.2.6.10.omap1patch with
 NFS(RFS)
Date: Thu, 19 Jan 2006 21:35:52 +0900 (JST)
Message-ID: <20060119.213552.38718549.kaminaga@sm.sony.co.jp>
References: <43CF7D10.000001.02044@nhn527>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
	boundary="--Next_Part(Thu_Jan_19_21_35_52_2006_696)--"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <43CF7D10.000001.02044@nhn527>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: invain@naver.com
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

----Next_Part(Thu_Jan_19_21_35_52_2006_696)--
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hi,

> Thanks for your replying. I already successed  with nfs root file system  
> using  kernel.org.2.6.15 + omap2.patch. But, In my circumstance, Now, 
> I have to  do booting using 2.6.10 kernel.
> Please. inform method that can do Poting  to omap board using 2.6.10 kernel 
> because  I use 2.6.10 version.

Try this patch. Hope it works for you.


Best Regards,

HK.
--
----Next_Part(Thu_Jan_19_21_35_52_2006_696)--
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline; filename="smc91x.diff"

--- linux-2.6.10/drivers/net/smc91x.c	2004-12-25 06:35:40.000000000 +0900
+++ linux-2.6.11/drivers/net/smc91x.c	2006-01-19 22:26:25.000000000 +0900
@@ -483,6 +483,11 @@
 		dev->name, packet_number, status,
 		packet_len, packet_len);
 
+	if (unlikely(packet_len == 0 && !(status & RS_ERRORS))) {
+		printk(KERN_ERR "%s: bad memory timings: rxlen %u status %x\n",
+			dev->name, packet_len, status);
+		status |= RS_TOOSHORT;
+	}
 	if (unlikely(status & RS_ERRORS)) {
 		SMC_WAIT_MMU_BUSY();
 		SMC_SET_MMU_CMD(MC_RELEASE);
@@ -1333,6 +1338,19 @@
 	return IRQ_HANDLED;
 }
 
+#ifdef CONFIG_NET_POLL_CONTROLLER
+/*
+ * Polling receive - used by netconsole and other diagnostic tools
+ * to allow network i/o with interrupts disabled.
+ */
+static void smc_poll_controller(struct net_device *dev)
+{
+	disable_irq(dev->irq);
+	smc_interrupt(dev->irq, dev, NULL);
+	enable_irq(dev->irq);
+}
+#endif
+
 /* Our watchdog timed out. Called by the networking layer */
 static void smc_timeout(struct net_device *dev)
 {
@@ -1912,6 +1930,9 @@
 	dev->get_stats = smc_query_statistics;
 	dev->set_multicast_list = smc_set_multicast_list;
 	dev->ethtool_ops = &smc_ethtool_ops;
+#ifdef CONFIG_NET_POLL_CONTROLLER
+	dev->poll_controller = smc_poll_controller;
+#endif
 
 	tasklet_init(&lp->tx_task, smc_hardware_send_pkt, (unsigned long)dev);
 	INIT_WORK(&lp->phy_configure, smc_phy_configure, dev);

----Next_Part(Thu_Jan_19_21_35_52_2006_696)--
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


----Next_Part(Thu_Jan_19_21_35_52_2006_696)----
