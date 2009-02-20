From: Aaro Koskinen <aaro.koskinen@nokia.com>
Subject: [PATCH 0/2] twl4030-madc fixes
Date: Fri, 20 Feb 2009 16:10:51 +0200
Message-ID: <499EB9EB.4050008@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:19297 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752042AbZBTOLF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 20 Feb 2009 09:11:05 -0500
Received: from esebh106.NOE.Nokia.com (esebh106.ntc.nokia.com [172.21.138.213])
	by mgw-mx09.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id n1KEAhaN010070
	for <linux-omap@vger.kernel.org>; Fri, 20 Feb 2009 08:10:59 -0600
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hello,

Two fixes for twl4030-madc:

- The first one converts the ioctl to unlocked one.

- The second one should return the conversion status to user quicker, 
both in OK and timeout cases. There's also fix for the timeout case 
(currently the request remains active) and some cleanup.

A.
