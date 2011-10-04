From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/9] regulator: helper routine to extract
 regulator_init_data
Date: Tue, 4 Oct 2011 11:18:47 +0100
Message-ID: <20111004101846.GD3250@opensource.wolfsonmicro.com>
References: <1317118372-17052-3-git-send-email-rnayak@ti.com>
 <20110927121003.GB4289@opensource.wolfsonmicro.com>
 <4E81E224.2070408@ti.com>
 <20110927150511.GM4289@opensource.wolfsonmicro.com>
 <4E854532.6080605@ti.com>
 <20110930102849.GA4195@opensource.wolfsonmicro.com>
 <20110930104820.GE2085@sirena.org.uk>
 <4E85A34E.9070203@ti.com>
 <20110930121844.GI5366@opensource.wolfsonmicro.com>
 <4E8A9988.3080907@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:42664 "EHLO
	opensource.wolfsonmicro.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755670Ab1JDKSw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 4 Oct 2011 06:18:52 -0400
Content-Disposition: inline
In-Reply-To: <4E8A9988.3080907@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: b-cousson@ti.com, patches@linaro.org, tony@atomide.com, devicetree-discuss@lists.ozlabs.org, grant.likely@secretlab.ca, linux-omap@vger.kernel.org, lrg@ti.com, linux-arm-kernel@lists.infradead.org

On Tue, Oct 04, 2011 at 10:58:40AM +0530, Rajendra Nayak wrote:

> The problem is I don't know if the property in the regulator dt
> node is called "vin-supply" or "vxyz-supply" and hence I
> can parse the property based on a substring alone, which is
> "-supply" because all I know is the property name is expected
> to end with a "-supply".

This seems fairly straightforward though it will require some changes
within Linux, all we have to do is have the regulators name their
supplies.
