From: Komal Shah <komal_shah802003@yahoo.com>
Subject: Re: [PATCH 3/4] TSC2102 hwmon driver
Date: Fri, 18 Aug 2006 05:52:20 -0700 (PDT)
Message-ID: <20060818125220.38707.qmail@web37905.mail.mud.yahoo.com>
References: <fb249edb0608180317j1f47ee3crfb89728cdc1f3814@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <fb249edb0608180317j1f47ee3crfb89728cdc1f3814@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: balrogg@gmail.com, Linux-OMAP <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

--- andrzej zaborowski <balrog@zabor.org> wrote:

> This driver makes the status of sensors connected to the TSC2102 chip
> availiable to the Linux hwmon api and APM. The chip has two battery
> monitor inputs, one auxiliary input and two built-in thermometers,
> all
> report 12-bit samples in intervals that can be configured. The driver
> calculates temperature in Celcius grades using the difference between
> the two temperature measurements. To calibrate it, it needs to be
> given the nominal values reported by sensors when at 25 C. This may
> allow changing the way temperature is calculated, to a more accurate
> one, without affecting board definitions in future.
> 

Few comments:

+	.driver		= {
+		.name	= "tsc2102-hwmon",
+	},

You might like to add .owner = THIS_MODULE here.

+static int
+tsc2102_hwmon_suspend(struct platform_device *pdev, pm_message_t
state)
+{
+	return 0;
+}
+
+static int tsc2102_hwmon_resume(struct platform_device *pdev)
+{
+	return 0;
+}

How about covering them with #ifdef CONFIG_PM ?

+	}
+	if (status) {
+		hwmon_device_unregister(hwmon.dev);
+		return status;
+	}

In the error path you should set platform_set_drvdata(pdev, NULL).

+	if (pdata->monitor & TSC_BAT1)
+		device_create_file(&pdev->dev, &dev_attr_in0_input);
+	if (pdata->monitor & TSC_BAT2)
+		device_create_file(&pdev->dev, &dev_attr_in1_input);
+	if (pdata->monitor & TSC_AUX)
+		device_create_file(&pdev->dev, &dev_attr_in2_input);
+	if (pdata->monitor & TSC_TEMP)
+		device_create_file(&pdev->dev, &dev_attr_temp1_input);

You "must" check the return error value of device_create_file and such
functions. They are now under __must_check.

+static int tsc2102_hwmon_remove(struct platform_device *pdev)
+{
+	struct tsc2102_hwmon *dev = platform_get_drvdata(pdev);
+
+	tsc2102_ports_cb(0);
+	tsc2102_temp1_cb(0);
+	tsc2102_temp2_cb(0);
+	hwmon_device_unregister(dev->dev);

Again at the end platform_set_drvdata(pdev, NULL). 

+#include <linux/init.h>
+#include <linux/err.h>
+#include <linux/hwmon.h>

Where is #include <linux/module.h> ?

---Komal Shah
http://komalshah.blogspot.com/

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
