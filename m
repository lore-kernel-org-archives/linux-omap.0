From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCHv4 00/15] voltdm cleanup + auto-ret / auto-off support
Date: Wed, 30 Nov 2011 12:19:19 +0200
Message-ID: <1322648359.21753.22.camel@sokoban>
References: <1322236188-19456-1-git-send-email-t-kristo@ti.com>
	 <CAORVsuUQPJPYehWVBMpgNF8HTk1zsDqVLV1RoY6StydX=FnoJw@mail.gmail.com>
Reply-To: <t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:56509 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752866Ab1K3KTY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 30 Nov 2011 05:19:24 -0500
In-Reply-To: <CAORVsuUQPJPYehWVBMpgNF8HTk1zsDqVLV1RoY6StydX=FnoJw@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jean Pihet <jean.pihet@newoldbits.com>
Cc: linux-omap@vger.kernel.org, khilman@ti.com, nm@ti.com

On Wed, 2011-11-30 at 11:06 +0100, Jean Pihet wrote:
> Hi Tero,
> 
> On Fri, Nov 25, 2011 at 4:49 PM, Tero Kristo <t-kristo@ti.com> wrote:
> > Hi,
> >
> > Changes compared to previous version:
> >
> > - merged most of the voltagedomain cleanup fixes to patch 2
> > - moved pmic latencies to omap_voltdm_pmic struct
> > - renamed omap_lp_params to omap2_oscillator as it only contains
> >  osc info now
> > - major changes to usecount support (patch 11+, needed for auto-ret)
> >  * added usecounts to voltagedomain / powerdomain
> >  * fixed usecount tracking so that the numbers are sane now
> >  * changed behavior of some usecounting sources that they do not
> >    update the counts (autoidle support)
> > - added auto-ret / auto-off support, based on fixed usecounting
> >  * smartreflex disabled / enabled
> >  * auto-ret / auto-off enabled based on target state
> > - some other minor tweaks I have probably forgotten to mention
> Ok after review, except the remarks I sent as replies to the specific patches.
> 
> Minor remark: the patch set could be split into the following features:
> - oscillator startup/shutdown time,
> - Beagle OPP6,
> - usecount code,
> - auto ret/off.

True. It was actually split almost like that earlier, however it is now
a big pile of patches together. :)

> 
> > Tested on omap3 beagle:
> > - voltages for vdd1 and vdd2 change when entering idle
> Nice!
> 
> > - both suspend and dynamic idle tested
> > - tested that voltages reach target levels for both ret / off
> >
> > Tested on omap4 blaze with custom kernel
> > - this requires a few additional patches missing from this set as
> >  omap4 PM support is still not merged
> > - will post missing patches once possible from upstream point of view
> > - voltages for vdd1 and vdd3 change when entering idle
> >
> > Applies on top of Kevin's for_3.2/voltage-cleanup branch.
> >
> > I have a bunch of additional debugging patches I have used in verification
> > of this set if anybody is interested.
> >
> > TBD:
> > - no pmic off support yet
> >  * no pmic script support
> >  * vdd1 / vdd2 only reach 0.6V, not 0V in off
> >  * oscillator is not turned off
> That would be nice to have. IIRC last time I checked the existing T2
> scripts where not working on Beagle due to a different wiring of the
> PMIC<->OMAP signals.

Yeah, fixing the script support should probably be done also, not sure
who is going to do that though. Looking at the board files quickly, I
can only see pmic script support for board-rx51.

-Tero


