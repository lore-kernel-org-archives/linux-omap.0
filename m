From: Matthijs van Duin <matthijsvanduin@gmail.com>
Subject: Re: ARM errata 430973 on multi platform kernels
Date: Sun, 5 Apr 2015 18:50:38 +0200
Message-ID: <CAALWOA_-RkkgvrxZ32U6WFAZ4Wo5hkkaeo9VNBq48JwMVvkMvw@mail.gmail.com>
References: <55197A12.1050009@bitmer.com> <20150330164237.GJ10805@atomide.com>
 <55198BA4.5010207@bitmer.com> <20150330175051.GK10805@atomide.com>
 <20150331123233.GA15103@earth> <20150401194734.GT10805@atomide.com>
 <20150403163553.GA16247@earth> <551F0F50.1030701@gmail.com>
 <20150403221517.GX10805@atomide.com> <551F186B.90608@gmail.com>
 <20150403225212.GY10805@atomide.com> <CAALWOA-h5SdnGhbckJ+x0efijmNaQxX-8ULjn_J=mCb-UJMeoQ@mail.gmail.com>
 <5520E2EE.4080302@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:37628 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752010AbbDEQvA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 5 Apr 2015 12:51:00 -0400
Received: by wiaa2 with SMTP id a2so14698322wia.0
        for <linux-omap@vger.kernel.org>; Sun, 05 Apr 2015 09:50:59 -0700 (PDT)
In-Reply-To: <5520E2EE.4080302@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, Sebastian Reichel <sre@kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>

On 5 April 2015 at 09:23, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com> wrote:
> Though I wonder why SMC is needed to write ACR on non-HS devices. A simple
> MRC should suffice, unless I miss something.

Public-world access to ACR varies per bit:
bit 1 (L2EN) is documented as banked, but at least on r3p2 turns out
to be common r/w.
bits 30-31 are secure read-only and public RAZ.
remaining bits are secure read/write and public read-only.

The net effect is that doing an MRC from public world will only modify
the L2EN bit.

There's no bit in the non-secure access control register to affect all
of this, so GP vs HS doesn't matter here (from a CPU point of view; it
may matter for the availability of SM calls obviously).

Matthijs
