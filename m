From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/2] phy: core: Add phy_pm_runtime_enabled
Date: Sat, 17 Nov 2018 07:43:53 -0800
Message-ID: <20181117154353.GM53235@atomide.com>
References: <20181117133755.9129-1-tony@atomide.com>
 <20181117133755.9129-2-tony@atomide.com>
 <20181117153845.GU19900@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181117153845.GU19900@localhost>
Sender: linux-kernel-owner@vger.kernel.org
To: Johan Hovold <johan@kernel.org>
Cc: Kishon Vijay Abraham I <kishon@ti.com>, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, Pavel Machek <pavel@ucw.cz>, Sebastian Reichel <sre@kernel.org>
List-Id: linux-omap@vger.kernel.org

* Johan Hovold <johan@kernel.org> [181117 15:38]:
> On Sat, Nov 17, 2018 at 05:37:54AM -0800, Tony Lindgren wrote:
> > The phy driver may need to check phy_pm_runtime_enabled() in suspend as
> > PM runtime for phy may be already disabled when phy power_off() is called.
> > 
> > Cc: Pavel Machek <pavel@ucw.cz>
> > Cc: Sebastian Reichel <sre@kernel.org>
> > Signed-off-by: Tony Lindgren <tony@atomide.com>
> > ---
> >  drivers/phy/phy-core.c  | 9 +++++++++
> >  include/linux/phy/phy.h | 6 ++++++
> >  2 files changed, 15 insertions(+)
> > 
> > diff --git a/drivers/phy/phy-core.c b/drivers/phy/phy-core.c
> > --- a/drivers/phy/phy-core.c
> > +++ b/drivers/phy/phy-core.c
> 
> > diff --git a/include/linux/phy/phy.h b/include/linux/phy/phy.h
> > --- a/include/linux/phy/phy.h
> > +++ b/include/linux/phy/phy.h
> > @@ -158,6 +158,7 @@ int phy_pm_runtime_get(struct phy *phy);
> >  int phy_pm_runtime_get_sync(struct phy *phy);
> >  int phy_pm_runtime_put(struct phy *phy);
> >  int phy_pm_runtime_put_sync(struct phy *phy);
> > +bool phy_pm_runtime_enabled(struct phy *phy);
> >  void phy_pm_runtime_allow(struct phy *phy);
> >  void phy_pm_runtime_forbid(struct phy *phy);
> >  int phy_init(struct phy *phy);
> > @@ -240,6 +241,11 @@ static inline int phy_pm_runtime_put_sync(struct phy *phy)
> >  	return -ENOSYS;
> >  }
> >  
> > +static inline bool phy_pm_runtime_enabled(struct phy *phy)
> > +{
> > +	return false
> 
> Missing semicolon.

Oops thanks for catching that. I guess I did not try building
without CONFIG_GENERIC_PHY. Will fix and repost.

Regards,

Tony
