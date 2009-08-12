From: "Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>
Subject: RE: [PATCH v2 3/6] ARM: OMAP4: PM: Adds PRM register defs for OMAP4
Date: Wed, 12 Aug 2009 12:37:28 -0500
Message-ID: <A24693684029E5489D1D202277BE89444A6ED6AD@dlee02.ent.ti.com>
References: <1250087254-28653-1-git-send-email-rnayak@ti.com>
 <1250087254-28653-2-git-send-email-rnayak@ti.com>
 <1250087254-28653-3-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:55360 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753945AbZHLReD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 12 Aug 2009 13:34:03 -0400
In-Reply-To: <1250087254-28653-3-git-send-email-rnayak@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Nayak, Rajendra" <rnayak@ti.com>, "linux-arm-kernel@lists.arm.linux.org.uk" <linux-arm-kernel@lists.arm.linux.org.uk>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Rajendra,

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Nayak, Rajendra
> Sent: Wednesday, August 12, 2009 9:28 AM
> To: linux-arm-kernel@lists.arm.linux.org.uk
> Cc: linux-omap@vger.kernel.org; Nayak, Rajendra
> Subject: [PATCH v2 3/6] ARM: OMAP4: PM: Adds PRM register defs for OMAP4
> 
> This patch adds OMAP4 specific PRM register defs
> 
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> ---
>  arch/arm/mach-omap2/prm.h |  293
> ++++++++++++++++++++++++++++++++++++++++++++-
>  1 files changed, 292 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/prm.h b/arch/arm/mach-omap2/prm.h
> index 9937e28..7e27585 100644
> --- a/arch/arm/mach-omap2/prm.h
> +++ b/arch/arm/mach-omap2/prm.h
> @@ -4,10 +4,11 @@
>  /*
>   * OMAP2/3 Power/Reset Management (PRM) register definitions

According to the new content, this should be updated aswell, like:

OMAP2/3/4 Power/Reset Management (PRM) register definitions

Regards,
Sergio

<snip>
