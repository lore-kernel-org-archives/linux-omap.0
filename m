From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCHv7 3/7] omap3: voltage: fix channel configuration
Date: Wed, 7 Dec 2011 10:57:08 +0200
Message-ID: <1323248228.9045.15.camel@sokoban>
References: <1322492005-27741-1-git-send-email-t-kristo@ti.com>
	 <1322492005-27741-4-git-send-email-t-kristo@ti.com> <87pqg6jzq6.fsf@ti.com>
	 <1323077736.7555.10.camel@sokoban>  <87r50iix7n.fsf@ti.com>
Reply-To: <t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:47929 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753670Ab1LGI5R (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 7 Dec 2011 03:57:17 -0500
In-Reply-To: <87r50iix7n.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, sameo@linux.intel.com, broonie@opensource.wolfsonmicro.com, lrg@ti.com, b-cousson@ti.com, rnayak@ti.com, gg@slimlogic.co.uk, "Menon, Nishanth" <nm@ti.com>

On Mon, 2011-12-05 at 12:23 -0800, Kevin Hilman wrote:
> Tero Kristo <t-kristo@ti.com> writes:
> 
> > On Fri, 2011-12-02 at 15:55 -0800, Kevin Hilman wrote:
> >> Tero Kristo <t-kristo@ti.com> writes:
> >> 
> >> > OMAP3 uses the default settings for VDD1 channel, otherwise the settings will
> >> > overlap with VDD2 and attempting to modify VDD1 voltage will actually change
> >> > VDD2 voltage.
> >> >
> >> > Signed-off-by: Tero Kristo <t-kristo@ti.com>
> >> 
> >> I've forgotten a bit how this was supposed to work (again), Can you
> >> elaborate more on how this fails?
> >
> > There is a diagram in the OMAP TRM for setting the bits in this
> > register, however the racen fix part appears to be needed only for
> > omap4. I can drop this part of the fix from the series if you want for
> > the next version, alternatively I can split this patch into two.
> 
> A separate patch, with a descriptive changelog would be preferred.
> 
> > The idea for this part of the fix is anyway that the channel
> > configuration is more complex in omap4, we define volt_reg and cmd_reg
> > addresses for each omap4_X_pmic, however we only want to enable racen
> > bit only if cmd and volt register addresses are the same. 
> 
> This part still doesn't make sense to me.
> 
> If the volt register address (RA_VOL in OMAP4 terms) and command
> register address (RA_CMD) are the same, then RACEN shouldn't matter,
> since either way the commands go the same address.   
> 
> My understanding of RACEN is that it is only for the case where RA_VOL
> and RA_CMD are different, so you can select between them.

I am not sure if you got the polarity of the bit right. RACEN should be
enabled only if the register addresses are the same. My understanding is
that: if command register is defined => RAC=1, if voltage register is
defined => RAV=1. If VFSM should use voltage register address for
sending voltage commands => RACEN=1, otherwise it will use command
register address.

> 
> The current code assumes that if you pass in command register address
> you plan to use it.  If it isn't being used (RACEN == 0) then the PMIC
> setup should probably not pass in a separate command register address.
> 
> What am I missing (or mis-reading in the TRM) here?

The register addresses defined in omap_twl for omap4 pmics are
different, and this is causing trouble at the moment if RACEN is
enabled, as VFSM commands will end up going to voltage register address.
One could probably also argue that the register addresses for these
should be the same...

The documentation for this part of the chip is rather bad anyway. Added
Nishanth to CC as he might have some comments on this also.

-Tero


