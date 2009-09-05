From: <ext-Eero.Nurkkala@nokia.com>
Subject: RE: [RFC][PATCH] ARM: OMAP: McBSP: Use register cache
Date: Sat, 5 Sep 2009 22:46:53 +0200
Message-ID: <1FFEF31EBAA4F64B80D33027D42977600CB82F95D3@NOK-EUMSG-02.mgdnok.nokia.com>
References: <1252042776.23177.39.camel@eenurkka-desktop>
 <200909041234.06121.jkrzyszt@tis.icnet.pl>
 	<1252062431.23177.68.camel@eenurkka-desktop>,<2ee9e08d0909051031g6463f1b6g1a8bb3a642dd2b0a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:54139 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751244AbZIEUrw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 5 Sep 2009 16:47:52 -0400
In-Reply-To: <2ee9e08d0909051031g6463f1b6g1a8bb3a642dd2b0a@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: anuj.aggarwal@gmail.com
Cc: jkrzyszt@tis.icnet.pl, linux-omap@vger.kernel.org, e3-hacking@earth.li


> Isn't the better way to achieve this thing, at least from the OFF mode
> perspective, is to provide similar implementation for McBSP in
> omap3_core_save_context () / omap3_core_restore_context(), in
> file arch/arm/mach-omap2/pm34xx.c? Code for other core peripherals
> is already there and we have to add support for rest of the core-domain
> peripherals.

Yes and no. I'm not sure McBSP context would be needed to be restored
after every wake up from PER off mode.. isn't that how it's handled now
for other peripherals? But maybe restore context for McBSP whenever
there's need for it. Rewriting millions of registers just for the case doesn't
sound good. IMO, with an irq from an external device, a rewrite of  the
McBSP registers occurs. You loose the point of the OFF mode if you always
start rewriting all registers? (you're not saving power.. the opposite).
Or did I not understand something? (most likely the case) =)

- Eero