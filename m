From: Tom Cooksey <thomas.cooksey@trolltech.com>
Subject: tslib on OMAP3
Date: Wed, 25 Jun 2008 18:33:25 +0200
Message-ID: <200806251833.25218.thomas.cooksey@trolltech.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from hoat.troll.no ([62.70.27.150]:49619 "EHLO hoat.troll.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752043AbYFYQdc (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 25 Jun 2008 12:33:32 -0400
Received: from hoat.troll.no (tedur.troll.no [62.70.27.154])
	by hoat.troll.no (Postfix) with SMTP id E0296209F8
	for <linux-omap@vger.kernel.org>; Wed, 25 Jun 2008 18:33:25 +0200 (CEST)
Received: from sx01.troll.no (sx01.troll.no [62.70.27.21])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by hoat.troll.no (Postfix) with ESMTP id DA783209D9
	for <linux-omap@vger.kernel.org>; Wed, 25 Jun 2008 18:33:25 +0200 (CEST)
Received: from sx01.troll.no (localhost.localdomain [127.0.0.1])
	by sx01.troll.no (8.13.8/8.13.8) with ESMTP id m5PGXPOS023666
	for <linux-omap@vger.kernel.org>; Wed, 25 Jun 2008 18:33:25 +0200
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Does anyone have tslib running well on an OMAP3?

I have a LogicPD Zoom LPD3430 thing and a TI OMAP3430 SDP dev board,
and both have similar issues. The touchscreen is on /dev/input/event1 and
works, but is so inaccurate, it's almost unusable. After running ts_calibrate
I'm testing with ts_test. If I press and hold with ts_test in draw mode, I can
see just how inaccurate it is... After a few seconds I get a white blob about
1/3 of the screen width in diameter.

Has anyone got this to work correctly? If so, what tslib plugins/modules are 
you using and with which parameters? I've tried various combinations and
found some to give a slight improvement and others make it a lot worse.



Cheers,

Tom
