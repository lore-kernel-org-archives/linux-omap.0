From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [2/4] OMAP: DSS2: Renaming register macro DISPC_DIVISOR(ch)
Date: Wed, 16 Feb 2011 17:38:40 +0200
Message-ID: <1297870720.14556.9.camel@deskari>
References: <1296742161-9395-3-git-send-email-raghuveer.murthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:34594 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752365Ab1BPPin (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 16 Feb 2011 10:38:43 -0500
Received: from dlep36.itg.ti.com ([157.170.170.91])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id p1GFcgT7024978
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Wed, 16 Feb 2011 09:38:42 -0600
Received: from dlep26.itg.ti.com (localhost [127.0.0.1])
	by dlep36.itg.ti.com (8.13.8/8.13.8) with ESMTP id p1GFcg8A017420
	for <linux-omap@vger.kernel.org>; Wed, 16 Feb 2011 09:38:42 -0600 (CST)
Received: from dlee73.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id p1GFcgsU017169
	for <linux-omap@vger.kernel.org>; Wed, 16 Feb 2011 09:38:42 -0600 (CST)
In-Reply-To: <1296742161-9395-3-git-send-email-raghuveer.murthy@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Raghuveer Murthy <raghuveer.murthy@ti.com>
Cc: linux-omap@vger.kernel.org

Hi,

On Thu, 2011-02-03 at 14:09 +0000, Raghuveer Murthy wrote:
> Renamed DISPC_DIVISOR(ch) to DISPC_DIVISORo(ch), to facilitate introduction
> of DISPC_DIVISOR register, which is specific for OMAP4. OMAP4 has 3 registers
> DISPC_DIVISOR, DISPC_DIVISOR1 and DISPC_DIVISOR2.
> 
> Also updated, all the usages of DISPC_DIVISOR(ch) to DISPC_DIVISORo(ch).
> 
> OMAP4 TRM uses DISPC_DIVISORo generically to refer to DISPC_DIVISOR1 and
> DISPC_DIVISOR2
> 
> Signed-off-by: Raghuveer Murthy <raghuveer.murthy@ti.com>
> 
> ---
> drivers/video/omap2/dss/dispc.c |   31 ++++++++++++++++++-------------
>  1 files changed, 18 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
> index cc58208..e52a413 100644
> --- a/drivers/video/omap2/dss/dispc.c
> +++ b/drivers/video/omap2/dss/dispc.c
> @@ -72,7 +72,12 @@ struct dispc_reg { u16 idx; };
>  #define DISPC_TIMING_H(ch)		DISPC_REG(ch != 2 ? 0x0064 : 0x0400)
>  #define DISPC_TIMING_V(ch)		DISPC_REG(ch != 2 ? 0x0068 : 0x0404)
>  #define DISPC_POL_FREQ(ch)		DISPC_REG(ch != 2 ? 0x006C : 0x0408)
> -#define DISPC_DIVISOR(ch)		DISPC_REG(ch != 2 ? 0x0070 : 0x040C)
> +/*
> + * Use DISPC_DIVISORo(ch) when DISPC_DIVISOR1 or DISPC_DIVISOR2 has to be
> + * configured. OMAP4 TRM uses DISPC_DIVISORo generically to refer DISPC_DIVISOR1
> + * and DISPC_DIVISOR2
> + */

While comments are good, I think this is extra. The purpose of the
register is clear from TRM. I like to keep the code clean of
trivialities =). The same goes for the register comment in the next
patch also.

You could mention this in the patch description though, so that patch
reviewing is easier.

And about DISPC_DIVISORo, I think the TRM writer has typoed it, he meant
to write DISPC_DIVISORi =). But let's stick with the naming from TRM.

 Tomi


