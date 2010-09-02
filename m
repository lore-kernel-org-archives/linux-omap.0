From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH 01/13] OMAP: Introduce a user list for each voltage domain
 instance in the voltage driver.
Date: Thu, 2 Sep 2010 05:17:01 -0500
Message-ID: <4C7F799D.8020207@ti.com>
References: <1282130412-12027-1-git-send-email-thara@ti.com>	<1282130412-12027-2-git-send-email-thara@ti.com>	<87eiddgjr7.fsf@deeprootsystems.com> <20100902094327.31a96174@surf> <4C7F5DB4.70306@ti.com> <38353bada7f16740e8008e6d3f2748bd@secure211.sgcpanel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:48723 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751187Ab0IBKRK (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 2 Sep 2010 06:17:10 -0400
In-Reply-To: <38353bada7f16740e8008e6d3f2748bd@secure211.sgcpanel.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <me@felipebalbi.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Kevin Hilman <khilman@deeprootsystems.com>, "Gopinath, Thara" <thara@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "paul@pwsan.com" <paul@pwsan.com>, "Sripathy, Vishwanath" <vishwanath.bs@ti.com>, "Sawant, Anand" <sawant@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>

Felipe Balbi had written, on 09/02/2010 05:00 AM, the following:
> On Thu, 2 Sep 2010 03:17:56 -0500, Nishanth Menon <nm@ti.com> wrote:
>> Just brainstorming -> if we use the regulator framework - there are 
>> potential benefits - agreed. BUT, consider the cpuidle path -> currently
> 
>> we disable SR while hitting off/ret for class3, this is done in irq 
>> locked context while the regulator framework uses locks by itself - we 
> 
> wouldn't it be enough to:
> 
> spin_unlock(&sr_lock);
> call_whatever_regulator_api();
> spin_lock(&sr_lock);
> 
> [...]
> 
> spin_unlock_irqrestore(&sr_lock, flags);
> 
> ??
> 
> otherwise we will have yet another OMAP-only API to maintain.
> 
unfortunately no. look at omap_sram_idle function in 
arch/arm/mach-omap2/pm34xx.c

we do irq_lock_save to prevent interrupts from messing up our decision logic

apply a lot of checks to translate C state to mean which domain is going 
to go to which OMAP domain state mode - ret/off/inactive etc..

add a bunch of erratas on top of it

finally see if the core/mpu domains (in case of omap4 ivahd domain as 
well) is going to ret/off state - if yes, SR is disabled for that domain.

note - if we allow unlock of irqs at this point, we cannot predictably 
progress down the logic.

the option is to move up the sr disable out of omap_sram_idle into yet 
to be determined logic where irqs are enabled, c state is decided and if 
c state is lower than a threshold (meaning if mpu OR core OR ivahd can 
go to lower power states), disable SR.. not efficient and without 
looking deeper at logic and considering multiple omap generations not 
sure if this will scale either..


-- 
Regards,
Nishanth Menon
