From: Tero Kristo <t-kristo@ti.com>
Subject: OMAP CLK / CM data move to /drivers/clk
Date: Wed, 27 Feb 2013 10:44:19 +0200
Message-ID: <1361954659.8362.70.camel@sokoban>
Reply-To: <t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:49007 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757014Ab3B0IoY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 27 Feb 2013 03:44:24 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>, mturquette@linaro.org, "Valentin, Eduardo" <eduardo.valentin@ti.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "Nayak, Rajendra" <rnayak@ti.com>

Hi Paul and Mike,

It looks like we need to start putting more effort into this clock data
move now, as this is starting to hinder us on several fronts.
Unfortunately I still can't personally participate in this work myself
as I am now allocated to some hwmod related work, but Eduardo should
have plenty of time to help with this...

Anyway, Paul, I think you have been working a bit with this topic, what
is the latest status with this? Do you see any areas Eduardo can help
with? If you have some partially finished work also which you don't have
time yourself, we can even take a look at that.

Also, I would like to receive some initial comments about the approach
we should take, and I added Mike here for this as you are the maintainer
for the /drivers/clk. I believe we should start by moving the clock data
under /drivers/clk/omap, and potentially move also some other stuff
here, like CM code, clockdomain code and clockdomain data even. Do you
have any opinions on this?

-Tero


