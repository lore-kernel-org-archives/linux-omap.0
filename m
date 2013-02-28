From: =?UTF-8?Q?Andreas_M=C3=BCller?= <schnitzeltony@googlemail.com>
Subject: omapdss wakeup issues
Date: Thu, 28 Feb 2013 17:27:17 +0100
Message-ID: <CALbNGRThXXuSE9Q9h7rcSHYm_s4nUcdGjC-xRFD23f0-Ncy3-w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ve0-f175.google.com ([209.85.128.175]:58511 "EHLO
	mail-ve0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753459Ab3B1Q1S (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 28 Feb 2013 11:27:18 -0500
Received: by mail-ve0-f175.google.com with SMTP id cy12so1974907veb.20
        for <linux-omap@vger.kernel.org>; Thu, 28 Feb 2013 08:27:17 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi,

I am preparing 3.8 mainline for gumstix overo and have the following
issue: waking Monitor connected by HDMI from power save makes Monitor
complain for unsupported frequency and console says:

| omapdss APPLY error: FIFO UNDERFLOW on gfx, disabling the overlay

Is this a known issue?

Andreas
