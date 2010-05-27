From: "Premi, Sanjeev" <premi@ti.com>
Subject: RE: omap3 pm: dependency between opp layer and cpufreq
Date: Fri, 28 May 2010 01:59:39 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301E5828FC1@dbde02.ent.ti.com>
References: <B85A65D85D7EB246BE421B3FB0FBB59301E71FDD30@dbde02.ent.ti.com>,<4BFE9D7E.8020602@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:38079 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758832Ab0E0U3o convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 27 May 2010 16:29:44 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id o4RKTfd2003911
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Thu, 27 May 2010 15:29:43 -0500
Received: from dbde71.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id o4RKTe4X005208
	for <linux-omap@vger.kernel.org>; Fri, 28 May 2010 01:59:40 +0530 (IST)
In-Reply-To: <4BFE9D7E.8020602@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Menon, Nishanth" <nm@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

From: Menon, Nishanth
Sent: Thursday, May 27, 2010 9:57 PM
To: Premi, Sanjeev
Cc: linux-omap@vger.kernel.org
Subject: Re: omap3 pm: dependency between opp layer and cpufreq

[snip]--[snip]

[sp] Responding via webmail.. so the formatting and quotes are non-standard :(

> # OPP support in (OMAP3+ only at the moment)
> # XXX The OPP TWL/TPS code should only be included when a TWL/TPS
> # PMIC is selected.
> ifdef CONFIG_CPU_FREQ
> obj-$(CONFIG_ARCH_OMAP3) += opp.o opp_twl_tps.o
ok this needs to be split:
a) opp_twl_tps should depend on TWL_CORE and not CPUFREQ - there is no
need actually
b) opp.o should remain dependent on CPU_FREQ.

[sp] That was in my next mail.

> endif
>
> But changing CONFIG_CPU_FREQ to CONFIG_TWL4030_POWER leads to these errors:
see (b)
>
[snip--[snip]

>
> Questions/ comments:
>
> 1) The linkage between OPP and Voltage are not driven by the PMIC.
>     They are defined by/for the silicon itself.

look carefully at twl -> it is the abstraction where needed for pmic
translation of a voltage value - this you agree is PMIC dependent I suppose.

>
> 2) The implementation for setting the voltage should depend upon the PMIC.
ACK- the concept should be independent of PMIC - each PMIC, like
5030/tps Vs custom PMICs have thier own unique mechanisms of setting
voltages - the renewed SR series from Thara addresses this concern.(not
in pm branch yet - but potentially soon)

>
> 3) Was there any specific need to tie the functions "opp_get_voltage" and others to cpufreq only?

yes, because without cpufreq there is no transitions in the system :)

[sp] I does - via bootarg - mpurate!

When kernel boots, volatge must be set properly.
We cannot rely on u-boot to be settiing everything correctly. e.g. 720MHz on OMAP3530 would fail at nominal 1.2V set by u-boot.

>
> I am working on a patch that should remove some of these dependencies.
> But, trying to open up a discussion as well...

do post them. thanks

>
> Best regards,
> Sanjeev
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Regards,
Nishanth Menon
