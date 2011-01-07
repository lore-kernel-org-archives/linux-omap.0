From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: RE: Latest regressions
Date: Fri, 7 Jan 2011 20:24:26 +0530
Message-ID: <041d2be25d29537d75bea1d949249176@mail.gmail.com>
References: <20110107115744.GL1198@n2100.arm.linux.org.uk> <20110107144123.GA28049@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog105.obsmtp.com ([74.125.149.75]:40646 "EHLO
	na3sys009aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752172Ab1AGOyb convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 7 Jan 2011 09:54:31 -0500
Received: by bwz8 with SMTP id 8so16866851bwz.21
        for <linux-omap@vger.kernel.org>; Fri, 07 Jan 2011 06:54:30 -0800 (PST)
In-Reply-To: <20110107144123.GA28049@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Russell King - ARM Linux
> Sent: Friday, January 07, 2011 8:11 PM
> To: linux-omap@vger.kernel.org
> Subject: Re: Latest regressions
>
> While trying to build the latest kernel for the SDP4430 board:
>
> arch/arm/mach-omap2/clockdomain.c: In function =E2=94=82_enable_hwsup=
=E2=94=82:
> arch/arm/mach-omap2/clockdomain.c:251: error: =E2=94=82struct clockdo=
main=E2=94=82
> has no member named =E2=94=82clktrctrl_mask=E2=94=82
> arch/arm/mach-omap2/clockdomain.c:254: error: =E2=94=82struct clockdo=
main=E2=94=82
> has no member named =E2=94=82clktrctrl_mask=E2=94=82
> arch/arm/mach-omap2/clockdomain.c: In function =E2=94=82_disable_hwsu=
p=E2=94=82:
> arch/arm/mach-omap2/clockdomain.c:277: error: =E2=94=82struct clockdo=
main=E2=94=82
> has no member named =E2=94=82clktrctrl_mask=E2=94=82
> arch/arm/mach-omap2/clockdomain.c:280: error: =E2=94=82struct clockdo=
main=E2=94=82
> has no member named =E2=94=82clktrctrl_mask=E2=94=82
> arch/arm/mach-omap2/clockdomain.c: In function =E2=94=82omap2_clkdm_s=
leep=E2=94=82:
> arch/arm/mach-omap2/clockdomain.c:744: error: =E2=94=82struct clockdo=
main=E2=94=82
> has no member named =E2=94=82clktrctrl_mask=E2=94=82
> arch/arm/mach-omap2/clockdomain.c: In function =E2=94=82omap2_clkdm_w=
akeup=E2=94=82:
> arch/arm/mach-omap2/clockdomain.c:789: error: =E2=94=82struct clockdo=
main=E2=94=82
> has no member named =E2=94=82clktrctrl_mask=E2=94=82
> arch/arm/mach-omap2/clockdomain.c: In function
> =E2=94=82omap2_clkdm_clk_enable=E2=94=82:
> arch/arm/mach-omap2/clockdomain.c:922: error: =E2=94=82struct clockdo=
main=E2=94=82
> has no member named =E2=94=82clktrctrl_mask=E2=94=82
> arch/arm/mach-omap2/clockdomain.c:926: error: =E2=94=82struct clockdo=
main=E2=94=82
> has no member named =E2=94=82clktrctrl_mask=E2=94=82
> arch/arm/mach-omap2/clockdomain.c: In function
> =E2=94=82omap2_clkdm_clk_disable=E2=94=82:
> arch/arm/mach-omap2/clockdomain.c:994: error: =E2=94=82struct clockdo=
main=E2=94=82
> has no member named =E2=94=82clktrctrl_mask=E2=94=82
> arch/arm/mach-omap2/clockdomain.c:998: error: =E2=94=82struct clockdo=
main=E2=94=82
> has no member named =E2=94=82clktrctrl_mask=E2=94=82
>
> Linus' tree prior to the OMAP merge is buildable for the same
> config.
:)  This one is also fixed with the series but would get merged in rc1
http://www.mail-archive.com/linux-omap@vger.kernel.org/msg41712.html

Regards,
Santosh
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
