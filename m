From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/2] arm: boot: dts: am437x-sk: fix for new newhaven
 display module revision
Date: Mon, 4 May 2015 09:21:34 -0700
Message-ID: <20150504162134.GL24469@atomide.com>
References: <1428595167-10050-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from muru.com ([72.249.23.125]:48997 "EHLO muru.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751007AbbEDQVh (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 4 May 2015 12:21:37 -0400
Content-Disposition: inline
In-Reply-To: <1428595167-10050-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>

* Felipe Balbi <balbi@ti.com> [150409 09:03]:
> AM437x Starter Kit uses a NewHaven Display module with
> a 4.3" display and EDT FT5306 touchscreen
> 
> On that module's new revision, NewHave decided to change
> the pinout on the 6 pin flat-pcb touchscreen connector so
> that instead of having WAKE pin, we now have RESETn.
> 
> The new display module is available on AM437x SK Beta and
> all new revisions while the older revision is only available
> on AM437x SK Alpha which, unfortunately, can't be supported
> anymore in mainline without a revert of this patch.

Applying both into omap-for-v4.1/fixes thanks.

Tony
