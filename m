From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v3 1/4] TI816X: Update common omap platform files
Date: Thu, 6 Jan 2011 18:56:20 -0800
Message-ID: <20110107025620.GG7771@atomide.com>
References: <1294075737-22320-1-git-send-email-hemantp@ti.com>
 <alpine.DEB.2.00.1101031603070.10403@utopia.booyaka.com>
 <20110104015008.GX7771@atomide.com>
 <2A3DCF3DA181AD40BDE86A3150B27B6B036A57AF93@dbde02.ent.ti.com>
 <alpine.DEB.2.00.1101041046540.9203@utopia.booyaka.com>
 <20110104232547.GP7771@atomide.com>
 <2A3DCF3DA181AD40BDE86A3150B27B6B036A57AFF5@dbde02.ent.ti.com>
 <2A3DCF3DA181AD40BDE86A3150B27B6B036A57B5DB@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:15719 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755350Ab1AGC41 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 6 Jan 2011 21:56:27 -0500
Content-Disposition: inline
In-Reply-To: <2A3DCF3DA181AD40BDE86A3150B27B6B036A57B5DB@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Pedanekar, Hemant" <hemantp@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Paul Walmsley <paul@pwsan.com>

* Pedanekar, Hemant <hemantp@ti.com> [110105 15:59]:
> linux-omap-owner@vger.kernel.org wrote on :
> 
> > Tony Lindgren wrote on Wednesday, January 05, 2011 4:56 AM:
> > 
> >> * Paul Walmsley <paul@pwsan.com> [110104 09:48]:
> >>> On Tue, 4 Jan 2011, Pedanekar, Hemant wrote:
> >>> 
> >>>> Looking at above, it seems another config option like
> >>>> CONFIG_SOC_OMAP3XXX is also needed in addition to CONFIG_SOC_OMAPTI816X.
> >>> 
> >>> We already have CONFIG_ARCH_OMAP3430, CONFIG_ARCH_OMAP2430, and
> >>> CONFIG_ARCH_OMAP2420.  I guess at some point those need to be renamed to
> >>> CONFIG_SOC_*.
> >> 
> >> Yes that's what I was thinking too. Keep CONFIG_ARCH_OMAP2, 3, and 4,
> >> and rename CONFIG_ARCH_OMAP3430 etc to CONFIG_SO_COMAP3430 and so on.
> >> 
> >> Regards,
> >> 
> >> Tony
> > 
> > So I will add CONFIG_SOC_OMAPTI816X to handle TI816X specific variations.
> > But I think without addition of corresponding
> > CONFIG_SOC_OMAP3XXX, it would be
> > difficult to handle 2nd case I mentioned (OMAP3 build for OMAP3xxx as well
> > as TI816X SoCs). Will it be OK if we consider this 2nd case as
> > invalid/unsupported for the moment - that is, 2nd case = 4th case (OMAP3
> > build for TI816X only)? Same applies for multi-omap case too.
> > 
> > In short, if CONFIG_SOC_OMAPTI816X is selected, the build becomes specific
> > to TI816X and not OMAP3xxx in all the cases (so keep
> > CONFIG_SOC_OMAPTI816X disabled
> > by default in multi-omap configuration).
> > 
> Tony,
> Does the above look ok? Also please let me know any other comments and I will
> send updated patches.

Let's try to keep all the possible dependencies out of this for now.
Please just add CONFIG_SOC_OMAPTI816X and keep CONFIG_ARCH_OMAP3 selected.
The CONFIG_SOC_XXXX things must be optional to save memory, whatever we
do we should also be able to do without them.

Regards,

Tony

