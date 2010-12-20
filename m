From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: RE: [PATCH v4 4/7] OMAP3630: PM: Erratum i608: disable RTA
Date: Mon, 20 Dec 2010 17:45:48 +0530
Message-ID: <0ea9388e5895225e9365f29ca4054262@mail.gmail.com>
References: <1292712817-24999-1-git-send-email-nm@ti.com> <1292712817-24999-5-git-send-email-nm@ti.com>
 <c8819161924787cb5de43492278c4e36@mail.gmail.com> <4D0F3CC2.3010407@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog112.obsmtp.com ([74.125.149.207]:48656 "EHLO
	na3sys009aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755491Ab0LTMPu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 20 Dec 2010 07:15:50 -0500
Received: by mail-gx0-f175.google.com with SMTP id 20so1667087gxk.20
        for <linux-omap@vger.kernel.org>; Mon, 20 Dec 2010 04:15:49 -0800 (PST)
In-Reply-To: <4D0F3CC2.3010407@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Jean Pihet <jean.pihet@newoldbits.com>, Kevin <khilman@deeprootsystems.com>, Tony <tony@atomide.com>

> -----Original Message-----
> From: Nishanth Menon [mailto:nm@ti.com]
> Sent: Monday, December 20, 2010 4:54 PM
> To: Santosh Shilimkar
> Cc: linux-omap; linux-arm; Jean Pihet; Kevin; Tony
> Subject: Re: [PATCH v4 4/7] OMAP3630: PM: Erratum i608: disable RTA
>
> Santosh Shilimkar wrote, on 12/20/2010 12:59 AM:
> [..]
> >> index 3fbd1e5..cc3507b 100644
> >> --- a/arch/arm/mach-omap2/sleep34xx.S
> >> +++ b/arch/arm/mach-omap2/sleep34xx.S
> >> @@ -45,6 +45,8 @@
> >>   #define CM_IDLEST_CKGEN_V	OMAP34XX_CM_REGADDR(PLL_MOD,
> CM_IDLEST)
> >>   #define SRAM_BASE_P		0x40200000
> >>   #define CONTROL_STAT		0x480022F0
> >> +#define CONTROL_MEM_RTA_CTRL	(OMAP343X_CTRL_BASE\
> >> +					+ OMAP36XX_CONTROL_MEM_RTA_CTRL)
> > Just a clarification. This register is not part of HW SAR SCM
> > Registers, right ?
> Right.
>
> [..]
Thanks.
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
