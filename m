From: Amit Kucheria <amit.kucheria@verdurent.com>
Subject: Broken cpuidle on PM branch?
Date: Mon, 12 Oct 2009 22:23:47 +0300
Message-ID: <20091012192347.GI32041@smtp.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.154]:30741 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756811AbZJLT0G (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 12 Oct 2009 15:26:06 -0400
Received: by fg-out-1718.google.com with SMTP id 16so557889fgg.1
        for <linux-omap@vger.kernel.org>; Mon, 12 Oct 2009 12:24:17 -0700 (PDT)
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi,

I am testing twl4030 script optimisations on the current PM branch. But I am
seeing the board (RX51) freeze when CPU_IDLE is enabled in the config.

Is it known to work on other boards?

Regards,
Amit
-- 
-------------------------------------------------------------------------
Amit Kucheria,				 Kernel Developer, Verdurent
-------------------------------------------------------------------------
