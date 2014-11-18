From: =?UTF-8?B?VXJzIEbDpHNzbGVy?= <urs@bytesatwork.ch>
Subject: gpio chip select for spi-omap2-mcspi.c
Date: Tue, 18 Nov 2014 16:31:45 +0100
Message-ID: <546B6661.9080707@bytesatwork.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bytesatwork.ch ([91.135.72.15]:45976 "EHLO bytesatwork.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755986AbaKRPlc (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 18 Nov 2014 10:41:32 -0500
Received: from [192.168.58.154] (2.50.253.84.static.wline.lns.sme.cust.swisscom.ch [84.253.50.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: urs)
	by bytesatwork.ch (Postfix) with ESMTPSA id CC96D1800003
	for <linux-omap@vger.kernel.org>; Tue, 18 Nov 2014 16:30:58 +0100 (CET)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hello,
we need gpio chip selects in the spi-omap2-mcspi.c driver. I have seen 
that we are not the first ones, but there is no implementation in mainline.
Is there a reason for this (not possible, problems)?
Otherwise, can somebody provide some pointers where to start to 
implement those?

Regards
Urs
