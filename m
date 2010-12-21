From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 3/3] OMAP: wd_timer: remove old, dead probing code
Date: Tue, 21 Dec 2010 15:30:27 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1012211529440.1446@utopia.booyaka.com>
References: <20101116102205.27991.37909.stgit@twilight.localdomain> <20101116102518.27991.38133.stgit@twilight.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:42797 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753307Ab0LUWa1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 21 Dec 2010 17:30:27 -0500
In-Reply-To: <20101116102518.27991.38133.stgit@twilight.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Charulatha Varadarajan <charu@ti.com>

Hi,

On Tue, 16 Nov 2010, Paul Walmsley wrote:

> After commit f2ce62312650211f6cf665cd6dc519c334c4071e, watchdog
> probing is handled by files in mach-omap1/ and mach-omap2/, and the
> plat-omap/devices.c probing code is no longer used.  Remove the dead
> code in plat-omap/devices.c.
> 
> Signed-off-by: Paul Walmsley <paul@pwsan.com>
> Cc: Charulatha Varadarajan <charu@ti.com>

Dropping this patch since Tony merged Anand Gadiyar's fix for the same 
issue dated 3 December 2010.


- Paul
