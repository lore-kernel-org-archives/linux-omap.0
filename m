From: "Joe Woodward" <jw@terrafix.co.uk>
Subject: board_onenand_init() build error in linux-next
Date: Fri, 15 Jun 2012 13:46:50 +0100
Message-ID: <WC20120615124650.94039B@terrafix.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp1.keele.netcentral.co.uk ([212.57.235.197]:36095 "EHLO
	smtp3.keele.netcentral.co.uk" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1756770Ab2FOMrH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 15 Jun 2012 08:47:07 -0400
Received: from terrafix.co.uk (reverse.keele.netcentral.co.uk [212.57.249.250] (may be forged))
	by smtp3.keele.netcentral.co.uk (8.14.2/8.14.2) with ESMTP id q5FCkru5016759
	for <linux-omap@vger.kernel.org>; Fri, 15 Jun 2012 13:46:58 +0100
Received: from WorldClient by terrafix.co.uk (MDaemon PRO v12.5.6)
	with ESMTP id md50002237059.msg
	for <linux-omap@vger.kernel.org>; Fri, 15 Jun 2012 13:46:57 +0100
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Someone may have spotted this already...

But if you build todays linux-next (next-20120615) without CONFIG_MTD_ONENAND_OMAP2 or 
CONFIG_MTD_ONENAND_OMAP2_MODULE then board_onenand_init() is defined in two places 
(in board-flash.c:102 as an empty function, and board-flash.h:56 as a static inline).

This causes the build to fail as board-flash.c includes board-flash.h:
  CC      arch/arm/mach-omap2/board-flash.o
arch/arm/mach-omap2/board-flash.c:102:8: error: redefinition of 'board_onenand_init'
arch/arm/mach-omap2/board-flash.h:56:20: note: previous definition of 'board_onenand_init' 
was here
make[1]: *** [arch/arm/mach-omap2/board-flash.o] Error 1

I'm fairly sure this isn't right!?

Cheers,
Joe


