From: Rabin Vincent <rabin@rab.in>
Subject: Re: [PATCH] OMAP4: fix return value of omap4_l3_init
Date: Wed, 18 May 2011 21:23:31 +0530
Message-ID: <BANLkTi=Rr0u5dyVAEQzwPRPMABmOQHF6tQ@mail.gmail.com>
References: <1304787527-8314-1-git-send-email-rabin@rab.in>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:38160 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756021Ab1ERPyM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 18 May 2011 11:54:12 -0400
Received: by bwz15 with SMTP id 15so1545300bwz.19
        for <linux-omap@vger.kernel.org>; Wed, 18 May 2011 08:54:11 -0700 (PDT)
In-Reply-To: <1304787527-8314-1-git-send-email-rabin@rab.in>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, r.sricharan@ti.com, Santosh Shilimkar <santosh.shilimkar@ti.com>

On Sat, May 7, 2011 at 22:28, Rabin Vincent <rabin@rab.in> wrote:
> Don't PTR_ERR() a non-error pointer:
>
> =A0initcall omap4_l3_init+0x0/0xdc returned -544980480 after 0 usecs
> =A0initcall omap4_l3_init+0x0/0xdc returned with error code -54498048=
0
>
> Signed-off-by: Rabin Vincent <rabin@rab.in>

Ping?

(with some git blame'd people now on cc.)

> ---
> =A0arch/arm/mach-omap2/devices.c | =A0 =A02 +-
> =A01 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devi=
ces.c
> index 7b85585..5b8ca68 100644
> --- a/arch/arm/mach-omap2/devices.c
> +++ b/arch/arm/mach-omap2/devices.c
> @@ -97,7 +97,7 @@ static int __init omap4_l3_init(void)
>
> =A0 =A0 =A0 =A0WARN(IS_ERR(od), "could not build omap_device for %s\n=
", oh_name);
>
> - =A0 =A0 =A0 return PTR_ERR(od);
> + =A0 =A0 =A0 return IS_ERR(od) ? PTR_ERR(od) : 0;
> =A0}
> =A0postcore_initcall(omap4_l3_init);
>
> --
> 1.7.4.1
>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
