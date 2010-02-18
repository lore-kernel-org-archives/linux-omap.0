From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/2] twl6030: regulator: Fix vsel calculations in
 set/get voltage apis
Date: Thu, 18 Feb 2010 11:42:37 +0000
Message-ID: <20100218114237.GE3542@rakim.wolfsonmicro.main>
References: <1266420255-4307-1-git-send-email-rnayak@ti.com>
 <20100217161509.GA13324@rakim.wolfsonmicro.main>
 <5A47E75E594F054BAF48C5E4FC4B92AB03215B1039@dbde02.ent.ti.com>
 <20100218094814.GD3315@rakim.wolfsonmicro.main>
 <5A47E75E594F054BAF48C5E4FC4B92AB03215B1172@dbde02.ent.ti.com>
 <20100218104032.GA3542@rakim.wolfsonmicro.main>
 <5A47E75E594F054BAF48C5E4FC4B92AB03215B11D9@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:45902 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753397Ab0BRLml (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 18 Feb 2010 06:42:41 -0500
Content-Disposition: inline
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB03215B11D9@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Nayak, Rajendra" <rnayak@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Liam Girdwood <lrg@slimlogic.co.uk>, Samuel Ortiz <sameo@linux.intel.com>

On Thu, Feb 18, 2010 at 05:09:53PM +0530, Nayak, Rajendra wrote:

> Mark, I get your point. The table values were derived from what the spec
> suggests, but I agree that its confusing that in theory the formula
> suggests there could be more selectors than whats present in the table.

> I will check if its indeed possible to support all possible selectors
> between say a min/max range. And then have maybe seperate kind of tables
> for twl6030 which only specify min/max range and then use the formula to
> generate the right selector.

Another option if you do need the supported voltage list would be to
rename the table and have a separate function to do set on twl6030 which
makes the intended usage clear.
