From: Ajit Motra <motraat@iis.fraunhofer.de>
Subject: V4L on OMAP3
Date: Thu, 26 Jun 2008 10:09:03 +0200
Message-ID: <48634E9F.8040405@iis.fraunhofer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from relay04-haj2.antispameurope.de ([83.246.65.54]:35069 "EHLO
	relay04-haj2.antispameurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754394AbYFZIPF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 26 Jun 2008 04:15:05 -0400
Received: from iis.fhg.de (iis.iis.fhg.de [153.96.172.2])
	by relay04-haj2.antispameurope.de (Postfix) with SMTP id 51AA563C09B
	for <linux-omap@vger.kernel.org>; Thu, 26 Jun 2008 10:09:04 +0200 (CEST)
Received: from sunserv02.iis.fhg.de ([153.96.171.22])
	by iis.fhg.de (8.8.5/) with ESMTP id KAA21660
	for <linux-omap@vger.kernel.org>; Thu, 26 Jun 2008 10:09:04 +0200 (MET DST)
Received: from [10.54.95.40] (mp834.iis.fhg.de [10.54.95.40])
	by sunserv02.iis.fhg.de (8.12.10+Sun/8.12.10) with ESMTP id m5Q893M0025052
	for <linux-omap@vger.kernel.org>; Thu, 26 Jun 2008 10:09:03 +0200 (CEST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hello,

 We received OMAP3 board from TI. This has linux from mistral on this. There is a node /dev/video0 on this but when I try to open this using O_RDONLY or O_RDWR option, this does not open device. Is V4L functionality missing in this case? 
We are using Linux version 2.6.22.1. We have registered our EVB on TI website but there are no new updates for OMAP3503.

Thanks 
Motra

