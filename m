From: "Mark A. Greer" <mgreer@animalcreek.com>
Subject: Re: [PATCH 06/12] arm: omap3: am35x: Add full PWRDM_POWER_INACTIVE
 support
Date: Wed, 11 Apr 2012 14:12:53 -0700
Message-ID: <20120411211253.GA7979@animalcreek.com>
References: <1334171147-7517-1-git-send-email-mgreer@animalcreek.com>
 <1334171147-7517-7-git-send-email-mgreer@animalcreek.com>
 <CAORVsuW2Nax4h+SxEJ6dLM1AopAFPQjvK0FHa9N5mEEVCStpQw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail20.dotsterhost.com ([66.11.232.73]:33363 "EHLO
	mail20.dotsterhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753625Ab2DKVMy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 11 Apr 2012 17:12:54 -0400
Content-Disposition: inline
In-Reply-To: <CAORVsuW2Nax4h+SxEJ6dLM1AopAFPQjvK0FHa9N5mEEVCStpQw@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jean Pihet <jean.pihet@newoldbits.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, khilman@ti.com, paul@pwsan.com

On Wed, Apr 11, 2012 at 10:56:01PM +0200, Jean Pihet wrote:
> Hi Mark,
> 
> On Wed, Apr 11, 2012 at 9:05 PM, Mark A. Greer <mgreer@animalcreek.com> wrote:
> > From: "Mark A. Greer" <mgreer@animalcreek.com>
> >
> > The am35x family of SoCs only support PWRDM_POWER_ON
> > and PWRDM_POWER_INACTIVE power states. This causes
> > an issue in some areas of the OMAP3 power-related
> > code because of assumptions that PWRDM_POWER_RET
> > and/or PWRDM_POWER_OFF are always valid states.
> >
> > To get am35x SoCs to work properly, add missing support
> > for PWRDM_POWER_INACTIVE and remove assumptions that
> > PWRDM_POWER_RET and PWRDM_POWER_OFF are always valid states.
> >
> > Signed-off-by: Mark A. Greer <mgreer@animalcreek.com>
> 
> I just posted a patch set '[RFC/PATCH v2 0/6] ARM: OMAP2+: PM:
> introduce the power domains functional states' [1] which I think
> should be used to base your patches on. This patch set introduces
> functional states for the power domains power ans logic states, and
> the conversion functions between the internal power and logic states
> and the functional states.
> 
> I would be glad to help on the AM35x support for the functional states.
> 
> What do you think?

Sure.  Sounds like the right thing to do.

> [1] http://marc.info/?l=linux-omap&m=133417729712693&w=2

Thanks for the pointer.  I'll do a little research and contact you
out-of-band.

Mark
--
