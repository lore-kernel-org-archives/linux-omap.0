From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 0/3] OMAP: wd_timer: update integration code to use new
 hwmod changes
Date: Tue, 16 Nov 2010 09:48:18 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1011160947330.32653@utopia.booyaka.com>
References: <20101116102205.27991.37909.stgit@twilight.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:46123 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751767Ab0KPQsT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 16 Nov 2010 11:48:19 -0500
In-Reply-To: <20101116102205.27991.37909.stgit@twilight.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Charulatha V <charu@ti.com>

On Tue, 16 Nov 2010, Paul Walmsley wrote:

> Update the OMAP watchdog timer integration code to take advantage of
> the new hwmod upgrades added by the "OMAP2+: hwmod core upgrades for
> 2.6.38: first set" series, posted previously.  So that series needs
> to be applied before these patches.
> 
> Charu, it would be great if you could take a look at these.
> 
> Tested on an OMAP34xx BeagleBoard with omap2plus_defconfig.

And these patches are also available as 'wdt_2.6.38' from 
git://git.pwsan.com/linux-2.6


- Paul
