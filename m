From: "Gopinath, Thara" <thara@ti.com>
Subject: RE: [PATCH v3 09/11] OMAP3: PM: Smartreflex Class3 initialization
 from board files.
Date: Mon, 25 Oct 2010 14:46:22 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB035EB9622C@dbde02.ent.ti.com>
References: <1285166719-19352-1-git-send-email-thara@ti.com>
	<1285166719-19352-10-git-send-email-thara@ti.com>
	<87aamgpc5e.fsf@deeprootsystems.com>
	<5A47E75E594F054BAF48C5E4FC4B92AB035EB95EAC@dbde02.ent.ti.com>
 <87pqv29oa7.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:35115 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751680Ab0JYJQa convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 25 Oct 2010 05:16:30 -0400
In-Reply-To: <87pqv29oa7.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "paul@pwsan.com" <paul@pwsan.com>, "Cousson, Benoit" <b-cousson@ti.com>, "Sripathy, Vishwanath" <vishwanath.bs@ti.com>, "Sawant, Anand" <sawant@ti.com>



>>-----Original Message-----
>>From: Kevin Hilman [mailto:khilman@deeprootsystems.com]
>>Sent: Friday, October 22, 2010 10:08 PM
>>To: Gopinath, Thara
>>Cc: linux-omap@vger.kernel.org; paul@pwsan.com; Cousson, Benoit; Sripathy,
>>Vishwanath; Sawant, Anand
>>Subject: Re: [PATCH v3 09/11] OMAP3: PM: Smartreflex Class3 initialization
>>from board files.
>>
>>"Gopinath, Thara" <thara@ti.com> writes:
>>
>>>>>> This patch enables smartreflex class3 functionality for OMAP3430SDP,
>>>>>> OMAP3630SDP, ZOOM2 and ZOOM3 boards.
>>>>>
>>>>>This patch doesn't touch 3630sdp.
>>>>>
>>>>>> Signed-off-by: Thara Gopinath <thara@ti.com>
>>>>>
>>>>>I'm having some doubts about whether this should be done by board files or
>>>>>not.  Seems like the general case will be that by default will be SoC
>>>>>specific, and only boards that want something other than the default
>>>>>class should need to override this.
>>>>>
>>>>>Thoughts?
>>>
>>> I agree. I wanted this to be a default initcall and one to enable the
>>> menuconfig option for the required class driver.. But Nishant wanted
>>> this from board files.
>>
>>And I want both.  :)
>>
>>> If we have consensus in removing this init from board file, I am cool
>>> with it.
>>
>>I want to suport a kernel that could be built with all possible classes
>>supported.  e.g. an omap3/4 kernel that has both class 1.5 and class 3
>>support.
>>
>>If both are enabled in Kconfig, then either could be used.  We'll have
>>to pick one as the default initcall (e.g. highest class present), but if
>>a board file chooses to call a different one, that should override the
>>default one.

We can pick class 3 by default and make it a late_initcall. This way if the board files choose to call some other class init, that class ddriver would be registered. Smartreflex driver sr_register_class API will ensure that only one class is registered. The second registeration will fail. What say ??

Regards,
Thara
