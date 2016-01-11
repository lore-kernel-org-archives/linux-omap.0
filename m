From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: arm qemu boot failures in -next due to 'PM / Domains: add setter for dev.pm_domain'
Date: Mon, 11 Jan 2016 23:49:59 +0100
Message-ID: <7302125.veLBHLkdLG@vostro.rjw.lan>
References: <5693EB8A.40802@roeck-us.net> <20160111185459.GZ12777@atomide.com> <20160111200450.GA16902@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160111200450.GA16902@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Guenter Roeck <linux@roeck-us.net>
Cc: Tony Lindgren <tony@atomide.com>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Russell King <linux@arm.linux.org.uk>, Kevin Hilman <khilman@kernel.org>, linux-arm-kernel@lists.infradead.org, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Monday, January 11, 2016 12:04:50 PM Guenter Roeck wrote:
> On Mon, Jan 11, 2016 at 10:55:00AM -0800, Tony Lindgren wrote:
> > * Guenter Roeck <linux@roeck-us.net> [160111 09:51]:
> > > Hi,
> > > 
> > > I see 6 out of 24 arm qemu tests failing in next-20160111. Bisect points
> > > to commit 989561de9b51 ("PM / Domains: add setter for dev.pm_domain").
> > > Failures are silent - there is no output on the console.
> > > Affected tests are
> > > 
> > > arm:beagle:multi_v7_defconfig:omap3-beagle
> > > arm:beaglexm:multi_v7_defconfig:omap3-beagle-xm
> > > arm:overo:multi_v7_defconfig:omap3-overo-tobi
> > > arm:beagle:omap2plus_defconfig:omap3-beagle
> > > arm:beaglexm:omap2plus_defconfig:omap3-beagle-xm
> > > arm:overo:omap2plus_defconfig:omap3-overo-tobi
> > > 
> > > For details please see the 'next' column at http://server.roeck-us.net:8010/builders.
> > > 
> > > Reverting the offending commit fixes the problems.
> > > 
> > > Please let me know if there is anything I can do to help tracking down the problem.
> > 
> > The following fixes the booting, but I wonder if it's a
> 
> Yes, it does. 
> 
> Tested-by: Guenter Roeck <linux@roeck-us.net>
> 
> > proper fix?
> > 
> That I don't know.

If I'm not mistaken, what happens is that device_is_bound() tries to
dereference dev->p which is NULL.  If that's the case, the appended one
should help too.

Can you please check?

---
 drivers/base/dd.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-pm/drivers/base/dd.c
===================================================================
--- linux-pm.orig/drivers/base/dd.c
+++ linux-pm/drivers/base/dd.c
@@ -234,7 +234,7 @@ late_initcall(deferred_probe_initcall);
  */
 bool device_is_bound(struct device *dev)
 {
-	return klist_node_attached(&dev->p->knode_driver);
+	return dev->p && klist_node_attached(&dev->p->knode_driver);
 }
 
 static void driver_bound(struct device *dev)
