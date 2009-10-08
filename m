From: Christopher Friedt <chrisfriedt@gmail.com>
Subject: omap850 & omap730 rtc
Date: Thu, 8 Oct 2009 14:42:22 +0200
Message-ID: <3ea34a000910080542v567e7536t599414d506a53a3f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gx0-f212.google.com ([209.85.217.212]:36971 "EHLO
	mail-gx0-f212.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757914AbZJHMm6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Oct 2009 08:42:58 -0400
Received: by gxk4 with SMTP id 4so6888287gxk.8
        for <linux-omap@vger.kernel.org>; Thu, 08 Oct 2009 05:42:22 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi,

I'm currently very close to finishing the rtc working on my htc wizard
(omap850).

During boot-up, I see:

omap_rtc omap_rtc: setting system clock to 2009-09-08 12:47:02 UTC (1252414022)

which is the correct time, however, trying to read /dev/rtc0 fails:

select() to /dev/rtc0 to wait for clock tick timed out

Any ideas?

Chris
