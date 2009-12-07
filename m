From: Sergey Lapin <slapinid@gmail.com>
Subject: commit f4633d810405d4df8b3ea98f617856d149af636a breaks non-DSS2 pxafb
	support
Date: Mon, 7 Dec 2009 16:13:00 +0300
Message-ID: <48239d390912070513w40aabc6m89193fb3d4387140@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.24]:13254 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757007AbZLGNMy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 7 Dec 2009 08:12:54 -0500
Received: by ey-out-2122.google.com with SMTP id d26so1127860eyd.19
        for <linux-omap@vger.kernel.org>; Mon, 07 Dec 2009 05:13:00 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi, all!

I have custom external framebuffer driver based on drivers/video/omap/hwa742.c
It is broken by commit f4633d810405d4df8b3ea98f617856d149af636a.
if I revert it, it starts working. What is needed to be done to fix
driver to make it
work with non-DSS2 omapdss device?

S.
