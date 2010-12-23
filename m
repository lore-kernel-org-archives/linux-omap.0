From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/6] omap: Board specific muxing using hwmod
Date: Wed, 22 Dec 2010 19:07:58 -0800
Message-ID: <20101223030757.GL7771@atomide.com>
References: <20101203004040.31687.9476.stgit@baageli.muru.com>
 <alpine.DEB.2.00.1012210739570.1446@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:12864 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752220Ab0LWDID (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 22 Dec 2010 22:08:03 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1012210739570.1446@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

* Paul Walmsley <paul@pwsan.com> [101221 09:03]:
> Hi,
> 
> On Thu, 2 Dec 2010, Tony Lindgren wrote:
> 
> > Here are some patches to allow us to pass the board specific mux data
> > to the platform level device init code, and then allow hwmod state
> > changes to do the pin muxing.
> > 
> > Dynamic remuxing is also supported as needed, the last patch in this
> > series sets up the board-*.c data for n8x0 to do uart3 rx pin remuxing
> > for the idle modes.
> 
> Tony and I have been discussing these patches recently.  Here are some of 
> the topics from that conversation, to share with the lists.  Tony, I hope 
> I've summarized our discussions accurately; please correct anything you 
> feel I've misstated below.  For those new to OMAP mux/padconf discussions, 
> there is a short glossary at the bottom of this message that might be 
> useful.

Yeah, that's a good summary, adding few more comments below.
 
> - We also discussed that it might make sense to defer adding a bdata the 
> omap_device_build() interface for this merge window, until we had a better 
> sense of the use cases and how the board data relates to the 
> platform_data.  We agreed that, in general, we should try to move as much 
> of the common padconf details as possible out of the individual board 
> files.

I've now dropped the omap_device_build parts from the patches. For now,
we can populate the hwmod mux data from each platform init function.
 
> Based on the discussion and review, I had a few specific comments on the 
> patches:
> 
> - It looks like patch 6 can use static mux directives for all but one of 
> its dynamic padconf reprogramming entries (uart3_rx_irrx).  In terms of 
> enable/idle padconf reprogramming, it might be worth trying to minimize 
> the number of these, since many IP blocks can switch frequently between 
> idled and enabled states.

Good point, I've changed the n8x0 related patch to keep uart3 rx there
for now. In the long run we probably want to have a separate list for
dynamic pins. The other pins we should still enable during init and disable
when the driver is removed. But that can be added later.
 
> - It seems like it might be problematic to program CONTROL_PADCONF 
> registers based on the enabled/idled/shutdown state of a single hwmod.  
> This is because the CONTROL_PADCONF settings affect multiple hwmods.  For 
> example, the correct setting of ETK_D1 pad on OMAP3 can depend on the 
> state of several different hwmods: ETK, McSPI3, HSUSB, GPIO1.  If dynamic 
> padconf reprogramming directives for the same pad(s) (e.g., ETK_D1) are 
> associated with more than one of these hwmods, then the final padconf 
> setting could be unpredictable: basically, the last hwmod to change state 
> will be the one that determines the setting of the padconf register.  
> Ultimately, it may be necessary to make dynamic padconf reprogramming 
> directives conditional on the states of all of the hwmods that are 
> associated with a pad.  For example, something like this:
> 
> omap_mux_add_dynamic_remux(etk_hwmod,    HWMOD_STATE_NOT_ENABLED,
> 	                   mcspi3_hwmod, HWMOD_STATE_ENABLED,
>                            hsusb1_hwmod, HWMOD_STATE_NOT_ENABLED,
>                            gpio1_hwmod,  HWMOD_STATE_DONT_CARE,
>                            "etk_d1", OMAP_MUX_MODE1)
> 
> meaning that pad "etk_d1" would only be programmed to mode 1 (mcspi3_somi)
> when:
> 
> (etk_hwmod_state != HWMOD_STATE_ENABLED) &&
> (mcspi3_hwmod_state == HWMOD_STATE_ENABLED) &&
> (hsusb1_hwmod == HWMOD_STATE_NOT_ENABLED)
> 
> This may not be necessary to implement right away, since the use cases are 
> not clear; and code to implement this will need some careful engineering 
> to keep it from becoming too heavyweight.  If it does become necessary, it 
> seems that this type of data would then be best stored in some higher 
> layer than the struct hwmod.

Yes these kind of issues need to be dealt separately. Probably the best
place to deal with shared pins in each board-*.c file.
 
> We also discussed one other general comment about the mux layer - not 
> related to these patches.  Since some signals can appear on multiple pads, 
> at some point in the future, maybe in the future it might be useful to 
> allow board files to specify their pad configurations in terms of (package 
> ID, ball ID) -> (signal ID) -- so, for example, (CUS, AC11) -> (gpio_81).  
> The idea being that the board designer, using a PCB design tool, might 
> someday be able to export a list of padconf settings out of their EDA 
> tools that we could use in the board files.  Looking at the OMAP3530 IBIS 
> model at 
> 
>    http://focus.ti.com/lit/mo/symlink/omap3530-25_cus__ibis_model.ibs
> 
> it includes both the ball ID (which it calls the "pin") and the pad/mode 0 
> name (which it calls the "signal name").

That can be added easily, but depends on CONFIG_DEBUG_FS for the ball IDs
currently.

Regards,

Tony
