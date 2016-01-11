From: Tony Lindgren <tony@atomide.com>
Subject: Re: arm qemu boot failures in -next due to 'PM / Domains: add setter
 for dev.pm_domain'
Date: Mon, 11 Jan 2016 10:55:00 -0800
Message-ID: <20160111185459.GZ12777@atomide.com>
References: <5693EB8A.40802@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5693EB8A.40802@roeck-us.net>
Sender: linux-pm-owner@vger.kernel.org
To: Guenter Roeck <linux@roeck-us.net>
Cc: Tomeu Vizoso <tomeu.vizoso@collabora.com>, Russell King <linux@arm.linux.org.uk>, Kevin Hilman <khilman@kernel.org>, linux-arm-kernel@lists.infradead.org, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

* Guenter Roeck <linux@roeck-us.net> [160111 09:51]:
> Hi,
> 
> I see 6 out of 24 arm qemu tests failing in next-20160111. Bisect points
> to commit 989561de9b51 ("PM / Domains: add setter for dev.pm_domain").
> Failures are silent - there is no output on the console.
> Affected tests are
> 
> arm:beagle:multi_v7_defconfig:omap3-beagle
> arm:beaglexm:multi_v7_defconfig:omap3-beagle-xm
> arm:overo:multi_v7_defconfig:omap3-overo-tobi
> arm:beagle:omap2plus_defconfig:omap3-beagle
> arm:beaglexm:omap2plus_defconfig:omap3-beagle-xm
> arm:overo:omap2plus_defconfig:omap3-overo-tobi
> 
> For details please see the 'next' column at http://server.roeck-us.net:8010/builders.
> 
> Reverting the offending commit fixes the problems.
> 
> Please let me know if there is anything I can do to help tracking down the problem.

The following fixes the booting, but I wonder if it's a
proper fix?

--- a/drivers/base/power/common.c
+++ b/drivers/base/power/common.c
@@ -145,9 +145,10 @@ void dev_pm_domain_set(struct device *dev, struct dev_pm_domain *pd)
 {
 	if (dev->pm_domain == pd)
 		return;
-
-	WARN(device_is_bound(dev),
-	     "PM domains can only be changed for unbound devices\n");
+	if (device_is_registered(dev)) {
+		WARN(device_is_bound(dev),
+		     "PM domains can only be changed for unbound devices\n");
+	}
 	dev->pm_domain = pd;
 	device_pm_check_callbacks(dev);
 }
