From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: dspbridge rfc: get rid of services/list.c (try 2)
Date: Thu,  3 Sep 2009 12:06:10 +0300
Message-ID: <1251968774-25380-1-git-send-email-andy.shevchenko@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:32238 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754023AbZICJGs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Sep 2009 05:06:48 -0400
Received: from vaebh105.NOE.Nokia.com (vaebh105.europe.nokia.com [10.160.244.31])
	by mgw-mx06.nokia.com (Switch-3.3.3/Switch-3.3.3) with ESMTP id n8396EFw023570
	for <linux-omap@vger.kernel.org>; Thu, 3 Sep 2009 12:06:36 +0300
Received: from dilbert.research.nokia.com (esdhcp034223.research.nokia.com [172.21.34.223])
	by mgw-sa01.ext.nokia.com (Switch-3.3.3/Switch-3.3.3) with ESMTP id n8396JpC004758
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Thu, 3 Sep 2009 12:06:19 +0300
Received: from andy by dilbert.research.nokia.com with local (Exim 4.69)
	(envelope-from <ext-andriy.shevchenko@nokia.com>)
	id 1Mj8Gk-0006bx-Vg
	for linux-omap@vger.kernel.org; Thu, 03 Sep 2009 12:06:14 +0300
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org


Hello.

Here are two patches which change driver's own circular linked list
implementation to native one in linux kernel. The initial idea was come from
Hiroshi Doyu.

This version includes corrections which I got from Imre and Felipe.
Additionally the fourth patch changes LST_ELEM name to native list_head in
whole dsp bridge driver.

--
With Best Regards,
Andy Shevchenko

