From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCHv6 1/6] regulator: core: add support for external
 get/set_voltage
Date: Fri, 25 Nov 2011 19:20:32 +0200
Message-ID: <1322241632.13828.10.camel@sokoban>
References: <1322238562-19943-1-git-send-email-t-kristo@ti.com>
	 <1322238562-19943-2-git-send-email-t-kristo@ti.com>
	 <20111125165214.GG5315@opensource.wolfsonmicro.com>
Reply-To: <t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:51333 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751246Ab1KYRUi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 25 Nov 2011 12:20:38 -0500
In-Reply-To: <20111125165214.GG5315@opensource.wolfsonmicro.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: linux-omap@vger.kernel.org, khilman@ti.com, lrg@ti.com, gg@slimlogic.co.uk, rnayak@ti.com, b-cousson@ti.com

On Fri, 2011-11-25 at 16:52 +0000, Mark Brown wrote:
> On Fri, Nov 25, 2011 at 06:29:17PM +0200, Tero Kristo wrote:
> 
> Why is this only on the OMAP list?  Always CC the relevant discussion
> list for the subsystem, especially when proposing changes to the
> subsystem!
> 
> > Regulator users can now set override functions for get_voltage and
> > set_voltage. This is required by some regulators, which have two
> > alternate control paths. E.g., OMAP SMPS regulators can be controlled
> > either through the I2C interface or voltage processor control path,
> > which uses specialized hardware.
> 
> My basic reaction to this is "eew, ick".  Doing this with a runtime call
> just feels badly joined up, and there's nothing here which hands off the
> configuration between the various drivers involved in the transitions.
> We need to make sure that the voltage doesn't suddenly lurch around when
> doing transitions.

Would you feel better if we just hacked around with the twl-regulator
driver and added a compile time switch for the voltage get/set for smps
regulators?

> 
> There's also a lack of locking in the code which would seem to be
> required and I'd expect regulator_set_external_ctl() to return an error
> if it fails.

Well, I can add locking in to the code if you think this dynamic
approach would be something that is acceptable, and even useful for
someone. Either way, we need to do this somehow, it is just agreeing
what is the cleanest way to do it.

-Tero

