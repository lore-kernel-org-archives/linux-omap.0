From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: TWL4030 keypad timeout interrupt
Date: Tue, 13 May 2008 16:54:17 +0300
Message-ID: <20080513135417.GL4244@gandalf.research.nokia.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:54092 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757412AbYEMNze (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 13 May 2008 09:55:34 -0400
Received: from esebh108.NOE.Nokia.com (esebh108.ntc.nokia.com [172.21.143.145])
	by mgw-mx06.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m4DDt5Z3008636
	for <linux-omap@vger.kernel.org>; Tue, 13 May 2008 16:55:32 +0300
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linux OMAP Mailing List <linux-omap@vger.kernel.org>

Hi all,

I noted whenever we release a key in omap-twl4030.c driver it generates
two interrupts: one for release event and one for a timeout event.

Is that expected or is that a bug somewhere in the driver ?

It's easily noted by cat /proc/interrupts ;-)

-- 
	- Balbi
