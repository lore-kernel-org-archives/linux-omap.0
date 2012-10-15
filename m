From: Mans Rullgard <mans.rullgard@linaro.org>
Subject: Re: [PATCH] ARM: vfp: fix save and restore when running on pre-VFPv3
 and CONFIG_VFPv3 set
Date: Mon, 15 Oct 2012 03:39:07 +0100
Message-ID: <CAG5Tg6XqpeRppWbr9-yBmsf+2TobhE5ateMX4crs10grn-tuAA@mail.gmail.com>
References: <alpine.DEB.2.00.1210130441300.5736@utopia.booyaka.com>
	<20121013090255.GT28061@n2100.arm.linux.org.uk>
	<yw1xr4p2myre.fsf@unicorn.mansr.com>
	<20121013133654.GU28061@n2100.arm.linux.org.uk>
	<alpine.DEB.2.00.1210150157400.16624@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:58219 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753708Ab2JOCjJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 14 Oct 2012 22:39:09 -0400
Received: by mail-lb0-f174.google.com with SMTP id n3so3141632lbo.19
        for <linux-omap@vger.kernel.org>; Sun, 14 Oct 2012 19:39:07 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1210150157400.16624@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Catalin Marinas <catalin.marinas@arm.com>, Dave Martin <dave.martin@linaro.org>

On 15 October 2012 02:58, Paul Walmsley <paul@pwsan.com> wrote:
>
> Fix by implementing a request from Russell King to add a new HWCAP
> flag that affirmatively indicates the presence of the d16-d31
> registers:

[...]

> diff --git a/arch/arm/include/uapi/asm/hwcap.h b/arch/arm/include/uapi/asm/hwcap.h
> index f254f65..b1555d0 100644
> --- a/arch/arm/include/uapi/asm/hwcap.h
> +++ b/arch/arm/include/uapi/asm/hwcap.h
> @@ -18,11 +18,12 @@
>  #define HWCAP_THUMBEE  (1 << 11)
>  #define HWCAP_NEON     (1 << 12)
>  #define HWCAP_VFPv3    (1 << 13)
> -#define HWCAP_VFPv3D16 (1 << 14)
> +#define HWCAP_VFPv3D16 (1 << 14)       /* also set for VFPv4-D16 */
>  #define HWCAP_TLS      (1 << 15)
>  #define HWCAP_VFPv4    (1 << 16)
>  #define HWCAP_IDIVA    (1 << 17)
>  #define HWCAP_IDIVT    (1 << 18)
> +#define HWCAP_VFPD16   (1 << 19)       /* set if VFP has 32 regs (not 16) */
>  #define HWCAP_IDIV     (HWCAP_IDIVA | HWCAP_IDIVT)

Please consider calling the new flag VFPD32 or so instead.  The D16 suffix
usually signifies an implementation with 16 registers, i.e. the opposite of
what this flag does.  Using the same tag to mean both things depending on
whether there's a 'v3' before it is nothing but confusing.

-- 
Mans Rullgard / mru
