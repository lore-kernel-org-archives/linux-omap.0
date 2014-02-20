From: Jenny Tc <jenny.tc@intel.com>
Subject: Re: [PATCH 3/4] power_supply: Introduce PSE compliant algorithm
Date: Thu, 20 Feb 2014 10:46:55 +0530
Message-ID: <20140220051655.GB2498@jenny-desktop>
References: <1391490780-6141-1-git-send-email-jenny.tc@intel.com>
 <1391490780-6141-4-git-send-email-jenny.tc@intel.com>
 <20140204113640.GD2450@amd.pavel.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20140204113640.GD2450@amd.pavel.ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-kernel@vger.kernel.org, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, Anton Vorontsov <cbouatmailru@gmail.com>, Anton Vorontsov <anton.vorontsov@linaro.org>, Kim Milo <Milo.Kim@ti.com>, Lee Jones <lee.jones@linaro.org>, Jingoo Han <jg1.han@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Sachin Kamat <sachin.kamat@linaro.org>, Lars-Peter Clausen <lars@metafoo.de>, Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, Rhyland Klein <rklein@nvidia.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, David Woodhouse <dwmw2@infradead.org>, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, Sebastian Reichel <sre@ring0.de>, aaro.koskinen@iki.fi, Pallala Ramakrishna <ramakrishna.pallala@intel.com>, freemangordon@abv.bg, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Tue, Feb 04, 2014 at 12:36:40PM +0100, Pavel Machek wrote:
> > --- a/drivers/power/Kconfig
> > +++ b/drivers/power/Kconfig
> > @@ -22,6 +22,19 @@ config POWER_SUPPLY_CHARGER
> >  	  drivers to keep the charging logic outside and the charger driver
> >  	  just need to abstract the charger hardware.
> >  
> > +config POWER_SUPPLY_CHARGING_ALGO_PSE
> > +	bool "PSE compliant charging algorithm"
> > +	help
> > +	  Say Y here to select Product Safety Engineering (PSE) compliant
> > +	  charging algorithm. As per PSE standard the battery characteristics
> > +	  and thereby the charging rates can vary on different temperature
> > +	  zones. This config will enable PSE compliant charging algorithm with
> > +	  maintenance charging support. At runtime the algorithm will be
> > +	  selected by the psy charger driver based on the type of the battery
> > +	  charging profile.
> 
> Information where to expect PSE compliant chargers would be nice.

This algorithm can be used with non PSE compliant chargers also. This is a SW
based charging algorithm.

-Jenny
