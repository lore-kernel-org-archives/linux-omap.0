From: Pavel Machek <pavel@ucw.cz>
Subject: 3.19 on Nokia n900: audio quality awful
Date: Tue, 6 Jan 2015 18:04:33 +0100
Message-ID: <20150106170433.GA5408@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:34083 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755277AbbAFREi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 6 Jan 2015 12:04:38 -0500
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: pali.rohar@gmail.com, sre@debian.org, sre@ring0.de, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com

Hi!

In 3.18, sound is nice and clear.

In 3.19, sound is unusable. It produces nasty tone when it should be
quiet, and there's at least as much noise as is sound.

Unfortunately, list of mixers also changed (and there's cca 120
settings), but a) it does not work with the old list and b) nothing I
could figure out did make the sound usable. Some setting resulted in
even more noise.

Any idea what could have caused it?

Thanks,
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
