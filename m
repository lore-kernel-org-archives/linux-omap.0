From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 01/13] twl4030_charger: use runtime_pm to keep usb phy
 active while charging.
Date: Tue, 15 Sep 2015 13:29:04 +0200
Message-ID: <20150915112904.GB10704@amd>
References: <20150730001113.4012.18086.stgit@noble>
 <20150730001124.4012.41690.stgit@noble>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150730001124.4012.41690.stgit@noble>
Sender: linux-pm-owner@vger.kernel.org
To: NeilBrown <neil@brown.name>
Cc: Sebastian Reichel <sre@kernel.org>, Samuel Ortiz <sameo@linux.intel.com>, linux-pm@vger.kernel.org, Tony Lindgren <tony@atomide.com>, David Woodhouse <dwmw2@infradead.org>, linux-kernel@vger.kernel.org, real GTA04 owners <gta04-owner@goldelico.com>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, linux-omap@vger.kernel.org, Lee Jones <lee.jones@linaro.org>
List-Id: linux-omap@vger.kernel.org

On Thu 2015-07-30 10:11:24, NeilBrown wrote:
> The twl4030 usb phy needs to be active while we are using
> the USB VBUS as a current source for charging.
> In particular, the usb3v1 regulator must be enabled and the
> PHY_PWR_PHYPWD bit must be set to keep the phy powered.
> 
> commit ab37813f4093a5f59cb8e083cde277289dc72ed3
>     twl4030_charger: Allow charger to control the regulator that feeds it
> 
> gave the charger control over the regulator, but didn't resolve
> the PHY_PWR_PHYPWD issue.
> 
> Now that both of these are controlled by runtime_pm in
> phy-twl4030-usb, we can simply take a runtime_pm reference to the USB
> phy whenever the charger wants to use it as a current source.
> 
> So this patch reverts the above commit, and adds the necessary
> runtime_pm calls.
> 
> Acked-by: Lee Jones <lee.jones@linaro.org>
> Signed-off-by: NeilBrown <neil@brown.name>

Acked-by: Pavel Machek <pavel@ucw.cz>

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
