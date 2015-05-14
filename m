From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH 2/5] PM / Wakeirq: Add automated device wake IRQ handling
Date: Thu, 14 May 2015 11:51:10 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1505141145530.1107-100000@iolanthe.rowland.org>
References: <20150514020634.GB20006@saruman.tx.rr.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150514020634.GB20006@saruman.tx.rr.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Andreas Fenkart <afenkart@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Huiquan Zhong <huiquan.zhong@intel.com>, Kevin Hilman <khilman@kernel.org>, NeilBrown <neilb@suse.de>, Mika Westerberg <mika.westerberg@linux.intel.com>, Nishanth Menon <nm@ti.com>, Peter Hurley <peter@hurleysoftware.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Ulf Hansson <ulf.hansson@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Wed, 13 May 2015, Felipe Balbi wrote:

> This brings up a question, actually. What to do with devices which were
> already runtime suspended when user initiated suspend-to-ram ? Do we
> leave wakeups enabled, or do we revisit device_may_wakeup() and
> conditionally runtime_resume the device, disable wakeup, and let its
> ->suspend() callback be called ?

In theory, the subsystem/device drivers already have code do this.  
They're supposed to, anyway.  The USB host stack does it in
drivers/usb/core/driver.c:choose_wakeup().

Alan Stern
