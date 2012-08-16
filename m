From: Tony Lindgren <tony@atomide.com>
Subject: Re: Fate of OMAP3-Touchbook board
Date: Thu, 16 Aug 2012 01:35:40 -0700
Message-ID: <20120816083540.GJ11011@atomide.com>
References: <502C0BF4.4010502@mrkva.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:41622 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756242Ab2HPIfn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 16 Aug 2012 04:35:43 -0400
Content-Disposition: inline
In-Reply-To: <502C0BF4.4010502@mrkva.eu>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Radek Pilar <mrkva@mrkva.eu>
Cc: linux-omap@vger.kernel.org

* Radek Pilar <mrkva@mrkva.eu> [120815 14:00]:
> Hello,
> a few months ago, Always Innovating - a company behind their OMAP3 based
> product Touchbook basically stopped production. I've been porting some
> specific drivers for current kernels since then and I'd like to push at
> least some of them to the mainline.
> However, I found  a bug in mainline that prevents this device from
> booting - and looks like noone has reported it for a few months.
> So, I'd like to ask - do you want to keep this board in mainline (in
> this case, I can send a few patches adding few drivers (backlight,
> accelerometer, soundcard, keyboard). Or do you want to remove it from
> the mainline altogether?

The fix should be posted for -rc cycle. Minimal patches for the board-*.c
files are OK, but we should put most effort making things usable with
device tree based booting.

Regards,

Tony
