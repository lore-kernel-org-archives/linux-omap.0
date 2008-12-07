From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 5/6] ARM: OMAP2: drop redundant pending write check for gptimer
Date: Sun, 7 Dec 2008 11:25:11 +0000
Message-ID: <20081207112511.GB1646@flint.arm.linux.org.uk>
References: <20081205023737.3868.78857.stgit@localhost> <20081205024121.3868.18876.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:58503 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753490AbYLGLZe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 7 Dec 2008 06:25:34 -0500
Content-Disposition: inline
In-Reply-To: <20081205024121.3868.18876.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, Kevin Hilman <khilman@deeprootsystems.com>, Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, Richard Woodruff <r-woodruff2@ti.com>

On Thu, Dec 04, 2008 at 06:41:21PM -0800, Tony Lindgren wrote:
> omap_dm_timer_write_reg() already waits for pending writes to complete,
> so the extra wait in omap_dm_timer_set_load() is superfluous.

Is this right?  I mean - do you have to wait for each individual write
to each register to complete before writing the next (and different)
register?

Given that the code waits for every write to complete, no wonder Richard
Woodruff is complaining that the NOHZ code is poor (it isn't) - with three
writes each waiting for the previous to complete- what was it, 78us each,
to complete?  That's 234us just to reprogram the timer hardware with the
CPU spinning waiting for each of the posted writes to complete.

