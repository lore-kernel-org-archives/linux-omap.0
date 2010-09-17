From: "Aguirre, Sergio" <saaguirre@ti.com>
Subject: RE: [PATCH] opp: introduce library for device-specific OPPs
Date: Fri, 17 Sep 2010 11:11:45 -0500
Message-ID: <A24693684029E5489D1D202277BE89447260B27A@dlee02.ent.ti.com>
References: <[PATCH 1/4] OMAP: introduce OPP layer for device-specific OPPs>
	<1284686973-13993-1-git-send-email-nm@ti.com>
	<A24693684029E5489D1D202277BE89447260B073@dlee02.ent.ti.com>
	<4C93898B.2070606@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <4C93898B.2070606@ti.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "Menon, Nishanth" <nm@ti.com>
Cc: Phil Carmody <ext-phil.2.carmody@nokia.com>, linux-doc <linux-doc@vger.kernel.org>, Kevin Hilman <khilman@deeprootsystems.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, "H. Peter Anvin" <hpa@zytor.com>, Jesse Barnes <jbarnes@virtuousgeek.org>, Randy Dunlap <rdunlap@xenotime.net>, Pavel Machek <pavel@ucw.cz>, "Chikkature Rajashekar, Madhusudhan" <madhu.cr@ti.com>, Andi Kleen <ak@linux.intel.com>, "Sripathy,
	Vishwanath" <vishwanath.bs@ti.com>, linux-pm <linux-pm@lists.linux-foundation.org>, "romit@ti.com" <romit@ti.com>, Matthew Garrett <mjg@redhat.com>, Len Brown <len.brown@intel.com>, Eduardo Valentin <eduardo.valentin@nokia.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-omap <linux-omap@vger.kernel.org>, "Gopinath, Thara" <thara@ti.com>, linux-arm <linux-arm-kernel@lists.infradead.org>, Linus Walleij <linus.walleij@stericsson.com>, Paul Walmsley <paul@pws>
List-Id: linux-omap@vger.kernel.org

Hi Nishanth,

> -----Original Message-----
> From: Menon, Nishanth
> Sent: Friday, September 17, 2010 10:30 AM
> To: Aguirre, Sergio
> Cc: linux-arm; lkml; Len Brown; Pavel Machek; Rafael J. Wysocki; Randy
> Dunlap; Jesse Barnes; Matthew Garrett; H. Peter Anvin; Andrew Morton;
> Benjamin Herrenschmidt; Martin K. Petersen; Andi Kleen; linux-pm; linux-
> doc; linux-omap; Cousson, Benoit; Chikkature Rajashekar, Madhusudhan; Phil
> Carmody; Granados Dorado, Roberto; Shilimkar, Santosh; Tero Kristo;
> Eduardo Valentin; Paul Walmsley; Romit Dasgupta; Premi, Sanjeev; Gopinath,
> Thara; Sripathy, Vishwanath; Linus Walleij; Kevin Hilman
> Subject: Re: [PATCH] opp: introduce library for device-specific OPPs
> 
> Aguirre, Sergio had written, on 09/17/2010 09:09 AM, the following:
> > Hi Nishanth,
> thanks for the review.. comments below..
> 

You're welcome!

My responses below.

> 
> [...]
> >> diff --git a/include/linux/opp.h b/include/linux/opp.h
> >> new file mode 100644
> >> index 0000000..94a552b
> >> --- /dev/null
> >> +++ b/include/linux/opp.h
> >> @@ -0,0 +1,136 @@
> >> +/*
> >> + * Generic OPP Interface
> >> + *
> >> + * Copyright (C) 2009-2010 Texas Instruments Incorporated.
> >> + *   Nishanth Menon
> >> + *   Romit Dasgupta <romit@ti.com>
> >> + * Copyright (C) 2009 Deep Root Systems, LLC.
> >> + *   Kevin Hilman
> >
> > Just curious why only Romit's e-mail address is there, and not Kevin's
> or
> > yours...
> 
> personal choice I guess, Romit prefered his email id added Kevin and I
> did not.

OK. No problem then :)

> 
> [...]
> 
> >> diff --git a/lib/opp.c b/lib/opp.c
> >> new file mode 100644
> >> index 0000000..650c8c3
> >> --- /dev/null
> >> +++ b/lib/opp.c
> >> @@ -0,0 +1,440 @@
> >> +/*
> >> + * Generic OPP Interface
> [...]
> >> +
> >> +/**
> >> + * struct device_opp - Device opp structure
> >> + * @node:    list node
> >> + * @dev:     device handle
> >> + * @opp_list:        list of opps
> >> + * @opp_count:       num opps
> >> + * @enabled_opp_count:       how many opps are actually enabled
> >> + *
> >> + * This is an internal datastructure maintaining the link to
> >> + * opps attached to a domain device. This structure is not
> >> + * meant to be shared with users as it private to opp layer.
> >
> > "... as it is private ..."
> thanks. will fix.
> [..]
> >> +/**
> >> + * opp_get_voltage() - Gets the voltage corresponding to an opp
> >> + * @opp:     opp for which voltage has to be returned for
> >> + *
> >> + * Return voltage in micro volt corresponding to the opp, else
> >> + * return 0
> >> + */
> >> +unsigned long opp_get_voltage(const struct opp *opp)
> >> +{
> >> +     if (unlikely(!opp || IS_ERR(opp)) || !opp->enabled) {
> >> +             pr_err("%s: Invalid parameters being passed\n",
> __func__);
> >> +             return 0;
> >
> > Shouldn't the case for !opp->enabled just return 0, without error
> reporting.
> >
> > IMHO, having an OPP disabled is not really a bug in params, and
> returning this, will misinform the user.. I think.
> >
> > What do you think?
> 
> I think we discussed it a little earlier in the chain
> http://marc.info/?t=128152609200064&r=1&w=2
> the operations of get_freq and get_voltage dont make sense to be used on
> a disabled OPP. if we are using it so, we need to report an error to the
> user and log it for debugging.
> 
> The intent is as follows:
> a) find_freq_exact is the function to use for finding the opp which is
> disabled (without the opp pointer, you cant query voltage and frequency
> anyways).
> b) to query this, you need to know the opp frequency anyways, so it
> makes no usage sense for get_freq or get_voltage to be able to be using
> a disabled opp.

Ok. I understand now.

> 
> Do we think it makes sense to add this info to the documentation as well?

Yeah, I think that would be good to see explained in the docs.

> 
> >
> >> +     }
> >> +
> >> +     return opp->u_volt;
> >> +}
> >> +
> >> +/**
> >> + * opp_get_freq() - Gets the frequency corresponding to an opp
> >> + * @opp:     opp for which frequency has to be returned for
> >> + *
> >> + * Return frequency in hertz corresponding to the opp, else
> >> + * return 0
> >> + */
> >> +unsigned long opp_get_freq(const struct opp *opp)
> >> +{
> >> +     if (unlikely(!opp || IS_ERR(opp)) || !opp->enabled) {
> >> +             pr_err("%s: Invalid parameters being passed\n",
> __func__);
> >> +             return 0;
> >
> > Similarly here.
> commented above.

Ok.

> 
> >
> >> +     }
> >> +
> >> +     return opp->rate;
> >> +}
> >> +
> >> +/**
> >> + * opp_get_opp_count() - Get number of opps enabled in the opp list
> >> + * @dev:     device for which we do this operation
> >> + *
> >> + * This functions returns the number of opps if there are any OPPs
> >
> > "This function returns.."
> Thanks. will fix in v2 post.
> 
> >
> >> enabled,
> >> + * else returns corresponding error value.
> >> + */
> >> +int opp_get_opp_count(struct device *dev)
> >> +{
> >> +     struct device_opp *dev_opp;
> >> +
> >> +     dev_opp = find_device_opp(dev);
> >> +     if (IS_ERR(dev_opp))
> >> +             return -ENODEV;
> >> +
> >> +     return dev_opp->enabled_opp_count;
> >> +}
> >> +
> >> +/**
> >> + * opp_find_freq_exact() - search for an exact frequency
> >> + * @dev:     device for which we do this operation
> >> + * @freq:    frequency to search for
> >> + * @enabled: enabled/disabled OPP to search for
> >> + *
> >> + * Searches for exact match in the opp list and returns handle to the
> >> matching
> >> + * opp if found, else returns ERR_PTR in case of error and should be
> >> handled
> >> + * using IS_ERR.
> >> + *
> >> + * Note: enabled is a modifier for the search. if enabled=true, then
> the
> >> match
> >> + * is for exact matching frequency and is enabled. if false, the match
> is
> >> for
> >> + * exact frequency which is disabled.
> >
> > That enabled var is ignored, which makes this explanation mismatch with
> the code behavior.
> >
> > Am I missing something?
> ouch.. you are correct.. it is a mistake that got introduced in one of
> the merges we did.. the matching check
> if (temp_opp->enabled && temp_opp->rate == freq) {
> should have been
> if (temp_opp->enabled == enabled && temp_opp->rate == freq) {
> 
> Thanks for catching it.
> 
> >
> >> + */
> >> +struct opp *opp_find_freq_exact(struct device *dev,
> >> +                                  unsigned long freq, bool enabled)
> >> +{
> >> +     struct device_opp *dev_opp;
> >> +     struct opp *temp_opp, *opp = ERR_PTR(-ENODEV);
> >> +
> >> +     dev_opp = find_device_opp(dev);
> >> +     if (IS_ERR(dev_opp))
> >> +             return opp;
> >> +
> >> +     list_for_each_entry(temp_opp, &dev_opp->opp_list, node) {
> >> +             if (temp_opp->enabled && temp_opp->rate == freq) {
> >> +                     opp = temp_opp;
> >> +                     break;
> >> +             }
> >> +     }
> >> +
> >> +     return opp;
> >> +}
> >> +
> >> +/**
> >> + * opp_find_freq_ceil() - Search for an rounded ceil freq
> >> + * @dev:     device for which we do this operation
> >> + * @freq:    Start frequency
> >> + *
> >> + * Search for the matching ceil *enabled* OPP from a starting freq
> >> + * for a domain.
> >> + *
> >> + * Returns *opp and *freq is populated with the match, else
> >> + * returns NULL opp if no match, else returns ERR_PTR in case of
> error.
> >
> > By looking at the code below, I don't think returning NULL is a
> possibility.
> yet another documentation error.. thanks for catching.
> ERR_PTR(-ENODEV) is returned instead of NULL..
> 
> how about "
> Returns *opp and *freq is populated with the match if found, else
> returns ERR_PTR in case of error and should be handled using IS_ERR.
> 
> "

I'll say:

"Returns matching *opp and refreshes *freq accordingly"

But is a matter of taste of words. :)


> >
> >> + *
> >> + * Example usages:
> >> + *   * find match/next highest available frequency *
> >> + *   freq = 350000;
> >> + *   opp = opp_find_freq_ceil(dev, &freq))
> >> + *   if (IS_ERR(opp))
> >> + *           pr_err("unable to find a higher frequency\n");
> >> + *   else
> >> + *           pr_info("match freq = %ld\n", freq);
> >> + *
> >> + *   * print all supported frequencies in ascending order *
> >> + *   freq = 0; * Search for the lowest enabled frequency *
> >> + *   while (!IS_ERR(opp = opp_find_freq_ceil(OPP_MPU, &freq)) {
> >> + *           pr_info("freq = %ld\n", freq);
> >> + *           freq++; * for next higher match *
> >> + *   }
> >> + */
> >> +struct opp *opp_find_freq_ceil(struct device *dev, unsigned long
> *freq)
> >> +{
> >> +     struct device_opp *dev_opp;
> >> +     struct opp *temp_opp, *opp = ERR_PTR(-ENODEV);
> >> +
> >> +     dev_opp = find_device_opp(dev);
> >> +     if (IS_ERR(dev_opp))
> >> +             return opp;
> >> +
> >> +     list_for_each_entry(temp_opp, &dev_opp->opp_list, node) {
> >> +             if (temp_opp->enabled && temp_opp->rate >= *freq) {
> >
> > What if freq contains a NULL pointer?
> thanks.. good catch.. should have checked for dev and freq on entry..
> added in the to be posted v2
> 
> >
> >> +                     opp = temp_opp;
> >> +                     *freq = opp->rate;
> >> +                     break;
> >> +             }
> >> +     }
> >> +
> >> +     return opp;
> >> +}
> >> +
> >> +/**
> >> + * opp_find_freq_floor() - Search for an rounded floor freq
> >
> > "... Search for a rounded floor ..."
> Thanks.. will fix in v2.
> 
> >
> >> + * @dev:     device for which we do this operation
> >> + * @freq:    Start frequency
> >> + *
> >> + * Search for the matching floor *enabled* OPP from a starting freq
> >> + * for a domain.
> >> + *
> >> + * Returns *opp and *freq is populated with the next match, else
> >> + * returns NULL opp if no match, else returns ERR_PTR in case of
> error.
> >
> > Similar comment about opp not being ever NULL as the function above.
> 
> Suggest replacing with:
> Returns *opp and *freq is populated with the match if found, else
> returns ERR_PTR in case of error and should be handled using IS_ERR.

Same comment as above.

Regards,
Sergio

> 
> [..]
> 
> --
> Regards,
> Nishanth Menon
