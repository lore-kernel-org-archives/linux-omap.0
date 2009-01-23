From: "Hunter, Jon" <jon-hunter@ti.com>
Subject: RE: OMAP1: mcbsp clocks
Date: Fri, 23 Jan 2009 11:18:37 -0600
Message-ID: <7B4574D56E4ADF438756313E9A172A872CABB6EA@dlee01.ent.ti.com>
References: <20090122235543.GC8137@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:34535 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753310AbZAWRSk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 23 Jan 2009 12:18:40 -0500
In-Reply-To: <20090122235543.GC8137@n2100.arm.linux.org.uk>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Russell King wrote on :

> A question about OMAP1 mcbsp clocks.  From what I understand from the
> OMAP5912 clock architecture documentation, mcbsp1 and mcbsp3 have two
> clocks:
>
> 1. interface clock switchable between DSPPER_CK and DSPXOR_CK.
> 2. a function clock which could be DSPXOR_CK (mcbsp3), and
>    CK_DPLL1OUT or MCBS1_CLKS (mcbsp1).
>
> However, the code in mach-omap1/mcbsp.c associates both mcbsp1 and 3
> unconditionally with all of: DSP_CK, API_CK and DSPXOR_CK.  As far as
> I can see, DSP_CK (for the DSP processor) and API_CK (for system dma)
> have nothing to do with mcbsp1,3.
>
> So, the question is why is it this way, and what would be the effect
> of correcting this so that both of these mcbsp units are associated
> with their proper interface and function clocks?

On the OMAP1 architecture there are peripherals that are located on the ARM peripheral bus and peripherals that are located on the DSP bus. The McBSP1 and McBSP3 are located on the DSP peripheral bus and McBSP2 is located on the ARM peripheral bus. The ARM has access to some of the DSP peripherals via the MPUI (aka API - the name was changed to avoid confusion with sofware term). The API or 'ARM Peripheral Interface' (if I recall the abbreviation correctly) is really just the ARM's internal interface to peripherals on the DSP's bus. However, in order for the ARM to access peripherals via the MPUI, the MPUI clock (API_CK) must be enabled. This is the difference between McBSP2 and McBSP1/3.

So for McBSP1/3 you definitely need to have the MPUI clock enabled. On OMAP2/3 devices the internal bus architecture was change significantly so you don't have as many crazy dependencies.

Hope this helps.

Cheers
Jon
