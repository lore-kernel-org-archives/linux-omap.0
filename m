From: "Koyamangalath, Abhilash" <abhilash.kv@ti.com>
Subject: [OMAP3] [PM] [QUERY] voltage not reducing with enable_off_mode
Date: Wed, 22 Jun 2011 03:48:23 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC3560870370A4D8D2@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:51101 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753187Ab1FUWS1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 21 Jun 2011 18:18:27 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id p5LMIONr019045
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Tue, 21 Jun 2011 17:18:26 -0500
Received: from dbde71.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id p5LMIN70003184
	for <linux-omap@vger.kernel.org>; Wed, 22 Jun 2011 03:48:23 +0530 (IST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>

hi all

On the 2.6.37 , I've seen that when I set enable_off_mode mode through
debug-fs, VDD1 ( as measured across pin 2 of J6 and GND on OMAP3 
EVM) increases from a nominal value of 1.225 V to 1.247 V.

When the uart finally times-out and the mpu_pwrdm enters OFF mode, 
it finally goes down to 1.237 V, which is still more than the nominal value.

This unexpected behaviour is in contrast to a 2.6.32 kernel that I tried with.
On probing further, I found that the VDD1 increase is happening when forced 
wakeup is called  on the iva2_clkdm clockdomain in omap_set_pwrdm_state()
as a response to setting the enable_off_mode flag.

It seems that after boot-up the iva2_pwrdm is in RET state from where its 
clock-domain needs to be force waken up before having its automatic 
Hardware supervised  transition bit-field set (reg field 
CM_CLKSTCTRL_IVA2.CLKTRCTRL_IVA2).

Why is this so ? Any inputs would be appreciated.

regards
Abhilash