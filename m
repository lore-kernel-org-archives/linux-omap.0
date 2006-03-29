From: lamikr <lamikr@cc.jyu.fi>
Subject: Re: [PATCH] fix MMC response types
Date: Thu, 30 Mar 2006 02:29:04 +0300
Message-ID: <442B1840.6060801@cc.jyu.fi>
References: <fb249edb0603241237l5854cc04k@mail.gmail.com>		<4427DEA0.6050804@indt.org.br>	<fb249edb0603271204o1d8df4oe636c1181362d740@mail.gmail.com>
	<4429A3A6.5000503@indt.org.br>
Reply-To: lamikr@cc.jyu.fi
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------060003010902020406080808"
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <4429A3A6.5000503@indt.org.br>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: OMAP-Linux <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

This is a multi-part message in MIME format.
--------------060003010902020406080808
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

So there are planned to do somekind of MMC/SD code merge with the
mainline and has it already happened in the current driver version in
linux-omap.git?

Just to confuse a little bit more... I have a small patch I received
from another ipaq h6300 (omap1510 based) developer. As I do not know
anything from the mmc/sd layer, all I can say is that with this patch me
and the Deniz (patch author) were able to boot from the SD card to iPAQ
h6300. (I tested with 512 mb kingston)
Without this patch we were only able to boot from the MMC cards. Deniz
(said that he is not 100 % sure whether all of the changes are actually
needed
or would only a subset be enought.

Hopefully this patch is not needed anymore after your updates, but here
it is anyway just in case that somebody finds it usefull.

Mika

--------------060003010902020406080808
Content-Type: text/x-patch;
 name="sd_fixes.diff"
Content-Disposition: inline;
 filename="sd_fixes.diff"
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by reloaded.ext.ti.com id k2TNTLr7012707

diff -Naur orig/mmc.c fixed/mmc.c
--- orig/mmc.c	2006-03-18 10:22:19.000000000 +0200
+++ fixed/mmc.c	2006-03-18 10:30:32.000000000 +0200
@@ -964,7 +964,7 @@
 		mmc_decode_scr(card);
 	}
=20
-	mmc_deselect_cards(host);
+	//mmc_deselect_cards(host);
 }
=20
 static unsigned int mmc_calculate_clock(struct mmc_host *host)
diff -Naur orig/omap.c fixed/omap.c
--- orig/omap.c	2006-03-18 10:22:10.000000000 +0200
+++ fixed/omap.c	2006-03-18 10:42:48.000000000 +0200
@@ -2,7 +2,7 @@
  *  linux/drivers/media/mmc/omap.c
  *
  *  Copyright (C) 2004 Nokia Corporation
- *  Written by Tuukka Tikkanen and Juha Yrj=F6l=E4 <juha.yrjola@nokia.co=
m>
+ *  Written by Tuukka Tikkanen and Juha Yrj=C3=B6l=C3=A4 <juha.yrjola@no=
kia.com>
  *  Misc hacks here and there by Tony Lindgren <tony@atomide.com>
  *  Other hacks (DMA, SD, etc) by David Brownell
  *
@@ -231,6 +231,9 @@
 	if (host->data && !(host->data->flags & MMC_DATA_WRITE))
 		cmdreg |=3D 1 << 15;
=20
+	if (cmd->opcode=3D=3D0)
+		cmdreg |=3D 1 << 7;
+
 	clk_enable(host->fclk);
=20
 	OMAP_MMC_WRITE(host->base, CTO, 200);
@@ -890,7 +893,7 @@
 	reg &=3D ~(1 << 5);
 	OMAP_MMC_WRITE(host->base, SDIO, reg);
 	/* Set maximum timeout */
-	OMAP_MMC_WRITE(host->base, CTO, 0xff);
+	OMAP_MMC_WRITE(host->base, CTO, 0xfd);
 }
=20
 static inline void set_data_timeout(struct mmc_omap_host *host, struct m=
mc_request *req)
@@ -901,7 +904,7 @@
 	/* Convert ns to clock cycles by assuming 20MHz frequency
 	 * 1 cycle at 20MHz =3D 500 ns
 	 */
-	timeout =3D req->data->timeout_clks + req->data->timeout_ns / 500;
+	timeout =3D (req->data->timeout_clks * 10)  + (req->data->timeout_ns*10=
) / 500;
=20
 	/* Some cards require more time to do at least the first read operation=
 */
 	timeout =3D timeout << 4;
@@ -986,7 +989,7 @@
 		mmc_omap_sg_to_buf(host);
 		host->dma_in_use =3D 0;
 	}
-	mod_timer(&host->xfer_timer, jiffies + msecs_to_jiffies(500));
+	mod_timer(&host->xfer_timer, jiffies + msecs_to_jiffies(1500));
=20
 	pr_debug("MMC%d: %s %s %s, DTO %d cycles + %d ns, "
 			"%d blocks of %d bytes, %d segments\n",
@@ -1164,7 +1167,7 @@
 	case MMC_POWER_UP:
 	case MMC_POWER_ON:
 		mmc_omap_power(host, 1);
-		dsor |=3D 1<<11;
+		dsor =3D (120 | (1 << 11));
 		break;
 	}
=20
@@ -1484,4 +1487,4 @@
 MODULE_DESCRIPTION("OMAP Multimedia Card driver");
 MODULE_LICENSE("GPL");
 MODULE_ALIAS(DRIVER_NAME);
-MODULE_AUTHOR("Juha Yrj=F6l=E4");
+MODULE_AUTHOR("Juha Yrj=C3=B6l=C3=A4");

--------------060003010902020406080808
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 7bit


--------------060003010902020406080808--
