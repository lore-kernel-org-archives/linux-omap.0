From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCHv6 1/6] regulator: core: add support for external
 get/set_voltage
Date: Fri, 25 Nov 2011 19:59:03 +0200
Message-ID: <1322243943.13828.13.camel@sokoban>
References: <1322238562-19943-1-git-send-email-t-kristo@ti.com>
	 <1322238562-19943-2-git-send-email-t-kristo@ti.com>
	 <20111125165214.GG5315@opensource.wolfsonmicro.com>
	 <1322241632.13828.10.camel@sokoban>
	 <20111125172945.GJ5315@opensource.wolfsonmicro.com>
Reply-To: <t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:46425 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751965Ab1KYR7J (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 25 Nov 2011 12:59:09 -0500
In-Reply-To: <20111125172945.GJ5315@opensource.wolfsonmicro.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: linux-omap@vger.kernel.org, khilman@ti.com, lrg@ti.com, gg@slimlogic.co.uk, rnayak@ti.com, b-cousson@ti.com

On Fri, 2011-11-25 at 17:29 +0000, Mark Brown wrote:
> On Fri, Nov 25, 2011 at 07:20:32PM +0200, Tero Kristo wrote:
> > On Fri, 2011-11-25 at 16:52 +0000, Mark Brown wrote:
> 
> > > My basic reaction to this is "eew, ick".  Doing this with a runtime call
> > > just feels badly joined up, and there's nothing here which hands off the
> > > configuration between the various drivers involved in the transitions.
> > > We need to make sure that the voltage doesn't suddenly lurch around when
> > > doing transitions.
> 
> > Would you feel better if we just hacked around with the twl-regulator
> > driver and added a compile time switch for the voltage get/set for smps
> > regulators?
> 
> No, that's clearly going to break multi-board kernel images.  If this
> is something board specific platform/device tree data sounds like the
> way forwards.

Okay, so I will update this patch with proper locking and you should be
okay with that approach? Usually in the omap case we just want to switch
to using the external controller during init time and leave it be like
that, there is no really use-case as such for runtime switching of
controller, except maybe for some experimental / debug usage.

-Tero


