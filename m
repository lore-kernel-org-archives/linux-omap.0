From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 00/26] ARM: OMAP2+: PRCM cleanups for 3.18 merge window
Date: Tue, 23 Sep 2014 09:08:56 -0700
Message-ID: <20140923160856.GD2451@atomide.com>
References: <1409594955-1476-1-git-send-email-t-kristo@ti.com>
 <20140918171650.GK14505@atomide.com>
 <alpine.DEB.2.02.1409191606310.22526@utopia.booyaka.com>
 <542021C5.5060201@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:18026 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756374AbaIWQJR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 23 Sep 2014 12:09:17 -0400
Content-Disposition: inline
In-Reply-To: <542021C5.5060201@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Tero Kristo <t-kristo@ti.com> [140922 06:18]:
> On 09/19/2014 07:30 PM, Paul Walmsley wrote:
> >On Thu, 18 Sep 2014, Tony Lindgren wrote:
> >
> >>* Tero Kristo <t-kristo@ti.com> [140901 11:09]:
> >>>Hi,
> >>>
> >>>This set contains PRCM related cleanups meant for 3.18 merge window.
> >>>These are based on top of 3.17-rc1 + the PRM set from Nishanth Menon
> >>>(http://article.gmane.org/gmane.linux.ports.arm.kernel/350305.) Nishanth's
> >>>set is used as basis to avoid merge issues.
> >>>
> >>>Purpose of this work is to eventually convert the PRCM code into a
> >>>separate driver, but this is done in incremental parts as the amount
> >>>of changes is substantial. Expected conclusion of this work is 3.19
> >>>if everything goes fine.
> >>>
> >>>This part of the work mostly moves some of the SoC specific PRCM driver
> >>>calls under generic version of the same, and adds SoC-ops to support
> >>>these on the driver level.
> >>>
> >>>Working branch posted here:
> >>>
> >>>tree: https://github.com/t-kristo/linux-pm.git
> >>>branch: for-v3.18/prcm-cleanup
> 
> Hi,
> 
> I pushed v2 of this set as 'for-v3.18/prcm-cleanup-v2' to my tree. Basically
> to address the below comments, and additionally I changed a few public cm_*
> api names to omap_cm_* + add the tested-by/acked-by statuses. Tony/Paul, do
> you want me to repost the series, or are you ok with a local diff / pull
> only?

If the changes were minor, at least I'm fine without reposting.
But let's wait to hear from Paul in case he has further comments.

Regards,

Tony
 
> >>
> >>Paul, any comments on this series?
> >
> >Patches 1, 3, 5, 8, 10, 13, 17, 18, 20, 21, 22, 23, 24 are:
> >
> >Acked-by: Paul Walmsley <paul@pwsan.com>
> 
> Thanks, added acks to v2 patches.
> 
> >
> >Here are some specific comments on a few other patches:
> >
> >Regarding patch 7:  The kerneldoc-nano function comments are good, but
> >should begin with "/**" rather than "/*".  When that's fixed, it can be
> >considered acked by me.
> 
> Yea, this was a typo, thanks for noticing.
> 
> >
> >Regarding patches 14, 15, 16: Non-static prm_* functions really should
> >start with omap*_ to avoid potential naming conflicts with other drivers
> >when these are moved to drivers/.  (Obviously the same would apply for any
> >CM function names in other, future patches.)  When that's fixed, it can be
> >considered acked by me.
> 
> Ok, changed. Additionally I changed some cm_* prototypes in patches #6, #7
> and #9 to be of form omap_cm_*.
> 
> >Regarding patch 25: What are "I/O wakeup gaes" -- gates?  When that's
> >fixed, an acked-by for me can be added.
> 
> Yes, gates. Fixed.
> 
> >Regarding patch 26: It seems wise to ensure that omap_prm_reset_system()
> >ends with a 'while(1) { cpu_relax(); }' or something similar, to ensure
> >that execution flow does not proceed past that point. At that point, it
> >should be possible to remove the "while(1) {}"s from omap44xx_restart(),
> >omap2xxx_restart(), etc.  When that's fixed, an acked-by for me can be
> >added.
> 
> Ok, changed this also. Added the while(1) cpu_relax(); part to the public
> API, and removed the loops from everywhere else.
> 
> >
> >...
> >
> >And some general comments: none of which should probably block this
> >series, but seemed worth noting:
> >
> >Regarding patches 6 and 19: Tero, could you please share the DT node data
> >that you're planning to submit for the PRM, CM1, and CM2 on the OMAP4*
> >platforms? According to the TRM, these are separate IP blocks, with
> >separate OCP header register areas.  So these should probably have
> >separate DT nodes, regs, etc. if the DTS files are to match the hardware.
> >The planned DTS data may impact the way these patches are written, at
> >least, if more patches are to be avoided later.
> 
> We already have the nodes for these. Check out omap4.dtsi for example, we
> have nodes for prm/cm1/cm2/scrm there already. These were already defined
> when the clock DT data was introduced, and I don't foresee any changes to
> the nodes as of now. The nodes only contain register space info as of now,
> and Nishanth is adding the interrupt property for PRM interrupt purposes,
> but rest of the features are probably going to be hardcoded within the PRCM
> drivers themselves.
> 
> If you are interested, feel free to look at for-3.19/prcm-cleanup branch in
> my git tree, this contains the remaining patches I have for PRCM cleanup
> after this set available as of now.
> 
> -Tero
> 
> >
> >As far as patches 2, 4, 9, 11, and 12 go, I'll let those go without
> >comment.
> >
> >
> >- Paul
> >
> 
