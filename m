From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/9] regulator: helper routine to extract
 regulator_init_data
Date: Fri, 30 Sep 2011 11:28:49 +0100
Message-ID: <20110930102849.GA4195@opensource.wolfsonmicro.com>
References: <1317118372-17052-1-git-send-email-rnayak@ti.com>
 <1317118372-17052-3-git-send-email-rnayak@ti.com>
 <20110927121003.GB4289@opensource.wolfsonmicro.com>
 <4E81E224.2070408@ti.com>
 <20110927150511.GM4289@opensource.wolfsonmicro.com>
 <4E854532.6080605@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:48684 "EHLO
	opensource.wolfsonmicro.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754109Ab1I3K2v (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 30 Sep 2011 06:28:51 -0400
Content-Disposition: inline
In-Reply-To: <4E854532.6080605@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: grant.likely@secretlab.ca, devicetree-discuss@lists.ozlabs.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com, lrg@ti.com, b-cousson@ti.com, patches@linaro.org

On Fri, Sep 30, 2011 at 09:57:30AM +0530, Rajendra Nayak wrote:

> Mark, I still seem to be a little confused with this one as to why
> we would need a phandle *and* a supply-name to reference a parent
> regulator/supply.
> The phandle would point to a regulator dt node and that node internally
> would have just one name associated with it.

To repeat: the supply name is for the consumer.  It is needed so that
the consumer can tell which supply is provided by which regulator.
Almost all devices have more than one supply and if the device does
anything more complicated than just turning on all the supplies when the
device is active it's going to need to figure out which supply is which.

Also, please do remember to keep linux-kernel in the loop on all
regulator API discussion - you should always keep the relevant mailing
lists in the loop for any subsystem you're changing.
