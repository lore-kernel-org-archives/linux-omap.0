From: Pavel Machek <pavel@ucw.cz>
Subject: 3.20-rc0: very poor performance when running festival
Date: Thu, 12 Feb 2015 16:06:08 +0100
Message-ID: <20150212150608.GA14349@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:51162 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753150AbbBLPGL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Feb 2015 10:06:11 -0500
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: pali.rohar@gmail.com, sre@debian.org, sre@ring0.de, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com

Hi!

I'm using

echo 'Come shall then well bload? Then well bload shell when blaight!' | bash -c 'time festival --tts'

to test audio, and I noticed that in 3.20-rc0, it takes about 3x longer
than it should, on Nokia N900. Normally on 3.19, it takes 12 seconds,
but it takes 30 on 3.20.

Any ideas?

Best regards,
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
