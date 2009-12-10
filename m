From: Paul Walmsley <paul@pwsan.com>
Subject: RE: [PATCHV2 1/4] OMAP3: introduce DPLL4 Jtype
Date: Thu, 10 Dec 2009 14:24:12 -0700 (MST)
Message-ID: <alpine.DEB.2.00.0912010904590.13408@utopia.booyaka.com>
References: <1259211517-12713-1-git-send-email-vishwanath.bs@ti.com> <1259211517-12713-2-git-send-email-vishwanath.bs@ti.com> <alpine.DEB.2.00.0911300141440.17083@utopia.booyaka.com> <FCCFB4CDC6E5564B9182F639FC35608702FA90250A@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:38835 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755817AbZLJVYG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 10 Dec 2009 16:24:06 -0500
In-Reply-To: <FCCFB4CDC6E5564B9182F639FC35608702FA90250A@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Sripathy, Vishwanath" <vishwanath.bs@ti.com>
Cc: "ext-ari.kauppi@nokia.com" <ext-ari.kauppi@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Woodruff, Richard" <r-woodruff2@ti.com>, "Menon, Nishanth" <nm@ti.com>

Hi Vishwanath,

On Tue, 1 Dec 2009, Sripathy, Vishwanath wrote:

> > -----Original Message-----
> > From: Paul Walmsley [mailto:paul@pwsan.com]
> > Sent: Monday, November 30, 2009 3:00 PM
> > To: Sripathy, Vishwanath
> > Cc: ext-ari.kauppi@nokia.com; linux-omap@vger.kernel.org; Woodruff, Richard;
> > Menon, Nishanth
> > Subject: Re: [PATCHV2 1/4] OMAP3: introduce DPLL4 Jtype
> > 
> > Hello Vishwanath,
> > 
> > a few comments:
> > 
> > On Thu, 26 Nov 2009, Vishwanath BS wrote:
> > 
> > > From: Richard Woodruff <r-woodruff2@ti.com>
> > >
> > > DPLL4 for 3630 introduces a changed block requiring special divisor bits and
> > > additional reg fields. To allow for silicons to use this, this is introduced
> > > as a omap3_has_jtype_dpll4() and is enabled for 3630 silicon
> > >
> > > Tested with 3630 ZOOM3
> > 
> > Could you please consider Ari Kauppi's suggestions that he posted on
> > 30 and 31 October?  They look good to me.  Here is a link:
> > 
> Regarding comments from Ari Kauppi on addition of dco_sel_mask and 
> sd_div_mask, yes I had a look at them. However I feel, it's better to 
> have these masks in the structure variable. Reason being this approach 
> will help us to support when dpll types for other dplls get changed in 
> future. For example, if dpll3 block is changed, then having new mask 
> will help us to support it.

Is there a product coming out that will add more j-type DPLLs with 
different dco_sel_masks and sd_div_masks?  If not, then let's go with 
Ari's suggested changes, since we don't really know if any more of these 
j-type DPLLs will be used.  We can always add the fields back in when we 
need them.  But if you know for sure that there is a chip variant coming 
out soon that will use more j-type DPLLs, let's talk about it.

> > - One thing that is confusing is that the 3630 Rev A TRM (SWPU176A)
> > conflicts with the 34xx-36xx Delta TRM (SWPU204).  For example, the delta
> > TRM claims that the FREQSEL bits are all removed, but the 3630 TRM claims
> > that they are still present.  Could you find out which one is correct?  If
> > no FREQSEL bits are present, then the clock code shouldn't write to them.
> > 
> 
> 3630 TRM (Rev A) shows that FREQSEL is no longer present for Per DPLL 
> (CM_CLKEN_PLL [23:20] is reserved). So we should not write freqsel for 
> PER dpll.

Okay.  Could you please update the patch to that effect?  

Also, the other part of the question is that the delta TRM claims that 
none of the other DPLLs have FREQSEL bits either.  If that's true, then 
please update the patch to avoid programming FREQSEL bits for all DPLLs on 
3630.

> > - Table 3-13 in the delta TRM claims that the DPLL4 multiplier bitfield
> > can now go to 4096.  [This looks like an off-by-one error in the
> > documentation, since only 12 bits are available, so the max is (2^12 - 1)
> > = 4095.]  But the important point for this patch is that the struct
> > dpll_data.max_multiplier field for DPLL4 needs to be increased.
> 
> I confirmed that DPLL4 Multiplier is 12 bits. So max value is 4095.

OK.  I just realized that you put the 12 bit value in a different patch...


- Paul
