From: Tony Lindgren <tony@atomide.com>
Subject: Re: PM regression with commit 5de85b9d57ab PM runtime re-init in
 v4.5-rc1
Date: Fri, 5 Feb 2016 11:10:42 -0800
Message-ID: <20160205191042.GT19432@atomide.com>
References: <CAPDyKFpRnmn+h_VH3jtC3u-BOf7-00nbzD30omaxaaZOOAK8Gg@mail.gmail.com>
 <Pine.LNX.4.44L0.1602041702550.1515-100000@iolanthe.rowland.org>
 <CAPDyKFrMZYdeun67FBXdWL16DBOuO16qqOxRsks3QBJhNB8SoQ@mail.gmail.com>
 <20160205010810.GR19432@atomide.com>
 <CAPDyKFoawbrj3w_+2p5ugjByrwxwmA1S2God1VAvkRbh2rUtjg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAPDyKFoawbrj3w_+2p5ugjByrwxwmA1S2God1VAvkRbh2rUtjg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Alan Stern <stern@rowland.harvard.edu>, "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Kevin Hilman <khilman@baylibre.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

* Ulf Hansson <ulf.hansson@linaro.org> [160204 22:55]:
> On 5 February 2016 at 02:08, Tony Lindgren <tony@atomide.com> wrote:
> > * Ulf Hansson <ulf.hansson@linaro.org> [160204 14:35]:
> >> On 4 February 2016 at 23:09, Alan Stern <stern@rowland.harvard.edu> wrote:
> >> > On Thu, 4 Feb 2016, Ulf Hansson wrote:
> >> >
> >> >> I am really not questioning the autosuspend feature at all, it's a
> >> >> really great feature!
> >> >>
> >> >> Now, I question the minor benefit we actually gain from having the
> >> >> runtime PM core to update the mark in rpm_resume().
> >> >
> >> > As Tony pointed out, it prevents some devices from going to sleep right
> >> > away.
> >>
> >> Because their drivers don't care to update the last busy mark!?
> >
> > Nope. Without that devices may never resume at all so the drivers
> > can't do anything about it.
> 
> I don't get it. Why not? Because of another abuse of the runtime PM API?

I think you should be able to test this case in your test driver by
calling pm_runtime_resume() for your test driver after your
test drive has autosuspended. Probably you need some delayed_work to
do this in your test driver unless you have some test bus to go with it.

> Or we should probably continue to focus on fixing the regression. :-)

Naturally we should fix up things yeah :) Having a test driver
that works on any architecture sure makes things easier to verify.

Regards,

Tony
