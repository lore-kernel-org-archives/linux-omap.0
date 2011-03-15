From: Peter Barada <peter.barada@gmail.com>
Subject: Question regarding suspend/resume
Date: Tue, 15 Mar 2011 15:25:37 -0400
Message-ID: <4D7FBD31.6050806@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:49947 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758344Ab1COTZj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 15 Mar 2011 15:25:39 -0400
Received: by iwn34 with SMTP id 34so895904iwn.19
        for <linux-omap@vger.kernel.org>; Tue, 15 Mar 2011 12:25:39 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linux OMAP list <linux-omap@vger.kernel.org>

Is there any reference how to decode the output of /debug/pm_debug/count?  I'm trying to figure out when I resume why it says the core_pwrdm didn't enter the target state, and I'm assuming because a clock used is not disabled in the suspend path, but as fars as I can tell there's no output in the pm_debug code that tells which clocks in a power domain are active at the time of a suspend.

Any ideas?

-- 
Peter Barada
peter.barada@gmail.com

