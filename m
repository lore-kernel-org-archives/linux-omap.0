From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/9] regulator: helper routine to extract
 regulator_init_data
Date: Tue, 4 Oct 2011 12:51:54 +0100
Message-ID: <20111004115153.GL3250@opensource.wolfsonmicro.com>
References: <4E81E224.2070408@ti.com>
 <20110927150511.GM4289@opensource.wolfsonmicro.com>
 <4E854532.6080605@ti.com>
 <20110930102849.GA4195@opensource.wolfsonmicro.com>
 <20110930104820.GE2085@sirena.org.uk>
 <4E85A34E.9070203@ti.com>
 <20110930121844.GI5366@opensource.wolfsonmicro.com>
 <4E8A9988.3080907@ti.com>
 <20111004101846.GD3250@opensource.wolfsonmicro.com>
 <4E8AF090.4070304@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:39548 "EHLO
	opensource.wolfsonmicro.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755994Ab1JDLv4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 4 Oct 2011 07:51:56 -0400
Content-Disposition: inline
In-Reply-To: <4E8AF090.4070304@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: b-cousson@ti.com, patches@linaro.org, tony@atomide.com, devicetree-discuss@lists.ozlabs.org, grant.likely@secretlab.ca, linux-omap@vger.kernel.org, lrg@ti.com, linux-arm-kernel@lists.infradead.org

On Tue, Oct 04, 2011 at 05:10:00PM +0530, Rajendra Nayak wrote:
> On Tuesday 04 October 2011 03:48 PM, Mark Brown wrote:

> >This seems fairly straightforward though it will require some changes
> >within Linux, all we have to do is have the regulators name their
> >supplies.

> through dt? thats what the original bindings was doing.

I wouldn't expect it done through DT (except for things like the fixed
voltage regulator) - the driver should just know.
