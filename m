From: Paul Walmsley <paul@pwsan.com>
Subject: RE: [PATCH 0/4] OMAP2/3 clock: fix some bugs in
 omap2_clk_wait_ready()
Date: Thu, 26 Jun 2008 11:13:10 -0600 (MDT)
Message-ID: <alpine.DEB.1.00.0806261112400.25954@utopia.booyaka.com>
References: <20080626070305.16555.96759.stgit@localhost.localdomain> <FCCFB4CDC6E5564B9182F639FC356087019826DC08@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:34105 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754417AbYFZS7w (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 26 Jun 2008 14:59:52 -0400
In-Reply-To: <FCCFB4CDC6E5564B9182F639FC356087019826DC08@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Pandita, Vikram" <vikram.pandita@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Thu, 26 Jun 2008, Pandita, Vikram wrote:

> > To: linux-omap@vger.kernel.org
> > Cc: Gadiyar, Anand; k.kooi@student.utwente.nl; dirk.behme@googlemail.com;
> > igor.stoppa@nokia.com; Woodruff, Richard; jouni.hogander@nokia.comD
> > Subject: [PATCH 0/4] OMAP2/3 clock: fix some bugs in
> > omap2_clk_wait_ready()
> >
> > This patch series fixes some bugs in omap2_clk_wait_ready().  This
> > function
> 
> I hope this has fixed:
> "Clock usbhost_48m_fck didn't enable in 100000 tries"

First I've heard of it, Vikram.  Tell me more.


- Paul
