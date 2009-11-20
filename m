From: "Premi, Sanjeev" <premi@ti.com>
Subject: RE: VDD1 voltage after resume from idle
Date: Sat, 21 Nov 2009 01:04:23 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301DE5EE61E@dbde02.ent.ti.com>
References: <B85A65D85D7EB246BE421B3FB0FBB59301DE5EE5BC@dbde02.ent.ti.com>
 <20091120162933.GC2354@mvista.com>
 <B85A65D85D7EB246BE421B3FB0FBB59301DE5EE60C@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:34719 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752284AbZKTTel convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 20 Nov 2009 14:34:41 -0500
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB59301DE5EE60C@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Premi, Sanjeev" <premi@ti.com>, Maxime Petazzoni <mpetazzoni@mvista.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org 
> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Premi, Sanjeev
> Sent: Friday, November 20, 2009 11:46 PM
> To: Maxime Petazzoni
> Cc: linux-omap@vger.kernel.org
> Subject: RE: VDD1 voltage after resume from idle
> 
> > -----Original Message-----
> > From: Maxime Petazzoni [mailto:mpetazzoni@mvista.com] 
> > Sent: Friday, November 20, 2009 10:00 PM
> > To: Premi, Sanjeev
> > Cc: linux-omap@vger.kernel.org
> > Subject: Re: VDD1 voltage after resume from idle
> > 

[snip]--[snip]--[snip]

> 
> I guess the root cause could be same. I have not been able to 
> ascertain
> the reason for the voltage changing during the idle/wakeup sequence.
> Also tried to eliminate the enable_smartreflex() calls on wakeup path.
> Sill I see voltage ramp-up.
> 
> I am trying to find the cause of voltage ramping to 1.2V in hope that
> the reason for ramp down will be just inverted reflection.
> 
> With smartreflex disabled, there is no change in the voltage during
> suspend; so the problem area seems to be smartreflex.
> 
> Best regards,
> Sanjeev

Found the problem!

In sr_configure_vp() the vsel is picked up from the OPP table and used,
setting the voltage as expected (1.35V in my case).

A printk confirms PRM_VC_CMD_VAL_0 is 0x3C201E00. 

By the time, kernel boots up, the value has changed to 0x30201E00.
(0x30 corresponds to 1.2V)

[root@OMAP3EVM /]# devmem 0x4830722c 32
0x30201E00

Now, when I update the init voltage back to 3C (via devmem) the voltage
after resume/idle-wakeup is right (as expected).

[root@OMAP3EVM /]# devmem 0x4830722c 32 0x3c201e00
[root@OMAP3EVM /]#

So, I just need to find exact location where the configuration is being
overwritten.

It is well past midnight now. So the patch will have to wait until
tomorrow.

Best regards,
Sanjeev

[snip]--[snip]--[snip]
