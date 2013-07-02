From: Luciano Coelho <coelho@ti.com>
Subject: Re: [PATCH v2 4/9] wl12xx: use frequency instead of enumerations
 for pdata clocks
Date: Tue, 2 Jul 2013 23:14:44 +0300
Message-ID: <1372796084.21065.85.camel@cumari.coelho.fi>
References: <1372776948-24840-1-git-send-email-coelho@ti.com>
	 <1372776948-24840-5-git-send-email-coelho@ti.com>
	 <20130702153113.GF7013@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <20130702153113.GF7013@arwen.pp.htv.fi>
Sender: linux-doc-owner@vger.kernel.org
To: balbi@ti.com
Cc: linux-wireless@vger.kernel.org, tony@atomide.com, nsekhar@ti.com, mturquette@linaro.org, mark.rutland@arm.com, grant.likely@linaro.org, rob.herring@calxeda.com, devicetree-discuss@lists.ozlabs.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Tue, 2013-07-02 at 18:31 +0300, Felipe Balbi wrote:
> Hi,
> 
> On Tue, Jul 02, 2013 at 05:55:43PM +0300, Luciano Coelho wrote:
> > diff --git a/drivers/net/wireless/ti/wl12xx/main.c b/drivers/net/wireless/ti/wl12xx/main.c
> > index 1c627da..903dcb3 100644
> > --- a/drivers/net/wireless/ti/wl12xx/main.c
> > +++ b/drivers/net/wireless/ti/wl12xx/main.c
> > @@ -1701,6 +1701,42 @@ static struct ieee80211_sta_ht_cap wl12xx_ht_cap = {
> >  		},
> >  };
> >  
> > +static struct wl12xx_clock wl12xx_refclock_table[] = {
> 
> const
> 
> > +	{ 19200000,	false,	WL12XX_REFCLOCK_19	},
> > +	{ 26000000,	false,	WL12XX_REFCLOCK_26	},
> > +	{ 26000000,	true,	WL12XX_REFCLOCK_26_XTAL	},
> > +	{ 38400000,	false,	WL12XX_REFCLOCK_38	},
> > +	{ 38400000,	true,	WL12XX_REFCLOCK_38_XTAL	},
> > +	{ 52000000,	false,	WL12XX_REFCLOCK_52	},
> > +	{ 0,		false,	0 }
> > +};
> > +
> > +static struct wl12xx_clock wl12xx_tcxoclock_table[] = {
> 
> const

Duh! Thanks for noticing it.

--
Luca.

