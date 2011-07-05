From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 7/7] 4460sdp/blaze/panda: hwmod: Prevent gpio1 reset
 during hwmod init
Date: Tue, 5 Jul 2011 15:47:41 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1107051534140.4217@utopia.booyaka.com>
References: <1309486081-8257-3-git-send-email-rnayak@ti.com> <1309486081-8257-4-git-send-email-rnayak@ti.com> <1309486081-8257-5-git-send-email-rnayak@ti.com> <1309486081-8257-6-git-send-email-rnayak@ti.com> <1309486081-8257-7-git-send-email-rnayak@ti.com>
 <1309486081-8257-8-git-send-email-rnayak@ti.com> <20110701063241.GX23145@atomide.com> <alpine.DEB.2.00.1107022103430.12499@utopia.booyaka.com> <20110704085335.GP23145@atomide.com> <alpine.DEB.2.00.1107050136120.4217@utopia.booyaka.com>
 <20110705104553.GF5783@atomide.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:59051 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752179Ab1GEVrm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 5 Jul 2011 17:47:42 -0400
In-Reply-To: <20110705104553.GF5783@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Rajendra Nayak <rnayak@ti.com>, linux-omap@vger.kernel.org, khilman@ti.com, b-cousson@ti.com, Nishanth Menon <nm@ti.com>, s-sintes@ti.com, Moiz Sonasath <m-sonasath@ti.com>

Hi Tony

On Tue, 5 Jul 2011, Tony Lindgren wrote:

> * Paul Walmsley <paul@pwsan.com> [110705 00:35]:
> > On Mon, 4 Jul 2011, Tony Lindgren wrote:
> > > * Paul Walmsley <paul@pwsan.com> [110702 21:09]:
> > > 
> > > > 3. Merge the lazy/unused hwmod reset code, but disable the unused hwmod 
> > > >    reset code until the driver runtime PM conversion is finished.  This
> > > >    could cause problems with driverless devices that are left configured
> > > >    by bootloaders or ROM code, and that problem would reoccur for each new
> > > >    OMAP chip.
> > >
> > > I think #3 above is the safest option. How about make it only happen with
> > > hwmod_reset=1 cmdline with 0 being the default value?
> > 
> > With the patch that was posted, that would disable all reset.  Probably we 
> > want to reset devices that have drivers with PM runtime support?
> 
> Can't we always reset the registered hwmods automatically one at a time when
> omap_device_build is called?

The experimental series that I wrote, but haven't posted yet, resets each 
IP block during the first time it's enabled -- which is probably going to 
be when omap_device_build() is called.

> > That would allow drivers to assume that they are starting from consistent 
> > device state.  It also should prevent some power management problems 
> > that are dependent on particular bootloaders.   How about if we add a 
> > second parameter, hwmod_reset_unused?  The default could be 'no' and then 
> > only devices with PM runtime-enabled drivers would be reset first.
> 
> Yes I think hwmod_reset_unsed would be a better name, but do we actually
> need any other reset option in addition to that?

If a driver doesn't reset its device(s) when it starts, then disabling all 
reset might allow the kernel to boot when the board file is missing some 
omap_hwmod_no_setup_reset() calls.

Consider the 4460 GPIO case.  If someone hasn't added in the 
omap_hwmod_no_setup_reset(gpioX_hwmod) call into the 4460 board file's 
init_machine(), then these boards would still crash on boot.

This would definitely be considered a bug in the board file, that it's 
missing that omap_hwmod_no_setup_reset() call.  But having a general 
'hwmod_no_reset' might make it easier during initial board bring-up to 
determine whether a problem is caused by reset.

In any case, it doesn't matter too much to me whether a 'hwmod_no_reset' 
option is preserved or not; this is just based on our discussion of the 
issue a few months ago.

regards

- Paul
