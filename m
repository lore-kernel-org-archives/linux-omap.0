From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RFC/PATCH] ARM: OMAP: Add IDCODE revision to system_rev
Date: Thu, 13 Mar 2008 13:48:56 +0200
Message-ID: <20080313114855.GH11653@atomide.com>
References: <20080306003550.GA2709@party>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:51884 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752013AbYCMLtL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 13 Mar 2008 07:49:11 -0400
Content-Disposition: inline
In-Reply-To: <20080306003550.GA2709@party>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kyungmin Park <kyungmin.park@samsung.com>
Cc: linux-omap@vger.kernel.org

* Kyungmin Park <kyungmin.park@samsung.com> [080306 02:36]:
> In previous kernel there's IDCODE revision. But recently it was removed.
> I hope it want to add this one to distinguish board revision.
> 
> Are there another way to combine Silicon revision with IDCODE one?
>
> Any comments are welcome.

Well this is not done currently for 34xx, and two bits are not
enough so we need something better here eventually..

Anyways, pushing today.

Tony



> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
> diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
> index a2109c1..dd53ae2 100644
> --- a/arch/arm/mach-omap2/id.c
> +++ b/arch/arm/mach-omap2/id.c
> @@ -168,10 +168,13 @@ void __init omap2_check_revision(void)
>  	 * system_rev & 0xffff0000 -> Omap type (2420/2422/2423/2430/3430)
>  	 * system_rev & 0x0000f000 -> Silicon revision (ES1, ES2 )
>  	 * system_rev & 0x00000700 -> Device Type ( EMU/HS/GP/BAD )
> +	 * system_rev & 0x000000c0 -> IDCODE revision[6:7]
>  	 * system_rev & 0x0000003f -> sys_boot[0:5]
>  	 */
>  	/* Embedding the ES revision info in type field */
>  	system_rev = omap_ids[j].type;
> +	/* Also add IDCODE revision info only two lower bits */
> +	system_rev |= ((rev & 0x3) << 6);
>  
>  	/* Add in the device type and sys_boot fields (see above) */
>  	if (cpu_is_omap24xx()) {
