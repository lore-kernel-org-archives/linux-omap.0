From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCHv6 1/6] regulator: core: add support for external
 get/set_voltage
Date: Fri, 25 Nov 2011 17:29:45 +0000
Message-ID: <20111125172945.GJ5315@opensource.wolfsonmicro.com>
References: <1322238562-19943-1-git-send-email-t-kristo@ti.com>
 <1322238562-19943-2-git-send-email-t-kristo@ti.com>
 <20111125165214.GG5315@opensource.wolfsonmicro.com>
 <1322241632.13828.10.camel@sokoban>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:51549 "EHLO
	opensource.wolfsonmicro.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751883Ab1KYR3z (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 25 Nov 2011 12:29:55 -0500
Content-Disposition: inline
In-Reply-To: <1322241632.13828.10.camel@sokoban>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@ti.com, lrg@ti.com, gg@slimlogic.co.uk, rnayak@ti.com, b-cousson@ti.com

On Fri, Nov 25, 2011 at 07:20:32PM +0200, Tero Kristo wrote:
> On Fri, 2011-11-25 at 16:52 +0000, Mark Brown wrote:

> > My basic reaction to this is "eew, ick".  Doing this with a runtime call
> > just feels badly joined up, and there's nothing here which hands off the
> > configuration between the various drivers involved in the transitions.
> > We need to make sure that the voltage doesn't suddenly lurch around when
> > doing transitions.

> Would you feel better if we just hacked around with the twl-regulator
> driver and added a compile time switch for the voltage get/set for smps
> regulators?

No, that's clearly going to break multi-board kernel images.  If this
is something board specific platform/device tree data sounds like the
way forwards.
