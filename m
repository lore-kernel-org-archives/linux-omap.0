From: Daniel Schaeffer <daniel.schaeffer@timesys.com>
Subject: OMAP3EVM LCD red tint
Date: Fri, 26 Sep 2008 16:20:47 -0400
Message-ID: <48DD441F.6080106@timesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from exchange07.timesys.com ([209.114.137.35]:29073 "EHLO
	exchange07.timesys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752050AbYIZU0I (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 26 Sep 2008 16:26:08 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Has anyone looked into why the LCD display on the OMAP3EVM is always 
tinted red? I created a couple of color test images that I cat'ed to 
/dev/fb and it looks like the blue color channel is completely ignored. 
  I was testing on v2.6.26-omap2 but is doesn't look like there have 
been any changes to the fb driver since then so I'm assuming the issue 
is also present in the head of the git tree.

Regards,

Daniel Schaeffer

