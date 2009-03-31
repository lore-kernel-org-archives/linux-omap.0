From: Subramani Venkatesh <subbu31mani@gmail.com>
Subject: [RFC][PATCH] LAN9211 and LAN9221 NFS mounting and overrun fix on omap
	LDP
Date: Tue, 31 Mar 2009 15:05:19 -0400
Message-ID: <25dd9bf10903311205p7bda9627i30f276aaa9a55cbc@mail.gmail.com>
References: <25dd9bf10903250938h565ddf49rc556931b3bdc3d55@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from qw-out-2122.google.com ([74.125.92.24]:27153 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751047AbZCaTKa convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 31 Mar 2009 15:10:30 -0400
Received: by qw-out-2122.google.com with SMTP id 8so3278359qwh.37
        for <linux-omap@vger.kernel.org>; Tue, 31 Mar 2009 12:10:27 -0700 (PDT)
In-Reply-To: <25dd9bf10903250938h565ddf49rc556931b3bdc3d55@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

The patch below I am reposting it, because I could not get a chance to
communicate with Actual athor, I will be glad if someone can comment
on it.



---------- Forwarded message ----------
=46rom: Subramani Venkatesh <subbu31mani@gmail.com>
Date: Wed, Mar 25, 2009 at 12:38 PM
Subject: [RFC][PATCH] LAN9211 and LAN9221 NFS mounting and overrun fix
on omap LDP
To: nico@cam.org
Cc: linux-arm <linux-arm@lists.arm.linux.org.uk>


Hi,
I need your comment on the patch I generated on 2.6.27 Linux ARM for om=
ap LDP.
With this patch we are able to mount the NFS even with heavy traffic
like ping -f option, without which NFS retrying and hangs.
I am not sure whether this problem is fixed with the new the kernel, I
need your comments whether we can intergrate with the kernel or not.

=46rom 9bd50055785492f52877fc719ec5ad02dd183a99 Mon Sep 17 00:00:00 200=
1
=46rom: Subramani Venkatesh <subramani.venkatesh@windriver.com>
Date: Wed, 25 Mar 2009 12:23:45 -0400
Subject: [PATCH] LAN9211 NFS bootup fix
=A0This patch fixs the problem of Mounting NFS file system, when there
is too much traffic on the Network.
=A0We still face the Overrun issues, but we still have NFS working.

NFS mounting issue is found on Omap LDP target boards.

Signed-off-by: Subramani Venkatesh <subbu.wrs@ti.com>
---
=A0drivers/net/smc911x.c | =A0 =A06 ++++++
=A01 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/drivers/net/smc911x.c b/drivers/net/smc911x.c
index 7aa8c49..f3343ae 100644
--- a/drivers/net/smc911x.c
+++ b/drivers/net/smc911x.c
@@ -1111,6 +1111,12 @@ static irqreturn_t smc911x_interrupt(int irq,
void *dev_id)
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0smc911x_=
rcv(dev);
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0SMC_ACK_INT(lp, INT_STS_=
RSFL_);
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (rx_overrun) {
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 DBG(SMC_D=
EBUG_RX, "%s: RX Enable\n", dev->name);
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 SMC_GET_M=
AC_CR(lp, cr);
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 SMC_SET_M=
AC_CR(lp, cr|MAC_CR_RXEN_);
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
+
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* Handle transmit FIFO available */
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (status & INT_STS_TDFA_) {
--
1.5.4.3

Regards,
Subbu
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
