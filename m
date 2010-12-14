From: Peter Barada <peter.barada@gmail.com>
Subject: Thermal issues with OMAP35x on Logic Torpedo module
Date: Tue, 14 Dec 2010 13:54:35 -0500
Message-ID: <4D07BD6B.6030203@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:50345 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751364Ab0LNSyS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 14 Dec 2010 13:54:18 -0500
Received: by qwa26 with SMTP id 26so1082747qwa.19
        for <linux-omap@vger.kernel.org>; Tue, 14 Dec 2010 10:54:17 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

The OMAP3530 I-temp can run the core at up to 90 degrees C, but we have 
concerns in using the part in industrial environments (where process 
loading is unpredictable) that the temp may rise past that point.  I 
understand external heat sinks can be used to help mitigate the problem 
but not all applications can use such.

What I'd like to do is to use the core CONTROL_TEMP_SENSOR to monitor 
core temperature and if it rises too high, throttle the OPP point to 
slow it down enough to keep it cool - and restore the OPP point if it 
cools down enough, using hysteresis to prevent oscillation of the OPP 
point while operating near the extremes.

Does anyone have suggestions on how I can best implement such in the 
latest kernel?

Thanks in advance!

--
Peter Barada
peter.barada@logicpd.com

