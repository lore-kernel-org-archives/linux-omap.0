From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH 1/8] ARM: SCU: Add common routines for secondary CPU bootup
Date: Thu, 2 Dec 2010 15:19:05 +0000
Message-ID: <AANLkTikpjq-8BVanF5W76j0ZdDBur8DyHWSH8GGgJBQs@mail.gmail.com>
References: <20101130171626.GA6165@oksana.dev.rtsoft.ru>
	<20101130171658.GA24034@oksana.dev.rtsoft.ru>
	<20101130233204.GB14383@n2100.arm.linux.org.uk>
	<20101201002527.GC14383@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:51920 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757662Ab0LBPTI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 2 Dec 2010 10:19:08 -0500
In-Reply-To: <20101201002527.GC14383@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Anton Vorontsov <avorontsov@mvista.com>, Kukjin Kim <kgene.kim@samsung.com>, Srinidhi Kasagar <srinidhi.kasagar@stericsson.com>, Tony Lindgren <tony@atomide.com>, Jamie Iles <jamie.iles@picochip.com>, Colin Cross <ccross@android.com>, linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, linux-tegra@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On 1 December 2010 00:25, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Tue, Nov 30, 2010 at 11:32:04PM +0000, Russell King - ARM Linux wr=
ote:
>> Note that I'll go with factoring this out into arch/arm/kernel/smp_s=
cu.c
>> for the time being, but I'm not convinced about the other parts yet.
>
> IOW, something like the attached. =C2=A0I've gone a little further an=
d removed
> the now unnecessary scu_enable() and scu_get_core_count() global func=
tions,
> making scu_enable() static, and eliminating scu_get_core_count() enti=
rely.

There is some benefit in leaving get_core_count() in the platform
code. For example, the SCU on Cortex-A15 doesn't expose the core count
register and we have to get it from somewhere else (for now from some
L2 cache controller register but in the future it may be hardcoded,
passed via FDT or simply trying to boot maxcpus).

--=20
Catalin
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
