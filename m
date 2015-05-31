From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 3/5] serial: omap: Switch wake-up interrupt to generic
 wakeirq
Date: Sun, 31 May 2015 16:16:34 +0900
Message-ID: <20150531071634.GA9051@kroah.com>
References: <1431560196-5722-1-git-send-email-tony@atomide.com>
 <1431560196-5722-4-git-send-email-tony@atomide.com>
 <20150528145616.GG30984@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150528145616.GG30984@atomide.com>
Sender: linux-pm-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Andreas Fenkart <afenkart@gmail.com>, Felipe Balbi <balbi@ti.com>, Huiquan Zhong <huiquan.zhong@intel.com>, Kevin Hilman <khilman@kernel.org>, NeilBrown <neilb@suse.de>, Mika Westerberg <mika.westerberg@linux.intel.com>, Nishanth Menon <nm@ti.com>, Peter Hurley <peter@hurleysoftware.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Ulf Hansson <ulf.hansson@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, linux-omap@vger.kernel.org, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Alan Stern <stern@rowland.harvard.edu>
List-Id: linux-omap@vger.kernel.org

On Thu, May 28, 2015 at 07:56:16AM -0700, Tony Lindgren wrote:
> Hi Greg,
> 
> * Tony Lindgren <tony@atomide.com> [150513 16:38]:
> > We can now use generic wakeirq handling and remove the custom handling
> > for the wake-up interrupts.
> 
> How do you prefer to handle the two omap specific serial driver
> changes in this series?
> 
> There's a dependency to Rafael's pm-wakeirq branch that contains:
> 
> 4990d4fe327b ("PM / Wakeirq: Add automated device wake IRQ handling")
> 56f487c78015 ("PM / Runtime: Update last_busy in rpm_resume")
> f6a2fbb903d5 ("PM / runtime: add note about re-calling in during
> device probe()")
> 
> The 8250_omap.c driver change also needs to be merged with:
> 
> 9e91597f2423 ("serial: 8250_omap: provide complete custom startup &
> shutdown callbacks")
> 
> Not sure if 9e91597f2423 is immutable, but if so then I could:
> 
> a) Send you a pull request for the two serial driver patches
>    based on Rafael's pm-wakeirq branch merged with 9e91597f2423 to
>    avoid the merge conflict.
> 
> b) Apply both serial driver patches into omap-for-v4.2/wakeirq
>    based on Rafael's pm-wakeirq branch merged with 9e91597f2423.

That one sounds good to me, feel free to do so and add:

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

It's the easiest for everyone involved, right?

thanks,

greg k-h
