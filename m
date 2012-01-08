From: Sakari Ailus <sakari.ailus@iki.fi>
Subject: Re: [PATCH 1/1] omap3: add definition for CONTROL_CAMERA_PHY_CTRL
Date: Sun, 8 Jan 2012 12:43:40 +0200
Message-ID: <20120108104339.GP9323@valkosipuli.localdomain>
References: <1323875656-17147-1-git-send-email-sakari.ailus@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp-68.nebula.fi ([83.145.220.68]:32919 "EHLO
	smtp-68.nebula.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751264Ab2AHKnp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 8 Jan 2012 05:43:45 -0500
Content-Disposition: inline
In-Reply-To: <1323875656-17147-1-git-send-email-sakari.ailus@iki.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, paul@pwsan.com
Cc: linux-omap@vger.kernel.org, laurent.pinchart@ideasonboard.com

Hi Tony and Paul,

On Wed, Dec 14, 2011 at 05:14:16PM +0200, Sakari Ailus wrote:
> The register is used to configure the behaviour of the CSI-2 and CCP-2
> receivers. This register is available only in OMAP3630.
> 
> The original patch was submitted by Vimarsh Zutshi.
> 
> Signed-off-by: Sakari Ailus <sakari.ailus@iki.fi>
> ---
>  arch/arm/mach-omap2/control.h |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/control.h b/arch/arm/mach-omap2/control.h
> index d4ef75d..6a26a0d 100644
> --- a/arch/arm/mach-omap2/control.h
> +++ b/arch/arm/mach-omap2/control.h
> @@ -183,6 +183,7 @@
>  #define OMAP3630_CONTROL_FUSE_OPP120_VDD1       (OMAP2_CONTROL_GENERAL + 0x0120)
>  #define OMAP3630_CONTROL_FUSE_OPP50_VDD2        (OMAP2_CONTROL_GENERAL + 0x0128)
>  #define OMAP3630_CONTROL_FUSE_OPP100_VDD2       (OMAP2_CONTROL_GENERAL + 0x012C)
> +#define OMAP3630_CONTROL_CAMERA_PHY_CTRL	(OMAP2_CONTROL_GENERAL + 0x02f0)

I assume this patch hasn't gone anywhere yet which might be good. While the
definition of this register would appear to belong to this file, it is being
included from the OMAP 3 ISP driver, which only uses it if it's running on
the 3630. The problem is that control.h isn't apparently intended to be
included except locally and I didn't find a suitable file under include/mach
to put this definition either. Currently this file is being included by the
ISP driver with an explicit path.

Do you have an insight how this could be handled better?

Kind regards,

-- 
Sakari Ailus
e-mail: sakari.ailus@iki.fi	jabber/XMPP/Gmail: sailus@retiisi.org.uk
