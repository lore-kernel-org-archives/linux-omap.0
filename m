From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH] omap: hwmod: add syss reset done flags to omap2, omap3
 hwmods
Date: Thu, 31 Mar 2011 17:56:03 +0200
Message-ID: <4D94A413.3000406@ti.com>
References: <1298542123-3654-1-git-send-email-avinashhm@ti.com> <alpine.DEB.2.00.1103031427580.10981@utopia.booyaka.com> <20110314161609.GA10506@avinash-laptop> <alpine.DEB.2.00.1103242336410.21987@utopia.booyaka.com> <20110325062534.GA25480@avinash-laptop> <20110325072035.GB25480@avinash-laptop> <alpine.DEB.2.00.1103251124040.21987@utopia.booyaka.com> <20110326113538.GB3668@avinash-laptop> <20110331144010.GA18054@avinash-laptop> <871v1njpq2.fsf@ti.com> <20110331155142.GB18054@avinash-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:39229 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753342Ab1CaP4P (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 31 Mar 2011 11:56:15 -0400
In-Reply-To: <20110331155142.GB18054@avinash-laptop>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, Rajendra Nayak <rnayak@ti.com>

On 3/31/2011 5:51 PM, Mahadeva, Avinash wrote:
>>> The problem is the FCLK isn't enabled for these gpios(2..6) while
>>> resetting.  So the GPIO's are not resetting properly. Once i enable FCLK
>>> for them and then set the SYSCONFIG.SOFTRESET, then they are resetting
>>> and it is reflected in RESETDONE bit.
>>
>> What do you mean by fclk here.  GPIO doesn't have an fclk.  The
>> interface clock provides the functional clock, and the optional debounce
>> clock (dbclk) is needed only when GPIO debounce is enabled.
>>
>> I suggest you look at the "integration" sub chapter of the TRM for the
>> GPIO module.
>
> Hi Kevin ,
>
> I looked at this section. Now i am clear about the code. I meant fclk as
> functional clocks which is described by register CM_FCLKEN_PER, bit 12
> to bit 17. These bits are described as they control 'GPIO x functional
> clock'.
>
> Looking at the GPIO chapter, i understood that this is same as the gpio
> dbck. This was confirmed by section 'PER Power Domain Clock Controls'
> where he says CM_FCLKEN_PER[12-17] control PER_32K_ALWON_FCLK which is
> routed as GPIOx_DBCLK.
>
> [...]
>
>>
>> There are no GPIO fclks.
>>
>>> Also 'fclk' is structured as 'gpio2_dbck' and made as an optional
>>> clock.  I wasn't very sure, why the name 'dbck'?
>>
>> dbck == debounce clock
>
> I got it. Thanks for the clarification.
>
> Looks like without this clock, GPIO module isn't resetting even on
> writing to SYSCONFIG register. Should we provide a seperate reset
> function for gpio, like the way it was suggested for i2c ?

No need for that, it is already working like that on OMAP4.
We have a nice flag that handle that clock during reset.

	.flags		= HWMOD_CONTROL_OPT_CLKS_IN_RESET,

Regards,
Benoit

