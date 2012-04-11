From: "Mark A. Greer" <mgreer@animalcreek.com>
Subject: Re: [PATCH 06/12] arm: omap3: am35x: Add full PWRDM_POWER_INACTIVE
 support
Date: Wed, 11 Apr 2012 14:14:16 -0700
Message-ID: <20120411211416.GB7979@animalcreek.com>
References: <1334171147-7517-1-git-send-email-mgreer@animalcreek.com>
 <1334171147-7517-7-git-send-email-mgreer@animalcreek.com>
 <CAORVsuW2Nax4h+SxEJ6dLM1AopAFPQjvK0FHa9N5mEEVCStpQw@mail.gmail.com>
 <alpine.DEB.2.00.1204111506240.29473@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail20.dotsterhost.com ([66.11.232.73]:55762 "EHLO
	mail20.dotsterhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761275Ab2DKVOR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 11 Apr 2012 17:14:17 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1204111506240.29473@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Jean Pihet <jean.pihet@newoldbits.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, khilman@ti.com

On Wed, Apr 11, 2012 at 03:08:54PM -0600, Paul Walmsley wrote:
> Hi
> 
> On Wed, 11 Apr 2012, Jean Pihet wrote:
> 
> > On Wed, Apr 11, 2012 at 9:05 PM, Mark A. Greer <mgreer@animalcreek.com> wrote:
> > > From: "Mark A. Greer" <mgreer@animalcreek.com>
> > >
> > > The am35x family of SoCs only support PWRDM_POWER_ON
> > > and PWRDM_POWER_INACTIVE power states. This causes
> > > an issue in some areas of the OMAP3 power-related
> > > code because of assumptions that PWRDM_POWER_RET
> > > and/or PWRDM_POWER_OFF are always valid states.
> > >
> > > To get am35x SoCs to work properly, add missing support
> > > for PWRDM_POWER_INACTIVE and remove assumptions that
> > > PWRDM_POWER_RET and PWRDM_POWER_OFF are always valid states.
> > >
> > > Signed-off-by: Mark A. Greer <mgreer@animalcreek.com>
> > 
> > I just posted a patch set '[RFC/PATCH v2 0/6] ARM: OMAP2+: PM:
> > introduce the power domains functional states' [1] which I think
> > should be used to base your patches on. This patch set introduces
> > functional states for the power domains power ans logic states, and
> > the conversion functions between the internal power and logic states
> > and the functional states.
> > 
> > I would be glad to help on the AM35x support for the functional states.
> 
> Since it might take a while for the functional powerstate code to go 
> upstream, if Mark wants to do this, I'd suggest that he split the
> powerdomain-specific patches off from the rest of his series.  This should 
> avoid blocking the rest of his patches on the infrastructure changes.

Another good idea.  I'll do the split in another day or so in case there
are more comments I can address when I respin & separate the patches.

Mark
--
