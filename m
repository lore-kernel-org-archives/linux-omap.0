From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [RFC 2/4] ARM: OMAP: PM: Get rid of Powerdomain book-keeping
 from cpuidle
Date: Thu, 26 Jul 2012 14:50:20 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1207261447050.14468@utopia.booyaka.com>
References: <1342764284-8143-1-git-send-email-rnayak@ti.com>  <1342764284-8143-3-git-send-email-rnayak@ti.com>  <CAMQu2gyCmx57ctZFBoAUKUXY+9zwFLCDHsBfehXicH7mEyDzQg@mail.gmail.com>  <5009120A.1060400@ti.com> <1342774283.4672.181.camel@sokoban>
 <87obn3798o.fsf@ti.com> <50113B3C.4090608@ti.com>  <87boj2s9hi.fsf@ti.com> <1343327231.30247.151.camel@sokoban>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:37017 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752705Ab2GZUuU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 26 Jul 2012 16:50:20 -0400
In-Reply-To: <1343327231.30247.151.camel@sokoban>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: Kevin Hilman <khilman@ti.com>, Rajendra Nayak <rnayak@ti.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, b-cousson@ti.com

On Thu, 26 Jul 2012, Tero Kristo wrote:

> On Thu, 2012-07-26 at 10:44 -0700, Kevin Hilman wrote:
> 
> > Or, to get rid of autodeps. ;)
> 
> Whats the reason for having them anyway?

No one has yet posted tested patches to convert OMAP2/3 to use the IP 
block-based clockdomain enable sequence.  A few folks posted some patches 
for this in 2010 but the patches didn't boot.

It should be a little easier to try this now since we have more data 
defined now than we did in the past.

> Some of the wakedeps make sense (per domain due to hw bugs) but 
> sleepdeps...?

That sounds like a different issue.


- Paul
