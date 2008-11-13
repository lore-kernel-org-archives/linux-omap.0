From: Tony Lindgren <tony@atomide.com>
Subject: Re: [patch 2.6.28-rc2-omap 0/4] legacy gpio phaseout...
Date: Thu, 13 Nov 2008 13:38:52 -0800
Message-ID: <20081113213849.GE3106@atomide.com>
References: <200810292036.21321.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:58107 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751353AbYKMViz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 13 Nov 2008 16:38:55 -0500
Content-Disposition: inline
In-Reply-To: <200810292036.21321.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: linux-omap@vger.kernel.org

* David Brownell <david-b@pacbell.net> [081029 20:44]:
> This is the first two of the four patches I sent before, split
> into stuff that only relates to the OMAP tree and stuff that
> applies to that and to mainline:
> 
>  - OMAP tree
>     * use standard gpio get/set calls
>     * use gpio_direction_input
>  - Mainline *and* OMAP trees:
>     * use standard get/set calls, remove the legacy one
>     * use gpio_direction_input
> 
> Some of the OMAP-only bits relate to touchscreen support;
> when it's ads7846-compatible, that should probably be in
> the mainline merge queue too.
> 
> There will be a couple minor glitches applying the second
> set to mainline; nothing of significance.
> 
> I'll do the same split for the second pair of patches a
> bit later.

Pushing today and adding to omap-upstream queue.

Tony
