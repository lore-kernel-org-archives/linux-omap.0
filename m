From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCHv2] thermal: add omap3 support
Date: Fri, 13 Mar 2015 20:40:25 +0100
Message-ID: <20150313194025.GA22182@amd>
References: <20150103111146.GB7065@amd>
 <20150118202824.GB29014@amd>
 <20150313050300.GA30104@developer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150313050300.GA30104@developer>
Sender: linux-pm-owner@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: rui.zhang@intel.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-omap@vger.kernel.org, pali.rohar@gmail.com, sre@debian.org, sre@ring0.de, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, tony@atomide.com, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com
List-Id: linux-omap@vger.kernel.org

Hi!

> > @@ -384,25 +385,10 @@ int ti_bandgap_set_sensor_data(struct ti_bandgap *bgp, int id, void *data);
> >  void *ti_bandgap_get_sensor_data(struct ti_bandgap *bgp, int id);
> >  int ti_bandgap_get_trend(struct ti_bandgap *bgp, int id, int *trend);
> >  
> > -#ifdef CONFIG_OMAP4_THERMAL
> > +extern const struct ti_bandgap_data omap34xx_data;
> >  extern const struct ti_bandgap_data omap4430_data;
> >  extern const struct ti_bandgap_data omap4460_data;
> >  extern const struct ti_bandgap_data omap4470_data;
> > -#else
> > -#define omap4430_data					NULL
> > -#define omap4460_data					NULL
> > -#define omap4470_data					NULL
> > -#endif
> > -
> > -#ifdef CONFIG_OMAP5_THERMAL
> >  extern const struct ti_bandgap_data omap5430_data;
> > -#else
> > -#define omap5430_data					NULL
> > -#endif
> > -
> > -#ifdef CONFIG_DRA752_THERMAL
> >  extern const struct ti_bandgap_data dra752_data;
> > -#else
> > -#define dra752_data					NULL
> > -#endif
> 
> Pavel,
> 
> Why do we need to remove the existing symbols for other chips in this file to get OMAP3 support in?
> 

No, I don't need to remove this, and you can safely drop this hunk.

OTOH those ifdefs are unneccessary and eye-sore: extern symbol
declarations do not really hurt, and .c files already contain enough
#ifdefs for other reasons that the symbols will not be needed when it
is not configured.

Try it, it should work ok.

Best regards,
								Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
