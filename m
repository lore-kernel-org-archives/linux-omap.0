From: Kevin Hilman <khilman@ti.com>
Subject: Re: [RFC PATCH 03/11] arm:omap:am33xx: Add power domain data
Date: Thu, 01 Dec 2011 07:29:34 -0800
Message-ID: <87vcq0qpi9.fsf@ti.com>
References: <1321809555-13833-1-git-send-email-hvaibhav@ti.com>
	<1321809555-13833-4-git-send-email-hvaibhav@ti.com>
	<878vmxump8.fsf@ti.com>
	<79CD15C6BA57404B839C016229A409A8047604@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog115.obsmtp.com ([74.125.149.238]:59273 "EHLO
	na3sys009aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755016Ab1LAP3k (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 1 Dec 2011 10:29:40 -0500
Received: by mail-iy0-f181.google.com with SMTP id k12so2778674iak.40
        for <linux-omap@vger.kernel.org>; Thu, 01 Dec 2011 07:29:37 -0800 (PST)
In-Reply-To: <79CD15C6BA57404B839C016229A409A8047604@DBDE01.ent.ti.com>
	(Vaibhav Hiremath's message of "Thu, 1 Dec 2011 11:58:19 +0000")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>, "paul@pwsan.com" <paul@pwsan.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Cousson, Benoit" <b-cousson@ti.com>, "Mohammed, Afzal" <afzal@ti.com>, "Patil, Rachna" <rachna@ti.com>

"Hiremath, Vaibhav" <hvaibhav@ti.com> writes:

>> -----Original Message-----
>> From: Hilman, Kevin
>> Sent: Thursday, December 01, 2011 6:34 AM
>> To: Hiremath, Vaibhav
>> Cc: linux-omap@vger.kernel.org; tony@atomide.com; paul@pwsan.com; linux-
>> arm-kernel@lists.infradead.org; Cousson, Benoit; Mohammed, Afzal; Patil,
>> Rachna
>> Subject: Re: [RFC PATCH 03/11] arm:omap:am33xx: Add power domain data
>> 
>> Vaibhav Hiremath <hvaibhav@ti.com> writes:
>> 
>> > From: Afzal Mohammed <afzal@ti.com>
>> >
>> > This patch adds AM33XX power domain data,
>> > corresponding API's to access PRM module and
>> > PRM register offsets & bit fields.
>> >
>> > Signed-off-by: Rachna Patil <rachna@ti.com>
>> > Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
>> > Signed-off-by: Afzal Mohammed <afzal@ti.com>
>> 
>> First some general comments:
>> 
>> At first glance, it seems like there could be much more reuse with OMAP4
>> code here.  From what I see, AM33x has only one partition compared to
>> several on OMAP4, but that doesn't mean you couldn't reuse the OMAP4
>> functions and just use a single partition.
> Kevin,
>
> Indeed it looks close to OMAP4, but it becomes difficult and ugly once you
> Start getting into implementation details, for example,
>
>  - All PRM offsets don't match, you will end up with
> cpu_is_xxx check and handle this. Applicable to all power domains.
>
> 	OMAP4430_PRM_MPU_INST           0x0300
> 	Vs
> 	AM33XX_PRM_MPU_MOD              0x0E00
>
> 	OMAP4430_PRM_WKUP_INST          0x1700
> 	Vs
> 	AM33XX_PRM_WKUP_MOD             0x0D00
>
>  - Also there are some differences in logic states of domains as well.
>
> Another important point is, we have considered AM33xx as OMAP3 family
> of device (ARCH_OMAP3).  So you may end up with number of cpu_is_xxx
> checks in code.

If we end up with cpu_is_* checks in the code, we're doing it wrong.

I understand there are lots of differences with OMAP4, but from what I'm
looking at (at least for the power domains in this patch) there most of
those differences are handled in the data files, and the code could be
shared.

For example, looking at powerdomain33xx.c, this looks exactly like the
OMAP4 version except

- you have 2 new AM33XX_PRM_* defines (which are the same as OMAP4 version)
- you have a new register access functions: am33xx_prminst_read_inst_reg()...

So, my question is: if you could update the OMAP4 code to be able to
override the register access read/write functions, would you even need a
new powerdomain33xx.c?

Your am33xx_ version doesn't take a partition argument, but that would
be easy to remedy, and the AM33x powerdomains could be updated to all
declare a default partition.

Anyways, I'll let Benoit/Paul/Rajendra take it from here, as they're the
ones who know this code the best.

Kevin
