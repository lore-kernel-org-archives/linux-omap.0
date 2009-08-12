From: "Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>
Subject: RE: [PATCH v2 5/6] ARM: OMAP4: PM: Adds CM1/2 register defs for
 OMAP4
Date: Wed, 12 Aug 2009 12:40:31 -0500
Message-ID: <A24693684029E5489D1D202277BE89444A6ED6C0@dlee02.ent.ti.com>
References: <1250087254-28653-1-git-send-email-rnayak@ti.com>
 <1250087254-28653-2-git-send-email-rnayak@ti.com>
 <1250087254-28653-3-git-send-email-rnayak@ti.com>
 <1250087254-28653-4-git-send-email-rnayak@ti.com>
 <1250087254-28653-5-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:59906 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754632AbZHLRhB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 12 Aug 2009 13:37:01 -0400
In-Reply-To: <1250087254-28653-5-git-send-email-rnayak@ti.com>
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
> Subject: [PATCH v2 5/6] ARM: OMAP4: PM: Adds CM1/2 register defs for OMAP4
> 
> This patch adds OMAP4 specific CM1 and CM2 module
> register defs and corresponding register field bit
> shifts
> 
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> ---
>  arch/arm/mach-omap2/cm.h               |  249
> +++++++++++++++++++++++++++++-
>  arch/arm/mach-omap2/cm1-regbits-44xx.h |  161 +++++++++++++++++++
>  arch/arm/mach-omap2/cm2-regbits-44xx.h |  269
> ++++++++++++++++++++++++++++++++
>  3 files changed, 678 insertions(+), 1 deletions(-)
>  create mode 100644 arch/arm/mach-omap2/cm1-regbits-44xx.h
>  create mode 100644 arch/arm/mach-omap2/cm2-regbits-44xx.h
> 
> diff --git a/arch/arm/mach-omap2/cm.h b/arch/arm/mach-omap2/cm.h
> index 1d3c93b..19f7aeb 100644
> --- a/arch/arm/mach-omap2/cm.h
> +++ b/arch/arm/mach-omap2/cm.h
> @@ -4,10 +4,11 @@
>  /*
>   * OMAP2/3 Clock Management (CM) register definitions

According to the new content, this should be updated aswell, like:

OMAP2/3/4 Clock Management (CM) register definitions

Regards,
Sergio

<snip>

