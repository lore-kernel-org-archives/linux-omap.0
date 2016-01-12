From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: arm qemu boot failures in -next due to 'PM / Domains: add setter
 for dev.pm_domain'
Date: Tue, 12 Jan 2016 01:24:28 +0100
Message-ID: <CAJZ5v0gvvXkj16Ac_dWnx4ew+Y7biaR54HCsyHkqo_f9PPPmAQ@mail.gmail.com>
References: <5693EB8A.40802@roeck-us.net>
	<20160111185459.GZ12777@atomide.com>
	<20160111200450.GA16902@roeck-us.net>
	<7302125.veLBHLkdLG@vostro.rjw.lan>
	<56943D3B.8010600@roeck-us.net>
	<20160112001532.GD12777@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <20160112001532.GD12777@atomide.com>
Sender: linux-pm-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Guenter Roeck <linux@roeck-us.net>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Russell King <linux@arm.linux.org.uk>, Kevin Hilman <khilman@kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Tue, Jan 12, 2016 at 1:15 AM, Tony Lindgren <tony@atomide.com> wrote:
> * Guenter Roeck <linux@roeck-us.net> [160111 15:40]:
>> On 01/11/2016 02:49 PM, Rafael J. Wysocki wrote:
>> >On Monday, January 11, 2016 12:04:50 PM Guenter Roeck wrote:
>> >>On Mon, Jan 11, 2016 at 10:55:00AM -0800, Tony Lindgren wrote:
>> >>>* Guenter Roeck <linux@roeck-us.net> [160111 09:51]:
>> >>>>Hi,
>> >>>>
>> >>>>I see 6 out of 24 arm qemu tests failing in next-20160111. Bisect points
>> >>>>to commit 989561de9b51 ("PM / Domains: add setter for dev.pm_domain").
>> >>>>Failures are silent - there is no output on the console.
>> >>>>Affected tests are
>> >>>>
>> >>>>arm:beagle:multi_v7_defconfig:omap3-beagle
>> >>>>arm:beaglexm:multi_v7_defconfig:omap3-beagle-xm
>> >>>>arm:overo:multi_v7_defconfig:omap3-overo-tobi
>> >>>>arm:beagle:omap2plus_defconfig:omap3-beagle
>> >>>>arm:beaglexm:omap2plus_defconfig:omap3-beagle-xm
>> >>>>arm:overo:omap2plus_defconfig:omap3-overo-tobi
>> >>>>
>> >>>>For details please see the 'next' column at http://server.roeck-us.net:8010/builders.
>> >>>>
>> >>>>Reverting the offending commit fixes the problems.
>> >>>>
>> >>>>Please let me know if there is anything I can do to help tracking down the problem.
>> >>>
>> >>>The following fixes the booting, but I wonder if it's a
>> >>
>> >>Yes, it does.
>> >>
>> >>Tested-by: Guenter Roeck <linux@roeck-us.net>
>> >>
>> >>>proper fix?
>> >>>
>> >>That I don't know.
>> >
>> >If I'm not mistaken, what happens is that device_is_bound() tries to
>> >dereference dev->p which is NULL.  If that's the case, the appended one
>> >should help too.
>> >
>> >Can you please check?
>> >
>> >---
>> >  drivers/base/dd.c |    2 +-
>> >  1 file changed, 1 insertion(+), 1 deletion(-)
>> >
>> >Index: linux-pm/drivers/base/dd.c
>> >===================================================================
>> >--- linux-pm.orig/drivers/base/dd.c
>> >+++ linux-pm/drivers/base/dd.c
>> >@@ -234,7 +234,7 @@ late_initcall(deferred_probe_initcall);
>> >   */
>> >  bool device_is_bound(struct device *dev)
>> >  {
>> >-    return klist_node_attached(&dev->p->knode_driver);
>> >+    return dev->p && klist_node_attached(&dev->p->knode_driver);
>>
>> Yes, that fixes the problem as well.
>
> Yeah works for me too:
>
> Tested-by: Tony Lindgren <tony@atomide.com>

OK, thanks!

I'll add a changelog to this one and queue it up then.

Thanks,
Rafael
