From: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Subject: RE: [PATCH] ARM:VFPv3:enable {d16-d31} access
Date: Tue, 25 May 2010 21:13:52 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB0322FA8A6F@dbde02.ent.ti.com>
References: <Tarun Kanti DebBarma <tarun.kanti@ti.com>
 <1274818736-26597-1-git-send-email-tarun.kanti@ti.com>
 <5A47E75E594F054BAF48C5E4FC4B92AB0322FA884E@dbde02.ent.ti.com>
 <201005251526.52041.siarhei.siamashka@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:40041 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755119Ab0EYPoD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 25 May 2010 11:44:03 -0400
In-Reply-To: <201005251526.52041.siarhei.siamashka@gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Siarhei Siamashka <siarhei.siamashka@gmail.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hello Siarhei Siamashka,
Thanks for the inputs. Please see my comments.

-----Original Message-----
From: Siarhei Siamashka [mailto:siarhei.siamashka@gmail.com] 
Sent: Tuesday, May 25, 2010 5:57 PM
To: DebBarma, Tarun Kanti
Cc: linux-omap@vger.kernel.org; linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] ARM:VFPv3:enable {d16-d31} access

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

Are you saying following line generates code for {d16-d31}?
.irp	dr,0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15


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

I get following compilation error when:
-fmpu=vfp3 option used with
mrrc	p11, 3, r0, r1, c\dr instruction



arch/arm/vfp/vfphw.S:234: Error: co-processor register expected -- `mrrc p11,3,r0,r1,c16'
arch/arm/vfp/vfphw.S:234: Error: co-processor register expected -- `mrrc p11,3,r0,r1,c17'
arch/arm/vfp/vfphw.S:234: Error: co-processor register expected -- `mrrc p11,3,r0,r1,c18'
arch/arm/vfp/vfphw.S:234: Error: co-processor register expected -- `mrrc p11,3,r0,r1,c19'
arch/arm/vfp/vfphw.S:234: Error: co-processor register expected -- `mrrc p11,3,r0,r1,c20'
arch/arm/vfp/vfphw.S:234: Error: co-processor register expected -- `mrrc p11,3,r0,r1,c21'
arch/arm/vfp/vfphw.S:234: Error: co-processor register expected -- `mrrc p11,3,r0,r1,c22'
arch/arm/vfp/vfphw.S:234: Error: co-processor register expected -- `mrrc p11,3,r0,r1,c23'
arch/arm/vfp/vfphw.S:234: Error: co-processor register expected -- `mrrc p11,3,r0,r1,c24'
arch/arm/vfp/vfphw.S:234: Error: co-processor register expected -- `mrrc p11,3,r0,r1,c25'
arch/arm/vfp/vfphw.S:234: Error: co-processor register expected -- `mrrc p11,3,r0,r1,c26'
arch/arm/vfp/vfphw.S:234: Error: co-processor register expected -- `mrrc p11,3,r0,r1,c27'
arch/arm/vfp/vfphw.S:234: Error: co-processor register expected -- `mrrc p11,3,r0,r1,c28'
arch/arm/vfp/vfphw.S:234: Error: co-processor register expected -- `mrrc p11,3,r0,r1,c29'
arch/arm/vfp/vfphw.S:234: Error: co-processor register expected -- `mrrc p11,3,r0,r1,c30'
arch/arm/vfp/vfphw.S:234: Error: co-processor register expected -- `mrrc p11,3,r0,r1,c31'

Is this behavior expected? 
However I do not get the same when I use:
fmrrd	r0, r1, d\dr

Question: Is there any disadvantage of using: fmrrd	r0, r1, d\dr over the other one?

Thanks once again for your inputs.

-- 
Best regards,
Siarhei Siamashka
