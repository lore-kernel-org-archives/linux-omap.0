From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] omap: mux: fix multipath gpio handling
Date: Tue, 6 Jul 2010 16:25:10 +0300
Message-ID: <20100706132510.GS3192@atomide.com>
References: <1278360411-25797-1-git-send-email-notasas@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:60028 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754726Ab0GFNZP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 6 Jul 2010 09:25:15 -0400
Content-Disposition: inline
In-Reply-To: <1278360411-25797-1-git-send-email-notasas@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grazvydas Ignotas <notasas@gmail.com>
Cc: linux-omap@vger.kernel.org

* Grazvydas Ignotas <notasas@gmail.com> [100705 23:00]:
> OMAP3530 CBB package can have GPIO126 muxed on 2 pins: mmc1_dat4 and
> cam_strobe. This causes a problem with current multipath GPIO mux
> handling, which muxes both pins as GPIO126 and makes the GPIO unusable.
> 
> Fix this by not muxing any pins if multipath GPIO is detected and
> just print a warning instead. It's up to board files to set correct
> mux using omap_mux_init_signal and pin name.

This looks good to me. Are you OK if we merge it during the upcoming
merge window? Kind of worried that we might break some other boards
that rely on the first GPIO getting muxed..

Tony
