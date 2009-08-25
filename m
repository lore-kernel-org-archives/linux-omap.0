From: "Premi, Sanjeev" <premi@ti.com>
Subject: RE: [PATCH v2] Runtime detection of Si features
Date: Tue, 25 Aug 2009 17:06:16 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301DD39A358@dbde02.ent.ti.com>
References: <1250509858-7951-1-git-send-email-premi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:59145 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752309AbZHYLgX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 25 Aug 2009 07:36:23 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id n7PBaJji017215
	for <linux-omap@vger.kernel.org>; Tue, 25 Aug 2009 06:36:24 -0500
Received: from dbde71.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id n7PBaI5Z027754
	for <linux-omap@vger.kernel.org>; Tue, 25 Aug 2009 17:06:18 +0530 (IST)
In-Reply-To: <1250509858-7951-1-git-send-email-premi@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Premi, Sanjeev" <premi@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> -----Original Message-----
> From: Premi, Sanjeev 
> Sent: Monday, August 17, 2009 5:21 PM
> To: linux-omap@vger.kernel.org
> Cc: Premi, Sanjeev
> Subject: [PATCH v2] Runtime detection of Si features
> 
> The OMAP35x family has multiple variants differing
> in the HW features. This patch detects these features
> at runtime and prints information during the boot.
> 
> Since most of the code seemed repetitive, macros
> have been used for readability.
> 
> Signed-off-by: Sanjeev Premi <premi@ti.com>
> ---
>  arch/arm/mach-omap2/id.c                  |   52 
> +++++++++++++++++++++++++++--
>  arch/arm/mach-omap2/mmc-twl4030.c         |    1 +
>  arch/arm/plat-omap/include/mach/control.h |   34 +++++++++++++++++++
>  arch/arm/plat-omap/include/mach/cpu.h     |   23 +++++++++++++
>  4 files changed, 107 insertions(+), 3 deletions(-)
> 
<snip>--<snip>

Hi Tony,

Where does this patch stand in your queue?

Best regards,
Sanjeev
