From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 3/4] ARM: OMAP3: Add support for 3430 SDP, v3
Date: Fri, 3 Apr 2009 17:29:16 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.0904031725450.14281@utopia.booyaka.com>
References: <20090331184802.GA27745@n2100.arm.linux.org.uk> <5A47E75E594F054BAF48C5E4FC4B92AB02FB086086@dbde02.ent.ti.com> <0680EC522D0CC943BC586913CF3768C0036E7EF891@dbde02.ent.ti.com> <alpine.DEB.2.00.0904011301320.9879@utopia.booyaka.com>
 <alpine.DEB.2.00.0904031308340.2134@utopia.booyaka.com> <87tz55xrfj.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:57460 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759795AbZDCX3S (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 3 Apr 2009 19:29:18 -0400
In-Reply-To: <87tz55xrfj.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "Syed Mohammed\\, Khasim" <khasim@ti.com>, "Gadiyar\\, Anand" <gadiyar@ti.com>, Tony Lindgren <tony@atomide.com>, "linux-arm-kernel\\@lists.arm.linux.org.uk" <linux-arm-kernel@lists.arm.linux.org.uk>, "linux-omap\\@vger.kernel.org" <linux-omap@vger.kernel.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>

Hello Kevin

> Could you also include the GPT12 updates that were recently merged
> from the PM branch that allow GPT12 to be a wakeup source.

The GPT12 patches are targeted for a -fixes branch to be sent upstream 
quickly.  

On Fri, 3 Apr 2009, Kevin Hilman wrote:

> $ git log --reverse --pretty=oneline 0c8eba8051eb4fd4228e459c0575d6adfe53d13b..743a413f3e8f8df4cd51f9e4059c7478e927506e
> 20752c3fd65bc6e84faebc7341c8495d75c171bc OMAP: move GP timer selection alongside
> 65b630a097e1d181336c67b2a3b8631e572c93bb OMAP: dmtimer: enable all timers to be 
> 743a413f3e8f8df4cd51f9e4059c7478e927506e OMAP3: PM: enable gptimer12 as a wakeup

Commit 20752c3fd65bc6e84faebc7341c8495d75c171bc no longer applies to the 
current version of the patch set.  I'll include commit 
65b630a097e1d181336c67b2a3b8631e572c93bb.  Commit 
743a413f3e8f8df4cd51f9e4059c7478e927506e has a PM dependency that doesn't 
exist in mainline, so I won't include that one.


- Paul
