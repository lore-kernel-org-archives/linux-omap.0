From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [RESEND][Review Request] Adding csi2_fck declaration to
	clock34xx.h
Date: Wed, 3 Sep 2008 01:37:52 +0300
Message-ID: <20080902223749.GH6814@frodo>
References: <A24693684029E5489D1D202277BE894411A0781F@dlee02.ent.ti.com>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:47864 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751457AbYIBWiM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 2 Sep 2008 18:38:12 -0400
Content-Disposition: inline
In-Reply-To: <A24693684029E5489D1D202277BE894411A0781F@dlee02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

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
