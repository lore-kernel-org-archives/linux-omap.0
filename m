From: arno@natisbad.org (Arnaud Ebalard)
Subject: Upstream linux-omap kernel on Nokia N900?
Date: Mon, 19 Apr 2010 13:49:15 +0200
Message-ID: <87iq7nslvo.fsf@small.ssi.corp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from copper.chdir.org ([88.191.97.87]:40929 "EHLO copper.chdir.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752051Ab0DSLtP (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 19 Apr 2010 07:49:15 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Lauri Leukkunen <lauri.leukkunen@nokia.com>, Felipe Balbi <felipe.balbi@nokia.com>, Roger Quadros <roger.quadros@nokia.com>, Kalle Valo <kalle.valo@nokia.com>

Hi,

Nokia N900 is shipped to users with a 2.6.28 omap kernel. Many patches
for the hardware and various features have been pushed upstream by Nokia
developers and possibly others. Those are now available in current l-o
tree.

Nonetheless, many drivers and various features are still missing
upstream. Simply put, one cannot expect to run a current l-o kernel on
the device (and expect to get a GUI and/or make call with the device).

To get an idea of what it would take to achieve that, I started looking
at what is missing upstream, what is already there and what is currently
being pushed. I started putting some notes on this triage work and a set
of patches here:

  http://natisbad.org/N900/n900-current-linux-omap-kernel.html

If some among you are interested and/or have comments on the topic, they
are welcome. Among other things, I am worried about the OMAP 3430 GPU
code: if some people from TI can provide some advice on that aspect,
that would be great!

Cheers,

a+
