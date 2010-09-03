From: "Premi, Sanjeev" <premi@ti.com>
Subject: RE: [PATCH 1/1] omap2/3: Update revision identification
Date: Fri, 3 Sep 2010 13:51:01 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301F6BC896F@dbde02.ent.ti.com>
References: <1281973989-2484-1-git-send-email-premi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:50705 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752873Ab0ICIVG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 3 Sep 2010 04:21:06 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id o838L3Dg012172
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Fri, 3 Sep 2010 03:21:05 -0500
Received: from dbde71.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id o838L2nR012555
	for <linux-omap@vger.kernel.org>; Fri, 3 Sep 2010 13:51:02 +0530 (IST)
In-Reply-To: <1281973989-2484-1-git-send-email-premi@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> -----Original Message-----
> From: Premi, Sanjeev 
> Sent: Monday, August 16, 2010 9:23 PM
> To: linux-omap@vger.kernel.org
> Cc: Premi, Sanjeev
> Subject: [PATCH 1/1] omap2/3: Update revision identification
> 
> The existing definitions for cpu revision used
> upper nibble in the bits[15:08]. With OMAP3630,
> definitions use lower nibble.
> 
> This patch unifies the definitions to start
> at lower nibble.
> 
>   [1] http://marc.info/?t=128161739100005&r=1&w=2
> 
> Signed-off-by: Sanjeev Premi <premi@ti.com>
> ---
>  arch/arm/mach-omap2/id.c              |   22 +++++++++++---------
>  arch/arm/plat-omap/include/plat/cpu.h |   36 
> ++++++++++++++++----------------

Hi Tony,

Did you have chance to look at this?
(I was away from work; couldn't follow-up earlier).

Best regards,
Sanjeev

[snip]--[snip]
