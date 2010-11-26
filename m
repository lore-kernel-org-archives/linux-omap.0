From: MyungJoo Ham <myungjoo.ham@gmail.com>
Subject: Re: [RFC][PATCH 1/1] ARM: Add initial hibernation support
Date: Fri, 26 Nov 2010 16:39:43 +0900
Message-ID: <AANLkTin-ZCb7bdYhtUe00cPMs7m+Kjp0=4EEQ38i0q5Y@mail.gmail.com>
References: <1277908081-17195-1-git-send-email-Hiroshi.DOYU@nokia.com>
	<1277908081-17195-2-git-send-email-Hiroshi.DOYU@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:43648 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753186Ab0KZHjp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 26 Nov 2010 02:39:45 -0500
Received: by fxm15 with SMTP id 15so471274fxm.19
        for <linux-omap@vger.kernel.org>; Thu, 25 Nov 2010 23:39:44 -0800 (PST)
In-Reply-To: <1277908081-17195-2-git-send-email-Hiroshi.DOYU@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Cc: linux-arm-kernel@lists.infradead.org, khilman@deeprootsystems.com, Yoshiya.Hirase@nokia.com, teerth@ti.com, linux-pm@lists.linux-foundation.org, linux-omap@vger.kernel.org

On Wed, Jun 30, 2010 at 11:28 PM, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>=
 wrote:
> From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
>
> Hibernation (a.k.a: Suspend-To-Disk) support for ARM
>
> Based on the original work from Romit and Raghu at TI. The original
> patch(*1) was sent to LOML by Teerth Reddy <teerth@ti.com>
>
> *1: https://patchwork.kernel.org/patch/96442/
>
> Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>

(snip)

> +config ARCH_HIBERNATION_POSSIBLE
> + =A0 =A0 =A0 def_bool y
> + =A0 =A0 =A0 depends on CPU_V7 && !SMP
> +

(snip)

> +/*
> + * FIXME: Only support for Cortex A8 now
> + */

(snip)

> --- a/arch/arm/kernel/vmlinux.lds.S
> +++ b/arch/arm/kernel/vmlinux.lds.S
> @@ -149,7 +149,6 @@ SECTIONS
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0__init_end =3D .;
> =A0#endif
>
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 NOSAVE_DATA
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0CACHELINE_ALIGNED_DATA(32)
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/*
> @@ -172,6 +171,8 @@ SECTIONS
> =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0_edata_loc =3D __data_loc + SIZEOF(.data);
>
> + =A0 =A0 =A0 NOSAVE_DATA
> +
> =A0#ifdef CONFIG_HAVE_TCM
> =A0 =A0 =A0 =A0 /*
> =A0 =A0 =A0 =A0 * We align everything to a page boundary so we can
> --

I have been working on the hibernation feature on S5PC210 (ARM Cortex
A9 MP-Core) based on this patch and it's working find with minor
modifications. (and will send as soon as clutters are removed and
tested further)

However, I've got a question on your patch: is it really necessary to
patch [arch/arm/kernel/vmlinux.lds.S] file? Without patching that
file, it works fine at my system (although it's based on 2.6.36, not
37 rc #) and with that patch, the linker spits an error. If it's
necessary to patch [arch/arm/kernel/vmlinux.lds.S], could you please
explain a bit about it?

Thank you.


- MyungJoo

> 1.7.1.rc2
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>



--=20
MyungJoo Ham, Ph.D.
Mobile Software Platform Lab,
Digital Media and Communications (DMC) Business
Samsung Electronics
cell: 82-10-6714-2858
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
