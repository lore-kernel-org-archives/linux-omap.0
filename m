From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/9] regulator: helper routine to extract
 regulator_init_data
Date: Fri, 30 Sep 2011 11:49:47 +0100
Message-ID: <20110930104947.GF2085@sirena.org.uk>
References: <1317118372-17052-1-git-send-email-rnayak@ti.com>
 <1317118372-17052-3-git-send-email-rnayak@ti.com>
 <20110927121003.GB4289@opensource.wolfsonmicro.com>
 <4E81E224.2070408@ti.com>
 <20110927150511.GM4289@opensource.wolfsonmicro.com>
 <4E854532.6080605@ti.com>
 <4E85768C.6050601@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cassiel.sirena.org.uk ([80.68.93.111]:35863 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754032Ab1I3Ktt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 30 Sep 2011 06:49:49 -0400
Content-Disposition: inline
In-Reply-To: <4E85768C.6050601@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: "Nayak, Rajendra" <rnayak@ti.com>, "patches@linaro.org" <patches@linaro.org>, "tony@atomide.com" <tony@atomide.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "grant.likely@secretlab.ca" <grant.likely@secretlab.ca>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Girdwood, Liam" <lrg@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Fri, Sep 30, 2011 at 09:58:04AM +0200, Cousson, Benoit wrote:

> I think as well that we should avoid considering a regulator with
> several outputs. I saw the same pattern used for the clock binding
> in DT as well.

This binding is for the consumer side, not the producer side.  A binding
which restricted us to a single consumer per regulator would obviously
not work for real systems.
