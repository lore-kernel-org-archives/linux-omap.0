From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 3/3] ARM: OMAP: hwmod: Look for hwmod/module level context
 lost count if supported
Date: Fri, 16 Dec 2011 05:38:51 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1112160538200.12660@utopia.booyaka.com>
References: <1320317665-6381-1-git-send-email-rnayak@ti.com> <1320317665-6381-4-git-send-email-rnayak@ti.com> <4ED52007.8010804@ti.com> <4ED85835.7080108@ti.com> <alpine.DEB.2.00.1112160414530.12660@utopia.booyaka.com> <4EEB36E5.8020504@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:44581 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754041Ab1LPMiw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 Dec 2011 07:38:52 -0500
In-Reply-To: <4EEB36E5.8020504@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: "Cousson, Benoit" <b-cousson@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Fri, 16 Dec 2011, Rajendra Nayak wrote:

> On Friday 16 December 2011 04:46 PM, Paul Walmsley wrote:
> > 
> > Hi Rajendra,
> > 
> > I've combined your patches down to one patch and changed the logic a
> > little bit.  It looks to me that the update and clear context registers
> > can be done in one step, since an IP block shouldn't lose context when
> > it's enabled.  But maybe I'm missing something?
> 
> Thanks for the patch. The changes look fine and I also did a quick
> test on an internal tree which supports core OSWR and it seems to
> work fine too.

Great, thanks.  Will wait on this one until you have a chance to tinker 
with it during the 3.4 time frame.


- Paul
