From: astralstorm@gen2.org
Subject: linux-omap vs N810
Date: Mon, 28 Apr 2008 00:01:09 +0200 (CEST)
Message-ID: <55288.89.77.111.170.1209333669.squirrel@mail.gen2.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from host-91-192-90-10.elomza.pl ([91.192.90.10]:36642 "EHLO
	gen2.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752066AbYD0WOc (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sun, 27 Apr 2008 18:14:32 -0400
Received: from mail.gen2.org (neptune.gen2.org [127.0.0.1])
	by gen2.org (Postfix) with ESMTP id BEEAB3D6B1
	for <linux-omap@vger.kernel.org>; Mon, 28 Apr 2008 00:01:07 +0200 (CEST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hello,
I'm having a major problem running linux-omap kernel on Nokia N810.
After correct build and flashing (tested by the use of self-built patched
Nokia kernel) the device seems to hang before framebuffer initialization,
then is rebooted by the watchdog. Manual FB update is disabled, I've
checked the configuration in many possible ways.

I'd like to hear about possible causes of that.

I do not have the serial console wired in (yet_, but would still like to
get debugging output. What would you recommend?


