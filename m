From: "Menon, Nishanth" <nm@ti.com>
Subject: RE: [PATCH 05/14] omap4: control: Add accessor api's for pad
 control module
Date: Fri, 17 Sep 2010 05:17:18 -0500
Message-ID: <7A436F7769CA33409C6B44B358BFFF0C014F13A77E@dlee02.ent.ti.com>
References: <1284716878-27667-1-git-send-email-santosh.shilimkar@ti.com>
 <1284716878-27667-2-git-send-email-santosh.shilimkar@ti.com>
 <1284716878-27667-3-git-send-email-santosh.shilimkar@ti.com>
 <1284716878-27667-4-git-send-email-santosh.shilimkar@ti.com>
 <1284716878-27667-5-git-send-email-santosh.shilimkar@ti.com>
 <1284716878-27667-6-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:57934 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751298Ab0IQKRW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 17 Sep 2010 06:17:22 -0400
In-Reply-To: <1284716878-27667-6-git-send-email-santosh.shilimkar@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Santosh Shilimkar
> Sent: Friday, September 17, 2010 4:48 AM
> 
> On OMAP4 control pad are not addressable from control
> core base. So the common omap_ctrl_read/write APIs breaks
> Hence export separate APIs to manage the omap4 pad control
> registers.
> 
> This APIs will work only for OMAP4

Cosmetic comment below:

> 
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> ---
>  arch/arm/mach-omap2/control.c             |   18 ++++++++++++++++++
>  arch/arm/plat-omap/include/plat/control.h |    4 ++++
>  2 files changed, 22 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/control.c b/arch/arm/mach-omap2/control.c
> index 99c0eb6..4ace2d1 100644
> --- a/arch/arm/mach-omap2/control.c
> +++ b/arch/arm/mach-omap2/control.c
> @@ -138,6 +138,7 @@ static struct omap3_control_regs control_context;
>  #endif /* CONFIG_ARCH_OMAP3 && CONFIG_PM */
> 
>  #define OMAP_CTRL_REGADDR(reg)		(omap2_ctrl_base + (reg))
> +#define OMAP_CTRL_PAD_REGADDR(reg)	(omap4_ctrl_pad_base + (reg))
s/ OMAP_CTRL_PAD_REGADDR/OMAP4_CTRL_PAD_REGADDR ?
[...]


Regards,
Nishanth Menon

