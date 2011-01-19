From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH] OMAP3: CPUIdle: prevent CORE from going off if doing
 so would reset an active clockdomain
Date: Wed, 19 Jan 2011 14:25:09 -0600
Message-ID: <4D3748A5.4020207@ti.com>
References: <1295344109-7056-1-git-send-email-tero.kristo@nokia.com> <e84561af552e084d0a6c904aabfe46c8@mail.gmail.com> <cff409280dee72a6d3426cc2edf93069@mail.gmail.com> <854C6400F5AA6644BA6FE7953F3E769B036776FE@008-AM1MPN1-012.mgdnok.nokia.com> <91467096ca191cde5a0d8b69ef0fce00@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:38097 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752421Ab1ASUZR (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 19 Jan 2011 15:25:17 -0500
In-Reply-To: <91467096ca191cde5a0d8b69ef0fce00@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: "Tero.Kristo@nokia.com" <Tero.Kristo@nokia.com>, "Sripathy, Vishwanath" <vishwanath.bs@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "paul@pwsan.com" <paul@pwsan.com>, "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>

On 1/19/2011 3:03 AM, Shilimkar, Santosh wrote:
>> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
>> owner@vger.kernel.org] On Behalf Of Tero.Kristo@nokia.com
>> Sent: Wednesday, January 19, 2011 2:09 PM
>> To: vishwanath.bs@ti.com; linux-omap@vger.kernel.org
>> Cc: paul@pwsan.com; khilman@deeprootsystems.com
>> Subject: RE: [PATCH] OMAP3: CPUIdle: prevent CORE from going off if
>> doing so would reset an active clockdomain
>>
> [...]
>
>>>> If some parts of the chip are busy, then how can Core domain
>> enter off
>>>> state? The necessary condition for Core to enter low power state
>> is
>>> that
>>>> all the clock domains (including DSS, CAM, IVA, USB, PER etc)
>> should
>>>> have
>>>> idled. Doesn't it mean that all the modules have idled and
>> asserted
>>>> idleack when Core is entering off state?
>>> Besides these, Core off should reset the modules which are only in
>> Core
>>> domain. It should not impact other power domains. Also Core domain
>>> modules
>>> which are reset will restore their context when Core comes out of
>> off
>>> mode. So why are you saying that "If those parts of the chip are
>> busy,
>>> the reset will disrupt them, causing unpredictable and generally
>>> undesirable results."?
>>
>> Core off issues reset to peripheral domains when it wakes up, this
>> is somehow (badly) visible in TRM (look for COREDOMAINWKUP_RST.)
>> When this reset happens, the peripheral domain shows its reset
>> status as being high, but the powerdomain itself has not entered off
>> (previous state can be e.g. RET), thus its context will not be
>> restored.

That's for that reason that CORE OFF with any other power domain active 
is not a supported configuration from the system point of view.
And for that very same reason it was removed on OMAP4 to avoid the OMAP3 
confusion. Only CORE OSWR is supported on OMAP4.
CORE OFF should be set only if device OFF is targeted, all the other 
combinations are not valid.
Wakeup from CORE off will force a reset in order to ensure that the MPU 
and thus the ROM code is executed in order to deal with firewall config.

Regards,
Benoit
