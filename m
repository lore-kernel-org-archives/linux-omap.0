From: Komal Shah <komal_shah802003@yahoo.com>
Subject: Re: [PATCH] fix watchdog
Date: Mon, 19 Dec 2005 08:31:45 -0800 (PST)
Message-ID: <20051219163145.51444.qmail@web32906.mail.mud.yahoo.com>
References: <1135009205.12906.28.camel@two.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <1135009205.12906.28.camel@two.research.nokia.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org


> Why?
> 
> Instead of explaining _what_ you do in the patch comments, you should
> explain _why_, especially in the case of a trivial patch like 
> this.

Ok, I had made a mistake while generating the patch of omap_wdt.c for
"[PATCH] ARCH: OMAP omap-wdt: use struct platform_driver"


"-static struct device_driver omap_wdt_driver = {
- .name = "omap_wdt",
- .bus = &platform_bus_type,
- .probe = omap_wdt_probe,
- .shutdown = omap_wdt_shutdown,
- .remove = __exit_p(omap_wdt_remove),
- .suspend = omap_wdt_suspend,
- .resume = omap_wdt_resume,
+static struct platform_driver omap_wdt_driver = {
+ .probe = omap_wdt_probe,
+ .remove = omap_wdt_remove,
+ .shutdown = omap_wdt_shutdown,
+ .suspend = omap_wdt_suspend,
+ .resume = omap_wdt_resume,
+ .driver = {
+ .owner = THIS_MODULE,
+ .name = "omap-wdt",
+ },
};
 
In that I had mistakenly changed original driver name from "omap_wdt"
which matches with one in "devices.c" to "omap-wdt". So, you know the
effect...

The current patch reverts it back....

---Komal Shah
http://komalshah.blogspot.com/

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
