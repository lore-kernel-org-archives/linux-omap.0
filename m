From: Dirk Behme <dirk.behme@googlemail.com>
Subject: Kernel hang on OMAP3 based Beagle board, RTC issue?
Date: Wed, 02 Jul 2008 21:55:22 +0200
Message-ID: <486BDD2A.5070500@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.154]:47463 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752986AbYGBTzc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 2 Jul 2008 15:55:32 -0400
Received: by fg-out-1718.google.com with SMTP id 19so196865fgg.17
        for <linux-omap@vger.kernel.org>; Wed, 02 Jul 2008 12:55:30 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: "Syed Mohammed, Khasim" <khasim@ti.com>


At Beagle IRC there was some discussion [1] [2] today about kernel 
hang on OMAP3 based Beagle board. I'll try to summarize discussion and 
Khasim's findings, maybe somebody here has an idea.

Latest OMAP git kernel seems to hang on beagle board after some time. 
You don't see any crash, but after a while typing, anything doesn't 
work. SD stops as well, so you can only do stuff that's in ram, any IO 
will block. It can take >1 day to get there, but mostly it's ~30 minutes.

Khasim found that it seems disabling RTC will remove the hang. When 
booting the git kernel after some time there are no timer or PRCM 
interrupts and the control resides in cpu_idle. We don't know where 
exactly the problem in RTC is, but while browsing the history of files 
related to RTC Khasim found that some changes were done to the files 
to handle T2 interrupts in a centralized way for USB, Battery and RTC. 
It seems even Battery broke with this patch set

http://source.mvista.com/git/gitweb.cgi?p=linux-omap-2.6.git;a=commitdiff;h=68d7477caca19c0b52b5d4e85700cd3e6115577f

May be this is the change that is affecting RTC. But it's unclear why 
it is affecting GP timer and PRCM interrupts.

Any idea?

Thanks and please correct if something is wrong in the summary

Dirk

[1] http://www.beagleboard.org/irclogs/index.php?date=2008-07-02#T07:19:47

[2] http://www.beagleboard.org/irclogs/index.php?date=2008-07-02#T16:57:47
