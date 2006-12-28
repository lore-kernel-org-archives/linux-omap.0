From: Dirk Behme <dirk.behme@googlemail.com>
Subject: Re: OMAP: small patch fixes "error: field 'gpio_expa' has incomplete
 type"
Date: Thu, 28 Dec 2006 08:48:36 +0100
Message-ID: <459376D4.707@gmail.com>
References: <25c21ceb0612271236ped35f6t65da0e66c86fcd9a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------040202040906030303060400"
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <25c21ceb0612271236ped35f6t65da0e66c86fcd9a@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: =?ISO-8859-1?Q?Ragner_N_Magalh=E3es?= <ragner@users.sourceforge.net>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

This is a multi-part message in MIME format.
--------------040202040906030303060400
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by calf.ext.ti.com id kBS7muth018880

Ragner N Magalh=E3es wrote:
> In file included from arch/arm/mach-omap1/board-h2.c:40:
> include/asm/arch/irda.h:27: error: field 'gpio_expa' has incomplete typ=
e
...
> --- 2.6-dev.orig/include/asm/arch/irda.h	2006-12-27 10:28:09.000000000 =
-0400
> +++ 2.6-dev/include/asm/arch/irda.h	2006-12-27 10:29:07.000000000 -0400
> @@ -10,6 +10,8 @@
>  #ifndef ASMARM_ARCH_IRDA_H
>  #define ASMARM_ARCH_IRDA_H
> =20
> +#include <linux/workqueue.h>
> +
>  /* board specific transceiver capabilities */

Can you test patch in attachment?

I think the issue is in drivers/net/irda/omap-ir.c. So I=20
think touching global irda.h isn't a good idea.

With this patch, drivers/net/irda/omap-ir.c and=20
arch/arm/mach-omap1/board-h2.c compiles for me.

Dirk

--------------040202040906030303060400
Content-Type: text/plain;
 name="irda_workqueue_patch.txt"
Content-Disposition: inline;
 filename="irda_workqueue_patch.txt"
Content-Transfer-Encoding: 7bit


Make drivers/net/irda/omap-ir.c compile again.

Signed-off-by: Dirk Behme <dirk.behme_at_gmail.com>
Index: linux-osk/drivers/net/irda/omap-ir.c
===================================================================
--- linux-osk.orig/drivers/net/irda/omap-ir.c
+++ linux-osk/drivers/net/irda/omap-ir.c
@@ -54,6 +54,7 @@
 #include <linux/dma-mapping.h>
 #include <linux/platform_device.h>
 #include <linux/i2c.h>
+#include <linux/workqueue.h>
 
 #include <net/irda/irda.h>
 #include <net/irda/irmod.h>
@@ -849,7 +850,7 @@ static int omap_irda_probe(struct platfo
 
 	/* Any better way to avoid this? No. */
 	if (machine_is_omap_h3() || machine_is_omap_h4())
-		INIT_WORK(&omap_ir->pdata->gpio_expa, NULL, NULL);
+		INIT_WORK(&(omap_ir->pdata->gpio_expa.work), NULL);
 
 	err = register_netdev(dev);
 	if (!err)

--------------040202040906030303060400
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 7bit


--------------040202040906030303060400--
