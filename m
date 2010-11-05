From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 0/2] OMAP1: drop AMS_DELTA_FIQ config option
Date: Thu, 4 Nov 2010 18:53:11 -0700
Message-ID: <20101105015311.GA25690@core.coreip.homeip.net>
References: <201011050126.01426.jkrzyszt@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gw0-f46.google.com ([74.125.83.46]:64487 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751613Ab0KEBxV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 4 Nov 2010 21:53:21 -0400
Received: by gwj21 with SMTP id 21so1913853gwj.19
        for <linux-omap@vger.kernel.org>; Thu, 04 Nov 2010 18:53:21 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <201011050126.01426.jkrzyszt@tis.icnet.pl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Cc: Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi Janusz,

On Fri, Nov 05, 2010 at 01:26:00AM +0100, Janusz Krzysztofik wrote:
> This set of patches removes a config option that was used to select a FIQ 
> handler to be build for Amstrad Delta, as required by the on-board serio 
> interface driver. Not having any problem reports received since it was 
> introduced in 2.6.35, the FIQ handler can now be built by default, thus 
> reqiring no extra config option.
> 
> 1/2: serio: Amstrad Delta: no longer select AMS_DELTA_FIQ from serio Kconfig
> 2/2: OMAP1: Amstrad Delta: always build with FIQ handler linked in
> 

It does not makes ense to split these 2, please fold together and merge
through Tony's tree.

Thanks.

-- 
Dmitry
