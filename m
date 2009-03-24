From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: How to test regulator driver?
Date: Tue, 24 Mar 2009 15:35:54 +0000
Message-ID: <20090324153554.GC5990@sirena.org.uk>
References: <20090309153250.GF13593@sirena.org.uk> <5A47E75E594F054BAF48C5E4FC4B92AB02FAFEEA01@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cassiel.sirena.org.uk ([80.68.93.111]:34909 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757273AbZCXPf5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 24 Mar 2009 11:35:57 -0400
Content-Disposition: inline
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB02FAFEEA01@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Aggarwal, Anuj" <anuj.aggarwal@ti.com>
Cc: Linux OMAP List <linux-omap@vger.kernel.org>, "Pillai, Manikandan" <mani.pillai@ti.com>

On Tue, Mar 24, 2009 at 05:14:58PM +0530, Aggarwal, Anuj wrote:

> I am seriously confused on how to fetch the struct device * in my
> consumer driver, for an already registered regulator. I am planning to
> use this consumer driver as a part of my CPU freq/CPU idle framework
> but I don't know what to pass in regulator_get.

Your consumer driver should not be using the struct device for the
regulator when calling regulator_get().  They should never need to know
anything about the struct device of the regulator that is providing a
supply to them.  The consumer should use a fixed device name and the
struct device for itself, these will then be resolved to an actual
regulator by the core based on the machine constraints.

In the specific case of cpufreq where there is no struct device for the
consumer use NULL when calling regulator_get().
