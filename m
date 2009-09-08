From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: dspbridge rfc: get rid of services/list.c (v3)
Date: Tue,  8 Sep 2009 15:12:13 +0300
Message-ID: <1252411936-25722-1-git-send-email-andy.shevchenko@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:38742 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754285AbZIHMMg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 Sep 2009 08:12:36 -0400
Received: from esebh106.NOE.Nokia.com (esebh106.ntc.nokia.com [172.21.138.213])
	by mgw-mx09.nokia.com (Switch-3.3.3/Switch-3.3.3) with ESMTP id n88CBUiu007641
	for <linux-omap@vger.kernel.org>; Tue, 8 Sep 2009 07:11:59 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: hiroshi.doyu@nokia.com


Hello.

Here are a few patches which change driver's own circular linked list
implementation to native one in linux kernel. The initial idea was come from
Hiroshi Doyu.

This version includes corrections which I got from Imre, Artem and Felipe.

All patches are rebased against android-bridge-2.6.29 kernel branch of the
kernel-dspbridge repository.

Please, review them. Thank you.

-- 
With Best Regards,
Andy Shevchenko

