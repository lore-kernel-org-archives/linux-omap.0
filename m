From: Tony Lindgren <tony@atomide.com>
Subject: Git tree updated to v2.6.26-rc3, all header files moved
Date: Thu, 14 Aug 2008 13:13:30 +0300
Message-ID: <20080814101329.GA9226@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:56690 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752450AbYHNKLQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 14 Aug 2008 06:11:16 -0400
Received: from muru.com ([72.249.23.125] helo=localhost.localdomain)
	by mho-01-bos.mailhop.org with esmtpa (Exim 4.68)
	(envelope-from <tony@atomide.com>)
	id 1KTZnX-000KhS-Iy
	for linux-omap@vger.kernel.org; Thu, 14 Aug 2008 10:11:16 +0000
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi all,

I've just pushed an update to v2.6.27-rc3, which moves all machine
specific headers to arch/arm/plat-omap/include/mach/.

I've boot tested it on 2430sdp, 3430sdp, n810 and n770. Compile
tested also on OSK and H2. Please check your boards still work,
and patch as needed.

Please also refresh and resend your patches as needed, in most
cases something like this should be enough:

sed -i -e s/asm\\/arch\\//mach\\//g your.files

Also, looks like the n8x0 not booting without LL_DEBUG seems to
have disappeared between rc2 and rc3, did not track it down
any further.

Cheers,

Tony
