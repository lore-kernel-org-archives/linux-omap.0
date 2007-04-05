From: "Trilok Soni" <soni.trilok@gmail.com>
Subject: Re: [PATCH] WATCHDOG: use base address from platform resources and
	make 2430 boot again
Date: Thu, 5 Apr 2007 15:50:17 +0530
Message-ID: <5d5443650704050320t242adc8ak46c76cfbc69449ed@mail.gmail.com>
References: <782515bb0704041855x4ff69d3bp19d386805eaecf16@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <782515bb0704041855x4ff69d3bp19d386805eaecf16@mail.gmail.com>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: nishanth menon <menon.nishanth@gmail.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi Nishanth,

On 4/5/07, nishanth menon <menon.nishanth@gmail.com> wrote:
> Hi All,
> Here is a patch for making 2430 bark again. In the process cleaned up
> the watchdog timer driver a bit.
> Details:
> Watchdog fixes for 2430
> * modfied watchdog driver to use base address provided in platform defn
> * in the process cleaned up a bunch of statics used.
> * added 2430 baseaddress defn

Few comments:

+ * ***
+ * History:
+ * --------
+ * 2007-04-04 Nishanth Menon - move to depend on platform resource and clean
+ *                             statics
  */

Changelog goes in the SCM metadata, not source files. Please avoid this.

-static void omap_wdt_ping(void)
+static void omap_wdt_ping(struct omap_wdt_dev *wdev)
 {
+	void __iomem    *base=wdev->base;


space between *base and wdev->base is required for readability.

+	void __iomem *base;
+	base = wdev->base;

Please add atleast one empty line between above sentences and same
with all other places in the driver.

+	wdev = (struct omap_wdt_dev *) platform_get_drvdata(omap_wdt_dev);

You don't need casting here, I think.

+	file->private_data = (void *) wdev;
+	wdev = (struct omap_wdt_dev *) file->private_data;

No need of casting.

You should also set drvdata to NULL on wdt remove and error recovery
path in wdt_probe.

+	platform_set_drvdata(pdev, NULL);

-- 
--Trilok Soni
