From: Paul Brook <paul@codesourcery.com>
Subject: BeagleBoard ASOC problems
Date: Sat, 25 Oct 2008 16:03:37 +0100
Message-ID: <200810251603.38681.paul@codesourcery.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.codesourcery.com ([65.74.133.4]:51620 "EHLO
	mail.codesourcery.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751482AbYJYPDl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 25 Oct 2008 11:03:41 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Steve Sakoman <steve@sakoman.com>

I'm having some problems with alsa output on a beagleboard (rev b5) with 
current linux-omap git sources, plus a copy of the overo omap3/twl4030 
config.

- When the device is initially opened and playback started I get a high 
pitched tone that lasts about a second.

- About 5 seconds after stopping playback and closing the device I get an 
audible "pop".

Once started, playback works fine.  Stopping then quickly restarting playback 
works fine. It's only when the device is left idle for several seconds that 
artifacts occur.

Any suggestions?

Paul
