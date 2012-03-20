From: "237 Rumjantsev Egor (PROG)" <rumjantsev@papillon.ru>
Subject: OM4460 CPI
Date: Tue, 20 Mar 2012 11:01:05 +0600
Message-ID: <4F680F11.6010700@papillon.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ppln.papillon.ru ([217.19.115.162]:36452 "EHLO mail.papillon.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751564Ab2CTFKd (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 20 Mar 2012 01:10:33 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.papillon.ru (Postfix) with ESMTP id 2182496912D7
	for <linux-omap@vger.kernel.org>; Tue, 20 Mar 2012 11:01:06 +0600 (YEKT)
Received: from mail.papillon.ru ([127.0.0.1])
	by localhost (mail.papillon.ru [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qwExfJk9jD+F for <linux-omap@vger.kernel.org>;
	Tue, 20 Mar 2012 11:01:06 +0600 (YEKT)
Received: from rumjantsev.papillon.ru (rumjantsev.papillon.ru [192.168.21.69])
	by mail.papillon.ru (Postfix) with ESMTPA id 0F88196912B6
	for <linux-omap@vger.kernel.org>; Tue, 20 Mar 2012 11:01:06 +0600 (YEKT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hello.
TRM for OM4460 tells that there is such hardware block in this processor.
TI provide omap4iss driver but it's only for CSI sensors, in mux44xx.c 
there are pin muxes for CSI but not for CPI.
Has anyone use CPI module in OM4460? Is there driver for parallel camera 
interface.

WBR,
-- 
Rumjantsev Egor
