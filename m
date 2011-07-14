From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/3] ARM: OMAP4: Add pcm049 to Kconfig/Makefile
Date: Thu, 14 Jul 2011 00:47:10 -0700
Message-ID: <20110714074710.GM5783@atomide.com>
References: <1310119464-3514-1-git-send-email-j.weitzel@phytec.de>
 <1310119464-3514-2-git-send-email-j.weitzel@phytec.de>
 <4E16EECF.7030102@mvista.com>
 <20110708115521.GA5783@atomide.com>
 <20110708115842.GJ4820@legolas.emea.dhcp.ti.com>
 <20110714072708.GK5783@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:15251 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753834Ab1GNHrQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 14 Jul 2011 03:47:16 -0400
Content-Disposition: inline
In-Reply-To: <20110714072708.GK5783@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Sergei Shtylyov <sshtylyov@mvista.com>, Jan Weitzel <j.weitzel@phytec.de>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Tony Lindgren <tony@atomide.com> [110714 00:22]:
> * Felipe Balbi <balbi@ti.com> [110708 04:53]:
> > 
> > Are you or are you not taking now board files ? We have one which was
> > left out due to a comment from Russell stating that no new board-files
> > would be accepted until the move to device tree was completed [1]

For the mcop changes, that should be updated against current devel-board
for the irq/timer/init_early changes. Then I can add that to testing-board
too.

Tony
 
> > [1] http://marc.info/?t=130199607500006&r=1&w=2
