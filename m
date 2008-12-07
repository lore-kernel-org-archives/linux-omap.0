From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 5/6] ARM: OMAP2: drop redundant pending write check for gptimer
Date: Sun, 7 Dec 2008 17:06:24 +0000
Message-ID: <20081207170624.GA17640@flint.arm.linux.org.uk>
References: <20081205023737.3868.78857.stgit@localhost> <20081205024121.3868.18876.stgit@localhost> <20081207112511.GB1646@flint.arm.linux.org.uk> <13B9B4C6EF24D648824FF11BE8967162036D05AD4C@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:37400 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754104AbYLGRGq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 7 Dec 2008 12:06:46 -0500
Content-Disposition: inline
In-Reply-To: <13B9B4C6EF24D648824FF11BE8967162036D05AD4C@dlee02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Woodruff, Richard" <r-woodruff2@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, "linux-arm-kernel@lists.arm.linux.org.uk" <linux-arm-kernel@lists.arm.linux.org.uk>, Kevin Hilman <khilman@deeprootsystems.com>, Paul Walmsley <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Sun, Dec 07, 2008 at 08:55:54AM -0600, Woodruff, Richard wrote:
> Yes, NOHZ is _poor_ today in respect to needless reprogramming. Code can
> be improved. I have sent Thomas a patch for the same which is in the MM
> tree for a while now.

When I discussed this problem with Thomas, his reaction was rather
negative due to there being conflicting requirements between this and
ia64.  And quite frankly I think that the OMAP behaviour is utter
madness - taking as long as it does to update the timer registers
means that no matter what you do, you _will_ be paying a penalty
for that hardware.

Let's hope that later OMAP designs sanitise the timer hardware so
it doesn't take stupid amounts of time to write to the registers,
posted mode or not.
