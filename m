From: Sven Brandau <brandau@gmx.de>
Subject: OMAP DSS: How to skip FB initialization?
Date: Tue, 28 May 2013 10:05:38 +0200
Message-ID: <51A46552.1080107@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.15.19]:50011 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933282Ab3E1IDn (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 28 May 2013 04:03:43 -0400
Received: from mailout-de.gmx.net ([10.1.76.24]) by mrigmx.server.lan
 (mrigmx002) with ESMTP (Nemesis) id 0MCvpV-1UZEXW2DSt-009kiQ for
 <linux-omap@vger.kernel.org>; Tue, 28 May 2013 10:03:41 +0200
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi,

I've initialized the OMAP3 DDS framebuffer subsystem in u-boot to show a 
splash screen on LCD. Is there an option in the kernel implementation to 
avoid the reinitializing of the DSS framebuffer subsystem?

Thanks for help,
Sven
