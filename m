From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 2/9] regulator: helper routine to extract
	regulator_init_data
Date: Wed, 5 Oct 2011 00:01:27 +0100
Message-ID: <20111004230127.GB32102@n2100.arm.linux.org.uk>
References: <1317118372-17052-1-git-send-email-rnayak@ti.com> <1317118372-17052-3-git-send-email-rnayak@ti.com> <20110927121003.GB4289@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:34457 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933137Ab1JDXB7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 4 Oct 2011 19:01:59 -0400
Content-Disposition: inline
In-Reply-To: <20110927121003.GB4289@opensource.wolfsonmicro.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Rajendra Nayak <rnayak@ti.com>, b-cousson@ti.com, patches@linaro.org, tony@atomide.com, devicetree-discuss@lists.ozlabs.org, grant.likely@secretlab.ca, linux-omap@vger.kernel.org, lrg@ti.com, linux-arm-kernel@lists.infradead.org

On Tue, Sep 27, 2011 at 01:10:04PM +0100, Mark Brown wrote:
> On Tue, Sep 27, 2011 at 03:42:45PM +0530, Rajendra Nayak wrote:
> 
> > +	init_data = devm_kzalloc(dev, sizeof(struct regulator_init_data),
> > +						 GFP_KERNEL);
> > +	if (!init_data)
> > +		return NULL; /* Out of memory? */
> 
> This means that the init data will be kept around for the entire
> lifetime of the device rather than being discarded.

May I remind you that devm_* lifetime expires whenever the associated
driver is unbound, which can be much shorter than the lifetime of the
struct device.

It expires when any of the following occurs:
1. userspace asks the associated driver to be unbound
2. the driver is removed
3. any driver probe for this struct device fails
4. the struct device is unregistered.

So: don't use devm_* for anything other than stuff inside a driver being
associated with the struct device itself.  Other uses are a bug waiting
to happen.
