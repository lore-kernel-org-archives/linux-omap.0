From: Tero Kristo <t-kristo@ti.com>
Subject: RE: [PATCHv4 6/8] ARM: OMAP4: PM: support
 ret_logic/mem_off_counters
Date: Wed, 2 May 2012 12:20:21 +0300
Message-ID: <1335950421.2149.189.camel@sokoban>
References: <1334913591-26312-1-git-send-email-t-kristo@ti.com>
	 <1334913591-26312-7-git-send-email-t-kristo@ti.com>
	 <B5906170F1614E41A8A28DE3B8D121433EA6A33C@DBDE01.ent.ti.com>
Reply-To: <t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:48658 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750988Ab2EBJU3 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 2 May 2012 05:20:29 -0400
In-Reply-To: <B5906170F1614E41A8A28DE3B8D121433EA6A33C@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Bedia, Vaibhav" <vaibhav.bedia@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Hilman, Kevin" <khilman@ti.com>, "paul@pwsan.com" <paul@pwsan.com>, "Nayak, Rajendra" <rnayak@ti.com>, Axel Haslam <axelhaslam@gmail.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Wed, 2012-05-02 at 10:45 +0200, Bedia, Vaibhav wrote:
> Hi Tero,
> 
> On Fri, Apr 20, 2012 at 14:49:49, Kristo, Tero wrote:
> > From: Axel Haslam <axelhaslam@gmail.com>
> > 
> > On OMAP4, there is no support to read previous logic state
> > or previous memory state achieved when a power domain transitions
> > to RET. Instead there are module level context registers.
> > 
> > In order to support the powerdomain level logic/mem_off_counters
> > on OMAP4, instead use the previous power state achieved (RET) and
> > the *programmed* logic/mem RET state to derive if a powerdomain lost
> > logic or did not.
> > 
> > If the powerdomain is programmed to enter RET state and lose logic
> > in RET state, knowing that the powerdomain entered RET is good enough
> > to derive that the logic was lost as well, in such cases.
> > 
> 
> Unfortunately this won't scale for AM33xx devices :(
> It neither has module level context registers nor previous logic/memory state
> registers in PRCM. 
> 
> At a top level, there's a Cortex-M3 (CM3) to assist the low power state transitions
> and the indication of successful transition to a low power states is handled as part
> of the IPC mechanism between the MPU (A8) and CM3 which is s/w defined.
> 
> Since the various APIs like omap_hwmod_get_context_loss_context() and friends are
> necessary to have correct context saves and restores in drivers we'll need
> to add another API for AM33xx which basically builds on the IPC mechanism
> and updates the counters.
> 
> So, instead of the fallback mechanism that is currently in place, can the
> implementation for updating the logic/mem counters be converted to make use of
> function pointers. When AM33xx PM support comes in, we can just define
> a custom function and not pollute the code with cpu_is_* checks.

I think that should be fine. We can add arch_hwmod struct or such
(similar to arch_clkdm / arch_pwrdm) if need be. However, I think we
should just expand the support towards that way once we can implement
the am33xx support properly with a separate patch. I guess this doesn't
break anything on am33xx currently, right?

-Tero


