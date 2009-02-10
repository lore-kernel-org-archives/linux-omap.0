From: Gary Thomas <gary@mlbassoc.com>
Subject: OMAP [TV] video
Date: Tue, 10 Feb 2009 09:05:13 -0700
Message-ID: <4991A5B9.4060308@mlbassoc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from 137-67-76-76-skybeam.com ([76.76.67.137]:2093 "EHLO
	mail.chez-thomas.org" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1753236AbZBJQFS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 10 Feb 2009 11:05:18 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linux OMAP <linux-omap@vger.kernel.org>

I'm trying to get TV [S-Video] working on my 3530 board.
The settings in the current kernel don't seem to work very
well on my TV (U.S. NTSC, standard).  Comparing the video
encoder setup with the suggested values in the manual, I
find many differences, mostly with respect to the framing
(signal shaping).

Questions:
* Are the settings in the kernel tree known to work [as is]?
* Why the divergence from the recommended values?

Any ideas or helpful pointers would be graciously accepted

Thanks

-- 
------------------------------------------------------------
Gary Thomas                 |  Consulting for the
MLB Associates              |    Embedded world
------------------------------------------------------------
