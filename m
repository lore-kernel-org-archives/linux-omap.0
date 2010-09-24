From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH] OMAP4: PM: Declare idle modules as functional too
Date: Fri, 24 Sep 2010 09:50:30 +0200
Message-ID: <4C9C5846.1000409@ti.com>
References: <1285312248-15734-1-git-send-email-rnayak@ti.com> <alpine.DEB.2.00.1009240123420.10678@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:43202 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750829Ab0IXHu1 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 24 Sep 2010 03:50:27 -0400
In-Reply-To: <alpine.DEB.2.00.1009240123420.10678@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: "Nayak, Rajendra" <rnayak@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Basak, Partha" <p-basak2@ti.com>

On 9/24/2010 9:28 AM, Paul Walmsley wrote:
> Hi Rajendra, Partha, Beno=EEt,
>
> On Fri, 24 Sep 2010, Rajendra Nayak wrote:
>
>> The omap4_cm_wait_module_ready function would only check for
>> the modules to be completely functional before declaring them
>> ready to be accessed.
>> There might also be instances where in the module is actually
>> in idle (under h/w control) but should still be declared
>> accessible, as the h/w control would make it functional when
>> needed.
>>
>> Hence make omap4_cm_wait_module_ready return true in case
>> the module is fully functional *or* in idle state.
>> Fail only if the module is fully disabled or stuck intransition.
>>
>> The explaination from the TRM for the idlest bits on OMAP4 is as
>> below for quick reference
>>
>> Module idle state:
>> 0x0 func:     Module is fully functional, including OCP
>> 0x1 trans:    Module is performing transition: wakeup, or sleep, or =
sleep
>>                abortion
>> 0x2 idle:     Module is in Idle mode (only OCP part). It is function=
al if
>>                using separate functional clock
>
> Thanks for the detailed changelog.  Do we need to check any other
> registers to ensure that the OCP port is in autoidle, or to ensure th=
at
> the separate functional clock is active?

Unfortunately, we do not have any other status than that in OMAP4 for=20
the modules clocks activity :-(

Benoit
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
