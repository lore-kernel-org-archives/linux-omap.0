From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: arm qemu boot failures in -next due to 'PM / Domains: add setter
 for dev.pm_domain'
Date: Mon, 11 Jan 2016 12:48:19 -0800
Message-ID: <20160111204819.GA10522@roeck-us.net>
References: <5693EB8A.40802@roeck-us.net>
 <20160111185459.GZ12777@atomide.com>
 <CAOMZO5CkfXcZV3LTOP0oT__012ena9kmTYLb83dY9+BMj5X3hw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAOMZO5CkfXcZV3LTOP0oT__012ena9kmTYLb83dY9+BMj5X3hw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
To: Fabio Estevam <festevam@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Russell King <linux@arm.linux.org.uk>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Kevin Hilman <khilman@kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On Mon, Jan 11, 2016 at 06:14:31PM -0200, Fabio Estevam wrote:
> [Adding Rafael]
> 
> On Mon, Jan 11, 2016 at 4:55 PM, Tony Lindgren <tony@atomide.com> wrote:
> 
> >> I see 6 out of 24 arm qemu tests failing in next-20160111. Bisect points
> >> to commit 989561de9b51 ("PM / Domains: add setter for dev.pm_domain").
> >> Failures are silent - there is no output on the console.
> >> Affected tests are
> >>
> >> arm:beagle:multi_v7_defconfig:omap3-beagle
> >> arm:beaglexm:multi_v7_defconfig:omap3-beagle-xm
> >> arm:overo:multi_v7_defconfig:omap3-overo-tobi
> >> arm:beagle:omap2plus_defconfig:omap3-beagle
> >> arm:beaglexm:omap2plus_defconfig:omap3-beagle-xm
> >> arm:overo:omap2plus_defconfig:omap3-overo-tobi
> >>
> >> For details please see the 'next' column at http://server.roeck-us.net:8010/builders.
> >>
> >> Reverting the offending commit fixes the problems.
> >>
> >> Please let me know if there is anything I can do to help tracking down the problem.
> >
> > The following fixes the booting, but I wonder if it's a
> > proper fix?
> >
> > --- a/drivers/base/power/common.c
> > +++ b/drivers/base/power/common.c
> > @@ -145,9 +145,10 @@ void dev_pm_domain_set(struct device *dev, struct dev_pm_domain *pd)
> >  {
> >         if (dev->pm_domain == pd)
> >                 return;
> > -
> > -       WARN(device_is_bound(dev),
> > -            "PM domains can only be changed for unbound devices\n");
> > +       if (device_is_registered(dev)) {
> > +               WARN(device_is_bound(dev),
> > +                    "PM domains can only be changed for unbound devices\n");
> > +       }
> >         dev->pm_domain = pd;
> >         device_pm_check_callbacks(dev);
> 
> Commit 989561de9b51 ("PM / Domains: add setter for dev.pm_domain")
> causes issues for me after doing a 'reboot' command.
> 
> Rafael proposed a patch which fixed the 'reboot' problem:
> http://www.spinics.net/lists/arm-kernel/msg473562.html

Looks like a different problem.

Guenter
