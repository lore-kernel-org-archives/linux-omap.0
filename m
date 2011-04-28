From: green@linuxhacker.ru
Subject: Initial B&N Nook Color support, take two
Date: Thu, 28 Apr 2011 11:57:37 -0400
Message-ID: <1304006259-7939-1-git-send-email-green@linuxhacker.ru>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from c-71-228-165-73.hsd1.tn.comcast.net ([71.228.165.73]:38537 "EHLO
	fatbox1.localnet" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757717Ab1D1P5q (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 28 Apr 2011 11:57:46 -0400
Received: from fatbox1.localnet (fatbox1.localnet [127.0.0.1])
	by fatbox1.localnet (8.14.4/8.14.4) with ESMTP id p3SFvjux007981
	for <linux-omap@vger.kernel.org>; Thu, 28 Apr 2011 11:57:45 -0400
Received: (from green@localhost)
	by fatbox1.localnet (8.14.4/8.14.4/Submit) id p3SFviPc007979
	for linux-omap@vger.kernel.org; Thu, 28 Apr 2011 11:57:44 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hello!

   Ok, this is a second attempt at B&N Nook Color board file submission.
   USB peripheral mode is fully operational as is serial console and
   MMC/SDCard.

   I threw away all the android stuff as suggested, also cleaned up
   voltage regulators and removed the ones our twl chip actually
   does not have (contrary to my previous beliefs).

Bye,
    Oleg

