From: Matthijs van Duin <matthijsvanduin@gmail.com>
Subject: Re: ARM errata 430973 on multi platform kernels
Date: Mon, 6 Apr 2015 01:52:05 +0200
Message-ID: <CAALWOA_0r1syy4nPBOvf1evhd5_oX=LWjdZAsQGAoGk8OoXTwg@mail.gmail.com>
References: <55197A12.1050009@bitmer.com> <20150330164237.GJ10805@atomide.com>
 <55198BA4.5010207@bitmer.com> <20150330175051.GK10805@atomide.com>
 <20150331123233.GA15103@earth> <20150401194734.GT10805@atomide.com>
 <20150403163553.GA16247@earth> <551F0F50.1030701@gmail.com>
 <20150403221517.GX10805@atomide.com> <551F186B.90608@gmail.com>
 <20150403225212.GY10805@atomide.com> <CAALWOA-h5SdnGhbckJ+x0efijmNaQxX-8ULjn_J=mCb-UJMeoQ@mail.gmail.com>
 <5520E2EE.4080302@gmail.com> <CAALWOA_-RkkgvrxZ32U6WFAZ4Wo5hkkaeo9VNBq48JwMVvkMvw@mail.gmail.com>
 <5521A438.1070008@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f176.google.com ([209.85.212.176]:35726 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752590AbbDEXw1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 5 Apr 2015 19:52:27 -0400
Received: by widdi4 with SMTP id di4so17236324wid.0
        for <linux-omap@vger.kernel.org>; Sun, 05 Apr 2015 16:52:26 -0700 (PDT)
In-Reply-To: <5521A438.1070008@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, Sebastian Reichel <sre@kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>

Cortex-A8 errata doc states in its workaround for erratum 430973:

> By default, the BTB Invalidate instruction is treated as a NOP on Cortex-A8.
> However, it is possible to enable the BTB Invalidate instruction such that it
> actually does a full invalidate of the BTB by setting the IBE bit (bit 6) in
> the CP15 Auxiliary Control Register. As a consequence of erratum 687067, the
> L1 System Array Debug Register should be cleared to 0 before the IBE bit is
> set using the following code sequence:
> MOV r1, #0
> MCR p15, 0, r1, c15, c1, 0            ; write instruction data 0 register
> MRC p15, 0, R1, c1, c0, 1             ; read Aux Ctl Register
> ORR R1, R1 #(1 << 6)                  ; set IBE to 1
> MCR p15, 0, R1, c1, c0, 1             ; write Aux Ctl Register
> The above code needs to be executed in Secure state. ARM Limited recommends
> that this code is added to the boot monitor.

The 430973 workaround code in proc-v7.S will do absolutely nothing if
executed in non-secure state. Ditto for the 458693 workaround, and the
460075 workaround should trigger an undefined instruction exception.
Maybe linux is started in secure mode on some targets and this code
was written for one of those?

I scanned DM814x secure ROM for any (ARM or Thumb) write to
Instruction L1 System Array Debug Register 0, but I found none, hence
my warning to watch out for erratum 687067.

Adding the full set of BTB invalidates while making sure IBE is
disabled on sufficiently recent Cortex-A8 revisions would be optimal
for the Cortex-A8. But, apparently (based on the description of the
ARMv7 CPUID registers) there are also processors which only require
BTB invalidates when code is modified, but not when context-switching,
so there may be performance considerations there...

Matthijs
