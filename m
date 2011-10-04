From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 2/9] regulator: helper routine to extract
 regulator_init_data
Date: Tue, 4 Oct 2011 17:48:05 -0600
Message-ID: <20111004234805.GJ3009@ponder.secretlab.ca>
References: <1317118372-17052-1-git-send-email-rnayak@ti.com>
 <1317118372-17052-3-git-send-email-rnayak@ti.com>
 <20110927121003.GB4289@opensource.wolfsonmicro.com>
 <20111004230127.GB32102@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:33311 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933860Ab1JDXso (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 4 Oct 2011 19:48:44 -0400
Received: by ggnv2 with SMTP id v2so479001ggn.19
        for <linux-omap@vger.kernel.org>; Tue, 04 Oct 2011 16:48:43 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20111004230127.GB32102@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Rajendra Nayak <rnayak@ti.com>, b-cousson@ti.com, patches@linaro.org, tony@atomide.com, devicetree-discuss@lists.ozlabs.org, linux-omap@vger.kernel.org, lrg@ti.com, linux-arm-kernel@lists.infradead.org

On Wed, Oct 05, 2011 at 12:01:27AM +0100, Russell King - ARM Linux wrote:
> On Tue, Sep 27, 2011 at 01:10:04PM +0100, Mark Brown wrote:
> > On Tue, Sep 27, 2011 at 03:42:45PM +0530, Rajendra Nayak wrote:
> > 
> > > +	init_data = devm_kzalloc(dev, sizeof(struct regulator_init_data),
> > > +						 GFP_KERNEL);
> > > +	if (!init_data)
> > > +		return NULL; /* Out of memory? */
> > 
> > This means that the init data will be kept around for the entire
> > lifetime of the device rather than being discarded.
> 
> May I remind you that devm_* lifetime expires whenever the associated
> driver is unbound, which can be much shorter than the lifetime of the
> struct device.
> 
> It expires when any of the following occurs:
> 1. userspace asks the associated driver to be unbound
> 2. the driver is removed
> 3. any driver probe for this struct device fails
> 4. the struct device is unregistered.
> 
> So: don't use devm_* for anything other than stuff inside a driver being
> associated with the struct device itself.  Other uses are a bug waiting
> to happen.

Yes, Russell is right.  There were a number of places where I
suggested using devm_* in entirely the wrong places.  Double check
anyplace where you've added devm_ calls.

g.

