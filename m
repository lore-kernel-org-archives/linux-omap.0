From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: tidspbridge in drivers/staging
Date: Sun, 22 Apr 2012 10:57:17 +0100
Message-ID: <20120422095717.GA25053@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:43830 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750899Ab2DVJ5Y (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 22 Apr 2012 05:57:24 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, =?iso-8859-1?Q?V=EDctor_Manuel_J=E1quez?= Leal <vjaquez@igalia.com>
Cc: Greg KH <gregkh@linuxfoundation.org>

I've noticed these failure from time to time in my omap4 randconfig bui=
lds:

drivers/staging/tidspbridge/core/tiomap3430.c: In function 'bridge_brd_=
start':
drivers/staging/tidspbridge/core/tiomap3430.c:425: error: implicit decl=
aration of function 'OMAP2_L4_IO_ADDRESS'
drivers/staging/tidspbridge/core/wdt.c: In function 'dsp_wdt_init':
drivers/staging/tidspbridge/core/wdt.c:56: error: implicit declaration =
of function 'OMAP2_L4_IO_ADDRESS'

Looking at git, it looks like there is some activity with tidspbridge
(by V=EDctor).  Is there any interest in fixing these errors for v3.4
(or even v3.4-rc5)?
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
