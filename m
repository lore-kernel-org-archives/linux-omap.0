From: "Trilok Soni" <soni.trilok@gmail.com>
Subject: gpio_expander_omap removal?
Date: Mon, 24 Nov 2008 22:47:26 +0530
Message-ID: <5d5443650811240917q1215d424sdaec82889dbe2b49@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.169]:26577 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753439AbYKXRR0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 24 Nov 2008 12:17:26 -0500
Received: by wf-out-1314.google.com with SMTP id 27so2351664wfd.4
        for <linux-omap@vger.kernel.org>; Mon, 24 Nov 2008 09:17:26 -0800 (PST)
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Any plans to remove gpio expander APIs from drivers/i2c/chips?

I hope gpio_xxx APIs from gpiolib will work directly over pcf857x.

-- 
---Trilok Soni
http://triloksoni.wordpress.com
http://www.linkedin.com/in/triloksoni
