From: Dirk Behme <dirk.behme@googlemail.com>
Subject: Re: [PATCH] Convert drivers to new irq trigger modes
Date: Sun, 12 Feb 2006 16:43:12 +0100
Message-ID: <43EF5790.3020509@gmail.com>
References: <43E8D9CA.8000204@gmail.com>
	<20060208051451.GA22845@two.research.nokia.com>
	<43EA4234.4070807@gmail.com>
	<20060209062536.GC11799@two.research.nokia.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------020302000809070901090308"
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <20060209062536.GC11799@two.research.nokia.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: =?ISO-8859-1?Q?Juha_Yrj=F6l=E4?= <juha.yrjola@nokia.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

This is a multi-part message in MIME format.
--------------020302000809070901090308
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by reloaded.ext.ti.com id k1CFhMKD007679

Juha Yrj=F6l=E4 wrote:
> SA_SAMPLE_RANDOM doesn't have anything to do with triggering.  It's use=
d to
> indicate whether an IRQ source can be used to feed the kernel entropy p=
ools.=20
> If the IRQ in question cannot be considered to happen at random interva=
ls,
> the flag must not be set.

Okay. What's about this?

Add ORing the  SA_TRIGGER_FALLING and don't use
SA_SAMPLE_RANDOM as default value in ts_inn1510.c.

--------------020302000809070901090308
Content-Type: text/plain;
 name="sample_random_patch.txt"
Content-Disposition: inline;
 filename="sample_random_patch.txt"
Content-Transfer-Encoding: 7bit

--- ./drivers/i2c/chips/isp1301_omap.c_orig	2006-02-12 16:31:26.000000000 +0100
+++ ./drivers/i2c/chips/isp1301_omap.c	2006-02-12 16:36:13.000000000 +0100
@@ -1604,7 +1604,7 @@ fail1:
 		isp->irq = OMAP_GPIO_IRQ(2);
 		omap_request_gpio(2);
 		omap_set_gpio_direction(2, 1);
-		isp->irq_type = SA_TRIGGER_FALLING;
+		isp->irq_type |=  SA_TRIGGER_FALLING;
 	}
 
 	if (machine_is_omap_h3()) {
@@ -1613,7 +1613,7 @@ fail1:
 		isp->irq = OMAP_GPIO_IRQ(14);
 		omap_request_gpio(14);
 		omap_set_gpio_direction(14, 1);
-		isp->irq_type = SA_TRIGGER_FALLING;
+		isp->irq_type |= SA_TRIGGER_FALLING;
 	}
 
 	status = request_irq(isp->irq, isp1301_irq,
--- ./drivers/i2c/chips/tps65010.c_orig	2006-02-12 16:33:21.000000000 +0100
+++ ./drivers/i2c/chips/tps65010.c	2006-02-12 16:34:38.000000000 +0100
@@ -536,7 +536,7 @@ fail1:
 		tps->irq = OMAP_GPIO_IRQ(58);
 		omap_request_gpio(58);
 		omap_set_gpio_direction(58, 1);
-		tps->irq_type = SA_TRIGGER_FALLING;
+		tps->irq_type |= SA_TRIGGER_FALLING;
 	}
 	if (machine_is_omap_osk()) {
 		tps->model = TPS65010;
@@ -544,7 +544,7 @@ fail1:
 		tps->irq = OMAP_GPIO_IRQ(OMAP_MPUIO(1));
 		omap_request_gpio(OMAP_MPUIO(1));
 		omap_set_gpio_direction(OMAP_MPUIO(1), 1);
-		tps->irq_type = SA_TRIGGER_FALLING;
+		tps->irq_type |= SA_TRIGGER_FALLING;
 	}
 	if (machine_is_omap_h3()) {
 		tps->model = TPS65013;
--- ./drivers/input/touchscreen/omap/ts_inn1510.c_orig	2006-02-12 16:37:04.000000000 +0100
+++ ./drivers/input/touchscreen/omap/ts_inn1510.c	2006-02-12 16:37:18.000000000 +0100
@@ -176,7 +176,7 @@ static int __init inn1510_ts_probe(struc
 		return -ENODEV;
 
 	ts->irq = OMAP1510_INT_FPGA_TS;
-	ts->irq_type = SA_SAMPLE_RANDOM;
+	ts->irq_type = 0;
 	
 	return 0;
 }


--------------020302000809070901090308
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 7bit


--------------020302000809070901090308--
