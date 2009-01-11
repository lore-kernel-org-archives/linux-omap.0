From: "Premi, Sanjeev" <premi@ti.com>
Subject: RE: [PATCH 0/3] Add support for OMAP35x processors
Date: Mon, 12 Jan 2009 00:26:50 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301BB858BCF@dbde02.ent.ti.com>
References: <A24693684029E5489D1D202277BE8944163AB5F7@dlee02.ent.ti.com>,<200901102254.42829.david-b@pacbell.net>
 <A24693684029E5489D1D202277BE8944153C47FA@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:51406 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751840AbZAKS5a convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 11 Jan 2009 13:57:30 -0500
In-Reply-To: <A24693684029E5489D1D202277BE8944153C47FA@dlee02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>, David Brownell <david-b@pacbell.net>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

<snip>
> > > Question to all,
> > >
> > > Why don't making above options as choice.. endchoice.
> > 
> > Because that completely breaks "multi-OMAP" builds.
> > Having kernels build (and work!) with multiple boards has 
> been a goal 
> > for some time now.
> > 
> > Switching that stuff to choice...endchoice would be a major 
> > regression.  I wouldn't merge such a patch.
> 
> Ok, I understand what you're saying.. But I still have some questions:

[sp] In this case we can still use my earlier patch posted on 9th JAN.

> - Is the above change for being able to select (for example) 
> 3430SDP when !ARCH_OMAP35XX wrong? That won't allow a kernel 
> with both 3430SDP and 3530EVM boards support to build, right?
> - Do you think the above kind of check is redundant?:
> depends on ARCH_OMAP3 && ARCH_OMAP34XX
> 
> Bc i don't think ARCH_OMAP34XX can be when !ARCH_OMAP3...

[sp] If we look at only the ARM-Cortex A8, things don't look different but the other differences between OMAP34x and OMAP35x can be cause of concern someday.

<snip>

Best regards,
Sanjeev