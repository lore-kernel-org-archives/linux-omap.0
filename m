From: Mike Rapoport <mike@compulab.co.il>
Subject: several OMAP newbie questions
Date: Tue, 01 Sep 2009 13:34:20 +0300
Message-ID: <4A9CF8AC.2010408@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from compulab.co.il ([67.18.134.219]:54342 "EHLO compulab.co.il"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751091AbZIALCp (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 1 Sep 2009 07:02:45 -0400
Received: from mail.linux-boards.com ([192.114.83.142] helo=zimbra-mta.compulab.co.il)
	by compulab.site5.com with esmtp (Exim 4.69)
	(envelope-from <mike@compulab.co.il>)
	id 1MiQgv-0000in-VT
	for linux-omap@vger.kernel.org; Tue, 01 Sep 2009 05:34:22 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by zimbra-mta.compulab.co.il (Postfix) with ESMTP id D2B259A036A
	for <linux-omap@vger.kernel.org>; Tue,  1 Sep 2009 13:34:20 +0300 (IDT)
Received: from zimbra-mta.compulab.co.il ([127.0.0.1])
	by localhost (zimbra-mta.compulab.co.il [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id iM5NFjqt7g9r for <linux-omap@vger.kernel.org>;
	Tue,  1 Sep 2009 13:34:20 +0300 (IDT)
Received: from [10.1.1.95] (mike-pc.compulab.local [10.1.1.95])
	by zimbra-mta.compulab.co.il (Postfix) with ESMTP id 8CFF99A0343
	for <linux-omap@vger.kernel.org>; Tue,  1 Sep 2009 13:34:20 +0300 (IDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi all,
I've recently started to work on adding support for a custom OMAP3 board.
Several things in the arch/arm/mach-omap2/board-* caught my attention:
1) omap_xxx_map_io and omap_xxx_init_irq are mostly the same in all board-*
files, the only difference is omap_sdrc_params passed to omap2_init_common_hw.
Probably it'd make sense to have omap_map_io_{242x,243x,343x} as the initializer
of .map_io and move the common part of omap_xxx_map_io to some common place?
2) Boards that use NAND flash have the very same NAND chip select detection
code. Is this code necessary, or, if I know for sure that NAND is connected to
nCS0 I can skip the chip select detection? And, again, if several boards use the
same code for chip select detection, wouldn't it be wise to move it to some
common place?
3) If I'm not much mistaken, board specific pin mux configuration has to deal
with arch/arm/plat-omap/include/mach/mux.h and arch/arm/mach-omap2/mux.c. For
instance, if my board uses ULPI pins that have not been defined already, I need
to patch those file with my pin mux definitions. Am I right here, or have I
missed something?

-- 
Sincerely yours,
Mike.


