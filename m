From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH V2 08/10] ARM: OMAP4: Prevent EMU power domain transitioning
 to OFF when in-use
Date: Wed, 1 Aug 2012 09:08:59 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1208010906470.21488@utopia.booyaka.com>
References: <1339104132-26885-1-git-send-email-jon-hunter@ti.com> <1339104132-26885-9-git-send-email-jon-hunter@ti.com> <alpine.DEB.2.00.1207111441300.25585@utopia.booyaka.com> <500028B3.1040309@ti.com> <alpine.DEB.2.00.1207131418500.25585@utopia.booyaka.com>
 <50045D17.9050704@ti.com> <alpine.DEB.2.00.1207161228470.28834@utopia.booyaka.com> <50171841.40309@ti.com> <501760BF.8070801@ti.com> <5018210A.1040902@ti.com> <50187644.40308@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:43909 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755144Ab2HAPJA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 1 Aug 2012 11:09:00 -0400
In-Reply-To: <50187644.40308@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: Kevin Hilman <khilman@ti.com>, Benoit Cousson <b-cousson@ti.com>, Ming Lei <ming.lei@canonical.com>, Will Deacon <will.deacon@arm.com>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>

Hi Jon,

On Tue, 31 Jul 2012, Jon Hunter wrote:

> Sorry for all the emails. However, I wanted to get this out to you as
> I am due to be out for a couple weeks. 
> 
> So I have updated your patch [1] with the following changes ...
> 
> 1. Re-based on top of your omap3 clock domain fix [2]
> 2. Modified the above change I mentioned to check for
>    CLKDM_MISSING_IDLE_REPORTING in omap_pm_clkdms_setup() instead of
>    the omap2_clkdm_clk_enable(). This is to prevent the clock domain
>    being placed in HW_AUTO on boot if enabled early.
> 3. Made the other change I mentioned earlier [3].
> 
> This is now working well for me on OMAP3/4.

Your changes look good to me.  Do you have a strong preference as to 
whether that patch should go in as part of 3.6-rc or 3.7?  I'd be inclined 
to queue it for 3.7 based on the size of the patch.


- Paul
