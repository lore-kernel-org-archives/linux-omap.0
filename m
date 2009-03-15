From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 02/12] ARM: OMAP3: Store reboot mode in scratchpad on
	OMAP34xx
Date: Sun, 15 Mar 2009 15:51:05 +0000
Message-ID: <20090315155105.GB10786@n2100.arm.linux.org.uk>
References: <20090310205824.16425.97745.stgit@localhost> <20090310210333.16425.80205.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:36550 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753125AbZCOPvU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 15 Mar 2009 11:51:20 -0400
Content-Disposition: inline
In-Reply-To: <20090310210333.16425.80205.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, Juha Yrjola <juha.yrjola@solidboot.com>, Kevin Hilman <khilman@deeprootsystems.com>, linux-omap@vger.kernel.org

On Tue, Mar 10, 2009 at 02:03:33PM -0700, Tony Lindgren wrote:
> From: Juha Yrjola <juha.yrjola@solidboot.com>
> 
> The reboot mode can be communicated to a bootloader (or the
> kernel itself) with a scratchpad register. This functionality
> is especially useful, if userspace is allowed to change
> the reboot mode.

The reason for this being...
