From: "Premi, Sanjeev" <premi@ti.com>
Subject: RE: [PATCH] Runtime detection of OMAP35x devices
Date: Tue, 25 Aug 2009 17:06:44 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301DD39A35A@dbde02.ent.ti.com>
References: <1250612150-16345-1-git-send-email-premi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:34890 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754640AbZHYLgv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 25 Aug 2009 07:36:51 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id n7PBalsB013832
	for <linux-omap@vger.kernel.org>; Tue, 25 Aug 2009 06:36:52 -0500
Received: from dbde70.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id n7PBakGN027810
	for <linux-omap@vger.kernel.org>; Tue, 25 Aug 2009 17:06:46 +0530 (IST)
In-Reply-To: <1250612150-16345-1-git-send-email-premi@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Premi, Sanjeev" <premi@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> -----Original Message-----
> From: Premi, Sanjeev 
> Sent: Tuesday, August 18, 2009 9:46 PM
> To: linux-omap@vger.kernel.org
> Cc: Premi, Sanjeev
> Subject: [PATCH] Runtime detection of OMAP35x devices
> 
> Add runtime check for these OMAP35x variations
> based on the detected Si features:
>   OMAP3503, OMAP3515, OMAP3525 and OMA3530.
> 
> Also, delayed the call to pr_info() into actual
> variant is detected in omap3_cpuinfo()
> 
> Signed-off-by: Sanjeev Premi <premi@ti.com>
> ---
>  arch/arm/mach-omap2/id.c              |   59 
> +++++++++++++++++++++++++++-----
>  arch/arm/plat-omap/include/mach/cpu.h |   25 ++++++++++++++
>  2 files changed, 74 insertions(+), 10 deletions(-)
> 
<snip>--<snip>

...and this one as well.

Best regards,
Sanjeev