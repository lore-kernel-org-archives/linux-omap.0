From: "Nayak, Rajendra" <rnayak@ti.com>
Subject: RE: new PM branch available
Date: Fri, 23 Jan 2009 15:49:30 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB02F5110938@dbde02.ent.ti.com>
References: <87fxjj845c.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:53183 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753043AbZAWKTm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 23 Jan 2009 05:19:42 -0500
In-Reply-To: <87fxjj845c.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> I did some testing today on my 3.0GP 3430SDP. This is with the omap_3430sdp_min_defconfig.
>
> 1) Idle.
> echo -n 1 > /sys/power/clocks_off_while_idle
> echo -n 1 > /sys/power/enable_off
> Could not hit RET. something seems to be still active. Not sure if it could be something
> to do with this error that's thrown while bootup
>
> <6>Disabling unused clock "dpll5_ck"
> Disabling unused clock "dpll5_ck"
> <3>clock: dpll5_ck failed transition to 'locked'
> clock: dpll5_ck failed transition to 'locked'
> 
> This is the same results I see on my SDP.
> 
> Looking at the registers, I am pretty sure it is the D2D clockdomain
> that still has activity, but due to very poor Stacked-mode docs and no
> responses to the D2D questions asked to TI I have not been able to
> figure this one out.
> 
> Help debugging this would be greatly appreciated.

I looked some more into this today and saw that the hang is indeed caused
due to some kind of debug console going dead. The system was still looping in the
idle thread. I could even do a telnet remotely to my board and take some debug dumps..

I am not too familiar with the debug hooks that exist but from what I understand, IVA
seem to be one thing preventng a RET/OFF.

This dump I took from a telnet window after the hang on debug console.. 

# cd pm_debug/
# cat count
usbhost_pwrdm (RET),OFF:0,RET:1,INA:0,ON:1
sgx_pwrdm (OFF),OFF:1,RET:0,INA:0,ON:1
per_pwrdm (ON),OFF:0,RET:0,INA:0,ON:1
dss_pwrdm (RET),OFF:0,RET:1,INA:0,ON:1
cam_pwrdm (RET),OFF:0,RET:1,INA:0,ON:1
core_pwrdm (ON),OFF:0,RET:0,INA:0,ON:1
neon_pwrdm (ON),OFF:0,RET:466,INA:3048,ON:3515
mpu_pwrdm (ON),OFF:0,RET:466,INA:3048,ON:3515
iva2_pwrdm (ON),OFF:0,RET:0,INA:0,ON:1
per_clkdm->per_pwrdm (9)
usbhost_clkdm->usbhost_pwrdm (0)
cam_clkdm->cam_pwrdm (0)
dss_clkdm->dss_pwrdm (0)
core_l4_clkdm->core_pwrdm (3)
core_l3_clkdm->core_pwrdm (4)
d2d_clkdm->core_pwrdm (0)
sgx_clkdm->sgx_pwrdm (0)
iva2_clkdm->iva2_pwrdm (0)
neon_clkdm->neon_pwrdm (0)
mpu_clkdm->mpu_pwrdm (0)
prm_clkdm->wkup_pwrdm (12)
cm_clkdm->core_pwrdm (3)
#

Whats surprsing is that the same image sometimes does hit RET/OFF, though I still see the console hang.
I could see the VCORE Led flicker as well.

This dump I took from the telnet and here IVA did transition..

# cat count
usbhost_pwrdm (OFF),OFF:1,RET:1,INA:0,ON:1
sgx_pwrdm (OFF),OFF:1,RET:0,INA:0,ON:1
per_pwrdm (ON),OFF:131,RET:2980,INA:0,ON:3112
dss_pwrdm (OFF),OFF:1,RET:1,INA:0,ON:1
cam_pwrdm (OFF),OFF:1,RET:1,INA:0,ON:1
core_pwrdm (ON),OFF:0,RET:1840,INA:199,ON:2040
neon_pwrdm (ON),OFF:13,RET:2026,INA:2390,ON:4430
mpu_pwrdm (ON),OFF:13,RET:2026,INA:2390,ON:4430
iva2_pwrdm (OFF),OFF:1,RET:1,INA:0,ON:1
per_clkdm->per_pwrdm (9)
usbhost_clkdm->usbhost_pwrdm (0)
cam_clkdm->cam_pwrdm (0)
dss_clkdm->dss_pwrdm (0)
core_l4_clkdm->core_pwrdm (3)
core_l3_clkdm->core_pwrdm (4)
d2d_clkdm->core_pwrdm (0)
sgx_clkdm->sgx_pwrdm (0)
iva2_clkdm->iva2_pwrdm (0)
neon_clkdm->neon_pwrdm (0)
mpu_clkdm->mpu_pwrdm (0)
prm_clkdm->wkup_pwrdm (12)
cm_clkdm->core_pwrdm (3)
#

Kevin, after you put the omap3_iva_idle code in there, did you try if that worked on a SDP? 

