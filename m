From: Sakari Ailus <sakari.ailus@nokia.com>
Subject: 32 kHz timer granularity when CONFIG_NO_HZ is enabled
Date: Wed, 22 Oct 2008 16:13:02 +0300
Message-ID: <48FF26DE.4060107@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:23672 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752466AbYJVNNZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 22 Oct 2008 09:13:25 -0400
Received: from vaebh105.NOE.Nokia.com (vaebh105.europe.nokia.com [10.160.244.31])
	by mgw-mx03.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m9MDD4mp011793
	for <linux-omap@vger.kernel.org>; Wed, 22 Oct 2008 16:13:22 +0300
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by maxwell.research.nokia.com (Postfix) with ESMTP id 3B88427B15D
	for <linux-omap@vger.kernel.org>; Wed, 22 Oct 2008 16:13:03 +0300 (EEST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

I have OMAP 3 and I'm using the 32 kHz timer, CONFIG_OMAP_32K_TIMER_HZ 
is set to 128 and CONFIG_NO_HZ is enabled. Many OMAP-based boards in 
arch/arm/config seem to have this kind of default configuration.

This has the effect that for example msleep(1) sleeps much longer than 
intended, between 7,8 and 15,6 ms, for no apparent good reason.

I'm just wondering whether all this is intentional. :-)

-- 
Sakari Ailus
sakari.ailus@nokia.com
