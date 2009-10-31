From: Sid Boyce <sboyce@blueyonder.co.uk>
Subject: EHCI on 2.6.32-rc5-git4 + patches
Date: Sat, 31 Oct 2009 15:14:18 +0000
Message-ID: <4AEC544A.4000304@blueyonder.co.uk>
Reply-To: sboyce@blueyonder.co.uk
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp-out4.blueyonder.co.uk ([195.188.213.7]:56480 "EHLO
	smtp-out4.blueyonder.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752588AbZJaQVU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Sat, 31 Oct 2009 12:21:20 -0400
Received: from [172.23.170.139] (helo=anti-virus01-10)
	by smtp-out4.blueyonder.co.uk with smtp (Exim 4.52)
	id 1N4Ffl-0002uP-K7
	for linux-omap@vger.kernel.org; Sat, 31 Oct 2009 15:15:21 +0000
Received: from [94.171.130.58] (helo=[192.168.10.2])
	by asmtp-out3.blueyonder.co.uk with esmtpa (Exim 4.52)
	id 1N4Ffl-00034K-75
	for linux-omap@vger.kernel.org; Sat, 31 Oct 2009 15:15:21 +0000
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

There is no way to configure EHCI on beagleboard, so my devices are
never seen. Only OHCI has ARCH_ARM as a config option.
I shall edit it into drivers/usb/Kconfig and see if it works.
Regards
Sid.
-- 
Sid Boyce ... Hamradio License G3VBV, Licensed Private Pilot
Emeritus IBM/Amdahl Mainframes and Sun/Fujitsu Servers Tech Support
Specialist, Cricket Coach
Microsoft Windows Free Zone - Linux used for all Computing Tasks

