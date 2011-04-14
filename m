From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [PATCH 08/13] OMAP3: cpufreq driver changes for DVFS support
Date: Thu, 14 Apr 2011 15:28:57 +0300
Message-ID: <20110414152857.fc3f3323.jhnikula@gmail.com>
References: <1295618465-15234-1-git-send-email-vishwanath.bs@ti.com>
	<1295618465-15234-9-git-send-email-vishwanath.bs@ti.com>
	<20110413171320.5226cd86.jhnikula@gmail.com>
	<a3214a9323e70490664dfa3ec52fc926@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:41613 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754325Ab1DNM1P (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 14 Apr 2011 08:27:15 -0400
Received: by eyx24 with SMTP id 24so432927eyx.19
        for <linux-omap@vger.kernel.org>; Thu, 14 Apr 2011 05:27:14 -0700 (PDT)
In-Reply-To: <a3214a9323e70490664dfa3ec52fc926@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vishwanath Sripathy <vishwanath.bs@ti.com>
Cc: linux-omap@vger.kernel.org, patches@linaro.org, Santosh Shilimkar <santosh.shilimkar@ti.com>

On Wed, 13 Apr 2011 10:57:54 -0700
Vishwanath Sripathy <vishwanath.bs@ti.com> wrote:

> > -----Original Message-----
> > From: Jarkko Nikula [mailto:jhnikula@gmail.com]
> > Sent: Wednesday, April 13, 2011 7:13 AM
> > To: Vishwanath BS
> > Cc: linux-omap@vger.kernel.org; patches@linaro.org; Santosh
> > Shilimkar
> > Subject: Re: [PATCH 08/13] OMAP3: cpufreq driver changes for DVFS
> > support
> >
> > Hi
> >
> > A few comments below in case this is still under development as I
> > was
> > playing a bit with this version on omap3.
> There is an updated version of omap cpufreq patches where this issue is
> fixed.
> https://patchwork.kernel.org/patch/632781/
> 
Thanks, I didn't notice that patch fixes the issues I noticed. Now
also the clk_round_rate works fine since the dpll1_ck does have the
round_clock defined and the former arm_fck is anyway derived from it.

-- 
Jarkko
