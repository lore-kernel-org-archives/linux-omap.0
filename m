From: Felipe Contreras <felipe.contreras@nokia.com>
Subject: Re: [ANNOUNCE] rebased dspbridge-pm on top of dspbridge
Date: Thu, 21 Jan 2010 15:18:16 +0200
Message-ID: <20100121131816.GA3787@annwn.felipec.org>
References: <27F9C60D11D683428E133F85D2BB4A53042DF3B315@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:19911 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751575Ab0AUNSx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 21 Jan 2010 08:18:53 -0500
Content-Disposition: inline
In-Reply-To: <27F9C60D11D683428E133F85D2BB4A53042DF3B315@dlee03.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Omar Ramirez Luna <omar.ramirez@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Ameya Palande <ameya.palande@nokia.com>, Hiroshi Doyu <hiroshi.doyu@nokia.com>, Nishanth Menon <menon.nishanth@gmail.com>, Tony Lindgren <tony@atomide.com>

On Thu, Jan 21, 2010 at 01:19:52AM +0100, Omar Ramirez Luna wrote:
> dspbridge-pm branch was rebased on top of latest dspbridge, so please
> update your local branches.
> 
> As a reminder:
> 	dspbridge is based on top of 2.6.32 LO

I remember Tony explained that branches should be based on top of
mainstream, not l-o. Moreover, I see no reason to depend on l-o;
everything dspbridge needs is already in mainstream.

-- 
Felipe Contreras
