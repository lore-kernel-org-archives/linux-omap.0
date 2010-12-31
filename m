From: "Gopinath, Thara" <thara@ti.com>
Subject: RE: [PATCH v6 07/10] OMAP3: PM: Adding T2 enabling of smartreflex
 support
Date: Fri, 31 Dec 2010 13:31:56 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB0373BA283D@dbde02.ent.ti.com>
References: <1292864357-13939-1-git-send-email-thara@ti.com>
	<1292864357-13939-8-git-send-email-thara@ti.com>
 <87mxnxr1n8.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:34236 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751557Ab0LaICJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 31 Dec 2010 03:02:09 -0500
In-Reply-To: <87mxnxr1n8.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "paul@pwsan.com" <paul@pwsan.com>, "Cousson, Benoit" <b-cousson@ti.com>, "Sripathy, Vishwanath" <vishwanath.bs@ti.com>, "Sawant, Anand" <sawant@ti.com>, "Menon, Nishanth" <nm@ti.com>



>>-----Original Message-----
>>From: Kevin Hilman [mailto:khilman@deeprootsystems.com]
>>Sent: Thursday, December 23, 2010 2:01 AM
>>To: Gopinath, Thara
>>Cc: linux-omap@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
>>paul@pwsan.com; Cousson, Benoit; Sripathy, Vishwanath; Sawant, Anand;
>>Menon, Nishanth
>>Subject: Re: [PATCH v6 07/10] OMAP3: PM: Adding T2 enabling of smartreflex
>>support
>>
>>Hi Thara,
>>
>>Thara Gopinath <thara@ti.com> writes:
>>
>>> This patch adds support in the twl4030 driver to enable smartreflex.
>>> The smartreflex bit on twl4030 needs to be enabled by default
>>irrespective
>>> of whether smartreflex module is enabled on the OMAP side or not.
>>> This is because without this bit enabled the voltage scaling through
>>> vp forceupdate does not function properly.
>>
>>Is this true for OMAP2 as well?
>>
>>This patch actually hangs the boot on 2430SDP.

Hello Kevin,

I tried the latest lo master with smartreflex module compiled in using
omap2plus_defconfig and this patch on OMAP2430 SDP and it boots
fine for me. Your pm-core branch does not boot for me with or without this
patch on OMAP2430 SDP. But then I am not sure if this is needed for OMAP2
also. Considering this might be a omap and twl4030 dependent setting, my idea is to move this code to mach-omap2/omap_twl.c. I will post a patch for the same shortly.

Regards
Thara

