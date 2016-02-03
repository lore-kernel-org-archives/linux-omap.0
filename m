From: Tony Lindgren <tony@atomide.com>
Subject: Re: PM regression with commit 5de85b9d57ab PM runtime re-init in
 v4.5-rc1
Date: Wed, 3 Feb 2016 08:36:04 -0800
Message-ID: <20160203163604.GH19432@atomide.com>
References: <20160202210345.GZ19432@atomide.com>
 <Pine.LNX.4.44L0.1602021626540.1653-100000@iolanthe.rowland.org>
 <20160202234626.GD19432@atomide.com>
 <CAJZ5v0jbOJc2m=cBrvAuMUHvY8_AQPdJEyt1w-dPikU5expeLA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAJZ5v0jbOJc2m=cBrvAuMUHvY8_AQPdJEyt1w-dPikU5expeLA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Alan Stern <stern@rowland.harvard.edu>, Ulf Hansson <ulf.hansson@linaro.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Kevin Hilman <khilman@baylibre.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

* Rafael J. Wysocki <rafael@kernel.org> [160203 05:07]:
> On Wed, Feb 3, 2016 at 12:46 AM, Tony Lindgren <tony@atomide.com> wrote:
> >
> > Yes.. That works too. I guess the thing to consider is if we should
> > make pm_runtime_put_sync() always sync along the lines of a patch
> > I posted earlier today. That could avoid quite a bit of confusion
> > as already seen in this thread :)
> 
> No, we shouldn't.
> 
> As I said, the current behavior is actually well documented (in
> kerneldoc comments and elsewhere).

OK. I'll do a series of fixes to the drivers using omap_device.

Regards,

Tony
