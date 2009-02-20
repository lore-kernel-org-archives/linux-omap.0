From: Tony Lindgren <tony@atomide.com>
Subject: Re: SDIO broken in 2.6.29?
Date: Fri, 20 Feb 2009 07:49:11 -0800
Message-ID: <20090220154910.GJ7414@atomide.com>
References: <5e088bd90902192235n4104d8b1r80bfa6ff2be927d6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:62762 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754145AbZBTPtQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 20 Feb 2009 10:49:16 -0500
Content-Disposition: inline
In-Reply-To: <5e088bd90902192235n4104d8b1r80bfa6ff2be927d6@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Steve Sakoman <sakoman@gmail.com>
Cc: linux-omap <linux-omap@vger.kernel.org>

* Steve Sakoman <sakoman@gmail.com> [090219 22:38]:
> Overo has a wifi chip on mmc2 that uses the libertas_sdio driver.
> I've had my head down working in other areas and failed to noticed
> that at some point in the 2.6.29 rc cycle SDIO stopped working.
> 
> I'll start bisecting tomorrow morning, but thought I would ask first
> to see if anyone else has noticed issues in this area.

I wonder if it happened when we switched to the mainline version of
omap_hsmmc.c?

Anyways at least now most of the code is in the mainline :) So
hopefully we can get that fix in too during the -rc cycle.

Tony
