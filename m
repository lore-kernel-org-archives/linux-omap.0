From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: dspbridge: draft: get rid of services/list.c
Date: Tue,  1 Sep 2009 14:39:31 +0300
Message-ID: <1251805173-15214-1-git-send-email-andy.shevchenko@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:25329 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754135AbZIALj7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 1 Sep 2009 07:39:59 -0400
Received: from vaebh106.NOE.Nokia.com (vaebh106.europe.nokia.com [10.160.244.32])
	by mgw-mx09.nokia.com (Switch-3.3.3/Switch-3.3.3) with ESMTP id n81BatcP031812
	for <linux-omap@vger.kernel.org>; Tue, 1 Sep 2009 06:39:27 -0500
Received: from dilbert.research.nokia.com (esdhcp034223.research.nokia.com [172.21.34.223])
	by mgw-da01.ext.nokia.com (Switch-3.3.3/Switch-3.3.3) with ESMTP id n81BdaAX011030
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Tue, 1 Sep 2009 14:39:37 +0300
Received: from andy by dilbert.research.nokia.com with local (Exim 4.69)
	(envelope-from <ext-andriy.shevchenko@nokia.com>)
	id 1MiRi1-0003xw-TZ
	for linux-omap@vger.kernel.org; Tue, 01 Sep 2009 14:39:33 +0300
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org


Hello.

Here are two patches which change driver's own circular linked list
implementation to native one in linux kernel. The initial idea was come from
Hiroshi Doyu.

P.S. Please, ignore mail with 'Message-ID:
<1251793647-14569-1-git-send-email-andy.shevchenko@gmail.com>'


-- 
With Best Regards,
Andy Shevchenko


