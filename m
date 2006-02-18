From: Dirk Behme <dirk.behme@googlemail.com>
Subject: [PATCH] Support all four gpio trigger modes for OMAP1610
Date: Sat, 18 Feb 2006 09:19:31 +0100
Message-ID: <43F6D893.9030004@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------050802080405050706000803"
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

This is a multi-part message in MIME format.
--------------050802080405050706000803
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


ARM: OMAP: Support all four OMAP1610 GPIO trigger modes
(proposed by David Brownell)

Signed-off-by: Dirk Behme <dirk.behme_at_gmail.com>



--------------050802080405050706000803
Content-Type: text/x-patch;
 name="gpio_trigger.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="gpio_trigger.patch"

--- ./arch/arm/plat-omap/gpio.c_orig	2006-02-18 07:43:54.000000000 +0100
+++ ./arch/arm/plat-omap/gpio.c	2006-02-18 08:59:30.000000000 +0100
@@ -452,10 +452,8 @@ static int _set_gpio_triggering(struct g
 		l &= ~(3 << (gpio << 1));
 		if (trigger & __IRQT_RISEDGE)
 			l |= 2 << (gpio << 1);
-		else if (trigger & __IRQT_FALEDGE)
+		if (trigger & __IRQT_FALEDGE)
 			l |= 1 << (gpio << 1);
-		else
-			goto bad;
 		break;
 	case METHOD_GPIO_730:
 		reg += OMAP730_GPIO_INT_CONTROL;


--------------050802080405050706000803
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------050802080405050706000803--
