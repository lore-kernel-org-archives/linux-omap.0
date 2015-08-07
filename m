From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 07/13] twl4030_charger: distinguish between USB current
 and 'AC' current
Date: Thu, 6 Aug 2015 21:21:19 -0700
Message-ID: <20150807042118.GJ4215@atomide.com>
References: <20150730001113.4012.18086.stgit@noble>
 <20150730001124.4012.48552.stgit@noble>
 <20150807031116.GH4215@atomide.com>
 <20150807134525.251528ab@home.neil.brown.name>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150807134525.251528ab@home.neil.brown.name>
Sender: linux-pm-owner@vger.kernel.org
To: NeilBrown <neil@brown.name>
Cc: Sebastian Reichel <sre@kernel.org>, Samuel Ortiz <sameo@linux.intel.com>, linux-pm@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>, linux-kernel@vger.kernel.org, real GTA04 owners <gta04-owner@goldelico.com>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, Pavel Machek <pavel@ucw.cz>, linux-omap@vger.kernel.org, Lee Jones <lee.jones@linaro.org>
List-Id: linux-omap@vger.kernel.org

* NeilBrown <neil@brown.name> [150806 20:48]:
> 
> Thanks, I did get notified about that by Fengguang's test robot, but
> it's still on my list....
> 
> I guess making CHARGER_TWL4030 auto-select TWL4030_MADC would not be
> acceptable?  That would pull in IIO (it didn't use to...).
> 
> If this OK?

Looks OK to me thanks:

Acked-by: Tony Lindgren <tony@atomide.com>
