From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/4] usb: phy: rename nop_usb_xceiv => usb_phy_gen_xceiv
Date: Tue, 30 Jul 2013 00:08:14 -0700
Message-ID: <20130730070814.GF7656@atomide.com>
References: <1374869757-923-1-git-send-email-bigeasy@linutronix.de>
 <1374869757-923-2-git-send-email-bigeasy@linutronix.de>
 <20130729122022.GF24801@radagast>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20130729122022.GF24801@radagast>
Sender: linux-kernel-owner@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, george.cherian@ti.com, Linux OMAP Mailing List <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

* Felipe Balbi <balbi@ti.com> [130729 05:27]:
> On Fri, Jul 26, 2013 at 10:15:54PM +0200, Sebastian Andrzej Siewior wrote:
> > The "nop" driver isn't a do-nothing-stub but supports a couple functions
> > like clock on/off or is able to use a voltage regulator. This patch
> > simply renames the driver to "generic" since it is easy possible to
> > extend it by a simple function istead of writing a complete driver.
> > 
> > Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> 
> to me, this is great but I need Tony's Ack for it. Let's Cc Tony and
> linux-omap

Looking at this patch there's a pretty high probability of introducing
pointless merge conflicts.

How about do the platform data related changes as a separate follow-up
series? You can typically do this by keeping the old features around,
then doing a separate series to rename or remove the users later on.
This will remove the dependency between platform data and the driver
changes.

Regards,

Tony
