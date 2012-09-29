From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 3/4] ARM: OMAP: Move omap_reserve() locally to
	mach-omap1/2
Date: Sat, 29 Sep 2012 20:39:44 +0100
Message-ID: <20120929193944.GB15246@n2100.arm.linux.org.uk>
References: <1348839609-10456-1-git-send-email-lokeshvutla@ti.com> <1348839609-10456-4-git-send-email-lokeshvutla@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:43804 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932157Ab2I2Tjy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 29 Sep 2012 15:39:54 -0400
Content-Disposition: inline
In-Reply-To: <1348839609-10456-4-git-send-email-lokeshvutla@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Lokesh Vutla <lokeshvutla@ti.com>
Cc: tony@atomide.com, linux-omap@vger.kernel.org, santosh.shilimkar@ti.com, linux-arm-kernel@lists.infradead.org

On Fri, Sep 28, 2012 at 07:10:08PM +0530, Lokesh Vutla wrote:
> omap_reserve() is a stub for omap1. So creating a
> stub locally in mach-omap1. And moving the definition
> to mach-omap2.
> This helps in moving plat/omap_secure.h local to
> mach-omap2
> 
> Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
> Acked-by : Santosh Shilimkar <santosh.shilimkar@ti.com>
> ---
>  arch/arm/mach-omap1/common.h             |    3 +++
>  arch/arm/mach-omap2/common.c             |   20 ++++++++++++++++++++
>  arch/arm/mach-omap2/common.h             |    1 +
>  arch/arm/plat-omap/common.c              |   17 -----------------
>  arch/arm/plat-omap/include/plat/common.h |    1 -
>  5 files changed, 24 insertions(+), 18 deletions(-)
> 
> diff --git a/arch/arm/mach-omap1/common.h b/arch/arm/mach-omap1/common.h
> index c2552b2..f7b01f1 100644
> --- a/arch/arm/mach-omap1/common.h
> +++ b/arch/arm/mach-omap1/common.h
> @@ -90,4 +90,7 @@ extern int ocpi_enable(void);
>  static inline int ocpi_enable(void) { return 0; }
>  #endif
>  
> +static inline void omap_reserve(void)
> +{ }

This is the wrong approach.  If OMAP1 doesn't need to do any reservation,
then OMAP1 platforms should not be calling omap_reserve() and OMAP1 should
not have this defined.

Just because OMAP2 does something one way does not mean OMAP1 needs to
copy it in every detail.
