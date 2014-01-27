From: Nathan Lynch <Nathan_Lynch@codesourcery.com>
Subject: ethernet support for OMAP5 UEVM
Date: Mon, 27 Jan 2014 14:14:42 -0600
Message-ID: <52E6BE32.4060101@codesourcery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from relay1.mentorg.com ([192.94.38.131]:36615 "EHLO
	relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753875AbaA0Uhi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 27 Jan 2014 15:37:38 -0500
Received: from svr-orw-fem-01.mgc.mentorg.com ([147.34.98.93])
	by relay1.mentorg.com with esmtp
	id 1W7sZw-0004Fo-JN from Nathan_Lynch@mentor.com
	for linux-omap@vger.kernel.org; Mon, 27 Jan 2014 12:14:44 -0800
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi,

I am able to boot an OMAP5 uevm board with linux-next 20140124.
However, the smsc ethernet device does not show up without these patches
on top:

ARM: dts: OMAP5: Add 60MHz clock reference to USB Host module
https://patchwork.kernel.org/patch/3001841/

ARM: dts: omap5-uevm: Provide USB PHY clock
https://patchwork.kernel.org/patch/3001881/

Just wondering if these were overlooked or if there is something else
holding them up.


Thanks,
Nathan
