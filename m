From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 1/6] ARM: OMAP2+: Remove board-4430sdp.c
Date: Sat, 6 Jul 2013 23:36:48 +0200
Message-ID: <201307062336.49066.arnd@arndb.de>
References: <20130517191304.468.73487.stgit@localhost> <20130520095447.GR21614@n2100.arm.linux.org.uk> <20130706131057.GU21614@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:51212 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751984Ab3GFVh2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 6 Jul 2013 17:37:28 -0400
In-Reply-To: <20130706131057.GU21614@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Tony Lindgren <tony@atomide.com>, arm@kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, shawn.guo@linaro.org

On Saturday 06 July 2013, Russell King - ARM Linux wrote:
> Oh wait, why don't I get to choose my "debug console UART" on an AT91?
> Maybe AT91 should move their debug uart selection into this menu as well,
> and maybe the Versatile Express options too, because they're all to do
> with selecting the UART to be used.  Please... some sane thought would
> be really good here.
> 
> Oh my god, you're not the only ones.  Arnd/Olof, who started this madness
> and why haven't you already stepped on it?  Right, I'm fixing this in
> this merge window.  Everything is moving under the original choice menu
> as it was intended to be.

Sorry, I missed that this was going on, and I absolutely agree with your
sentiment. From what I can tell from the git log, Tegra was the first
to have the separate choice statement, after it just move its
options from mach-tegra/Kconfig into the Kconfig.debug. OMAP followed
with the same method and I think from there people just copied it.

I can understand why one wants to have some more structure in the list,
given that i.MX alone has 37 options for UART addresses, but we first
need to have a consistent method of configuring the addresses.

	Arnd
