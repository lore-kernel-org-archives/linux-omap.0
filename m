From: "Nayak, Rajendra" <rnayak@ti.com>
Subject: RE: [PATCH 0/5] OMAP4: ES2 PRCM diff series
Date: Thu, 16 Sep 2010 19:19:10 +0530
Message-ID: <0680EC522D0CC943BC586913CF3768C003C210F718@dbde02.ent.ti.com>
References: <1284643241-17203-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:33989 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752601Ab0IPNtO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 16 Sep 2010 09:49:14 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id o8GDnAgw024802
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Thu, 16 Sep 2010 08:49:13 -0500
Received: from dbde70.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id o8GDnAww001838
	for <linux-omap@vger.kernel.org>; Thu, 16 Sep 2010 19:19:10 +0530 (IST)
In-Reply-To: <1284643241-17203-1-git-send-email-rnayak@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Nayak, Rajendra" <rnayak@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

This patch series seems to be posted twice on the list due to some
issues with my mailer. Sorry for that. 

Regards,
Rajendra

> -----Original Message-----
> From: Nayak, Rajendra
> Sent: Thursday, September 16, 2010 6:51 PM
> To: linux-omap@vger.kernel.org
> Cc: Nayak, Rajendra
> Subject: [PATCH 0/5] OMAP4: ES2 PRCM diff series
> 
> The PRCM IP in OMAP4430 ES2 is completely validated
> and is expected to be functional, unlike the one in ES1
> which was untested and non functional.
> 
> This series of patches brings in all the differences
> introducted by PRCM in ES2.0. Includes additional registers
> added, some removed, bitfields in registers moved around.
> Some changes in clock tree modelling and some in powerdomain
> states supported.
> 
> This series is tested on OMAP4430 ES2 using the below series
> http://www.spinics.net/lists/linux-omap/msg36023.html
> and also boot tested on OMAP4430 ES1 and applied on latest
> mainline.
> 
> Patches based on mainline rc4 are available here:
> http://gitorious.org/omap-pm/linux for_2.6.37
> 
> Rajendra Nayak (4):
>   OMAP4: PM: Update PRCM register bitshits and masks for ES2
>   OMAP4: PM: Define additional registers for ES2
>   OMAP4: clocks: Update clock tree for ES2
>   OMAP4: powerdomain: Update DSS logic state for ES2
> 
> Santosh Shilimkar (1):
>   OMAP4: powerdomain: add context_offset field
> 
>  arch/arm/mach-omap2/clock44xx_data.c          |  168 ++++++--------
>  arch/arm/mach-omap2/cm-regbits-44xx.h         |  327 ++++++++++++++--------
> ---
>  arch/arm/mach-omap2/cm44xx.h                  |   90 +++++++-
>  arch/arm/mach-omap2/powerdomains44xx.h        |   16 ++-
>  arch/arm/mach-omap2/prm-regbits-44xx.h        |  194 ++++++++++++---
>  arch/arm/mach-omap2/prm44xx.h                 |   14 +-
>  arch/arm/plat-omap/include/plat/powerdomain.h |    2 +
>  7 files changed, 525 insertions(+), 286 deletions(-)

