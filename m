From: "Lopez Cruz, Misael" <x0052729@ti.com>
Subject: Configuring a TWL GPIO pin as an interrupt
Date: Fri, 20 Feb 2009 20:27:54 -0600
Message-ID: <2C7D3DF36ADFFC479B44490D912B616705D6329B7D@dlee07.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:60957 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754242AbZBUC2F convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 20 Feb 2009 21:28:05 -0500
Received: from dlep95.itg.ti.com ([157.170.170.107])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id n1L2Rw6C003357
	for <linux-omap@vger.kernel.org>; Fri, 20 Feb 2009 20:28:03 -0600
Received: from dlee73.ent.ti.com (localhost [127.0.0.1])
	by dlep95.itg.ti.com (8.13.8/8.13.8) with ESMTP id n1L2Rw0D020594
	for <linux-omap@vger.kernel.org>; Fri, 20 Feb 2009 20:27:58 -0600 (CST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

I'm interested in bringing headset detection feature for audio. The detection is done through TWL GPIO_2. How can I configure a GPIO pin to generate an interrupt? Is there any API? Could you please point out another driver using that functionality so I can use as reference?

-Misa