From: David Hagood <david.hagood@gmail.com>
Subject: Is anybody else having problems with SDHC cards on Beagleboard?
Date: Tue, 20 Jan 2009 06:38:38 -0600
Message-ID: <1232455118.6982.14.camel@surfer>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from yx-out-2324.google.com ([74.125.44.28]:58742 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754440AbZATMip (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 20 Jan 2009 07:38:45 -0500
Received: by yx-out-2324.google.com with SMTP id 8so1475307yxm.1
        for <linux-omap@vger.kernel.org>; Tue, 20 Jan 2009 04:38:44 -0800 (PST)
Received: from [10.10.10.241] (surfer.hagood.sktc.net [10.10.10.241])
	by Deathwish.hagood.sktc.net (8.14.3/8.14.0) with ESMTP id n0KCccGC023765
	for <linux-omap@vger.kernel.org>; Tue, 20 Jan 2009 06:38:39 -0600
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

I have been trying to bring up a Beagleboard as a development platform
for a project at work, but I am having a killer problem: any significant
access of the memory card (a class 8 SDHC 8G card) will die with a
transfer error, followed by about 10 failed sector accesses, followed by
the system dying.

I've tried 2 different Beagleboards and 3 different cards by 2 different
manufacturers, and the problem is repeatable on all permutations. I've
put the cards into a card reader on my workstation and done a "dd
if=/dev/sdf of=/dev/null" to verify the cards aren't wedged.

I've searched for this on Google and found no references, but I cannot
believe I'm the only person seeing this - but am I?



