From: Komal Shah <komal_shah802003@yahoo.com>
Subject: Re: [PATCH 2/4] TSC2102 Touchscreen
Date: Fri, 18 Aug 2006 06:09:37 -0700 (PDT)
Message-ID: <20060818130937.72819.qmail@web37915.mail.mud.yahoo.com>
References: <fb249edb0608180307t2fe9ea51wde113d1a8182b51f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <fb249edb0608180307t2fe9ea51wde113d1a8182b51f@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: balrogg@gmail.com, Linux-OMAP <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

--- andrzej zaborowski <balrog@zabor.org> wrote:

> This a driver for touchscreens connected to the TSC2102 chip. It uses
> the normal input events framework and can be accessed through
> /dev/input/eventX.
> 

Few comments here too:

+#include <linux/platform_device.h>
+#include <linux/kbd_kern.h>

Why you need kbd_kern.h ? 

+	dev->absbit[0] = BIT(ABS_X) | BIT(ABS_Y) | BIT(ABS_PRESSURE);
+	input_register_device(dev);

You should check the return value of input_register_device. 

+	printk("TSC2102 touchscreen driver initialized\n");

Better if you use KERN_INFO with printk above.

+	dev->name = "TSC2102 Touchscreen";
+	dev->dev = &pdev->dev;

Also fill up remaining fields of input_dev structure. eg. phys, bustype
etc. 

+static int
+tsc2102_ts_suspend(struct platform_device *pdev, pm_message_t state)
+{
+	/* Nothing yet */
+	return 0;
+}
+
+static int tsc2102_ts_resume(struct platform_device *pdev)
+{
+	/* Nothing either */
+	return 0;
+}

How about using #ifdef CONFIG_PM around suspend and resume.  ?


---Komal Shah
http://komalshah.blogspot.com/

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
