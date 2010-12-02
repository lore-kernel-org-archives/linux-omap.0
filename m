From: gus Gusenleitner Klaus <gus@keba.com>
Subject: [query] omap 35xx spi slave support
Date: Thu, 2 Dec 2010 11:42:20 +0100
Message-ID: <12C1B74BDFD05D40B2356A9B12DFA33902BF3CD723@KEBMXSPMB01.keba.co.at>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from xgmegw03.mdcs.at ([217.13.183.3]:50015 "EHLO xgmegw03.mdcs.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751633Ab0LBKu5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 2 Dec 2010 05:50:57 -0500
Received: from xgmegw03.wien.rbgat.net (localhost [127.0.0.1])
	by xgmegw03.mdcs.at (Postfix) with ESMTP id 1E2C544C13A
	for <linux-omap@vger.kernel.org>; Thu,  2 Dec 2010 11:42:22 +0100 (CET)
Received: from keb2.mdcs.at (xlmxsp02.mxsp.rbgat.net [10.122.42.176])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by xgmegw03.mdcs.at (Postfix) with ESMTPS id E3EB544C130
	for <linux-omap@vger.kernel.org>; Thu,  2 Dec 2010 11:42:21 +0100 (CET)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by keb2.mdcs.at (Postfix) with ESMTP id D1E628C819F
	for <linux-omap@vger.kernel.org>; Thu,  2 Dec 2010 11:42:21 +0100 (CET)
Received: from keb2.mdcs.at ([127.0.0.1])
	by localhost (xlmxsp02.mxsp.rbgat.net [127.0.0.1]) (amavisd-new, port 10025)
	with ESMTP id e6fg05i9OsAh for <linux-omap@vger.kernel.org>;
	Thu,  2 Dec 2010 11:42:21 +0100 (CET)
Received: from KEBMXSPCA02.keba.co.at (kebmxspca02.keba.co.at [10.122.100.36])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by keb2.mdcs.at (Postfix) with ESMTPS
	for <linux-omap@vger.kernel.org>; Thu,  2 Dec 2010 11:42:21 +0100 (CET)
Content-Language: de-DE
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "'linux-omap@vger.kernel.org'" <linux-omap@vger.kernel.org>

there's a patch for mcspi to add slave mode support. Please could you send 
me the latest version of the required patches. I've found confusing 
different version in some mailing lists.
How is the slave mode intended to work?

Many thanks,
Klaus




