From: "Curran, Dominic" <dcurran@ti.com>
Subject: RE: [PATCH 1/2] OMAP3430SDP: Remove unneded extern line
Date: Wed, 25 Feb 2009 16:58:17 -0600
Message-ID: <96DA7A230D3B2F42BA3EF203A7A1B3B5012E7742FA@dlee07.ent.ti.com>
References: <A24693684029E5489D1D202277BE89442DF8399A@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:35853 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762915AbZBYW6Z convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 25 Feb 2009 17:58:25 -0500
Received: from dlep95.itg.ti.com ([157.170.170.107])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id n1PMwJdS002637
	for <linux-omap@vger.kernel.org>; Wed, 25 Feb 2009 16:58:24 -0600
Received: from dlee75.ent.ti.com (localhost [127.0.0.1])
	by dlep95.itg.ti.com (8.13.8/8.13.8) with ESMTP id n1PMwJXu017971
	for <linux-omap@vger.kernel.org>; Wed, 25 Feb 2009 16:58:19 -0600 (CST)
In-Reply-To: <A24693684029E5489D1D202277BE89442DF8399A@dlee02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Syed Mohammed, Khasim" <khasim@ti.com>



> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Aguirre Rodriguez, Sergio Alberto
> Sent: Wednesday, February 25, 2009 4:03 PM
> To: linux-omap@vger.kernel.org
> Cc: Syed Mohammed, Khasim
> Subject: [PATCH 1/2] OMAP3430SDP: Remove unneded extern line
>
> From 9ec9fef55a7fbfc9f813a521bed6158db1aad46f Mon Sep 17 00:00:00 2001
> From: Sergio Aguirre <saaguirre@ti.com>
> Date: Wed, 25 Feb 2009 15:26:35 -0600
> Subject: [PATCH 1/2] OMAP3430SDP: Remove unneded extern line
>
> This patch removes a duplicate extern on board-3430sdp.c
> file, as it is present already on
>
> arch/arm/plat-omap/include/mach/board-3430sdp.h
>
> Found by doing a checkpatch.pl run with board-3430sdp.c
>
> Signed-off-by: Sergio Aguirre <saaguirre@ti.com>


Acked-by: Dominic Curran <dcurran@ti.com>

> ---
>  arch/arm/mach-omap2/board-3430sdp.c |    2 --
>  1 files changed, 0 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/board-3430sdp.c b/arch/arm/mach-omap2/board-
> 3430sdp.c
> index 758183c..ab0aa7d 100644
> --- a/arch/arm/mach-omap2/board-3430sdp.c
> +++ b/arch/arm/mach-omap2/board-3430sdp.c
> @@ -623,8 +623,6 @@ static int __init omap3430_i2c_init(void)
>       return 0;
>  }
>
> -extern void __init sdp3430_flash_init(void);
> -
>  static void __init omap_3430sdp_init(void)
>  {
>       omap3430_i2c_init();
> --
> 1.5.6.5
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

