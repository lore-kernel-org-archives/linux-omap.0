From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: RE: [PATCH] omap4: Fix build break when used with gcc-4.4.1
 (2009-q3)
Date: Fri, 19 Mar 2010 21:42:43 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02C4948018@dbde02.ent.ti.com>
References: <1268891188-31562-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:59055 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753371Ab0CSQMs convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 19 Mar 2010 12:12:48 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id o2JGCj8d006321
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Fri, 19 Mar 2010 11:12:47 -0500
Received: from dbde70.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id o2JGCh5j010349
	for <linux-omap@vger.kernel.org>; Fri, 19 Mar 2010 21:42:44 +0530 (IST)
In-Reply-To: <1268891188-31562-1-git-send-email-santosh.shilimkar@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Woodruff, Richard" <r-woodruff2@ti.com>

Tony, 
> -----Original Message-----
> From: Shilimkar, Santosh
> Sent: Thursday, March 18, 2010 11:16 AM
> To: linux-omap@vger.kernel.org
> Cc: Woodruff, Richard; Shilimkar, Santosh
> Subject: [PATCH] omap4: Fix build break when used with gcc-4.4.1 (2009-q3)
> 
> From: Richard Woodruff <r-woodruff2@ti.com>
> 
> This patch adds  argument to smc calls as gcc-4.4.1 requires it
> otherwise the build breaks with 2009-q3 toolchanin.
> 
> arch/arm/mach-omap2/omap-headsmp.S: Assembler messages:
> arch/arm/mach-omap2/omap-headsmp.S:36: Error: missing expression -- `smc'
> arch/arm/mach-omap2/omap-headsmp.S:55: Error: missing expression -- `smc'
> arch/arm/mach-omap2/omap-headsmp.S:63: Error: missing expression -- `smc'
> make[1]: *** [arch/arm/mach-omap2/omap-headsmp.o] Error 1
> 
> Signed-off-by: Richard Woodruff <r-woodruff2@ti.com>
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> ---
> The patch is generated against linux-omap  "omap-fixes-for-linus" and
> also applies on master branch. Boot tesetd on omap4430 SDP.
> 
If you are fine with the patch can you 
merge this in l-o master ?

>  arch/arm/mach-omap2/omap-headsmp.S |    6 +++---
>  arch/arm/mach-omap2/omap44xx-smc.S |    2 +-
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/omap-headsmp.S b/arch/arm/mach-omap2/omap-headsmp.S
> index aa3f65c..ef0e7a0 100644
> --- a/arch/arm/mach-omap2/omap-headsmp.S
> +++ b/arch/arm/mach-omap2/omap-headsmp.S
> @@ -33,7 +33,7 @@
>  ENTRY(omap_secondary_startup)
>  hold:	ldr	r12,=0x103
>  	dsb
> -	smc				@ read from AuxCoreBoot0
> +	smc	#0			@ read from AuxCoreBoot0
>  	mov	r0, r0, lsr #9
>  	mrc	p15, 0, r4, c0, c0, 5
>  	and	r4, r4, #0x0f
> @@ -52,7 +52,7 @@ ENTRY(omap_modify_auxcoreboot0)
>  	stmfd   sp!, {r1-r12, lr}
>  	ldr	r12, =0x104
>  	dsb
> -	smc
> +	smc	#0
>  	ldmfd   sp!, {r1-r12, pc}
>  END(omap_modify_auxcoreboot0)
> 
> @@ -60,6 +60,6 @@ ENTRY(omap_auxcoreboot_addr)
>  	stmfd   sp!, {r2-r12, lr}
>  	ldr	r12, =0x105
>  	dsb
> -	smc
> +	smc	#0
>  	ldmfd   sp!, {r2-r12, pc}
>  END(omap_auxcoreboot_addr)
> diff --git a/arch/arm/mach-omap2/omap44xx-smc.S b/arch/arm/mach-omap2/omap44xx-smc.S
> index 89bb2b1..f61c777 100644
> --- a/arch/arm/mach-omap2/omap44xx-smc.S
> +++ b/arch/arm/mach-omap2/omap44xx-smc.S
> @@ -27,6 +27,6 @@ ENTRY(omap_smc1)
>  	mov	r12, r0
>  	mov 	r0, r1
>  	dsb
> -	smc
> +	smc	#0
>  	ldmfd   sp!, {r2-r12, pc}
>  END(omap_smc1)
> --
> 1.6.0.4

