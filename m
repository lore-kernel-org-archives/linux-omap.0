From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: RE: [PATCH] Correct definition of register of OMAP4_RM_RSTST and OMAP4_RM_RSTTIME
Date: Tue, 7 Dec 2010 14:22:19 +0530
Message-ID: <58280319cf695f280ceefe82109d6f39@mail.gmail.com>
References: <AANLkTi=OdG2j2o+uZ+L_EpGKPTE8=fRBN8U60sJkqAhK@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:56614 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753113Ab0LGIwV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 7 Dec 2010 03:52:21 -0500
Received: by mail-qw0-f44.google.com with SMTP id 5so12328159qwg.31
        for <linux-omap@vger.kernel.org>; Tue, 07 Dec 2010 00:52:21 -0800 (PST)
In-Reply-To: <AANLkTi=OdG2j2o+uZ+L_EpGKPTE8=fRBN8U60sJkqAhK@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: MING ZHOU <a17711@motorola.com>, linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of MING ZHOU
> Sent: Tuesday, December 07, 2010 1:04 PM
> To: linux-omap@vger.kernel.org
> Cc: Tony Lindgren; Paul Walmsley
> Subject: [PATCH] Correct definition of register of OMAP4_RM_RSTST and
> OMAP4_RM_RSTTIME
>
> Since we need to reconfigure Reset time for OMAP4, we found the OMAP4
> register definition for reset time is wrong according to spec of
> OMAP4. And we verified this by reading default value of register. We
> found the offset definition of Reset time and Reset Test register
> should be switched. After correcting this bug, we verified by changing
> the value of reset time register, the pulse generated for reset is
> also changed as expected on scope.
>
> From 9a9c98c2f4008e5d8f2f5da1101e3bfe222a48ed Mon Sep 17 00:00:00 2001
> From: Zhou Ming <a17711@motorola.com>
> Date: Tue, 7 Dec 2010 10:00:59 -0500
> Subject: [PATCH] Correct definition of register of OMAP4_RM_RSTST and
> OMAP4_RM_RSTTIME
>
> According to test result, we found the offset definition of
OMAP4_RM_RSTST
> and OMAP4_RM_RSTIME should be switched.
> ---
>  arch/arm/mach-omap2/prm.h |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/prm.h b/arch/arm/mach-omap2/prm.h
> index 7be040b..23b4be2 100644
> --- a/arch/arm/mach-omap2/prm.h
> +++ b/arch/arm/mach-omap2/prm.h
> @@ -222,8 +222,8 @@
>
>  /* Omap4 specific registers */
>  #define OMAP4_RM_RSTCTRL                               0x0000
> -#define OMAP4_RM_RSTTIME                               0x0004
> -#define OMAP4_RM_RSTST                                 0x0008
> +#define OMAP4_RM_RSTTIME                               0x0008
> +#define OMAP4_RM_RSTST                                 0x0004
Yep. This is indeed correct offsets.

>  #define OMAP4_PM_PWSTCTRL                              0x0000
>  #define OMAP4_PM_PWSTST                                        0x0004
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
