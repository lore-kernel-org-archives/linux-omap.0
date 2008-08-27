From: "stanley.miao" <stanley.miao@windriver.com>
Subject: omapfb problem on 3430sdp
Date: Wed, 27 Aug 2008 17:28:36 +0800
Message-ID: <1219829316.15818.77.camel@localhost>
Reply-To: stanley.miao@windriver.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:48295 "EHLO mail.wrs.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753929AbYH0J04 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 27 Aug 2008 05:26:56 -0400
Received: from ALA-MAIL03.corp.ad.wrs.com (ala-mail03 [147.11.57.144])
	by mail.wrs.com (8.13.6/8.13.6) with ESMTP id m7R9QtxQ019195
	for <linux-omap@vger.kernel.org>; Wed, 27 Aug 2008 02:26:55 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hardware: 
	Mainboard: 750-2094-001(C)
	Display board: 750-2081-101(B)

Software: 
	the lastest kernel from linux-omap-2.6 and from omapzoom.org.

The linux bootup logo is green, and LCD is dark. It looks like backlight
disabled. 

I commented the following two sentences in lcd_2430.c, there is still
the same thing. It seems these two sentences doesn't work.

 96         omap_set_gpio_dataout(enable_gpio, 1);
 97         omap_set_gpio_dataout(backlight_gpio, 1);

Both the the latest kernels from omapzoom.org and linux-omap-2.6 have
this problem.  However, the old version in linux-omap-2.6, 2.6.21,
doesn't have this problem.

Stanley.

