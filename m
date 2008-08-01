From: "Peter 'p2' De Schrijver" <peter.de-schrijver@nokia.com>
Subject: off mode and smartreflex
Date: Fri, 1 Aug 2008 13:00:24 +0300
Message-ID: <20080801100024.GB8857@codecarver.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:59150 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753072AbYHAKBN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 Aug 2008 06:01:13 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: r-woodruff2@ti.com
Cc: linux-omap@vger.kernel.org

Hi,

Using Rajendra's cpuidle and offmode patches + the patches I posted to
configure triton2 and set the correct off mode polarity, I noticed the
system does not go to off mode when smartreflex is enabled. At least
sysoffmode is not deasserted and the VDD1 and VDD2 voltages do not drop
to 0V. Should smartreflex be disabled by sw before the wfi is issued ?
Any other idea on why this would happen ?

Thanks,

Peter.
-- 
goa is a state of mind
