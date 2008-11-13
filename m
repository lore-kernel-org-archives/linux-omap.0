From: Tony Lindgren <tony@atomide.com>
Subject: Re: [patch 2.6.28-rc2-omap 0/5] legacy gpio phaseout (II) ...
Date: Thu, 13 Nov 2008 13:39:15 -0800
Message-ID: <20081113213914.GF3106@atomide.com>
References: <200810300031.42711.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:58467 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751497AbYKMVjS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 13 Nov 2008 16:39:18 -0500
Content-Disposition: inline
In-Reply-To: <200810300031.42711.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: linux-omap@vger.kernel.org

* David Brownell <david-b@pacbell.net> [081030 00:38]:
> Second set, plus the first of Jarkko's:
> 
>  - OMAP tree
>     * use gpio_direction_output()
>     * use gpio_to_irq()
>  - Mainline *and* OMAP trees:
>     * use gpio_direction_output(), remove the legacy version
>     * use gpio_to_irq()
>     * make legacy gpio_request()/gpio_free() calls superfluous
> 
> These go on top of the preceding four.
> 
> Merging these will facilitate for example a mach-omap2/gpio.c file
> that is much nicer since it's not full of OMAP1 support...

Pushing today and adding to omap-upstream queue.

Tony
