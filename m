From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RFC][PATCH v2 4/4] OMAP4: PMIC: Update TWL mfd driver to
	create twl6030 regulators
Date: Tue, 4 Aug 2009 10:45:45 +0300
Message-ID: <20090804074544.GG24334@atomide.com>
References: <1248842173-21821-1-git-send-email-balajitk@ti.com> <20090803142356.GA4265@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:56455 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932542AbZHDHp4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 4 Aug 2009 03:45:56 -0400
Content-Disposition: inline
In-Reply-To: <20090803142356.GA4265@rakim.wolfsonmicro.main>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: balajitk@ti.com, linux-omap@vger.kernel.org, khilman@deeprootsystems.com, david-b@pacbell.net, linux-i2c@vger.kernel.org, sameo@openedhand.com, wim@iguana.be, timo.t.kokkonen@nokia.com, ben-linux@fluff.org, lrg@slimlogic.co.uk, Rajendra Nayak <rnayak@ti.com>

* Mark Brown <broonie@opensource.wolfsonmicro.com> [090803 17:23]:
> On Wed, Jul 29, 2009 at 10:06:13AM +0530, balajitk@ti.com wrote:
> 
> > -	if (twl_has_regulator()) {
> > +	if (twl_has_regulator() && is_class_twl4030()) {
> 
> is_class_twl4030() feels like it should have better namespacing, though
> having the part name in there means it's not actually an issue.

How about twl_is_4030()?
 
> > @@ -306,6 +306,7 @@ int twl_i2c_read(u8 mod_no, u8 *value, u8 reg, unsigned num_bytes);
> >  #define TWL4030_INT_PWR_EDR2		0x6
> >  #define TWL4030_INT_PWR_SIH_CTRL	0x7
> >  
> > +
> >  /*----------------------------------------------------------------------*/
> >  
> >  /* Power bus message definitions */
> 
> Random unrelated indentation change?
