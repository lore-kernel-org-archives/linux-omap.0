From: "Lesly AM" <x0080970@ti.com>
Subject: Re: How to put TWL/TPS into sleep?
Date: Thu, 21 Jan 2010 20:34:38 +0530
Message-ID: <032901ca9aab$0e9ac6b0$LocalHost@wipultra1385>
References: <4B583E62.80603@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:39893 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750985Ab0AUPEz (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 21 Jan 2010 10:04:55 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mike Rapoport <mike@compulab.co.il>, linux-omap@vger.kernel.org

Hi Mike,

----- Original Message ----- 
From: "Mike Rapoport" <mike@compulab.co.il>
To: <linux-omap@vger.kernel.org>
Sent: Thursday, January 21, 2010 5:15 PM
Subject: How to put TWL/TPS into sleep?


> Hi all,
> I'm trying to achieve maximal power savings on omap3 based system with
> TPS65930 PMIC using twl4030_script and twl4030_resconfig. I've tried
> different resource mappings and different command sequences in the
> sleep/wakeup scripts by to no avail. Moreover, with some resource
> definitions and sleep/wakeup scripts the system behaves in a weird ways,
> e.g. does not properly respond to hard resets.
> Most probably my resource remapping and command sequences are wrong and
> this is the reason for system misbehavior.
>
> However, several things are completely unclear to me:
> * Does TPS/TWL have defaults for sleep-on and sleep-off transitions?

AFIK TPS659x & TWL4030 is same chip, may have some Si version(ES 1.x) 
difference.
So the power seqeunce used on TWL4030, should work on TPS659x  also.

> * What would happen if nSLEEP1 would go low/high and there is no
> sleep/wakeup sequence programmed?
By default reset value for the resgister pointing to [sleep/wakeup/wrst] seq 
is 0x3F, which is the exit addr for seq.
So the TRITON resources will not have any change.

> * If I have a sleep sequence that disables some power resources, what
> would be the state of the other resources?
If you are using singular messages in the seq, you can address each resource 
by specifying the Resource_id.
But if you are using broadcast messages, the resources which will respond 
depends on the Resource_group, TYPE & TYPE2 values.

>
> I've read the TPS TRM several times to now and I still got now clue
> about what's going on there :(
You can verify wether your clk/volt setup_time holds good.

>
>
> -- 
> Sincerely yours,
> Mike.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

