From: "Gopinath, Thara" <thara@ti.com>
Subject: RE: [PATCH v4 0/9] OMAP3: Adding Smartreflex and Voltage driver
 support
Date: Thu, 28 Oct 2010 21:02:48 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB035ECA9D5D@dbde02.ent.ti.com>
References: <1288195856-11011-1-git-send-email-thara@ti.com>
 <4CC85F8F.8020705@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:49246 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932572Ab0J1Pcy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 28 Oct 2010 11:32:54 -0400
In-Reply-To: <4CC85F8F.8020705@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Menon, Nishanth" <nm@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "paul@pwsan.com" <paul@pwsan.com>, "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>, "Cousson, Benoit" <b-cousson@ti.com>, "Sripathy, Vishwanath" <vishwanath.bs@ti.com>, "Sawant, Anand" <sawant@ti.com>



>>-----Original Message-----
>>From: Menon, Nishanth
>>Sent: Wednesday, October 27, 2010 10:51 PM
>>To: Gopinath, Thara
>>Cc: linux-omap@vger.kernel.org; paul@pwsan.com; khilman@deeprootsystems.com;
>>Cousson, Benoit; Sripathy, Vishwanath; Sawant, Anand
>>Subject: Re: [PATCH v4 0/9] OMAP3: Adding Smartreflex and Voltage driver
>>support
>>
>>Gopinath, Thara had written, on 10/27/2010 11:10 AM, the following:
>>> This patch series introduces smartreflex and voltage driver support
>>> for OMAP3430 and OMAP3630. SmartReflex modules do adaptive voltage
>>> control for real-time voltage adjustments.
>>[..]
>>thanks for the revamped set

You are most welcome!!

>>>
>>> This patch series is based against lo-master with the following additional
>>> patches applied.
>>> 	https://patchwork.kernel.org/patch/266911/
>>> 	https://patchwork.kernel.org/patch/266921/
>>> 	https://patchwork.kernel.org/patch/266931/
>>> 	https://patchwork.kernel.org/patch/183712/
>>> 	https://patchwork.kernel.org/patch/285872/
>>>
>>> The entire series with the dependencies are available at
>>>         http://dev.omapzoom.org/?p=thara/omap-dvfs.git;a=summary
>>>         head: thara-pm-sr
>>>
>>> This patch series has been tested on OMAP3430 SDP with omap2plus_defconfig
>>> with the following menuconfig options enabled.
>>> System type -> TI OMAP Implementations -> Smartreflex Support
>>> System type -> TI OMAP Implementations ->
>>> 		Class 3 mode of Smartreflex Implementation
>>>
>>Thanks for hosting the branch, Looking at:

Again glad tat u liked it:-)

>>http://dev.omapzoom.org/?p=thara/omap-dvfs.git;a=shortlog;h=refs/heads/thara-
>>pm-sr
>>I am guessing DVFS is missing in this branch? Is it possible to give it
>>a test drive?

Yes.. This is exactly what I am trying to do. Will keep you updated.

>>
>>Also curious should:
>>"OMAP: OPP: twl/tps: Introduce TWL/TPS-specific code should probably be
>>" dropped with "OMAP3: PM: Register TWL4030 pmic info with the voltage" ?

Hmm.. Last time I suggested moving the contents of this patch to twl-core.c
Nobody seemed to much keen. Hence I retained the plat-omap/opp-twl-tpl.c file.
In fact "OMAP3: PM: Register TWL4030 pmic info with the voltage" registers the
params from plat-omap/opp-twl-tpl.c. But if we have a consensus I will just drop this patch and have the pmic params passed from twl-core.c.

>>
>>[...]
>>
>>my 2cents: If that tree were organized based on branches which depend on
>>each other it will be easier to identify the dependencies :)
>>probably:
>>kernel.org (now that l-o is merged - potential 2.6.37-rc1)
>>  |- clock patches  -\
>>  |- DVFS series    -|
>>  |- OMAP OPP series |
>>                     |-merged-based -
>>				 |-voltage layer & SR series perhaps
>>				 	|- twl optimization
>>						|- board changes
>>						*** final code ***
>>Just 2 cents to make it easier for folks who are not in PM mostly to see
>>how everything falls together in place..

I agree. But then I need some five patches on top of potential 2.6.37-rc1,
which are not present in any branch. Are you asking me to generate separate branches for all these patches?

Regards
Thara
