From: Matthijs van Duin <matthijsvanduin@gmail.com>
Subject: Re: ARM errata 430973 on multi platform kernels
Date: Mon, 6 Apr 2015 20:14:30 +0200
Message-ID: <CAALWOA93+ohYJ7Q06H4gVMywzP5=RC3uBkUVXjWMriRBoHzXKQ@mail.gmail.com>
References: <551F186B.90608@gmail.com> <20150403225212.GY10805@atomide.com>
 <CAALWOA-h5SdnGhbckJ+x0efijmNaQxX-8ULjn_J=mCb-UJMeoQ@mail.gmail.com>
 <5520E2EE.4080302@gmail.com> <CAALWOA_-RkkgvrxZ32U6WFAZ4Wo5hkkaeo9VNBq48JwMVvkMvw@mail.gmail.com>
 <5521A438.1070008@gmail.com> <CAALWOA_0r1syy4nPBOvf1evhd5_oX=LWjdZAsQGAoGk8OoXTwg@mail.gmail.com>
 <20150406151939.GG18048@atomide.com> <20150406154037.GI18048@atomide.com>
 <5522BEEF.2000405@gmail.com> <20150406174245.GJ18048@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f175.google.com ([209.85.212.175]:37527 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750891AbbDFSOw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 6 Apr 2015 14:14:52 -0400
Received: by wiaa2 with SMTP id a2so43245779wia.0
        for <linux-omap@vger.kernel.org>; Mon, 06 Apr 2015 11:14:51 -0700 (PDT)
In-Reply-To: <20150406174245.GJ18048@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Sebastian Reichel <sre@kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>

* Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com> [150406 10:15]:
> Why custom function, if IBE bit is zero, BTB invalidate instruction is a
> NOP. Do you think that "mcr p15, 0, r2, c7, c5, 6" executed as a NOP will
> put so much overhead, that it deserves a custom function?

Executing them as nop is Cortex-A8 specific. On other ARMv7 CPUs, BTB
invalidation on context switch may be unnecessary yet expensive.

In general I think you'll want a version with and one without BTB
flushing, and select depending on CPUID (ID_MMFR1, bits 28-31), with
overrides for known processor issues (i.e. the cortex-a8 has a wrong
value there in all cases: it reports value 2, while it should be
treated as 1 or 4 depending on cpu revision).


On 6 April 2015 at 19:42, Tony Lindgren <tony@atomide.com> wrote:
> Hmm but it still seems to do something also on cortex-a8 r3p2 that
> is supposedly not affected by 430973.. Based on my tests so far, at least
> armhf running cpuburn-a8 in the background and doing apt-get update
> segfaults constantly without flush BTAC/BTB. This seems to be the case
> no matter how the aux ctrl reg bits are set..

That sounds.... really odd.  The TRM is fairly explicit about BTB
flush executing as nop when IBE is not set. Of course the TRM is not
exactly flawless, but still...


>> 2. For Cortex-A8 revisions affected by 430973, set IBE bit to 1, set it
>>    to 0 for all others.

Note btw that erratum 687067 affects *all* Cortex-A8 revisions, so
there's a bit of a catch-22 there. The proper workaround for it
(zeroing some particular debug register) can only be done in secure
privileged mode, and there's no straightforward way to check whether
this has been done.

However, it only affects BTB invalidate by MVA, afaik BTB invalidate
all is safe.

>>  That should happen as soon as possible,
>>  otherwise kernel may crash on affected revisions if thumb-compiled.

The right place to do this to be honest would be in the bootloader,
but I guess that's not always convenient to arrange...

Matthijs
