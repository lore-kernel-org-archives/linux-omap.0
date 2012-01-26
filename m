From: Paul Walmsley <paul@pwsan.com>
Subject: PM debugging in debugfs is non-functional on 24xx
Date: Wed, 25 Jan 2012 19:12:53 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1201251910240.11174@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:50017 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751356Ab2AZCMy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 25 Jan 2012 21:12:54 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@ti.com


Hi

I think this is a known issue, but the debugfs pm_debug/count file is 
non-functional on 242x.  

root@(none):/debug/pm_debug# cat count 
core_pwrdm (OFF),OFF:1,RET:0,INA:0,ON:0,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0,RET-M
EMBANK2-OFF:0,RET-MEMBANK3-OFF:0
mpu_pwrdm (OFF),OFF:1,RET:0,INA:0,ON:0,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0
dsp_pwrdm (OFF),OFF:1,RET:0,INA:0,ON:0,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0
gfx_pwrdm (OFF),OFF:1,RET:0,INA:0,ON:0,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0
dss_clkdm->core_pwrdm (1)
core_l4_clkdm->core_pwrdm (27)
core_l3_clkdm->core_pwrdm (4)
gfx_clkdm->gfx_pwrdm (0)
dsp_clkdm->dsp_pwrdm (0)
iva1_clkdm->dsp_pwrdm (0)
mpu_clkdm->mpu_pwrdm (0)
prm_clkdm->wkup_pwrdm (0)
cm_clkdm->core_pwrdm (0)

That's with MPU retention enabled... so those counts are wrong.

Anyway, just hoping that someone out there is motivated to fix this -


- Paul
