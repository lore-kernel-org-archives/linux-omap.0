From: "Ghorai, Sukumar" <s-ghorai@ti.com>
Subject: RE: [PATCH v6 0/3] omap3 nand: cleanup exiting platform related code
Date: Fri, 9 Jul 2010 16:29:32 +0530
Message-ID: <2A3DCF3DA181AD40BDE86A3150B27B6B030E181B51@dbde02.ent.ti.com>
References: <1278660308-8689-1-git-send-email-s-ghorai@ti.com>
 <20100709083256.GI24913@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:37647 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753817Ab0GIK7m convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 9 Jul 2010 06:59:42 -0400
In-Reply-To: <20100709083256.GI24913@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>

Tony,

> -----Original Message-----
> From: Tony Lindgren [mailto:tony@atomide.com]
> Sent: Friday, July 09, 2010 2:03 PM
> To: Ghorai, Sukumar
> Cc: linux-omap@vger.kernel.org; linux-mtd@lists.infradead.org
> Subject: Re: [PATCH v6 0/3] omap3 nand: cleanup exiting platform related
> code
> 
> * Sukumar Ghorai <s-ghorai@ti.com> [100709 10:19]:
> >    The following set of patches applies on top of for-next branch.
> > 	http://git.kernel.org/?p=linux/kernel/git/tmlind/linux-omap-2.6.git
> >    Patches verified on: omap3430-SDP, omap3630-sdp, zoom3 and beagle
> board
> >
> >    And these are the patches required to address the following input -
> >      1. The NAND driver needs to stop tinkering with the GPMC registers
> > 	The omap General Purpose Memory Controller (GPMC) registers are omap
> >         specific, and not driver specific. Tinkering with these
> registers can
> >         cause issues with the other devices on the GPMC.
> >
> >      2. Passing hardcoded GPMC_CS0_BASE needs to go from the board files
> > 	Passing hardcoded GPMC virtual addressess is sure way to mess up
> things.
> >         This should all become unnecessary once the NAND drivers stops
> messing
> >         with the GPMC registers directly.
> 
> Looks good to me, thanks for doing this.
> 
> One more request: Please repost this series one more time with linux-arm-
> kernel
> mailing list Cc'd. Then if no comments, I'll merge this series during the
> next
> merge window.

[Ghorai] Thanks. 
And would you please check if you have any input on following patch series? Otherwise I will rework on this and send again. We need those patches in this time.
1. http://www.mail-archive.com/linux-omap@vger.kernel.org/msg30735.html
2. http://www.mail-archive.com/linux-omap@vger.kernel.org/msg31471.html

Regards,
Ghorai
