From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 01/13] OMAP: Introduce a user list for each voltage
 domain instance in the voltage driver.
Date: Fri, 3 Sep 2010 18:30:47 +0100
Message-ID: <20100903173046.GA32226@rakim.wolfsonmicro.main>
References: <1282130412-12027-1-git-send-email-thara@ti.com>
 <1282130412-12027-2-git-send-email-thara@ti.com>
 <87eiddgjr7.fsf@deeprootsystems.com>
 <5A47E75E594F054BAF48C5E4FC4B92AB03291AD889@dbde02.ent.ti.com>
 <87r5ha3hlk.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:43392 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753821Ab0ICRat (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 3 Sep 2010 13:30:49 -0400
Content-Disposition: inline
In-Reply-To: <87r5ha3hlk.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "Gopinath, Thara" <thara@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "paul@pwsan.com" <paul@pwsan.com>, "Sripathy, Vishwanath" <vishwanath.bs@ti.com>, "Sawant, Anand" <sawant@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>, "thomas.petazzoni@free-electrons.com" <thomas.petazzoni@free-electrons.com>, Liam Girdwood <lrg@slimlogic.co.uk>

On Fri, Sep 03, 2010 at 09:41:11AM -0700, Kevin Hilman wrote:

> Like you, I'm no expert on the regulator framework internals, but it
> appears to have a pretty thorough system of constraints management that
> upon first glance seems to be a good fit for what we need.  It may need
> to be extended, but I would rather see us enhance the regulator
> framework than re-invent the constraints management.

This seems reasonable, the only thing I'm wary of with this stuff is
adding things to manage anything outside voltages since I'm not
convinced that the requirements of different processors for other things
are sufficiently well understood to make a simple abstraction.  

The only thing I can think you might need to do if this is just straight
voltage setting is re-add support for multiple consumers setting
voltages simultaneously (there was someone from Qualcomm talking about
that as well but I didn't see any patches from him) but the API side is
all there and the core support ought to be relatively straightforward.
