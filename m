From: "Premi, Sanjeev" <premi@ti.com>
Subject: RE: [Patch v4] OMAP: AM3517/05: Add craneboard support
Date: Fri, 29 Oct 2010 15:02:15 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB593023475EBE5@dbde02.ent.ti.com>
References: <[PATCH] OMAP: AM3517/05: Add craneboard support>
 <1288336394-6320-1-git-send-email-srinath@mistralsolutions.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:46325 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751889Ab0J2JcX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 29 Oct 2010 05:32:23 -0400
In-Reply-To: <1288336394-6320-1-git-send-email-srinath@mistralsolutions.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "srinath@mistralsolutions.com" <srinath@mistralsolutions.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Kridner, Jason" <jdk@ti.com>, "tony@atomide.com" <tony@atomide.com>, "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>, "Menon, Nishanth" <nm@ti.com>, "nagendra@mistralsolutions.com" <nagendra@mistralsolutions.com>, "umeshk@mistralsolutions.com" <umeshk@mistralsolutions.com>

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org 
> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of 
> srinath@mistralsolutions.com
> Sent: Friday, October 29, 2010 12:43 PM
> To: linux-omap@vger.kernel.org
> Cc: Kridner, Jason; tony@atomide.com; 
> khilman@deeprootsystems.com; Menon, Nishanth; 
> nagendra@mistralsolutions.com; umeshk@mistralsolutions.com; Srinath
> Subject: [Patch v4] OMAP: AM3517/05: Add craneboard support
> 
> From: Srinath <srinath@mistralsolutions.com>
> 
> Craneboard is a hardware development platform based on the
> Sitara AM3517 ARM Cortex - A8 microprocessor device. This is a
> low cost reference design.
> 
> This patch adds basic board file. Detailed support will follow in
> subsequent patches.
> 
>   [1] http://www.ti.com/sitara
>   [2] http://www.ti.com/arm
>   [3] 
> http://tiexpressdsp.com/index.php?title=Applications_Processor
s_Crossreference
>   [4] http://marc.info/?l=linux-omap&m=125615009412281&w=2
>   [5] http://www.mistralsolutions.com/products/craneboard.php
> 
> History and comments:
> http://marc.info/?l=linux-omap&w=2&r=1&s=craneboard&q=b
> 
> Signed-off-by: Srinath <srinath@mistralsolutions.com>
> ---
>  arch/arm/mach-omap2/Kconfig                  |    5 ++
>  arch/arm/mach-omap2/Makefile                 |    2 +
>  arch/arm/mach-omap2/board-am3517crane.c      |   69 
> ++++++++++++++++++++++++++
>  arch/arm/plat-omap/include/plat/uncompress.h |    1 +
>  4 files changed, 77 insertions(+), 0 deletions(-)
>  create mode 100644 arch/arm/mach-omap2/board-am3517crane.c
> 

Acked-by: Sanjeev Premi <premi@ti.com>

[snip]
