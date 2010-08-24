From: "Menon, Nishanth" <nm@ti.com>
Subject: RE: [PM-OPP][PATCH] OMAP: Modifying the frequency comparison logic.
Date: Tue, 24 Aug 2010 14:51:12 -0500
Message-ID: <7A436F7769CA33409C6B44B358BFFF0C014062250C@dlee02.ent.ti.com>
References: <1281758292-18895-1-git-send-email-thara@ti.com>
 <87occromt4.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:60982 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751717Ab0HXTvP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 24 Aug 2010 15:51:15 -0400
In-Reply-To: <87occromt4.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>, "Gopinath, Thara" <thara@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>


> -----Original Message-----
> From: Kevin Hilman [mailto:khilman@deeprootsystems.com]
> Sent: Tuesday, August 24, 2010 2:04 PM


> 
> thara gopinath <thara@ti.com> writes:
> 
> > From: Thara Gopinath <thara@ti.com>
> >
> > In the current opp layer the frequency matching API's
> > tries to match the exact frequency passed in Hz. This leads
> > to problems in cases where dplls are locked to slightly differnet
> > frequencies due to sys clock speed or optimum M,N values.
> > Consider the following scenario
> > 	a. dpll_x is supposed to be locked at 266Mhz but is
> > 	   actually att 266.045 Mhz due to above mentioned reasons.
> > 	b. The opp table has the entry as 266000000 hz.
> > 	c. The user does a clk_get_rate(dpll_x) and passes the
> > 	  corresponding rate <rate> into the opp API's to get back
> > 	  a opp table entry.
> > 	d. In this scenario if  the user has called into
> > 	   opp_find_freq_exact it will return an error.
> > 	   If the user has called into opp_find_freq_ceil
> > 	   it will either return the opp entry corresponding
> > 	   to the next higher frequency in the opp table
> > 	   or return an error if 266 Mhz is the last entry
> > 	   in the table.
> >
> > The above is not correct as we expect the framework to return back
> > the opp table entry corresponding to 266 Mhz.
> >
> > Now there are two ways of fixing this issue.
> > 	a. Put the correct dpll lock frequency in the opp table.
> > 	   This means opp table will now have entries like 266045000 hz.
> > 	   But this is not scalable as these dpll lock frequencies
> > 	   can change slightly based on sys clk speeds. Like for eg
> > 	   at sys clk speed 38.4 Mhz we will able to get 266.045 Mhz
> > 	   where as at sys clk speed 26 Mhz we will be able to get
> > 	   onyl 266.124 Mhz etc. So depending on the platform we
> > 	   will have to start changing the opp table.
> >
> > 	b. Do the comparison in Mhz in the opp layer rather than in Hz.
> > 	   This would mean we will divide the rate passed into the opp layer
> > 	  API and the rates stored in the opp tables by 1000000 to get the
> > 	  rates in Mhz and do the necessary comparision. In this approach
> any
> > 	  vague frequency like 266.045Mhz will get mapped to 266 Mhz in the
> > 	  opp table. But if the passed rate is 267 Mhz, the opp framework
> > 	  will still rerturn an error or the next highest opp table entry
> >
> > This patch implements solution b. The scenario mentioned above is
> > esp true for OMAP4 dpll_iva where we do end up with such weird
> frequencies
> > due to sys clk being at 38.4 Mhz.
> 
> I agree that solution b is better, although it makes the '_exact'
> function a bit less exact. :/
> 
> solution b is fine with me, but the kerneldoc for these find functions
> should be updated to describe the new matching technique.

I agree, I suggest one improvement though - the search accuracy will vary
Based on the silicon rev, one size will probably not fit every silicon and
Domains we have - I suggest having accuracy as a parameter as part of domain
Registration/configurable parameter
e.g.
> > +			unsigned long rate = temp_opp->rate / 1000000;
Will probably configurable to the "exactness" we expect to handle per domain/silicon family.


> 
> Kevin
> 
> > Signed-off-by: Thara Gopinath <thara@ti.com>
> > ---
> >  arch/arm/plat-omap/opp.c |   37 ++++++++++++++++++++++++++-----------
> >  1 files changed, 26 insertions(+), 11 deletions(-)
> >
> > diff --git a/arch/arm/plat-omap/opp.c b/arch/arm/plat-omap/opp.c
> > index b9b7bda..ba7a554 100644
> > --- a/arch/arm/plat-omap/opp.c
> > +++ b/arch/arm/plat-omap/opp.c
> > @@ -212,15 +212,20 @@ struct omap_opp *opp_find_freq_exact(struct device
> *dev,
> >  {
> >  	struct device_opp *dev_opp;
> >  	struct omap_opp *temp_opp, *opp = ERR_PTR(-ENODEV);
> > +	unsigned long req_freq = freq / 1000000;
> >
> >  	dev_opp = find_device_opp(dev);
> >  	if (IS_ERR(dev_opp))
> >  		return opp;
> >
> >  	list_for_each_entry(temp_opp, &dev_opp->opp_list, node) {
> > -		if (temp_opp->enabled && temp_opp->rate == freq) {
> > -			opp = temp_opp;
> > -			break;
> > +		if (temp_opp->enabled) {
> > +			unsigned long rate = temp_opp->rate / 1000000;
> > +
> > +			if (rate == req_freq) {
> > +				opp = temp_opp;
> > +				break;
> > +			}
> >  		}
> >  	}
> >
> > @@ -258,16 +263,21 @@ struct omap_opp *opp_find_freq_ceil(struct device
> *dev, unsigned long *freq)
> >  {
> >  	struct device_opp *dev_opp;
> >  	struct omap_opp *temp_opp, *opp = ERR_PTR(-ENODEV);
> > +	unsigned long req_freq = *freq / 1000000;
> >
> >  	dev_opp = find_device_opp(dev);
> >  	if (IS_ERR(dev_opp))
> >  		return opp;
> >
> >  	list_for_each_entry(temp_opp, &dev_opp->opp_list, node) {
> > -		if (temp_opp->enabled && temp_opp->rate >= *freq) {
> > -			opp = temp_opp;
> > -			*freq = opp->rate;
> > -			break;
> > +		if (temp_opp->enabled) {
> > +			unsigned long rate = temp_opp->rate / 1000000;
> > +
> > +			if (rate >= req_freq) {
> > +				opp = temp_opp;
> > +				*freq = opp->rate;
> > +				break;
> > +			}
> >  		}
> >  	}
> >
> > @@ -305,16 +315,21 @@ struct omap_opp *opp_find_freq_floor(struct device
> *dev, unsigned long *freq)
> >  {
> >  	struct device_opp *dev_opp;
> >  	struct omap_opp *temp_opp, *opp = ERR_PTR(-ENODEV);
> > +	unsigned long req_freq = *freq / 1000000;
> >
> >  	dev_opp = find_device_opp(dev);
> >  	if (IS_ERR(dev_opp))
> >  		return opp;
> >
> >  	list_for_each_entry_reverse(temp_opp, &dev_opp->opp_list, node) {
> > -		if (temp_opp->enabled && temp_opp->rate <= *freq) {
> > -			opp = temp_opp;
> > -			*freq = opp->rate;
> > -			break;
> > +		if (temp_opp->enabled) {
> > +			unsigned long rate = temp_opp->rate / 1000000;
> > +
> > +			if (rate <= req_freq) {
> > +				opp = temp_opp;
> > +				*freq = opp->rate;
> > +				break;
> > +			}
> >  		}
> >  	}


Regards,
Nishanth Menon

