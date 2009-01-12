From: Tony Lindgren <tony@atomide.com>
Subject: v2.6.28-omap1 tagged, some bugs remain
Date: Mon, 12 Jan 2009 16:50:58 +0200
Message-ID: <20090112145051.GL9373@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:54431 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752051AbZALOvD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 12 Jan 2009 09:51:03 -0500
Received: from muru.com ([72.249.23.125] helo=localhost.localdomain)
	by mho-01-bos.mailhop.org with esmtpa (Exim 4.68)
	(envelope-from <tony@atomide.com>)
	id 1LMO84-000LHL-Ke
	for linux-omap@vger.kernel.org; Mon, 12 Jan 2009 14:51:01 +0000
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi all,

I've just tagged v2.6.28-omap1, and looks like we might want to also
do v2.6.28-omap2 as there are few annoying bugs remaining:

- According to Jarkko Nikula, ASoC does not currently work because of
  some recent clock changes.

- MMC seems to be broken for omap1, Ladislav Michl  might have a patch
  coming up for that.

- I2C is broken for 2430 according to Kainan Cha.

Also looks like source.mvista.com is down, so please use the kernel.org
tree.

Regards,

Tony
