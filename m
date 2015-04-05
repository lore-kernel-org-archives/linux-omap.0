From: Matthijs van Duin <matthijsvanduin@gmail.com>
Subject: Re: ARM errata 430973 on multi platform kernels
Date: Sun, 5 Apr 2015 06:13:47 +0200
Message-ID: <CAALWOA-h5SdnGhbckJ+x0efijmNaQxX-8ULjn_J=mCb-UJMeoQ@mail.gmail.com>
References: <55197A12.1050009@bitmer.com> <20150330164237.GJ10805@atomide.com>
 <55198BA4.5010207@bitmer.com> <20150330175051.GK10805@atomide.com>
 <20150331123233.GA15103@earth> <20150401194734.GT10805@atomide.com>
 <20150403163553.GA16247@earth> <551F0F50.1030701@gmail.com>
 <20150403221517.GX10805@atomide.com> <551F186B.90608@gmail.com> <20150403225212.GY10805@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:33440 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750719AbbDEEOJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 5 Apr 2015 00:14:09 -0400
Received: by wiax7 with SMTP id x7so2904513wia.0
        for <linux-omap@vger.kernel.org>; Sat, 04 Apr 2015 21:14:08 -0700 (PDT)
In-Reply-To: <20150403225212.GY10805@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Sebastian Reichel <sre@kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>

On 4 April 2015 at 00:52, Tony Lindgren <tony@atomide.com> wrote:
> Right, it affects n900 for sure. My point is that it also seems to
> affect 37xx versions not listed to suffer from this issue.

They shouldn't... erratum 430973 only affected Cortex-A8 r1, and the
dm37xx should have an r3p2 right?

A word of caution though: at least on the DM814x and AM335x, secure
ROM sets bit 6 (IBE) in the Auxiliary Control Register, thereby
enabling BTB invalidate instructions (which normally execute as nops).
This is presumably a leftover of the erratum 430973 workaround, but it
means there is a risk of running afoul of erratum 687067 if BTB
invalidate by MVA instructions are actually used.

I would actually suggest clearing IBE if it set on Cortex-A8 r2 or
later processors and a secure monitor call is available to do so
(there is on the DM814x and AM335x, dunno about the 37xx), also for
performance reasons: BTB invalidates are quite expensive instructions
(when enabled).

Matthijs
