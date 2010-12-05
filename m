From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH 5/5] ARM: GIC: private a standard get_irqnr_preamble
 assembler macro
Date: Sun, 5 Dec 2010 22:07:46 +0000
Message-ID: <AANLkTikBcgE2R6uO_vYbLqfdbsLULfHczfjAULuEHYpr@mail.gmail.com>
References: <20101205113311.GC9138@n2100.arm.linux.org.uk>
	<E1PPCsV-0004xe-Ua@rmk-PC.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:38426 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751149Ab0LEWHq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 5 Dec 2010 17:07:46 -0500
In-Reply-To: <E1PPCsV-0004xe-Ua@rmk-PC.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Erik Gilling <konkers@android.com>, Srinidhi Kasagar <srinidhi.kasagar@stericsson.com>, Tony Lindgren <tony@atomide.com>, Anton Vorontsov <avorontsov@mvista.com>, linux-tegra@vger.kernel.org, Colin Cross <ccross@android.com>, Olof Johansson <olof@lixom.net>

On 5 December 2010 11:35, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> Provide a standard get_irqnr_preamble assembler macro for platforms
> to use, which retrieves the base address of the GIC CPU interface
> from gic_cpu_base_addr. =C2=A0Allow platforms to override this by def=
ining
> HAVE_GET_IRQNR_PREAMBLE.
>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
