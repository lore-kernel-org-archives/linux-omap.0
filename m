From: "Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>
Subject: RE: [RESEND][Review Request] Adding csi2_fck declaration to
	clock34xx.h
Date: Tue, 2 Sep 2008 18:03:26 -0500
Message-ID: <A24693684029E5489D1D202277BE894411A07841@dlee02.ent.ti.com>
References: <20080902223749.GH6814@frodo>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:41701 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752220AbYIBXDh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 2 Sep 2008 19:03:37 -0400
In-Reply-To: <20080902223749.GH6814@frodo>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "me@felipebalbi.com" <me@felipebalbi.com>
Cc: Paul Walmsley <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Felipe,

I corrected the indentation as well as the initialization of clkdm, I'll resend the new patch.

About the OMAP3430_EN_CSI2 and OMAP3430_EN_CSI2_SHIFT defines, they look aligned in the final file, although in the patch looks unaligned. That space in the beginning of the patch line seems to be critical to look aligned... :/

Thanks for your time.

Regards,
Sergio

-----Original Message-----
From: Felipe Balbi [mailto:me@felipebalbi.com] 
Sent: Tuesday, September 02, 2008 5:38 PM
To: Aguirre Rodriguez, Sergio Alberto
Cc: Paul Walmsley; linux-omap@vger.kernel.org
Subject: Re: [RESEND][Review Request] Adding csi2_fck declaration to clock34xx.h

On Tue, Sep 02, 2008 at 05:33:55PM -0500, Aguirre Rodriguez, Sergio Alberto wrote:
> +static struct clk csi2_96m_fck = {
> +        .name           = "csi2_96m_fck",
> +        .parent         = &core_96m_fck,
> +        .init           = &omap2_init_clk_clkdm,
> +        .enable_reg     = _OMAP34XX_CM_REGADDR(OMAP3430_CAM_MOD, CM_FCLKEN),
> +        .enable_bit     = OMAP3430_EN_CSI2_SHIFT,
> +        .flags          = CLOCK_IN_OMAP343X,
> +	.clkdm		= { .name = "cam_clkdm" },
> +        .recalc         = &followparent_recalc,
> +};

do not use spaces for identation, I think it's a mailer problem. Try to
use git send-email. Also, clkdm should be initialized as:

	.clkdm		= {
		.name	= "cam_clkdm",
	},

>  /* CM_FCLKEN_CAM specific bits */
> +#define OMAP3430_EN_CSI2				(1 << 1)
> +#define OMAP3430_EN_CSI2_SHIFT				1

align these with the rest of the file

-- 
balbi

