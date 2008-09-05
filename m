From: "Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>
Subject: RE: cam_mclk clock not responding properly in OMAP3430
Date: Fri, 5 Sep 2008 14:21:32 -0500
Message-ID: <A24693684029E5489D1D202277BE894411B190CD@dlee02.ent.ti.com>
References: <alpine.DEB.1.00.0809042306110.25143@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:44287 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751167AbYIETVl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Sep 2008 15:21:41 -0400
In-Reply-To: <alpine.DEB.1.00.0809042306110.25143@utopia.booyaka.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi Paul,

I confirm that the patch solved the issue.

Thanks for your support.

Regards,
Sergio

-----Original Message-----
From: Paul Walmsley [mailto:paul@pwsan.com] 
Sent: Friday, September 05, 2008 12:07 AM
To: Aguirre Rodriguez, Sergio Alberto
Cc: linux-omap@vger.kernel.org
Subject: Re: cam_mclk clock not responding properly in OMAP3430

Hello Sergio,

On Thu, 4 Sep 2008, Aguirre Rodriguez, Sergio Alberto wrote:

> I'm working on camera implementation, and I want to debug why the cam_mclk clock is returning me a "count exceeded" message, although seems to be properly taken. (i.e. MT9P012 + ISP sensor works fine)
> 
> I'm having this message when trying to acquire it:
> 
> Clock cam_mclk didn't enable in 100000 tries
> 
> Any clue why is that?

Yes, I think so.  Does this patch fix the problem for you?


- Paul


[PATCH] OMAP3 clock: camera module has no target IDLEST bit

From: Paul Walmsley <paul@pwsan.com>

We must not attempt to wait for the CAM module to become ready after
clock enable, since it has no target IDLEST bit.

Thanks to Sergio Alberto Aguirre Rodriguez <saaguirre@ti.com> for
reporting this.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: "Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>
---
 arch/arm/mach-omap2/clock.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/clock.c b/arch/arm/mach-omap2/clock.c
index be5c616..189b8a6 100644
--- a/arch/arm/mach-omap2/clock.c
+++ b/arch/arm/mach-omap2/clock.c
@@ -256,6 +256,10 @@ static void omap2_clk_wait_ready(struct clk *clk)
 	/* REVISIT: What are the appropriate exclusions for 34XX? */
 	if (cpu_is_omap34xx()) {
 
+		/* CAM */
+		if (prcm_mod == OMAP34XX_CM_REGADDR(OMAP3430_CAM_MOD, 0))
+			return;
+
 		/* SSI */
 		if (prcm_mod == OMAP34XX_CM_REGADDR(CORE_MOD, 0) &&
 		    (reg & 0x0f) == 0 &&

