From: Sid Boyce <sboyce@blueyonder.co.uk>
Subject: linux-omap-2.6 does not allow configuring rt2xx
Date: Tue, 10 Nov 2009 21:35:52 +0000
Message-ID: <4AF9DCB8.9050305@blueyonder.co.uk>
Reply-To: sboyce@blueyonder.co.uk
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp-out2.blueyonder.co.uk ([195.188.213.5]:49275 "EHLO
	smtp-out2.blueyonder.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758180AbZKJVfx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 10 Nov 2009 16:35:53 -0500
Received: from [172.23.170.143] (helo=anti-virus02-10)
	by smtp-out2.blueyonder.co.uk with smtp (Exim 4.52)
	id 1N7yNa-0003tT-4n
	for linux-omap@vger.kernel.org; Tue, 10 Nov 2009 21:35:58 +0000
Received: from [94.171.130.58] (helo=[192.168.10.2])
	by asmtp-out4.blueyonder.co.uk with esmtpa (Exim 4.52)
	id 1N7yNZ-0005ul-N9
	for linux-omap@vger.kernel.org; Tue, 10 Nov 2009 21:35:57 +0000
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Spotted over the last few days.
"make ARCH=arm CROSS_COMPILE=/opt/arm-2009q1/bin/arm-none-linux/gnueabi-
omap3_beagle_defconfig", then xconfig/menuconfig/config, the option
never shows up.
Regards
Sid.
-- 
Sid Boyce ... Hamradio License G3VBV, Licensed Private Pilot
Emeritus IBM/Amdahl Mainframes and Sun/Fujitsu Servers Tech Support
Specialist, Cricket Coach
Microsoft Windows Free Zone - Linux used for all Computing Tasks

