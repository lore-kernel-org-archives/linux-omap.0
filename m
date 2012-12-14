From: Peter Kurrasch <gtink78@hotmail.com>
Subject: no audio out on beagleboard-xm
Date: Fri, 14 Dec 2012 08:48:35 +0000 (UTC)
Message-ID: <loom.20121214T091807-787@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:38231 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750986Ab2LNIyy (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 14 Dec 2012 03:54:54 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gplao-linux-omap-open-source-moved1@m.gmane.org>)
	id 1TjR2t-0006W0-LG
	for linux-omap@vger.kernel.org; Fri, 14 Dec 2012 09:55:04 +0100
Received: from 64-144-5-33.client.dsl.net ([64.144.5.33])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-omap@vger.kernel.org>; Fri, 14 Dec 2012 09:55:03 +0100
Received: from gtink78 by 64-144-5-33.client.dsl.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-omap@vger.kernel.org>; Fri, 14 Dec 2012 09:55:03 +0100
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi--

I'm not able to get any audio out the headphone jack on my beagleboard-xm.  I
have a Angstrom build that's on kernel 3.2.  If instead I use a 2.6.32 build the
audio works just fine.

If I go through the /proc and /sys trees it looks like everything is as it
should be.  I also see the output for the twl4030 driver during boot-up.  I also
ran through the alsamixer app and took everything off mute (maybe overkill?).

So, near as I can tell the software is okay (built properly, all modules present
and installed, etc.).  I suspect there may be a lower-level pin/register setting
that is goofed up, but I'm stuck in terms of how to investigate that further.

Any pointers on how I might proceed?

Thanks!
Peter Kurrasch

