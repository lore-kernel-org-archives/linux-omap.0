From: Peter Tseng <tsenpet09@gmail.com>
Subject: omap-pm: omap3_pm_defconfig no longer booting on Overo
Date: Thu, 29 Apr 2010 03:24:03 -0400
Message-ID: <4BD93413.6000409@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:53687 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934101Ab0D3Sfg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 30 Apr 2010 14:35:36 -0400
Received: by mail-vw0-f46.google.com with SMTP id 19so440186vws.19
        for <linux-omap@vger.kernel.org>; Fri, 30 Apr 2010 11:35:36 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Since the rc5 tag, omap3_pm_defconfig from the pm branch no longer boots
on the Gumstix Overo.
I am certain that a build back in the rc3 days worked. Unfortunately, I
don't know about rc4, or anything that happenend in the intervening time.

Any clues on how to fix? If necessary, I'll provide what info I can to
help diagnose the issue if told what to do.

Peter Tseng
