From: "Mark A. Greer" <mgreer@animalcreek.com>
Subject: Re: [PATCH 09/12] arm: omap3: am35x: Add SDRC EMIF4 feature
Date: Wed, 11 Apr 2012 15:50:02 -0700
Message-ID: <20120411225002.GF31197@animalcreek.com>
References: <1334171147-7517-1-git-send-email-mgreer@animalcreek.com>
 <1334171147-7517-10-git-send-email-mgreer@animalcreek.com>
 <alpine.DEB.2.00.1204111524550.29473@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail20.dotsterhost.com ([66.11.232.73]:38741 "EHLO
	mail20.dotsterhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965625Ab2DKXgn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 11 Apr 2012 19:36:43 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1204111524550.29473@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, khilman@ti.com

On Wed, Apr 11, 2012 at 03:29:00PM -0600, Paul Walmsley wrote:
> Hi
> 
> On Wed, 11 Apr 2012, Mark A. Greer wrote:
> 
> > From: "Mark A. Greer" <mgreer@animalcreek.com>
> > 
> > The typical SDRAM Controller Subsystem module (SDRC)
> > on TI OMAP3 devices has two submodules: the SDRAM Memory
> > Scheduler (SMS) submodule, and the SDRC submodule--the
> > 'SDRC' acronym/term is overloaded.  The am35x family of
> > devices is different in that it has an EMIF4 submodule
> > instead of an SDRC submodule.  The SMS submodules are
> > similar, though.
> > 
> > To allow code to determine whether the current device has an
> > SDRC submodule or and EMIF4 submodule, add the 'OMAP3_HAS_SDRC_EMIF4'
> > feature and set it when running on an am35x SoC.
> > 
> > So when:
> > - omap3_has_sdrc() returns true: the system has an SDRC module
> > 	consisting of an SMS submodule and either an SDRC submodule
> > 	or an EMIF4 submodule.
> > - omap3_has_sdrc_emif4() returns true: the system has an EMIF4
> > 	submodule.  It is assumed that this feature will only be
> > 	checked when there is an SDRC module present (i.e., when
> > 	omap3_has_sdrc() would return true).
> > 
> > Signed-off-by: Mark A. Greer <mgreer@animalcreek.com>
> 
> We need to stop declaring these feature flags for IP blocks, and use the 
> hwmod code instead.  hwmod code provides omap_hwmod_lookup() which can be 
> used to determine whether a given IP block exists on a particular chip, so 
> I don't think there's any need for omap3_has_sdrc(), 
> omap3_has_sdrc_emif4(), omap3_has_iva(), omap3_has_isp(), etc.
> 
> So it would be best if you could simply add an EMIF hwmod data entry in 
> omap_hwmod_3xxx_data.c.

Okay.

Mark
--
