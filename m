From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCHv3 01/22] OMAP3: PM: Adding hwmod data for Smartreflex
Date: Tue, 27 Apr 2010 10:34:06 -0700
Message-ID: <87r5m0ol4h.fsf@deeprootsystems.com>
References: <1271408597-3066-1-git-send-email-thara@ti.com>
	<1271408597-3066-2-git-send-email-thara@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:55839 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756133Ab0D0ReL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 27 Apr 2010 13:34:11 -0400
Received: by pwj9 with SMTP id 9so9604666pwj.19
        for <linux-omap@vger.kernel.org>; Tue, 27 Apr 2010 10:34:10 -0700 (PDT)
In-Reply-To: <1271408597-3066-2-git-send-email-thara@ti.com> (Thara Gopinath's message of "Fri\, 16 Apr 2010 14\:32\:56 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Thara Gopinath <thara@ti.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, b-cousson@ti.com, vishwanath.bs@ti.com, sawant@ti.com

Thara Gopinath <thara@ti.com> writes:

> This patch adds the hwmod strucutres and other hwmod data for
> OMAP3 Smartreflex IP's.

Should also comment about the additional data used in dev_attr as well.

> Signed-off-by: Thara Gopinath <thara@ti.com>
> ---
>  arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |  135 ++++++++++++++++++++++++++++
>  arch/arm/mach-omap2/smartreflex.h          |   33 +++++++
>  2 files changed, 168 insertions(+), 0 deletions(-)
>

[...]

> diff --git a/arch/arm/mach-omap2/smartreflex.h b/arch/arm/mach-omap2/smartreflex.h
> index 2a0e823..d239eb2 100644
> --- a/arch/arm/mach-omap2/smartreflex.h
> +++ b/arch/arm/mach-omap2/smartreflex.h
> @@ -237,6 +237,39 @@ extern u32 current_vdd2_opp;
>  #define SR_TESTING_NVALUES 	0
>  #endif
>  
> +/**
> + * omap_smartreflex_dev_data - Smartreflex device specific data
> + *
> + * @volts_supported	: Number of distinct voltages possible for the VDD
> + *			  associated with this smartreflex module.
> + * @efuse_sr_control	: The regisrter offset of control_fuse_sr efuse
> + *			  register from which sennenable and senpenable values
> + *			  are obtained.
> + * @sennenable_shift	: The shift in the control_fuse_sr register for
> + *			  obtaining the sennenable value for this smartreflex
> + *			  module.
> + * @senpenable_shift	: The shift in the control_fuse_sr register for
> + *			  obtaining the senpenable value for this smartreflex
> + *			  module.
> + * @efuse_nvalues_offs	: Array of efuse offsets from which ntarget values can
> + *			  be retrieved. Number of efuse offsets in this arrray
> + *			  is equal to the volts_supported value ie one efuse
> + *			  register per supported voltage.
> + * @test_sennenable	: SENNENABLE test value
> + * @test_senpenable	: SENPENABLE test value.
> + * @test_nvalues	: Array of test ntarget values.
> + */
> +struct omap_smartreflex_dev_data {

Minor nit here, but this could be named omap_sr_dev_data to
keep the name shorter and avoid some of the wrapping that has to
be done in other code because of this.

Kevin
