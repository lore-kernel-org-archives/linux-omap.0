From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH v4 1/2] OMAP3: SDRC: Dynamic Calculation of SDRC stall latency during DVFS
Date: Thu, 18 Mar 2010 08:09:23 -0700
Message-ID: <87k4t9mzto.fsf@deeprootsystems.com>
References: <1268888148-10983-1-git-send-email-pramod.gurav@ti.com>
	<1268888148-10983-2-git-send-email-pramod.gurav@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f200.google.com ([209.85.222.200]:55234 "EHLO
	mail-pz0-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751385Ab0CRPJ1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Mar 2010 11:09:27 -0400
Received: by pzk38 with SMTP id 38so1754925pzk.33
        for <linux-omap@vger.kernel.org>; Thu, 18 Mar 2010 08:09:26 -0700 (PDT)
In-Reply-To: <1268888148-10983-2-git-send-email-pramod.gurav@ti.com> (Pramod Gurav's message of "Thu\, 18 Mar 2010 10\:25\:47 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Pramod Gurav <pramod.gurav@ti.com>
Cc: linux-omap@vger.kernel.org, Teerth Reddy <teerth@ti.com>, Vishwanath Sripathy <vishwanath.bs@ti.com>

Pramod Gurav <pramod.gurav@ti.com> writes:

> From: Teerth Reddy <teerth@ti.com>
>
> The patch has the changes to calculate the dpll3 clock stabilization
> delay dynamically. The SRAM delay is calibrated during bootup using the
> gptimers and used while calculating the stabilization delay. By using
> the dynamic method the dependency on the type of cache being used is
> removed.
>
> The wait time for L3 clock stabilization is calculated using the formula
>         = 4*REFCLK + 8*CLKOUTX2,
> which uses the M, N and M2 read from the registers.
> Since this gives slightly less value, 2us is added as buffer for safety.
> This works fine for omap3.
>
> Signed-off-by: Teerth Reddy <teerth@ti.com>
> Signed-off-by: Pramod Gurav <pramod.gurav@ti.com>
> Signed-off-by: Vishwanath Sripathy <vishwanath.bs@ti.com>

OK, I'm now OK with the GP timer usage in this version.  The rest will
need to be reviewed/merged by Paul.

Kevin
