From: "Menon, Nishanth" <nm@ti.com>
Subject: Re: [PATCH] ARM: OMAP2+: powerdomain: unwrap and simplify logging strings
Date: Thu, 1 Mar 2012 18:36:01 -0600
Message-ID: <CAOMWX4cAABO8jUCi8g_vbv6SnU3vPcqOULV6ui2jV7E2Nt8g0Q@mail.gmail.com>
References: <alpine.DEB.2.00.1202292122560.12752@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog119.obsmtp.com ([74.125.149.246]:34146 "EHLO
	na3sys009aog119.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756069Ab2CBAg3 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 1 Mar 2012 19:36:29 -0500
Received: by mail-ww0-f53.google.com with SMTP id fm10so3742wgb.22
        for <linux-omap@vger.kernel.org>; Thu, 01 Mar 2012 16:36:21 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1202292122560.12752@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, rnayak@ti.com

On Wed, Feb 29, 2012 at 22:23, Paul Walmsley <paul@pwsan.com> wrote:
> b/arch/arm/mach-omap2/powerdomain.c
> index 8a18d1b..89000d3 100644
> --- a/arch/arm/mach-omap2/powerdomain.c
> +++ b/arch/arm/mach-omap2/powerdomain.c
> @@ -339,8 +339,8 @@ int pwrdm_add_clkdm(struct powerdomain *pwrdm, st=
ruct
> clockdomain *clkdm)
> =A0 =A0 =A0 =A0if (!pwrdm || !clkdm)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -EINVAL;
>
> - =A0 =A0 =A0 pr_debug("powerdomain: associating clockdomain %s with =
powerdomain
> "
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"%s\n", clkdm->name, pwrdm->name);
> + =A0 =A0 =A0 pr_debug("powerdomain: %s: associating clockdomain %s\n=
",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0clkdm->name, pwrdm->name);

while at this, could i suggest having instead:
pr_debug("%s: %s: associating clockdomain %s\n", __func__,
                clkdm->name, pwrdm->name);
since the function name helps associate the message back in, wont it
be a bit of a dual edged information as well?

or even simplify it further with

#define pr_fmt(fmt)  "%s:%s: " fmt, "powerdomain", __func__
?
Regards,
Nishanth Menon
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
