From: Tony Lindgren <tony@atomide.com>
Subject: Re: ARM errata 430973 on multi platform kernels
Date: Mon, 6 Apr 2015 08:40:37 -0700
Message-ID: <20150406154037.GI18048@atomide.com>
References: <551F0F50.1030701@gmail.com>
 <20150403221517.GX10805@atomide.com>
 <551F186B.90608@gmail.com>
 <20150403225212.GY10805@atomide.com>
 <CAALWOA-h5SdnGhbckJ+x0efijmNaQxX-8ULjn_J=mCb-UJMeoQ@mail.gmail.com>
 <5520E2EE.4080302@gmail.com>
 <CAALWOA_-RkkgvrxZ32U6WFAZ4Wo5hkkaeo9VNBq48JwMVvkMvw@mail.gmail.com>
 <5521A438.1070008@gmail.com>
 <CAALWOA_0r1syy4nPBOvf1evhd5_oX=LWjdZAsQGAoGk8OoXTwg@mail.gmail.com>
 <20150406151939.GG18048@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from muru.com ([72.249.23.125]:42346 "EHLO muru.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752785AbbDFPoY (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 6 Apr 2015 11:44:24 -0400
Content-Disposition: inline
In-Reply-To: <20150406151939.GG18048@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Matthijs van Duin <matthijsvanduin@gmail.com>
Cc: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Sebastian Reichel <sre@kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>

* Tony Lindgren <tony@atomide.com> [150406 08:24]:
> * Matthijs van Duin <matthijsvanduin@gmail.com> [150405 16:53]:
> > Cortex-A8 errata doc states in its workaround for erratum 430973:
> > 
> > > By default, the BTB Invalidate instruction is treated as a NOP on Cortex-A8.
> > > However, it is possible to enable the BTB Invalidate instruction such that it
> > > actually does a full invalidate of the BTB by setting the IBE bit (bit 6) in
> > > the CP15 Auxiliary Control Register. As a consequence of erratum 687067, the
> > > L1 System Array Debug Register should be cleared to 0 before the IBE bit is
> > > set using the following code sequence:
> > > MOV r1, #0
> > > MCR p15, 0, r1, c15, c1, 0            ; write instruction data 0 register
> > > MRC p15, 0, R1, c1, c0, 1             ; read Aux Ctl Register
> > > ORR R1, R1 #(1 << 6)                  ; set IBE to 1
> > > MCR p15, 0, R1, c1, c0, 1             ; write Aux Ctl Register
> > > The above code needs to be executed in Secure state. ARM Limited recommends
> > > that this code is added to the boot monitor.
> > 
> > The 430973 workaround code in proc-v7.S will do absolutely nothing if
> > executed in non-secure state. Ditto for the 458693 workaround, and the
> > 460075 workaround should trigger an undefined instruction exception.
> > Maybe linux is started in secure mode on some targets and this code
> > was written for one of those?
> 
> That's only for HS omaps, for those we currently only do it in the
> nokia_n900_legacy_init that calls rx51_secure_update_aux_cr.
> 
> > I scanned DM814x secure ROM for any (ARM or Thumb) write to
> > Instruction L1 System Array Debug Register 0, but I found none, hence
> > my warning to watch out for erratum 687067.
> 
> OK
>  
> > Adding the full set of BTB invalidates while making sure IBE is
> > disabled on sufficiently recent Cortex-A8 revisions would be optimal
> > for the Cortex-A8. But, apparently (based on the description of the
> > ARMv7 CPUID registers) there are also processors which only require
> > BTB invalidates when code is modified, but not when context-switching,
> > so there may be performance considerations there...
> 
> Attempting to summarize all that's been discussed.. It sounds like we
> need the following implemented:
> 
> 1. For cortex-a8 revisions affected by 458693, we can do a custom
>    cpu_v7_switch_mm function that always does flush BTAC/BTB.
> 
> 2. For HS cortex-a8 processors other than n900 affected by 458693,
>    we need to implement functions similar to rx51_secure_update_aux_cr,
>    the bootrom on n900 is different from TI HS omaps so the SMC call
>    numbering may be different.
> 
> 3. For later cortex-a8 processors not affected by 458693, we need
>    to clear IBE bit to avoid erratum 687067.

Oops sorry, wrong numbers for errata above.. s/458693/430973/, here's
a better version:

1. For cortex-a8 revisions affected by 430973, we can do a custom
   cpu_v7_switch_mm function that always does flush BTAC/BTB.
 
2. For HS cortex-a8 processors other than n900 affected by 430973,
   we need to implement functions similar to rx51_secure_update_aux_cr,
   the bootrom on n900 is different from TI HS omaps so the SMC call
   numbering may be different.
 
3. For later cortex-a8 processors not affected by 430973, we need
   to clear IBE bit to avoid erratum 687067.

Regards,

Tony
