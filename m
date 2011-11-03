From: Tony Lindgren <tony@atomide.com>
Subject: Re: mainline tree fails to build with OMAP3-only config
Date: Thu, 3 Nov 2011 11:57:50 -0700
Message-ID: <20111103185750.GV31337@atomide.com>
References: <4EB2B7B1.4070804@gmail.com>
 <4EB2D4FF.40408@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:15261 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933865Ab1KCS5y (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Nov 2011 14:57:54 -0400
Content-Disposition: inline
In-Reply-To: <4EB2D4FF.40408@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Daniel Mack <zonque@gmail.com>
Cc: linux-omap@vger.kernel.org, hvaibhav@ti.com, linux-arm-kernel@lists.infradead.org

* Daniel Mack <zonque@gmail.com> [111103 10:18]:
> On 11/03/2011 04:48 PM, Daniel Mack wrote:
> >Hi,
> >
> >when trying to build an OMAP3-only config with Linus' current mainline
> >HEAD, I'm getting the following errors. The same config works fine with
> >v3.1.
> 
> FWIW, the config in question is available here:
> 
>  http://zonque.org/linux-3.1-omap3.config

Just for reference, here's the patch for this:

http://marc.info/?l=linux-omap&m=132034503812225&w=2

Tony
 
