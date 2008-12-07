From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 5/6] ARM: OMAP2: drop redundant pending write check for
	gptimer
Date: Sun, 7 Dec 2008 12:54:29 -0800
Message-ID: <20081207205428.GA7388@atomide.com>
References: <20081205023737.3868.78857.stgit@localhost> <20081205024121.3868.18876.stgit@localhost> <20081207112511.GB1646@flint.arm.linux.org.uk> <13B9B4C6EF24D648824FF11BE8967162036D05AD4C@dlee02.ent.ti.com> <20081207170624.GA17640@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:61940 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751471AbYLGUyk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 7 Dec 2008 15:54:40 -0500
Content-Disposition: inline
In-Reply-To: <20081207170624.GA17640@flint.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: "Woodruff, Richard" <r-woodruff2@ti.com>, "linux-arm-kernel@lists.arm.linux.org.uk" <linux-arm-kernel@lists.arm.linux.org.uk>, Kevin Hilman <khilman@deeprootsystems.com>, Paul Walmsley <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

* Russell King - ARM Linux <linux@arm.linux.org.uk> [081207 09:06]:
> On Sun, Dec 07, 2008 at 08:55:54AM -0600, Woodruff, Richard wrote:
> > Yes, NOHZ is _poor_ today in respect to needless reprogramming. Code can
> > be improved. I have sent Thomas a patch for the same which is in the MM
> > tree for a while now.
> 
> When I discussed this problem with Thomas, his reaction was rather
> negative due to there being conflicting requirements between this and
> ia64.  And quite frankly I think that the OMAP behaviour is utter
> madness - taking as long as it does to update the timer registers
> means that no matter what you do, you _will_ be paying a penalty
> for that hardware.

Well still the timer code should be optimized for slower systems.
The timer should not be reprogrammed during every device interrupt
if the change is less than a jiffy. And going through the
timer lists is not always needed, so Richard's patch tries to
optimize that [1].

> Let's hope that later OMAP designs sanitise the timer hardware so
> it doesn't take stupid amounts of time to write to the registers,
> posted mode or not.

Yeah. Richard has some profiling data showing you how much time is
spent doing that, maybe post that again for reference? It's very
interesting data.

Tony


[1] http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.28-rc2/2.6.28-rc2-mm1/broken-out/tick-schedc-suppress-needless-timer-reprogramming.patch
