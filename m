From: Thomas Weber <thomas.weber.linux@googlemail.com>
Subject: Re: [PATCH 17/51] ARM: OMAP: convert reset to use arm_arch_reset (fwd)
Date: Mon, 31 Oct 2011 09:40:40 +0100
Message-ID: <CABoOg6x_v8Z+3VhRzc4E3TtbSxkvf0mZdqLpUX5RaYL7eCGhPQ@mail.gmail.com>
References: <alpine.DEB.2.00.1110280947270.24690@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:48029 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754421Ab1JaIkl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 31 Oct 2011 04:40:41 -0400
Received: by wwi36 with SMTP id 36so1197120wwi.1
        for <linux-omap@vger.kernel.org>; Mon, 31 Oct 2011 01:40:40 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1110280947270.24690@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org

Hello Paul, hello Will,

On Fri, Oct 28, 2011 at 5:47 PM, Paul Walmsley <paul@pwsan.com> wrote:
>
> fyi
>
>
>
> - Paul
>
> ---------- Forwarded message ----------
> Date: Fri, 28 Oct 2011 15:43:45 +0100
> From: Will Deacon <will.deacon@arm.com>
> To: linux-arm-kernel@lists.infradead.org
> Cc: Paul Walmsley <paul@pwsan.com>, Will Deacon <will.deacon@arm.com>
> Subject: [PATCH 17/51] ARM: OMAP: convert reset to use arm_arch_reset
>
> From: Paul Walmsley <paul@pwsan.com>
>
> Align the OMAP reset code with Will Deacon's "ARM: reset: introduce
> arm_arch_reset function pointer" cleanup patch.
>
> Signed-off-by: Paul Walmsley <paul@pwsan.com>
> Signed-off-by: Will Deacon <will.deacon@arm.com>
> ---
> =A0arch/arm/mach-omap1/board-voiceblue.c =A0 =A0| =A0 =A02 +-
> =A0arch/arm/mach-omap1/io.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A0=
4 ++++
> =A0arch/arm/mach-omap1/reset.c =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A02 =
--
> =A0arch/arm/mach-omap2/io.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A0=
7 ++++++-
> =A0arch/arm/mach-omap2/prcm.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A04 =
+---
> =A0arch/arm/plat-omap/include/plat/system.h | =A0 =A06 +++++-
> =A06 files changed, 17 insertions(+), 8 deletions(-)
>
<snip>
> diff --git a/arch/arm/mach-omap2/prcm.c b/arch/arm/mach-omap2/prcm.c
> index 2e40a5c..ad3ac5c 100644
> --- a/arch/arm/mach-omap2/prcm.c
> +++ b/arch/arm/mach-omap2/prcm.c
> @@ -58,7 +58,7 @@ u32 omap_prcm_get_reset_sources(void)
> =A0EXPORT_SYMBOL(omap_prcm_get_reset_sources);
>
> =A0/* Resets clock rates and reboots the system. Only called from sys=
tem.h */
I think it is no longer called from system.h only, isn't?
> -static void omap_prcm_arch_reset(char mode, const char *cmd)
> +void omap_prcm_arch_reset(char mode, const char *cmd)
> =A0{
> =A0 =A0 =A0 =A0s16 prcm_offs =3D 0;
>

Thomas
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
