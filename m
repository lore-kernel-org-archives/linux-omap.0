From: Steve Sakoman <sakoman@gmail.com>
Subject: SDIO broken in 2.6.29?
Date: Thu, 19 Feb 2009 22:35:33 -0800
Message-ID: <5e088bd90902192235n4104d8b1r80bfa6ff2be927d6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f161.google.com ([209.85.218.161]:56492 "EHLO
	mail-bw0-f161.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751608AbZBTGff (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 20 Feb 2009 01:35:35 -0500
Received: by bwz5 with SMTP id 5so2106815bwz.13
        for <linux-omap@vger.kernel.org>; Thu, 19 Feb 2009 22:35:33 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>

Overo has a wifi chip on mmc2 that uses the libertas_sdio driver.
I've had my head down working in other areas and failed to noticed
that at some point in the 2.6.29 rc cycle SDIO stopped working.

I'll start bisecting tomorrow morning, but thought I would ask first
to see if anyone else has noticed issues in this area.

Steve
