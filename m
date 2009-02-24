From: Tony Lindgren <tony@atomide.com>
Subject: Switching to applying patches from patchwork.kernel.org
Date: Tue, 24 Feb 2009 12:14:17 -0800
Message-ID: <20090224201417.GL26205@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:61532 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752611AbZBXUOV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 24 Feb 2009 15:14:21 -0500
Received: from c-69-181-40-92.hsd1.ca.comcast.net ([69.181.40.92] helo=localhost.localdomain)
	by mho-01-bos.mailhop.org with esmtpa (Exim 4.68)
	(envelope-from <tony@atomide.com>)
	id 1Lc3fW-000MXP-LZ
	for linux-omap@vger.kernel.org; Tue, 24 Feb 2009 20:14:18 +0000
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi all,

Just FYI, I've switched over to apply the omap patches from
patchwork.kernel.org [1]. So now we'll have some state tracking of the
patches, and I can keep my omap inbox relatively empty without
worrying about losing patches ;)

I'll be marking all the patches that should go via other mailing lists
as "Awaiting Upstream" as there's no other status for them. I've also
assigned the USB patches to Felipe to sort through, and the PM patches
to Kevin to sort through.

I'll also start sending out automated emails when I apply something
from patchwork, so let's see how that works. If it gets too annoying,
we can set up a separate mailing list for it. I guess for now I'll
reply to the patch, and change the subject to say [APPLIED] in the
beginning of the subject.

This does not change anything regarding the mailing list usage, the
patches will still get reviewed and commented on the linux-omap
mailing list. The only new thing is that patchwork allows us to keep
track of the patches.

Everybody, if your patch does not apply in patchwork yet, please
resend it. I've purged my omap inbox from most emails, so I'm relying
on the patchlist in patchworks completely now.

Cheers,

Tony

[1] http://patchwork.kernel.org/project/linux-omap/list/
