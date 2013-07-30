From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/4] usb: phy: rename nop_usb_xceiv => usb_phy_gen_xceiv
Date: Tue, 30 Jul 2013 00:56:51 -0700
Message-ID: <20130730075650.GI7656@atomide.com>
References: <1374869757-923-1-git-send-email-bigeasy@linutronix.de>
 <1374869757-923-2-git-send-email-bigeasy@linutronix.de>
 <20130729122022.GF24801@radagast>
 <20130730070814.GF7656@atomide.com>
 <51F76C90.90207@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <51F76C90.90207@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Felipe Balbi <balbi@ti.com>, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, george.cherian@ti.com, Linux OMAP Mailing List <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

* Sebastian Andrzej Siewior <bigeasy@linutronix.de> [130730 00:41]:
> On 07/30/2013 09:08 AM, Tony Lindgren wrote:
> > Looking at this patch there's a pretty high probability of introducing
> > pointless merge conflicts.
> > 
> > How about do the platform data related changes as a separate follow-up
> > series? You can typically do this by keeping the old features around,
> > then doing a separate series to rename or remove the users later on.
> > This will remove the dependency between platform data and the driver
> > changes.
> 
> I can do this. This will work of for the driver name but not for the
> name the platform_data struct. To address this part you could create a
> separate branch on top of -rc3 or so which contains only this change(s)
> and Felipe and you merge this branch so there won't be any conflicts.

A separate minimal branch against -rc3 sounds good to me.

Regards,

Tony
