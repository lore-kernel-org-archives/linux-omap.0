From: Dirk Behme <dirk.behme@de.bosch.com>
Subject: [PATCH] Re: Git tree update, patches sent upstream
Date: Sun, 20 Nov 2005 19:13:19 +0100
Message-ID: <4380BCBF.3010603@de.bosch.com>
References: <43745428.1428f2bd.23ee.0647@mx.gmail.com>	<200511110910.07129.david-b@pacbell.net>
	<20051111171650.GA10822@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------080101020805030307000509"
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <20051111171650.GA10822@atomide.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

This is a multi-part message in MIME format.
--------------080101020805030307000509
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Tony Lindgren wrote:
> * David Brownell <david-b@pacbell.net> [051111 09:10]:
> 
>>>error: `platform_bus_type' undeclared here (not in a function)
>>
>>#include <linux/platform_device.h> is now needed.
> 
> 
> It's best just replace <linux/device.h> with <linux/platform_device.h>,
> as it already includes <linux/device.h>.

Remove error

drivers/video/omap/omapfb_main.c:1395: error: `platform_bus_type'
undeclared here (not in a function)
sound/arm/omap-aic23.c:879: error: `platform_bus_type' undeclared here
(not in a function)

Remove warning

sound/arm/omap-aic23.c:882: warning: initialization from incompatible
pointer type
sound/arm/omap-aic23.c:883: warning: initialization from incompatible
pointer type

Signed-off-by: Dirk Behme <dirk.behme_at_de.bosch.com>





--------------080101020805030307000509
Content-Type: text/plain;
 name="patch_platform_device.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch_platform_device.txt"

--- ./sound/arm/omap-aic23.c_orig	2005-11-20 18:51:29.000000000 +0100
+++ ./sound/arm/omap-aic23.c	2005-11-20 19:03:50.682393232 +0100
@@ -39,7 +39,7 @@
 #include <linux/config.h>
 #include <sound/driver.h>
 #include <linux/module.h>
-#include <linux/device.h>
+#include <linux/platform_device.h>
 #include <linux/moduleparam.h>
 #include <linux/init.h>
 #include <linux/errno.h>
@@ -668,7 +668,7 @@ static int snd_omap_aic23_resume(snd_car
 /*
  * Driver suspend/resume - calls alsa functions. Some hints from aaci.c
  */
-static int omap_aic23_suspend(struct device *dev, pm_message_t state, u32 level)
+static int omap_aic23_suspend(struct device *dev, pm_message_t state)
 {
 	snd_card_t *card = dev_get_drvdata(dev);
 	
@@ -678,7 +678,7 @@ static int omap_aic23_suspend(struct dev
 	return 0;
 }
 
-static int omap_aic23_resume(struct device *dev, u32 level)
+static int omap_aic23_resume(struct device *dev)
 {
 	snd_card_t *card = dev_get_drvdata(dev);
 
--- ./drivers/input/touchscreen/omap/omap_ts.c_orig	2005-11-20 18:35:31.000000000 +0100
+++ ./drivers/input/touchscreen/omap/omap_ts.c	2005-11-20 18:38:29.000000000 +0100
@@ -35,7 +35,7 @@
 #include <linux/wait.h>
 #include <linux/interrupt.h>
 #include <linux/suspend.h>
-#include <linux/device.h>
+#include <linux/platform_device.h>
 
 #include <asm/mach-types.h>
 


--------------080101020805030307000509
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-omap-open-source mailing list
Linux-omap-open-source@linux.omap.com
http://linux.omap.com/mailman/listinfo/linux-omap-open-source

--------------080101020805030307000509--
