From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] PM / Wakeirq: Fix typo in prototype for dev_pm_set_dedicated_wake_irq
Date: Sat, 30 May 2015 03:16:37 +0200
Message-ID: <7288995.ybnnrBvNmJ@vostro.rjw.lan>
References: <1432918442-2043-1-git-send-email-tony@atomide.com> <20150529171837.GI2026@saruman.tx.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <20150529171837.GI2026@saruman.tx.rr.com>
Sender: linux-pm-owner@vger.kernel.org
To: balbi@ti.com
Cc: Tony Lindgren <tony@atomide.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Alan Stern <stern@rowland.harvard.edu>, Andreas Fenkart <afenkart@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Huiquan Zhong <huiquan.zhong@intel.com>, Kevin Hilman <khilman@kernel.org>, NeilBrown <neilb@suse.de>, Mika Westerberg <mika.westerberg@linux.intel.com>, Nishanth Menon <nm@ti.com>, Peter Hurley <peter@hurleysoftware.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Ulf Hansson <ulf.hansson@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, linux-omap@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>
List-Id: linux-omap@vger.kernel.org

On Friday, May 29, 2015 12:18:37 PM Felipe Balbi wrote:
> 
> --2fjX3cMESU3XgGmZ
> Content-Type: text/plain; charset=us-ascii
> Content-Disposition: inline
> Content-Transfer-Encoding: quoted-printable
> 
> On Fri, May 29, 2015 at 09:54:02AM -0700, Tony Lindgren wrote:
> > Looks like I only built test the dev_pm_set_wake_irq and not the
> > dev_pm_set_dedicated_wake_irq case on x86.
> >=20
> > Turns out there's a typo for the dev_pm_set_dedicated_wake_irq
> > prototype that causes a build error if CONFIG_COMPILE_TEST
> > and CONFIG_MMC_OMAP_HS are selected.
> >=20
> > Cc: Stephen Rothwell <sfr@canb.auug.org.au>
> > Cc: Ulf Hansson <ulf.hansson@linaro.org>
> > Reported-by: Jim Davis <jim.epost@gmail.com>
> > Signed-off-by: Tony Lindgren <tony@atomide.com>
> 
> cool:
> 
> Reviewed-by: Felipe Balbi <balbi@ti.com>

Applied, thanks!


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
