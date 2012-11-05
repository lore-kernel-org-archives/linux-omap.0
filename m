From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 13/15] ARM: DTS: AM33XX: Add nodes for OCMCRAM and Mailbox
Date: Tue, 6 Nov 2012 02:49:29 +0530
Message-ID: <50982D61.9060204@ti.com>
References: <1351859566-24818-1-git-send-email-vaibhav.bedia@ti.com> <1351859566-24818-14-git-send-email-vaibhav.bedia@ti.com> <50953E26.40906@ti.com> <B5906170F1614E41A8A28DE3B8D121433EBFFD0A@DBDE01.ent.ti.com> <5097D2D7.3090204@ti.com> <B5906170F1614E41A8A28DE3B8D121433EC0337B@DBDE01.ent.ti.com> <87a9uv97c0.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:55263 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751499Ab2KEVTj (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 5 Nov 2012 16:19:39 -0500
In-Reply-To: <87a9uv97c0.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Bedia, Vaibhav" <vaibhav.bedia@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "paul@pwsan.com" <paul@pwsan.com>, "Cousson, Benoit" <b-cousson@ti.com>, "tony@atomide.com" <tony@atomide.com>

On Tuesday 06 November 2012 12:59 AM, Kevin Hilman wrote:
> "Bedia, Vaibhav" <vaibhav.bedia@ti.com> writes:
>
>> On Mon, Nov 05, 2012 at 20:23:11, Shilimkar, Santosh wrote:
>> [...]
>>>>
>>> On OMAP the OCMC RAM is always clocked and doesn't need any special
>>> clock enable. CM_L3_2_OCMC_RAM_CLKCTRL module mode field is read only.
>>> Isn't it same on AMXX ?
>>>
>>
>> On AM33xx, OCMC RAM is in PER domain and the corresponding CLKCLTR module
>> mode fields are r/w. OCMC RAM needs to be disabled as part of the DeepSleep0
>> entry to let PER domain transition.
>
> After DeepSleep0, the ROM code is being given an address in OCMC RAM to
> jump to.  If OCMC RAM is disabled as part of suspend, this means that
> OCMC RAM contents are maintained even though PER domain transitions?
>
> If so, that needs to be more clearly documented.
>
Thats very good point. How does OCMC RAM retains the contents without
clock ?

Regards
Santosh

