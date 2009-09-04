From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: dspbridge rfc: get rid of services/list.c (rebased)
Date: Fri,  4 Sep 2009 12:18:57 +0300
Message-ID: <1252055941-29745-1-git-send-email-andy.shevchenko@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:23088 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933318AbZIDJTQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 4 Sep 2009 05:19:16 -0400
Received: from vaebh105.NOE.Nokia.com (vaebh105.europe.nokia.com [10.160.244.31])
	by mgw-mx03.nokia.com (Switch-3.3.3/Switch-3.3.3) with ESMTP id n849IcvM010099
	for <linux-omap@vger.kernel.org>; Fri, 4 Sep 2009 12:19:09 +0300
Received: from dilbert.research.nokia.com (esdhcp034223.research.nokia.com [172.21.34.223])
	by mgw-sa01.ext.nokia.com (Switch-3.3.3/Switch-3.3.3) with ESMTP id n849Iwts006362
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Fri, 4 Sep 2009 12:18:59 +0300
Received: from andy by dilbert.research.nokia.com with local (Exim 4.69)
	(envelope-from <ext-andriy.shevchenko@nokia.com>)
	id 1MjUwf-0007kL-V3
	for linux-omap@vger.kernel.org; Fri, 04 Sep 2009 12:19:02 +0300
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org


Hello.

Here are a few patches which change driver's own circular linked list
implementation to native one in linux kernel. The initial idea was come from
Hiroshi Doyu.

This version includes corrections which I got from Imre and Felipe.
Additionally the fourth patch changes LST_ELEM name to native list_head in
whole dsp bridge driver.

All patches are rebased against android-bridge-2.6.29 kernel branch of the
kernel-dspbridge repository.

-- 
With Best Regards,
Andy Shevchenko

