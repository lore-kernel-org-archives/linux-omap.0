From: "237 Rumjantsev Egor (PROG)" <rumjantsev@papillon.ru>
Subject: spi_complete oops
Date: Tue, 15 May 2012 11:00:54 +0600
Message-ID: <4FB1E306.6070907@papillon.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ppln.papillon.ru ([91.238.128.6]:50106 "EHLO mail.papillon.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751240Ab2EOFKN (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 15 May 2012 01:10:13 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.papillon.ru (Postfix) with ESMTP id 46BC99CC1DAF
	for <linux-omap@vger.kernel.org>; Tue, 15 May 2012 11:00:55 +0600 (YEKT)
Received: from mail.papillon.ru ([127.0.0.1])
	by localhost (mail.papillon.ru [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eNCid2AhvFaG for <linux-omap@vger.kernel.org>;
	Tue, 15 May 2012 11:00:55 +0600 (YEKT)
Received: from rumjantsev.papillon.ru (rumjantsev.papillon.ru [192.168.21.69])
	by mail.papillon.ru (Postfix) with ESMTPA id 3470B9CC1D08
	for <linux-omap@vger.kernel.org>; Tue, 15 May 2012 11:00:55 +0600 (YEKT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hello.
I develop driver to communicate to some chip via spi. Chip generate 
interrupts in which i run workqueue. Inside workqueue's handler i need 
to exchange data white chip again. Sometimes i got OOPS in spi_complete 
as args == NULL. What can be the reason of this? SPI message .complete 
and .context set up in __spy_sync call.
I run kernel 3.1.5 on Variscite OM4460 board.

WBR,
-- 
Rumjantsev Egor
