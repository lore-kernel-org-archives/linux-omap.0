From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 04/13] twl4030_charger: trust phy to determine when USB
 power is available.
Date: Tue, 15 Sep 2015 13:30:09 +0200
Message-ID: <20150915113009.GC10704@amd>
References: <20150730001113.4012.18086.stgit@noble>
 <20150730001124.4012.85912.stgit@noble>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150730001124.4012.85912.stgit@noble>
Sender: linux-pm-owner@vger.kernel.org
To: NeilBrown <neil@brown.name>
Cc: Sebastian Reichel <sre@kernel.org>, Samuel Ortiz <sameo@linux.intel.com>, linux-pm@vger.kernel.org, Tony Lindgren <tony@atomide.com>, David Woodhouse <dwmw2@infradead.org>, linux-kernel@vger.kernel.org, real GTA04 owners <gta04-owner@goldelico.com>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, linux-omap@vger.kernel.org, Lee Jones <lee.jones@linaro.org>
List-Id: linux-omap@vger.kernel.org

On Thu 2015-07-30 10:11:24, NeilBrown wrote:
> The usb phy driver already determines when VBUS is available,
> so repeating the test in the charger driver is pointless duplication.
> 
> On probe, process the last event from the phy, and from then on,
> do whatever the phy tells us without double-checking.
> 
> Signed-off-by: NeilBrown <neil@brown.name>

Acked-by: Pavel Machek <pavel@ucw.cz>

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
