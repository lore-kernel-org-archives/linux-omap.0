From: Pawel Moll <mail@pawelmoll.com>
Subject: Re: DSS2 broken with 36-rc1
Date: Mon, 16 Aug 2010 13:59:12 +0100
Message-ID: <1281963552.2793.3.camel@hornet.cambridge.arm.com>
References: <1281962906.1888.25.camel@chotu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from stallman.rootnode.net ([89.248.165.10]:51822 "EHLO
	stallman.rootnode.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753822Ab0HPM7f (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 16 Aug 2010 08:59:35 -0400
In-Reply-To: <1281962906.1888.25.camel@chotu>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ameya Palande <ameya.palande@nokia.com>
Cc: tomi.valkeinen@nokia.com, linux-omap <linux-omap@vger.kernel.org>

Hi Ameya,

> [    0.805419] omapfb omapfb: failed to allocate framebuffer
> [    0.810882] omapfb omapfb: failed to allocate fbmem
> [    0.815856] omapfb omapfb: failed to setup omapfb
> [    0.820648] omapfb: probe of omapfb failed with error -12

Could you quickly try this hack?

diff --git a/arch/arm/mm/ioremap.c b/arch/arm/mm/ioremap.c
index ab50627..0875b2d 100644
--- a/arch/arm/mm/ioremap.c
+++ b/arch/arm/mm/ioremap.c
@@ -204,8 +204,8 @@ void __iomem * __arm_ioremap_pfn_caller(unsigned lo=
ng pfn,
        /*
         * Don't allow RAM to be mapped - this causes problems with ARM=
v6+
         */
-       if (WARN_ON(pfn_valid(pfn)))
-               return NULL;
+//     if (WARN_ON(pfn_valid(pfn)))
+//             return NULL;
=20
        type =3D get_mem_type(mtype);
        if (!type)


If it helps you have just encountered side effects of this:


commit 309caa9cc6ff39d261264ec4ff10e29489afc8f8
Author: Russell King <rmk+kernel@arm.linux.org.uk>
Date:   Mon Jun 21 21:03:18 2010 +0100

    ARM: Prohibit ioremap() on kernel managed RAM


I've been there last week as well... (didn't have time to think this
over, though)

Cheers!

Pawe=C5=82

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
