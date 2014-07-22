From: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: Nokia N900 FB regression?
Date: Wed, 23 Jul 2014 00:23:18 +0300
Message-ID: <20140722212318.GC2615@drone.musicnaut.iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from filtteri5.pp.htv.fi ([213.243.153.188]:40110 "EHLO
	filtteri5.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752021AbaGVVX1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 22 Jul 2014 17:23:27 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>
Cc: Sebastian Reichel <sre@kernel.org>, Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, Pavel Machek <pavel@ucw.cz>

Hi,

Somewhere between 3.16-rc2 and rc6 (I was on holidays...) I noticed
the framebuffer stopped working on N900 (nothing on screen).

I bisected this to 9188883fd66e9809e93e06d5bbd49cf99a6cdbee (ARM: dts:
Enable twl4030 off-idle configuration for selected omaps).
With this commit reverted, I can see the Tux again with 3.16-rc6.

Any ideas?

A.
