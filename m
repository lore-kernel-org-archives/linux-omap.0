From: Siarhei Siamashka <siarhei.siamashka@gmail.com>
Subject: Re: [PATCH] ARM:VFPv3:enable {d16-d31} access
Date: Tue, 25 May 2010 15:26:51 +0300
Message-ID: <201005251526.52041.siarhei.siamashka@gmail.com>
References: <Tarun Kanti DebBarma <tarun.kanti@ti.com> <1274818736-26597-1-git-send-email-tarun.kanti@ti.com> <5A47E75E594F054BAF48C5E4FC4B92AB0322FA884E@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:46405 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756131Ab0EYM04 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 25 May 2010 08:26:56 -0400
Received: by mail-fx0-f46.google.com with SMTP id 5so3261194fxm.19
        for <linux-omap@vger.kernel.org>; Tue, 25 May 2010 05:26:56 -0700 (PDT)
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB0322FA884E@dbde02.ent.ti.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Tuesday 25 May 2010, DebBarma, Tarun Kanti wrote:
> (Including ARM mailing list)
>
> From: Tarun Kanti Debbarma <a0876346@a0876346-desktop.(none)>
>
> This patch attempts to fix two related problems:
>
> (1) vfp_get_double(), vfp_put_double() functions have VFPv3 specific
> implementation guarded within CONFIG_VFPv3 macro. The intent is to access
> {d16-d31} additional registers provided in VFPv3. However, it still wrongly
> refers to {d0-d15}. This has been corrected.

This does not seem to be the case, see below.

> (2) While compiling the above changes, it produced compilation error
> because arch/arm/vfp/Makefile had the -mfpu=vfp option which could not
> recognize VFPv3 registers. This has been corrected to -mfpu=vfp3. With this
> option we are also able to compile pre-VFPv3 code.
>
> Signed-off-by: Tarun Kanti Debbarma <tarun.kanti@ti.com>
> ---
>  arch/arm/vfp/Makefile |    2 +-
>  arch/arm/vfp/vfphw.S  |    8 ++++----
>  2 files changed, 5 insertions(+), 5 deletions(-)
>  mode change 100644 => 100755 arch/arm/vfp/vfphw.S
>
> diff --git a/arch/arm/vfp/Makefile b/arch/arm/vfp/Makefile
> index 39f6d8e..75855c0 100644
> --- a/arch/arm/vfp/Makefile
> +++ b/arch/arm/vfp/Makefile
> @@ -7,7 +7,7 @@
>  # EXTRA_CFLAGS := -DDEBUG
>  # EXTRA_AFLAGS := -DDEBUG
>
> -KBUILD_AFLAGS	:=$(KBUILD_AFLAGS:-msoft-float=-Wa,-mfpu=softvfp+vfp)
> +KBUILD_AFLAGS	:=$(KBUILD_AFLAGS:-msoft-float=-Wa,-mfpu=vfp3
> -mfloat-abi=softfp) LDFLAGS		+=--no-warn-mismatch
>
>  obj-y			+= vfp.o
> diff --git a/arch/arm/vfp/vfphw.S b/arch/arm/vfp/vfphw.S
> old mode 100644
> new mode 100755
> index 66dc2d0..b034076
> --- a/arch/arm/vfp/vfphw.S
> +++ b/arch/arm/vfp/vfphw.S
> @@ -254,8 +254,8 @@ ENTRY(vfp_get_double)
>  	.endr
>  #ifdef CONFIG_VFPv3
>  	@ d16 - d31 registers
> -	.irp	dr,0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15
> -1:	mrrc	p11, 3, r0, r1, c\dr	@ fmrrd	r0, r1, d\dr
> +	.irp	dr,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31
> +1:	fmrrd	r0, r1, d\dr

The existing code does exactly the same, but avoids the need to
specify -mfpu=vfp3 option. It's quite easy to verify:

/**** test.S *******/
test:
    mrrc  p11, 3, r0, r1, c0
    fmrrd r0, r1, d16
/*******************/

gcc -c test.S
objdump -d test.o

Disassembly of section .text:

00000000 <test>:
   0:   ec510b30        vmov    r0, r1, d16
   4:   ec510b30        vmov    r0, r1, d16

The comment in the existing code is a bit misleading though.

-- 
Best regards,
Siarhei Siamashka
