From: "Dasgupta, Romit" <romit@ti.com>
Subject: RE: [PATCH] PM: Prevent direct cpufreq scaling during initialization
Date: Thu, 3 Dec 2009 11:59:16 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301DE87AAD1@dbde02.ent.ti.com>
References: <1259748759.21203.11.camel@boson>
 <48239d390912020733w2981917ap6312eee193f14263@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:36829 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751156AbZLCG3Q convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Dec 2009 01:29:16 -0500
In-Reply-To: <48239d390912020733w2981917ap6312eee193f14263@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sergey Lapin <slapinid@gmail.com>
Cc: "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>



> > Signed-off-by: Romit Dasgupta <romit@ti.com>
> > ---
> > diff --git a/arch/arm/plat-omap/cpu-omap.c b/arch/arm/plat-omap/cpu-
> omap.c
> > index 449b6b6..f94df20 100644
> > --- a/arch/arm/plat-omap/cpu-omap.c
> > +++ b/arch/arm/plat-omap/cpu-omap.c
> > @@ -149,8 +149,6 @@ static int __init omap_cpu_init(struct
> cpufreq_policy *policy)
> >                                                        VERY_HI_RATE) /
> 1000;
> >        }
> >
> > -       clk_set_rate(mpu_clk, policy->cpuinfo.max_freq * 1000);
> > -
> >        policy->min = policy->cpuinfo.min_freq;
> >        policy->max = policy->cpuinfo.max_freq;
> >        policy->cur = omap_getspeed(0);
> 
> This patch leads to hang with current PM branch, SRF and CPU IDLE enabled
> on OMAP3525 rev C.
Verified this to work on Zoom2 + SRF + CPUidle. Can you give some debug info if possible?
