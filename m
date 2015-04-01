From: Nishanth Menon <nm@ti.com>
Subject: Re: omap voltage management
Date: Wed, 1 Apr 2015 08:47:22 -0500
Message-ID: <551BF6EA.6060900@ti.com>
References: <CAJ2oMhKGG9YrM4+rVdi2wZP=y4OBmCkw3GjgwBq-HpvtbWyNVg@mail.gmail.com>	<20150319202750.GM31346@atomide.com>	<CAJ2oMhLTH5ix0-6i=bzyqsGVuhf3aJUY5RhYyDLacdKOTCLNRg@mail.gmail.com>	<CAJ2oMhKLL8O2Pngg4=YwLmOMApvnJm9UPUhu+SJ421H72ONhTg@mail.gmail.com>	<20150325214725.GC31346@atomide.com>	<CAGo_u6rjAfzZ9YO0xDFcZQi1Su6fThn8xaKUAJ2xH_jK-Lf8mw@mail.gmail.com> <CANMsd02X43ZpL3PkLJKYKXtTutfi9t=-CUYvxET0DA1jgVm7DA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:38391 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751738AbbDANr1 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 1 Apr 2015 09:47:27 -0400
In-Reply-To: <CANMsd02X43ZpL3PkLJKYKXtTutfi9t=-CUYvxET0DA1jgVm7DA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ryan <ryanphilips19@googlemail.com>
Cc: Tony Lindgren <tony@atomide.com>, Ran Shalit <ranshalit@gmail.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>

On 04/01/2015 08:18 AM, Ryan wrote:
> Hi,
> 
> I would like to ask a related question here
Please try not to top post :).

> 
> If i use performance governor alone - constantly running at the
> highest frequency. Does the smart reflex still has a role to play?
Yes. cpufreq governor are just policies - cpufreq policies just
selects a frequency to run the CPU from a list of frequencies. for
each frequency to be achieved, there is ABB, AVS configuration needed
(strategy specific to SoC).

> Does smart-reflex involves reprogramming only the mpu power line alone?
> 
AVS strategies apply to all rails in TI SoCs which need such strategies.

-- 
Regards,
Nishanth Menon
