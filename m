From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCHv2 10/19] ARM: OMAP4: PM: Work-around for ROM code BUG of IVAHD/TESLA
Date: Wed, 16 May 2012 16:05:20 -0700
Message-ID: <87zk976827.fsf@ti.com>
References: <1336990730-26892-1-git-send-email-t-kristo@ti.com>
	<1336990730-26892-11-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog105.obsmtp.com ([74.125.149.75]:57423 "EHLO
	na3sys009aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1760723Ab2EPXFX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 16 May 2012 19:05:23 -0400
Received: by pbcwy7 with SMTP id wy7so2550376pbc.17
        for <linux-omap@vger.kernel.org>; Wed, 16 May 2012 16:05:22 -0700 (PDT)
In-Reply-To: <1336990730-26892-11-git-send-email-t-kristo@ti.com> (Tero
	Kristo's message of "Mon, 14 May 2012 13:18:41 +0300")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, linux-arm-kernel@lists.infradead.org, Santosh Shilimkar <santosh.shilimkar@ti.com>, Rajendra Nayak <rnayak@ti.com>

Tero Kristo <t-kristo@ti.com> writes:

> From: Santosh Shilimkar <santosh.shilimkar@ti.com>
>
> The ROM BUG is when MPU Domain OFF wake up sequence that can compromise
> IVA and Tesla execution.
>
> At wakeup from MPU OFF on HS device only (not GP device), when
> restoring the Secure RAM, the ROM Code reconfigures the clocks the
> same way it is done at Cold Reset.

Ouch.

> The IVAHD Clocks and Power Domain settings are:
> 	IVAHD_CM2 IVAHD_CLKCTRL_MODULE_MODE = DISABLE
> 	IVAHD_CM2 SL2_CLKCTRL_MODULE_MODE = DISABLE
> 	IVAHD_CM2 SL2_CLKSTCTRL_CLKTRCTRL = HW_AUTO
> 	IVAHD_PRM IVAHD_PWRSTCTRL_POWERSTATE = OFF
> The TESLA Clocks and Power Domain settings are:
> 	TESLA_CM1 TESLA_CLKCTRL_MODULE_MODE = DISABLE
> 	TESLA_CM1 TESLA_CLKSTCTRL_CLKTRCTRL = HW_AUTO
> 	TESLA_PRM TESLA_PWRSTCTRL_POWERSTATE = OFF
>
> This patch fixes the low power OFF mode code so that the these
> registers are saved and restore across MPU OFF state.
>
> Also because of this limitation, MPU OFF alone is not targeted without
> device OFF to avoid IVAHD and TESLA execution impact

I don't see where this restriction is implemented.

And, can this be hooked into cluster PM notifiers.

Kevin

