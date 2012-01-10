From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCHV2 REPOST 4/7] ARM: OMAP3 PM: Enable IO Wake up
Date: Tue, 10 Jan 2012 09:36:40 -0800
Message-ID: <87ehv7sbmf.fsf@ti.com>
References: <1323878477-21122-1-git-send-email-vishwanath.bs@ti.com>
	<1323878477-21122-5-git-send-email-vishwanath.bs@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:52818 "EHLO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756511Ab2AJRgo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 10 Jan 2012 12:36:44 -0500
Received: by mail-yx0-f179.google.com with SMTP id q9so803398yen.10
        for <linux-omap@vger.kernel.org>; Tue, 10 Jan 2012 09:36:43 -0800 (PST)
In-Reply-To: <1323878477-21122-5-git-send-email-vishwanath.bs@ti.com>
	(Vishwanath BS's message of "Wed, 14 Dec 2011 21:31:14 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vishwanath BS <vishwanath.bs@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Vishwanath BS <vishwanath.bs@ti.com> writes:

> Enable IO Wake up for OMAP3 as part of PM Init.
> Currently this has been managed in cpuidle path which is not the right place.
> Subsequent patch will remove IO Daisy chain handling in cpuidle path once daisy
> chain is handled as part of hwmod mux.
>
> Signed-off-by: Vishwanath BS <vishwanath.bs@ti.com>
> Tested-by: Govindraj.R <govindraj.raja@ti.com>


WARNING: line over 80 characters
#27: FILE: arch/arm/mach-omap2/pm34xx.c:840:
+		omap2_prm_set_mod_reg_bits(OMAP3430_EN_IO_MASK, WKUP_MOD, PM_WKEN);

