From: "Premi, Sanjeev" <premi@ti.com>
Subject: RE: [PATCH 2/2] OMAP3: PM: Do not rely on ROM code to restore
 CM_AUTOIDLE_PLL.AUTO_PERIPH_DPLL
Date: Thu, 14 Apr 2011 23:06:17 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB593024C960470@dbde02.ent.ti.com>
References: <1302708067-8226-1-git-send-email-eduardo.valentin@ti.com>
 <1302708067-8226-3-git-send-email-eduardo.valentin@ti.com>
 <B85A65D85D7EB246BE421B3FB0FBB593024C9603BD@dbde02.ent.ti.com>
 <20110414173352.GA3311@zarco>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:35914 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752090Ab1DNRgm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 14 Apr 2011 13:36:42 -0400
In-Reply-To: <20110414173352.GA3311@zarco>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Valentin, Eduardo" <eduardo.valentin@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@deeprootsystems.com>, Linux-OMAP <linux-omap@vger.kernel.org>, Linux-ARM <linux-arm-kernel@lists.infradead.org>

> -----Original Message-----
> From: Valentin, Eduardo 
> Sent: Thursday, April 14, 2011 11:04 PM
> To: Premi, Sanjeev
> Cc: Valentin, Eduardo; Paul Walmsley; Kevin Hilman; 
> Linux-OMAP; Linux-ARM
> Subject: Re: [PATCH 2/2] OMAP3: PM: Do not rely on ROM code 
> to restore CM_AUTOIDLE_PLL.AUTO_PERIPH_DPLL
> 
> Hello Sanjeev,
> 
> 
> On Thu, Apr 14, 2011 at 09:13:14AM -0500, Premi, Sanjeev wrote:
> > > -----Original Message-----
> > > From: linux-omap-owner@vger.kernel.org 
> > > [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of 
> > > Valentin, Eduardo
> > > Sent: Wednesday, April 13, 2011 8:51 PM
> > > To: Paul Walmsley; Kevin Hilman
> > > Cc: Linux-OMAP; Linux-ARM; Valentin, Eduardo
> > > Subject: [PATCH 2/2] OMAP3: PM: Do not rely on ROM code to 
> > > restore CM_AUTOIDLE_PLL.AUTO_PERIPH_DPLL
> > > 
> > > As per OMAP3 erratum (i671), ROM code adds extra latencies while
> > > restoring CM_AUTOIDLE_PLL register, if AUTO_PERIPH_DPLL 
> is equal to 1.
> > > 
> > > This patch stores 0's in scratchpad content area corresponding to
> > > AUTO_PERIPH_DPLL, to prevent ROM code to try to lock per 
> DPLL, since
> > > it won't respect proper programing scheme.
> > > 
> > > This register is then stored in prcm context. The saving 
> and restore
> > > is now done by kernel side.
> > > 
> > > Here follow the erratum description
> > > 
> > > DESCRIPTION
> > > 
> > > After OFF mode transition, among many restorations, the ROM 
> > > Code restores the
> > > CM_AUTOIDLE_PLL register, and after that, it tries to relock 
> > > the PER DPLL.
> > > 
> > > In case the restoration data stored in scratchpad memory 
> > > contains a field
> > > CM_AUTOIDLE_PLL.AUTO_PERIPH_DPLL = 1, then the way the ROM 
> > > Code restores and
> > > locks the PER DPLL does not respect the PER DPLL 
> programming scheme.
> > > 
> > > In that case, the DPLL might not lock. Meanwhile, when trying 
> > > to lock the PER
> > > DPLL, the ROM Code does not hang. Only extra latencies are 
> > > introduced at
> > > wake-up.
> > > 
> > 
> > [sp] You seem to have missed this patch:
> > http://marc.info/?l=linux-arm-kernel&m=129735383925285&w=2
> 
> Right,
> 
> But that one doesn't clear the AUTO_PERIPH_DPLL bits in the 
> scratchpad area
> to avoid rom code extra overhead (check my patch description).
> 
> Besides, why do we want to add more code inside omap_sram_idle,
> if we have better places to this S&R?

Didn't see that as a comment earlier?

~sanjeev

> 
> 
> > 
> > ~sanjeev
> > 
> > 
> 
> All best,
> 
> --
> Eduardo Valentin
> 