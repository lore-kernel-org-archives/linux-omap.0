From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: Naming convention used in mux.c
Date: Thu, 29 Jan 2009 21:04:22 +0530
Message-ID: <19F8576C6E063C45BE387C64729E739403FA79019A@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:48069 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752606AbZA2Peb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 29 Jan 2009 10:34:31 -0500
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id n0TFYN7F002626
	for <linux-omap@vger.kernel.org>; Thu, 29 Jan 2009 09:34:29 -0600
Received: from dbde71.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id n0TFYMmW014450
	for <linux-omap@vger.kernel.org>; Thu, 29 Jan 2009 21:04:22 +0530 (IST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

Can anybody tell me the meaning of naming convention used in mux.c file, e.g. - 

MUX_CFG_34XX("AH8_34XX_GPIO29", 0x5fa,
                OMAP34XX_MUX_MODE4 | OMAP34XX_PIN_INPUT)
MUX_CFG_34XX("J25_34XX_GPIO170", 0x1c6,
                OMAP34XX_MUX_MODE4 | OMAP34XX_PIN_INPUT)

What the suffix "AH8_" and "J25_" means here? I looked into TRM and could not able to co-relate with any meaningful?

Thanks,
Vaibhav Hiremath
Platform Support Products
Texas Instruments Inc
Ph: +91-80-25099927

