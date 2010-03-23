From: Abhay Kumar <abhay2101@gmail.com>
Subject: Regarding OMAP3630 Zoom3 Board Clock Speed
Date: Tue, 23 Mar 2010 15:52:39 +0000 (UTC)
Message-ID: <loom.20100323T164432-304@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:35771 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754834Ab0CWPzF (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 23 Mar 2010 11:55:05 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gplao-linux-omap-open-source-moved1@m.gmane.org>)
	id 1Nu6Ra-0006y5-VV
	for linux-omap@vger.kernel.org; Tue, 23 Mar 2010 16:55:03 +0100
Received: from ABTS-KK-Dynamic-034.83.167.122.airtelbroadband.in ([ABTS-KK-Dynamic-034.83.167.122.airtelbroadband.in])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-omap@vger.kernel.org>; Tue, 23 Mar 2010 16:55:02 +0100
Received: from abhay2101 by ABTS-KK-Dynamic-034.83.167.122.airtelbroadband.in with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-omap@vger.kernel.org>; Tue, 23 Mar 2010 16:55:02 +0100
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi,
   How can read DPLL1 (MPU_CLK) speed related registers in ported TI linux kernel.
i am facing in figuting out the values.
After going through TRM and given formula (SYS_CLK*2*M)/(N+1)*M2  value is
coming as 1200 Mhz having a SYS_CLK of 26 Mhz.

but while reading through  cat /proc/cpuinfo it is giving 600Mhz.
and this is not same and it is giving some wrong oitput as
ARM7 core as a processor name althjough it is a ARM11 coretex 8 processor.

Did my registers reading code is wrong as 1200Mhz  is not possible.

Is there any proper way to read the corresponding CPRM MPU registers.

Please help us as we are in critical stage.

Thanks and regards
Abhay Kumar

