From: <Tero.Kristo@nokia.com>
Subject: RE: [PATCH] OMAP3: CPUIdle: prevent CORE from going off if doing so
 would reset an active clockdomain
Date: Fri, 21 Jan 2011 09:22:48 +0000
Message-ID: <854C6400F5AA6644BA6FE7953F3E769B036BD30C@008-AM1MPN1-014.mgdnok.nokia.com>
References: <1295344109-7056-1-git-send-email-tero.kristo@nokia.com>
 <e84561af552e084d0a6c904aabfe46c8@mail.gmail.com>
 <cff409280dee72a6d3426cc2edf93069@mail.gmail.com>
 <854C6400F5AA6644BA6FE7953F3E769B036776FE@008-AM1MPN1-012.mgdnok.nokia.com>
 <91467096ca191cde5a0d8b69ef0fce00@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.128.24]:50534 "EHLO mgw-da01.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750810Ab1AUJYp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 21 Jan 2011 04:24:45 -0500
In-Reply-To: <91467096ca191cde5a0d8b69ef0fce00@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: santosh.shilimkar@ti.com, vishwanath.bs@ti.com, linux-omap@vger.kernel.org
Cc: paul@pwsan.com, khilman@deeprootsystems.com



>-----Original Message-----
>From: ext Santosh Shilimkar [mailto:santosh.shilimkar@ti.com]
>Sent: 19 January, 2011 11:03
>To: Kristo Tero (Nokia-MS/Tampere); Vishwanath Sripathy; linux-
>omap@vger.kernel.org
>Cc: paul@pwsan.com; khilman@deeprootsystems.com
>Subject: RE: [PATCH] OMAP3: CPUIdle: prevent CORE from going off if
>doing so would reset an active clockdomain
>
>> -----Original Message-----
>> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
>> owner@vger.kernel.org] On Behalf Of Tero.Kristo@nokia.com
>> Sent: Wednesday, January 19, 2011 2:09 PM
>> To: vishwanath.bs@ti.com; linux-omap@vger.kernel.org
>> Cc: paul@pwsan.com; khilman@deeprootsystems.com
>> Subject: RE: [PATCH] OMAP3: CPUIdle: prevent CORE from going off if
>> doing so would reset an active clockdomain
>>
>[...]
>
>> >> If some parts of the chip are busy, then how can Core domain
>> enter off
>> >> state? The necessary condition for Core to enter low power state
>> is
>> >that
>> >> all the clock domains (including DSS, CAM, IVA, USB, PER etc)
>> should
>> >> have
>> >> idled. Doesn't it mean that all the modules have idled and
>> asserted
>> >> idleack when Core is entering off state?
>> >Besides these, Core off should reset the modules which are only in
>> Core
>> >domain. It should not impact other power domains. Also Core domain
>> >modules
>> >which are reset will restore their context when Core comes out of
>> off
>> >mode. So why are you saying that "If those parts of the chip are
>> busy,
>> >the reset will disrupt them, causing unpredictable and generally
>> >undesirable results."?
>>
>> Core off issues reset to peripheral domains when it wakes up, this
>> is somehow (badly) visible in TRM (look for COREDOMAINWKUP_RST.)
>> When this reset happens, the peripheral domain shows its reset
>> status as being high, but the powerdomain itself has not entered off
>> (previous state can be e.g. RET), thus its context will not be
>> restored.
>>
>Now its clear. Reseting other independent clockdomains is
>certainly bad from CORE PD OFF to ON behavior .
>
>Please add this additional information to change log.

I'll update the patch desc and resend it in a bit.

-Tero

