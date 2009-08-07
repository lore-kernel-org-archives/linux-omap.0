From: Roger Quadros <ext-roger.quadros@nokia.com>
Subject: PM: UART not resuming from OFF mode
Date: Fri, 07 Aug 2009 11:55:38 +0300
Message-ID: <4A7BEC0A.9030909@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:59059 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757233AbZHGI4H (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Aug 2009 04:56:07 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: Kevin Hilman <khilman@deeprootsystems.com>

Hi,

  I'm facing this strange problem since some days. I have 3 identical boards 
using OMAP3430 ES3.1 and I'm using Kevin's PM tree. 
http://git.kernel.org/?p=linux/kernel/git/khilman/linux-omap-pm.git;a=shortlog;h=pm

The problem is that UART3 fails to operate correctly after OFF mode on _two_ of 
the boards but works on one. It seems to receive characters but 0 only. So 
characters do not show up on terminal.

Is anybody experiencing similar problems with UART and off mode on your boards?

regards,
-roger
