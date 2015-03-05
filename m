From: Ran Shalit <ranshalit@gmail.com>
Subject: Ethernet WOL (wake on lan)
Date: Thu, 5 Mar 2015 18:53:56 +0200
Message-ID: <CAJ2oMhKuDQXnJb795PeqsiOrBNEburB1AayRkGVQM9Tu92n=wA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f170.google.com ([209.85.212.170]:43511 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757896AbbCEQx6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 5 Mar 2015 11:53:58 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-pm@vger.kernel.org, Linux OMAP Mailing List <linux-omap@vger.kernel.org>

Hello,

I would please like to ask how I should use therenet WOL (wake on lan) ?
I am using device smsc911x, and I can see in code that there is
reference to WOL.
But I don't understand how this should function.
Should I call smsc911x_suspend() smsc911x_resume() or does it
automatically suspend/resume ?
Generally speaking I rather is to stop/start automatically.

Thanks,
Ran
