From: Tero Kristo <tero.kristo@nokia.com>
Subject: Dynamic idle support for UART
Date: Thu, 29 May 2008 17:55:47 +0300
Message-ID: <1212072948-3987-1-git-send-email-tero.kristo@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:40329 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755911AbYE2NBu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 29 May 2008 09:01:50 -0400
Received: from esebh105.NOE.Nokia.com (esebh105.ntc.nokia.com [172.21.138.211])
	by mgw-mx09.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m4TD1Phs017927
	for <linux-omap@vger.kernel.org>; Thu, 29 May 2008 08:01:48 -0500
Received: from localhost.localdomain (sokoban.ntc.nokia.com [172.22.144.95])
	by mgw-int01.ntc.nokia.com (Switch-3.2.5/Switch-3.2.5) with ESMTP id m4TD1YAU002635
	for <linux-omap@vger.kernel.org>; Thu, 29 May 2008 16:01:34 +0300
In-Reply-To: <>
References: <>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

This hack will most importantly allow serial console usage when dynamic
idle is enabled.

Note! Functionality under 24xx configuration has not been verified!
      There may be some problems with CONFIG_PM_DEBUG flag enabled,
      most likely during the PM debug information dumps after / before
      sleep. Without this debugging flag this patch should not affect 24xx
      devices. Todo: Someone to check functionality under 24xx
      configuration and to enable functionality by default on that
      platform also.


