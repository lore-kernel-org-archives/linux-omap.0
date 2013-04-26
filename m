From: Luciano Coelho <coelho@ti.com>
Subject: Re: [PATCH 0/3] WLAN support for omap4 when booted with devicetree
Date: Fri, 26 Apr 2013 09:31:48 +0300
Message-ID: <1366957908.4029.15.camel@cumari.coelho.fi>
References: <20130426034858.26065.65118.stgit@muffinssi.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:60697 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752968Ab3DZGdM (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 26 Apr 2013 02:33:12 -0400
In-Reply-To: <20130426034858.26065.65118.stgit@muffinssi.local>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

On Thu, 2013-04-25 at 20:52 -0700, Tony Lindgren wrote:
> Hi all,

Hi Tony,


> Here are some patches against linux next to make WLAN to work with
> device tree. Note that we still are initializing wl12xx with pdata,
> but so far it looks like only minimal binding for it is needed.

Thanks for doing this! I've been out on vacation for the past 3 weeks,
so I didn't manage to finish the wl12xx DT stuff in time for 3.10. :(


> There are various fixes pending posted recently, but at least the
> fix "[PATCH] mmc: omap_hsmmc: Fix the DT pbias workaround for MMC
> controllers 2 to 5" is needed.

I managed to apply the OMAP2+ and the blaze patches.  There were
conflicts with the panda patch, so I skipped it for now.  I'll come back
to it a bit later.


> Please test on blaze/sdp if you have a chance, I don't have the
> connectivity card on mine.

I tested this on Blaze and it seems to work fine! The driver gets probed
and I can power the chip on and off (by putting the interface up and
down) without any problems. :)

BTW, did you (or anyone else) manage to get ethernet to work on Blaze
(or Panda) with DT?

-- 
Luca.

