From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [GIT PULL] ARM: OMAP5: hwmod, prm/cm data files and updates for
 3.10
Date: Fri, 17 May 2013 13:30:00 +0530
Message-ID: <5195E380.4040103@ti.com>
References: <1363768852-18125-1-git-send-email-santosh.shilimkar@ti.com> <20130401170539.GK10155@atomide.com> <515BA76D.3000302@ti.com> <alpine.DEB.2.00.1304031146230.2616@utopia.booyaka.com> <515D6020.2030103@ti.com> <20130404165208.GI10155@atomide.com> <515DB110.9000503@ti.com> <515F00B8.3000501@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:34614 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752047Ab3EQH5v (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 17 May 2013 03:57:51 -0400
In-Reply-To: <515F00B8.3000501@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, "Kristo, Tero" <t-kristo@ti.com>, Nishanth Menon <nm@ti.com>, Rajendra Nayak <rnayak@ti.com>, "Valentin, Eduardo" <eduardo.valentin@ti.com>, "Anna, Suman" <s-anna@ti.com>, "Bedia, Vaibhav" <vaibhav.bedia@ti.com>, Vaibhav Hiremath <hvaibhav@ti.com>

Paul, Tony,

On Friday 05 April 2013 10:20 PM, Santosh Shilimkar wrote:
> On Thursday 04 April 2013 10:27 PM, Santosh Shilimkar wrote:
>> On Thursday 04 April 2013 10:22 PM, Tony Lindgren wrote:
>>> * Santosh Shilimkar <santosh.shilimkar@ti.com> [130404 04:15]:
> [..]
> 
>>> Can't we already trim the am33xx hwmod data after your patches for
>>> v3.10 as am33xx is already DT only? Unfortunately we cannot create
>>> negative diffstat in other ways for v3.10 merge window as we cannot
>>> make omap4 DT only just quite yet.
>>>
>> Yes we can and I can take a stab it tomorrow. The only thing is I
>> might need some support for testing but thats manageable. Will
>> take a stab at it tomorrow and if everything goes well, post a
>> patch for smae.
>>
> Patch for the AM33XX to trim is end of the email. Thanks to
> Sricharan and Pekon for patch and testing. Looping both
> Vaibhav's if they have any objection on the patch.
> 
> Regards,
> Santosh
> 
> From b95dd33fe59b8e77727eb3b1717d763bbf9a2893 Mon Sep 17 00:00:00 2001
> From: Sricharan R <r.sricharan@ti.com>
> Date: Fri, 5 Apr 2013 20:39:12 +0530
> Subject: [PATCH] ARM: AM33XX: hwmod data: Clean up the data file
> 
For whatever reason, we again missed the merge window for the subject
series, I would like to know your plan on the subject series for
at least 3.11. Asking *well in advance* to avoid late merge related
discussions.

Thanks to Vaibhav, AM33XX patch is tested and validated with some
updates considering upcoming PM support for AM33XX. So that
patch will be included in the series.

Rajendra will follow up the patchset if there is some re-basing is
needed since I will away for few weeks because of travel. 

OMAP5 data is the *only* thing which is gating the device to boot
from mainline.

Thanks in advance.

Regards,
Santosh




