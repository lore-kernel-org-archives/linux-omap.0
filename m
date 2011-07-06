From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 7/7] 4460sdp/blaze/panda: hwmod: Prevent gpio1 reset
 during hwmod init
Date: Tue, 5 Jul 2011 23:47:54 -0700
Message-ID: <20110706064754.GJ5783@atomide.com>
References: <1309486081-8257-5-git-send-email-rnayak@ti.com>
 <1309486081-8257-6-git-send-email-rnayak@ti.com>
 <1309486081-8257-7-git-send-email-rnayak@ti.com>
 <1309486081-8257-8-git-send-email-rnayak@ti.com>
 <20110701063241.GX23145@atomide.com>
 <alpine.DEB.2.00.1107022103430.12499@utopia.booyaka.com>
 <20110704085335.GP23145@atomide.com>
 <alpine.DEB.2.00.1107050136120.4217@utopia.booyaka.com>
 <20110705104553.GF5783@atomide.com>
 <alpine.DEB.2.00.1107051534140.4217@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:63416 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750930Ab1GFGr5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 6 Jul 2011 02:47:57 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1107051534140.4217@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Rajendra Nayak <rnayak@ti.com>, linux-omap@vger.kernel.org, khilman@ti.com, b-cousson@ti.com, Nishanth Menon <nm@ti.com>, s-sintes@ti.com, Moiz Sonasath <m-sonasath@ti.com>

* Paul Walmsley <paul@pwsan.com> [110705 14:42]:
> On Tue, 5 Jul 2011, Tony Lindgren wrote:
> > 
> > Can't we always reset the registered hwmods automatically one at a time when
> > omap_device_build is called?
> 
> The experimental series that I wrote, but haven't posted yet, resets each 
> IP block during the first time it's enabled -- which is probably going to 
> be when omap_device_build() is called.

OK
 
> > > That would allow drivers to assume that they are starting from consistent 
> > > device state.  It also should prevent some power management problems 
> > > that are dependent on particular bootloaders.   How about if we add a 
> > > second parameter, hwmod_reset_unused?  The default could be 'no' and then 
> > > only devices with PM runtime-enabled drivers would be reset first.
> > 
> > Yes I think hwmod_reset_unsed would be a better name, but do we actually
> > need any other reset option in addition to that?
> 
> If a driver doesn't reset its device(s) when it starts, then disabling all 
> reset might allow the kernel to boot when the board file is missing some 
> omap_hwmod_no_setup_reset() calls.
> 
> Consider the 4460 GPIO case.  If someone hasn't added in the 
> omap_hwmod_no_setup_reset(gpioX_hwmod) call into the 4460 board file's 
> init_machine(), then these boards would still crash on boot.
> 
> This would definitely be considered a bug in the board file, that it's 
> missing that omap_hwmod_no_setup_reset() call.  But having a general 
> 'hwmod_no_reset' might make it easier during initial board bring-up to 
> determine whether a problem is caused by reset.
> 
> In any case, it doesn't matter too much to me whether a 'hwmod_no_reset' 
> option is preserved or not; this is just based on our discussion of the 
> issue a few months ago.

Yeah. Sounds like for passing the board specific flags for special case
devices is best done with omap2_init_devices() like you suggested.

Tony
