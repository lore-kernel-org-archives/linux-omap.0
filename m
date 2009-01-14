From: Tony Lindgren <tony@atomide.com>
Subject: Important changes, please read
Date: Wed, 14 Jan 2009 15:41:53 +0200
Message-ID: <20090114134152.GJ29324@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:64751 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753279AbZANNlx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 14 Jan 2009 08:41:53 -0500
Received: from muru.com ([72.249.23.125] helo=localhost.localdomain)
	by mho-01-bos.mailhop.org with esmtpa (Exim 4.68)
	(envelope-from <tony@atomide.com>)
	id 1LN60G-000CZn-24
	for linux-omap@vger.kernel.org; Wed, 14 Jan 2009 13:41:52 +0000
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi all,

I'll be merging in v2.6.29-rc1 soonish, and suggest that we make some
changes to continue aligning our tree with the mainline tree. So
I suggest:

- We move the dspgateway code into a separate branch as discussed
  earlier.

- We stop using source.mvista.com git tree, and only use the
  kernel.org git tree. There's no need for having two master trees,
  and kernel.org is the standard way to go. Big thanks to
  Monta Vista for hosting us for many years.

- We reset arch/arm/mach-omap1 to be what's in the mainline and
  tag that patch again with "REMOVE OMAP LEGACY CODE" so it's easy
  to find later on. Naturally any code in that patch can be reworked
  so it can be integrated to the mainline kernel.

- We add a clocks branch maintained by Paul Walmsley that's based
  off the mainline tree

- We change the pm branch maintained by Kevin Hilman to be based
  on top of the mainline tree

Comments and suggestions anybody?

BTW, I've also re-cloned the omap tree on kernel.org as it had
tons of old objects that we don't need. It should not affect 
local trees, but report problems here. It will take a while
to get mirrored, and some branches might be missing until
mirroring is done.

I have also set up and empty for-next branch that will contain
the reviewed patches for next merge window. This will also get
pulled into Stephen Rothwell's linux next tree on daily basis.

Regards,

Tony
