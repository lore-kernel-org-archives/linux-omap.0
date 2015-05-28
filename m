From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 5/5] mmc: omap_hsmmc: Change wake-up interrupt to use
 generic wakeirq
Date: Thu, 28 May 2015 07:36:43 -0700
Message-ID: <20150528143643.GF30984@atomide.com>
References: <1431560196-5722-1-git-send-email-tony@atomide.com>
 <1431560196-5722-6-git-send-email-tony@atomide.com>
 <CAPDyKFqsfVL1SG2uuQRx3g=8DeJ4W_RhZwEEeQwFedhwOnBjXA@mail.gmail.com>
 <55664873.2080604@intel.com>
 <20150527224500.GB30984@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150527224500.GB30984@atomide.com>
Sender: linux-pm-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Alan Stern <stern@rowland.harvard.edu>, Andreas Fenkart <afenkart@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Felipe Balbi <balbi@ti.com>, Huiquan Zhong <huiquan.zhong@intel.com>, Kevin Hilman <khilman@kernel.org>, NeilBrown <neilb@suse.de>, Mika Westerberg <mika.westerberg@linux.intel.com>, Nishanth Menon <nm@ti.com>, Peter Hurley <peter@hurleysoftware.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Thomas Gleixner <tglx@linutronix.de>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-serial@vger.kernel.org, linux-omap <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [150527 15:46]:
> * Rafael J. Wysocki <rafael.j.wysocki@intel.com> [150527 15:44]:
> > On 5/25/2015 10:38 AM, Ulf Hansson wrote:
> > >On 14 May 2015 at 01:36, Tony Lindgren <tony@atomide.com> wrote:
> > >>We can now use generic wakeirq handling and remove the custom handling
> > >>for the wake-up interrupts.
> > >>
> > >>Signed-off-by: Tony Lindgren <tony@atomide.com>
> > >Rafael, if you are fine with it, please take this one through your
> > >linux-pm tree.
> > >
> > >Acked-by: Ulf Hansson <ulf.hansson@linaro.org>
> > 
> > I thought that Tony would resubmit this one.  Tony?
> 
> OK I can queue it with Ulf's ack via arm-soc no problem.

I've applied this one now into omap-for-v4.2/wakeirq branch that's
based on Rafael's pm-wakeirq branch.

Regards,

Tony
