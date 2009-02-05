From: Aaro Koskinen <aaro.koskinen@nokia.com>
Subject: [PATCH PM 0/2] OMAP McSPI: Fixes to save/restore
Date: Thu, 05 Feb 2009 13:05:38 +0200
Message-ID: <498AC802.8040302@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:60020 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751684AbZBELFq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 5 Feb 2009 06:05:46 -0500
Received: from esebh105.NOE.Nokia.com (esebh105.ntc.nokia.com [172.21.138.211])
	by mgw-mx06.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id n15B5TWc023344
	for <linux-omap@vger.kernel.org>; Thu, 5 Feb 2009 13:05:43 +0200
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hello,

Here's two fixes for the recent save/restore change (OMAP3 McSPI: Adds 
context save/restore), which does not seem to work with chip select. 
Jouni Hogander already sent one patch, but it does not solve all the 
problems. This patch updates the shadow value on every write, and uses 
it instead of reading the register.

A.

