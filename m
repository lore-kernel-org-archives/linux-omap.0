From: Chris Rodley <carlighting@yahoo.co.nz>
Subject: Power Management Omap3530
Date: Sun, 19 Jun 2011 20:22:38 -0700 (PDT)
Message-ID: <100862.94587.qm@web112004.mail.gq1.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from nm6-vm1.bullet.mail.ne1.yahoo.com ([98.138.91.71]:37516 "HELO
	nm6-vm1.bullet.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752458Ab1FTDWk convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sun, 19 Jun 2011 23:22:40 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi, 
I am attempting to reduce overall power consumption on a Board like the Beagle Board. 
I am using the 2.6.39-pm kernel from Steve Sakoman.
 
Here is my system as it stands now: 
# cat /debug/pm_debug/count 
usbhost_pwrdm (ON),OFF:0,RET:3,INA:1,ON:5,RET-LOGIC-OFF:0,RET-MEMBANK1- 
OFF:0 
sgx_pwrdm (OFF),OFF:1,RET:0,INA:0,ON:1,RET-LOGIC-OFF:0,RET-MEMBANK1- 
OFF:0 
per_pwrdm (ON),OFF:0,RET:3,INA:0,ON:4,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF: 
0 
dss_pwrdm (ON),OFF:0,RET:3,INA:0,ON:4,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF: 
0 
cam_pwrdm (RET),OFF:0,RET:2,INA:0,ON:2,RET-LOGIC-OFF:0,RET-MEMBANK1- 
OFF:0 
core_pwrdm (ON),OFF:0,RET:0,INA:0,ON:1,RET-LOGIC-OFF:0,RET-MEMBANK1- 
OFF:0,RET-MEMBANK2-OFF:0 
neon_pwrdm (ON),OFF:0,RET:3,INA:0,ON:4,RET-LOGIC-OFF:0 
mpu_pwrdm (ON),OFF:0,RET:3,INA:0,ON:4,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF: 
0 
iva2_pwrdm (RET),OFF:0,RET:1,INA:0,ON:1,RET-LOGIC-OFF:0,RET-MEMBANK1- 
OFF:0,RET-MEMBANK2-OFF:0,RET-MEMBANK3-OFF:0,RET-MEMBANK4-OFF:0 
per_clkdm->per_pwrdm (20) 
usbhost_clkdm->usbhost_pwrdm (3) 
cam_clkdm->cam_pwrdm (0) 
dss_clkdm->dss_pwrdm (1) 
core_l4_clkdm->core_pwrdm (23) 
core_l3_clkdm->core_pwrdm (4) 
d2d_clkdm->core_pwrdm (0) 
sgx_clkdm->sgx_pwrdm (0) 
iva2_clkdm->iva2_pwrdm (0) 
neon_clkdm->neon_pwrdm (0) 
mpu_clkdm->mpu_pwrdm (0) 
prm_clkdm->wkup_pwrdm (0) 
cm_clkdm->core_pwrdm (0)
 
I was wondering if it is possible or even beneficial to turn off various subsystems (like DSS) or anything else that can be switched off to save on power usage.

I'm not sure how to go about turning these things off.
My goal is to knock off another 100mA. 
Any other tips or additional things I can look at to further reduce 
power? 

Regards, 
CJ 
