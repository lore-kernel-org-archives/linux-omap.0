From: Paul Walmsley <paul@pwsan.com>
Subject: RE: [PATCH 0/4] OMAP2/3 clock: fix some bugs in
 omap2_clk_wait_ready()
Date: Wed, 16 Jul 2008 19:33:03 -0600 (MDT)
Message-ID: <alpine.DEB.1.00.0807161931280.467@utopia.booyaka.com>
References: <20080626070305.16555.96759.stgit@localhost.localdomain> <FCCFB4CDC6E5564B9182F639FC356087019826DC08@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:40125 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751573AbYGQBdF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 16 Jul 2008 21:33:05 -0400
In-Reply-To: <FCCFB4CDC6E5564B9182F639FC356087019826DC08@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Pandita, Vikram" <vikram.pandita@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Thu, 26 Jun 2008, Pandita, Vikram wrote:

> I hope this has fixed:
> "Clock usbhost_48m_fck didn't enable in 100000 tries"

Just to follow up on this.  I was able to reproduce this with a Beagle, 
and have a patch for it coming soon.  In the interim, the above message 
shouldn't cause any problems, except perhaps delaying boot slightly.


- Paul
