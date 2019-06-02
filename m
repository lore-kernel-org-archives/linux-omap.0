From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 1/2] phy: core: Add phy_pm_runtime_enabled
Date: Sun, 2 Jun 2019 12:25:41 +0200
Message-ID: <20190602102541.GA12625@atrey.karlin.mff.cuni.cz>
References: <20181117133755.9129-1-tony@atomide.com>
 <20181117133755.9129-2-tony@atomide.com>
 <20181117153845.GU19900@localhost>
 <20181117154353.GM53235@atomide.com>
 <20190602101434.GA1126@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190602101434.GA1126@atrey.karlin.mff.cuni.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Johan Hovold <johan@kernel.org>, Kishon Vijay Abraham I <kishon@ti.com>, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, Sebastian Reichel <sre@kernel.org>
List-Id: linux-omap@vger.kernel.org

Hi!

> > > > @@ -240,6 +241,11 @@ static inline int phy_pm_runtime_put_sync(struct phy *phy)
> > > >  	return -ENOSYS;
> > > >  }
> > > >  
> > > > +static inline bool phy_pm_runtime_enabled(struct phy *phy)
> > > > +{
> > > > +	return false
> > > 
> > > Missing semicolon.
> > 
> > Oops thanks for catching that. I guess I did not try building
> > without CONFIG_GENERIC_PHY. Will fix and repost.
> 
> Did this series get lost/forgotten somewhere? Is it still needed? Any
> way I can help?

Aha, it seems v2 of the series was applied, which touches different
files and that's why I did not detect it. Sorry for the noise.

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
