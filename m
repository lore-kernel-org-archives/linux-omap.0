From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [PATCH 1/3] ARM: OMAP2+: 32k-counter: Use hwmod lookup to check
 presence of 32k timer
Date: Tue, 3 Apr 2012 15:35:42 +0000
Message-ID: <79CD15C6BA57404B839C016229A409A8318461E8@DBDE01.ent.ti.com>
References: <1326983304-14619-1-git-send-email-hvaibhav@ti.com>
	<CACVXFVP4J8N271Tww77Btm9fGNiP17MepjswBJ0V-8Z4sNt8Eg@mail.gmail.com>
	<4F672364.3020403@ti.com>
	<79CD15C6BA57404B839C016229A409A83182386C@DBDE01.ent.ti.com>
	<CAMQu2gyFNXgx87Fsq5is88DOkOx-nWK6ohwyFV-CY2uTkZCGMA@mail.gmail.com>
	<79CD15C6BA57404B839C016229A409A83183EA54@DBDE01.ent.ti.com>
	<CAMQu2gyF83HJOE9Rf-fZXXMt=p_WFjFf3DpAeW8L8+htR4E6-g@mail.gmail.com>
	<79CD15C6BA57404B839C016229A409A83183EB47@DBDE01.ent.ti.com>
	<CAMQu2gzYULK+=6-WKQnnQDpzTYW7xKAOZo7obyu2q178jtNE-Q@mail.gmail.com>
	<79CD15C6BA57404B839C016229A409A831840C2E@DBDE01.ent.ti.com>
	<CAMQu2gw7aceHSYSd+UMVS6kHQMqy0_maf8QTJaUMzp9z8822rQ@mail.gmail.com>
	<79CD15C6BA57404B839C016229A409A831840E0C@DBDE01.ent.ti.com>
	<4F7570FC.8000907@ti.com>
	<79CD15C6BA57404B839C016229A409A831840F82@DBDE01.ent.ti.com>
	<CAMQu2gzOkE6LD0WZ_9bKe3J-=Dv89rWaMzvWWvJHPMSPe6MzNg@mail.gmail.com>
	<CACVXFVPbU2OqTN=S0AZCD10KuSBYxqyyRH_xee+WTaCD6VSmMQ@mail.gmail.com>
	<CAMQu2gzuQ-q+3RHsW0=U305jCF-td5-PEXkGZ6WnQTqA1K8oAQ@mail.gmail.com>
	<CACVXFVPu1GEQy+sCgXMB8JCszPBBs8zHRVm94TYb1-y2afkqgw@mail.gmail.com>
	<CAMQu2gwuRpZ133962r3N4Y4K3oQ88ySa=SyoS6v=sSHGA=SGKw@mail.gmail.com>
	<CACVXFVMjSPhF_+CfbF2vD5ts+WtZGjofEWmknB0D1OpTM7geZw@mail.gmail.com>
	<CAMQu2gyEUhDyyng+_oC5NpXHzWMaTGsnCSTTZcMUi2pLV0z8RQ@mail.gmail.com>
 <87sjgmt211.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:53421 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754823Ab2DCPgd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 3 Apr 2012 11:36:33 -0400
In-Reply-To: <87sjgmt211.fsf@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hilman, Kevin" <khilman@ti.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: Ming Lei <tom.leiming@gmail.com>, Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "marc.zyngier@arm.com" <marc.zyngier@arm.com>, "johnstul@us.ibm.com" <johnstul@us.ibm.com>, "Balbi, Felipe" <balbi@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>, "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>

On Tue, Apr 03, 2012 at 00:05:38, Hilman, Kevin wrote:
> "Shilimkar, Santosh" <santosh.shilimkar@ti.com> writes:
> 
> [...]
> 
> > I don't personally like to add features which hardly anybody use and
> > fundamentally broken with full kernel.
> 
> Let's keep sane defaults, but not make it unreasonable to tweak eaither.
> 
> I suggest what has already been mentioned.
> 
> Register both timers, but have the sync timer have a higher rating.  On
> AMxxx where there is no sync timer, GPtimer will be used.
> 

This is another good option, I can change the rating of both the timers.
With below description and given understanding/discussion/usability of both
the timers, we can reverse the rating,

32K-sync counter = 300
GPTIMER = 250

Considering the fact that, 32k-sync counter is more usable than gptimer on
OMAP platform.


@"include/linux/clocksource.h"

* @rating:             rating value for selection (higher is better)
*                      To avoid rating inflation the following
*                      list should give you a guide as to how
*                      to assign your clocksource a rating
*                      1-99: Unfit for real use
*                             Only available for bootup and testing purposes.
*                      100-199: Base level usability.
*                              Functional for real use, but not desired.
*                      200-299: Good.
*                              A correct and usable clocksource.
*                      300-399: Desired.
*                              A reasonably fast and accurate clocksource.
*                      400-499: Perfect
*                              The ideal clocksource. A must-use where
*                              available.


Thanks,
Vaibhav

