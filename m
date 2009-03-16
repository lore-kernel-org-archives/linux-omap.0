From: david.hagood@gmail.com
Subject: OpenGL ES 2.0 support under DSS2 kernel?
Date: Mon, 16 Mar 2009 10:05:02 -0500 (CDT)
Message-ID: <1fbf6fafac32c58f505001ce87cf0f35.squirrel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.176]:63062 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752702AbZCPPFI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 16 Mar 2009 11:05:08 -0400
Received: by wa-out-1112.google.com with SMTP id v33so1801370wah.21
        for <linux-omap@vger.kernel.org>; Mon, 16 Mar 2009 08:05:05 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by Deathwish.hagood.sktc.net (Postfix) with ESMTP id 0EACEC7B8015
	for <linux-omap@vger.kernel.org>; Mon, 16 Mar 2009 10:05:02 -0500 (CDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Does anybody have any pointers on getting the kernel driver for the
PowerVR OpenGL ES2.0 hardware working under the current Linux kernel with
the DSS2 patches?

I am trying to get accelerated X working in order to test if it will be
able to do what I need to do.

Currently the Xsgx X server won't work, as the drivers for the PowerVR
graphics acceleration are missing from the DSS2 kernel, so that leaves me
dead in the water.

Just to be clear: I am *not* talking about power management, I am talking
about the PowerVR graphic accelerator core for OpenGL support (yes, I am
repeating my self redundantly, but I have had some people contact me who I
think are confusing the two).


