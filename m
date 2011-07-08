From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH v2 00/18] OMAP4: PM data big spring cleanup and fixes
Date: Fri, 8 Jul 2011 01:33:32 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1107080124480.24181@utopia.booyaka.com>
References: <1309552901-8944-1-git-send-email-b-cousson@ti.com> <alpine.DEB.2.00.1107060017480.4217@utopia.booyaka.com> <4E14B820.6070202@ti.com> <20110707055549.GC15815@atomide.com> <E9AF1FACCF71F448B55E58D9AED1B0F40E626BEE32@staex7mb2.telecom.sna.samsung.com>
 <20110707121040.GF15815@atomide.com> <E9AF1FACCF71F448B55E58D9AED1B0F40E626BEE34@staex7mb2.telecom.sna.samsung.com> <20110707154834.GP15815@atomide.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:54903 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751450Ab1GHHdd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 8 Jul 2011 03:33:33 -0400
In-Reply-To: <20110707154834.GP15815@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Martin Fouts <mfouts@sta.samsung.com>, Rajendra Nayak <rnayak@ti.com>, Benoit Cousson <b-cousson@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Thu, 7 Jul 2011, Tony Lindgren wrote:

> Well sounds like we might be able to get rid of CHIP_IS in the *_data.c 
> files if we use SoC variant specific lists. Of course Paul might have 
> some other ideas here.

Sounds like a reasonable approach to me for the data files.  The 
powerdomain, clockdomain, and hwmod data would be good places to start.  
It will come at the cost of some extra memory and duplicated data - 
consider mach-omap2/clockdomains2xxx_3xxx_data.c. But given the zeitgeist, 
it's probably worth it to avoid patching that data when we need to 
generalize.

Unfortunately, we'll still have the macro naming and file naming parts of 
the problem.  Not sure if there's an easy fix for those, though.


- Paul
