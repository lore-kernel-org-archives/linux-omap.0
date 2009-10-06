From: "Premi, Sanjeev" <premi@ti.com>
Subject: RE: [PATCHv3 0/1] Runtime detection of Si features
Date: Tue, 6 Oct 2009 14:54:11 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301DDC091B6@dbde02.ent.ti.com>
References: <1254417895-3716-1-git-send-email-premi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:45178 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756370AbZJFJY4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 6 Oct 2009 05:24:56 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id n969OH2D028577
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Tue, 6 Oct 2009 04:24:20 -0500
Received: from dbde70.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id n969OHaT008748
	for <linux-omap@vger.kernel.org>; Tue, 6 Oct 2009 14:54:17 +0530 (IST)
In-Reply-To: <1254417895-3716-1-git-send-email-premi@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Premi, Sanjeev" <premi@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> -----Original Message-----
> From: Premi, Sanjeev 
> Sent: Thursday, October 01, 2009 10:55 PM
> To: linux-omap@vger.kernel.org
> Cc: Premi, Sanjeev
> Subject: [PATCHv3 0/1] Runtime detection of Si features
> 
> This version is essentially same patch as [1]; but
> refreshed against the tip (2bf0f78). The change in
> text corresponding to the closing #endif in cpu.h
> required change in the last line of the patch.
> 
>   [1] http://patchwork.kernel.org/patch/41989/
> 
> Sanjeev Premi (1):
>   Runtime detection of Si features
> 
>  arch/arm/mach-omap2/id.c                  |   52 
> +++++++++++++++++++++++++++--
>  arch/arm/mach-omap2/mmc-twl4030.c         |    1 +
>  arch/arm/plat-omap/include/mach/control.h |   34 +++++++++++++++++++
>  arch/arm/plat-omap/include/mach/cpu.h     |   23 +++++++++++++
>  4 files changed, 107 insertions(+), 3 deletions(-)
> 
> 

Tony,

Where does this stand in your queue?

Best regards,
Sanjeev