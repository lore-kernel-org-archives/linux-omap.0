From: "Arpad Wang" <arpadwang@fastmail.fm>
Subject: Where to start
Date: Tue, 09 Aug 2011 15:49:27 +0800
Message-ID: <1312876167.365.2161060801@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from new1.smtp.messagingengine.com ([66.111.4.221]:60927 "EHLO
	new1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752347Ab1HIH4K (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 9 Aug 2011 03:56:10 -0400
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.messagingengine.com (Postfix) with ESMTP id BFFF620F6C
	for <linux-omap@vger.kernel.org>; Tue,  9 Aug 2011 03:49:27 -0400 (EDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hello all,

sorry for asking a 'basic' question on this list. If this is indeed the
wrong place (and even if it isn't!), please feel free to point me to a
better forum for arm/omap specific kernel discussions.

My questions are:
1. What is a good place to read up on how to write board files and
drivers for OMAP3/4 based boards? The documentation I have found is
scarce and often outdated.
2. A specific problem I have is with DSS/FB/LCD panel/the like. We have
an old board file for v2.6.32 TI PSP. Despite doing what appears to be
equivalent to what the old board file does, there is nothing shown on
the LCD (nor DVI, VGA, TV-out, ....). What could have changed between
TI's 2.6.32 and 3.0-omap that causes, for instance an LCD panel, to stay
blank in the latter but not in the former.

While an answer would be very appreciated, even better would be to get
hints on how to learn to figure out the answer to #2 by myself...
feeling that will be a handy skill... :-)

Thank you,

Arpad

-- 
http://www.fastmail.fm - The professional email service

