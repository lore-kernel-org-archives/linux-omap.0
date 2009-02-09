From: Steve Sakoman <sakoman@gmail.com>
Subject: musb OTG broken in 2.6.29-rc3?
Date: Mon, 9 Feb 2009 09:40:57 -0800
Message-ID: <5e088bd90902090940s3c6de0eqac55e21acd4490bc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.185]:15678 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754652AbZBIRlA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 9 Feb 2009 12:41:00 -0500
Received: by mu-out-0910.google.com with SMTP id i10so1180501mue.1
        for <linux-omap@vger.kernel.org>; Mon, 09 Feb 2009 09:40:57 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>

I've been running with musb in host mode on Overo.

Now that EHCI is working, I decided to try putting musb in OTG mode.

Last time I tried this was back in 2.6.28 and it seemed to work just fine.

In 2.6.29-rc3 I don't get any joy - the musb port doesn't seem to
switch into host mode when I plug in a miniA cable. Booting with the
miniA cable in place doesn't seem to help.  Compiling the kernel with
host mode enabled works as expected.

Before I spend too much time debugging, has anyone else been
successful with musb OTG in 2.6.29-rc3?  A quick search of this list
didn't turn up any discussion of issues.

Steve
