From: "Premi, Sanjeev" <premi@ti.com>
Subject: RE: [PATCHv2 0/1] omap3: cpuidle: Update statistics for correct
 state
Date: Tue, 24 Nov 2009 23:26:12 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301DE6A754B@dbde02.ent.ti.com>
References: <1259085027-13269-1-git-send-email-premi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:40584 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933572AbZKXR4L convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 24 Nov 2009 12:56:11 -0500
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id nAOHuFDR018448
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Tue, 24 Nov 2009 11:56:17 -0600
Received: from dbde71.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id nAOHuEgQ008655
	for <linux-omap@vger.kernel.org>; Tue, 24 Nov 2009 23:26:14 +0530 (IST)
In-Reply-To: <1259085027-13269-1-git-send-email-premi@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> -----Original Message-----
> From: Premi, Sanjeev 
> Sent: Tuesday, November 24, 2009 11:20 PM
> To: linux-omap@vger.kernel.org
> Cc: Premi, Sanjeev
> Subject: [PATCHv2 0/1] omap3: cpuidle: Update statistics for 
> correct state
> 
> This is a fresh look at the problem [1] discussed earlier.
> 
> Generic approach here is same; but the 'valid' flag for the
> target state is verified in omap3_enter_idle_bm(). If the
> valid flag == 0, we look for next (lower) state with valid
> flag == 1.
> 
> Have tried to optimize the look-up without loosing readability.

Missed this in my message:
 [1] http://marc.info/?l=linux-omap&m=125214460417989&w=2

> 
> Sanjeev Premi (1):
>   omap3: cpuidle: Update statistics for correct state
> 
>  arch/arm/mach-omap2/cpuidle34xx.c |   98 
> ++++++++++++++++++++++++++++++++++---
>  arch/arm/mach-omap2/pm.h          |    1 +
>  arch/arm/mach-omap2/pm34xx.c      |    4 ++
>  3 files changed, 95 insertions(+), 8 deletions(-)
> 
> 