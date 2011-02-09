From: David Fries <david@fries.net>
Subject: Re: ARM suspend to disk?
Date: Tue, 8 Feb 2011 22:39:51 -0600
Message-ID: <20110209043951.GA23509@spacedout.fries.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from SpacedOut.fries.net ([67.64.210.234]:45976 "EHLO
	SpacedOut.fries.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750794Ab1BIEyH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 Feb 2011 23:54:07 -0500
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-omap@vger.kernel.org

 On Thu, Apr 29, 2010 at 1:58 PM, Kevin Hilman
 <khilman@deeprootsystems.com> wrote:
> What do you expect to gain from suspend-to-disk + snapshot boot that
> you don't already get from suspend-to-RAM using off-mode?
>
> On OMAP, with off-mode enabled, a suspend to RAM puts the entire OMAP
> into full-chip off, and essentially reboots the ARM when waking up
> from suspend (or idle) already.

A long dead thread, but what you can do with suspend to disk, is
suspend to disk, swap batteries to a spare, and resume where you were.
I'm specifically thinking about my Nokia N900 cell phone.

Other reasons I would have liked it,
- When the battery level gets critical, suspend to disk rather than
  killing it when the battery drains, when I'm not at a place to charge.
- Swapping SIM cards (it's under the battery).
- Airlines, "yes we really mean OFF not (fill in the blank)"

-- 
David Fries <david@fries.net>
http://fries.net/~david/ (PGP encryption key available)
