From: Tony Lindgren <tony@atomide.com>
Subject: Re: libbattery was Re: [RFC PATCH 5/5] power: generic-adc-battery:
 Add capacity handling
Date: Wed, 18 Oct 2017 06:22:04 -0700
Message-ID: <20171018132204.GD4394@atomide.com>
References: <1501620926-22669-1-git-send-email-marek.belisko@open-nandra.com>
 <1501620926-22669-6-git-send-email-marek.belisko@open-nandra.com>
 <20170829101147.debhadzyfrxhkrvt@earth>
 <20170908113231.GJ18365@amd>
 <20171018122804.GA14376@amd>
 <61BFA8AF-657A-4AD7-A7AC-3E5DC3B7E83D@goldelico.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <61BFA8AF-657A-4AD7-A7AC-3E5DC3B7E83D@goldelico.com>
Sender: linux-pm-owner@vger.kernel.org
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: Pavel Machek <pavel@ucw.cz>, Sebastian Reichel <sebastian.reichel@collabora.co.uk>, pali.rohar@gmail.com, sre@kernel.org, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com, abcloriens@gmail.com, clayton@craftyguy.net, martijn@brixit.nl, sakari.ailus@linux.intel.com, Marek Belisko <marek.belisko@open-nandra.com>, robh+dt@kernel.org, linux-pm@vger.kernel.org, Marek Belisko <marek.belisko@gmail.com>
List-Id: linux-omap@vger.kernel.org

* H. Nikolaus Schaller <hns@goldelico.com> [171018 05:49]:
> > Am 18.10.2017 um 14:28 schrieb Pavel Machek <pavel@ucw.cz>:
> > 
> > So I started something, it is at.
> > 
> > https://github.com/pavelmachek/libbattery
> > 
> > My battery on n900 is currently uncalibrated (and charging), still it
> > gets some kind of estimation:
> > 
> > Battery -1 %
> > Seconds -1
> > State 1
> > Voltage 3.88 V
> > Battery 63 %
> > 
> > Of course, there's a lot more work to be done.
> 
> Nice start but not a solution to our problem.
> 
> Our problem is that people simply expect that for example https://packages.debian.org/wheezy/xfce/xfce4-battery-plugin
> displays the battery percentage.

I think we could make things compatible with various battery apps by
having libbattery write back the capacity percentage and time remaining
to the kernel driver via sysfs or a dev entry. Then the kernel interface
can just display the data to whatever apps.

Regards,

Tony
