From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [GIT PULL] omap board updates for v3.1 merge window
Date: Thu, 7 Jul 2011 22:40:58 +0200
Message-ID: <201107072240.58987.arnd@arndb.de>
References: <20110707162911.GL5783@atomide.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:55876 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751607Ab1GGUlf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 7 Jul 2011 16:41:35 -0400
In-Reply-To: <20110707162911.GL5783@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Tony Lindgren <tony@atomide.com>, Thomas Gleixner <tglx@linutronix.de>, linux-omap@vger.kernel.org, Nicolas Pitre <nico@fluxnic.net>

On Thursday 07 July 2011 18:29:11 Tony Lindgren wrote:
> Please pull omap board updates from:
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6.git devel-board
> 
> These are currently on top of the fixes you pulled earlier but
> could be also rebased on the earlier cleanup if you prefer that.

I would generally prefer them to be independent, even if that causes
minor conflicts. If some branches are built on top of others, that
mainly means I have to remember the order in which to send them
upstream, and my memory for these things is limited.
 
> Please note that the board-cm-t35.c change will need a minor fix
> when merging with the atag_offset patch series. In MACHINE_START
> the .boot_params needs to be replaced with .atag_offset = 0x100.
>
> Also note that this series is missing the Nook Color board
> support as that one is waiting on the machine_id patch.

Ok

Thanks,

	Arnd
