From: onlyfever <onlyfever@gmail.com>
Subject: HELP:How to power down TWL5030 Voice/Bluetooth sidetone PGA?
Date: Thu, 9 Jun 2011 21:40:15 +0800
Message-ID: <BANLkTik0mX5wSYNdBwhjxuaKa6908fmazQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:52812 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757766Ab1FINkQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 9 Jun 2011 09:40:16 -0400
Received: by vxi39 with SMTP id 39so1167253vxi.19
        for <linux-omap@vger.kernel.org>; Thu, 09 Jun 2011 06:40:15 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, alsa-devel@alsa-project.org

Hello,
I want to power down Voice/Bluetooth sidetone PGA of TWL5030.
I set the VSTPGA Register/BTSTPGA Register to 0x00,but it seems that
the Voice/Bluetooth sidetone PGA still work,
and even set VSTPGA/BTSTPGA to Mute,there still have sidetone come out.

How can I power down Voice/Bluetooth sidetone PGA?
I don't need sidetone.

thanks!
