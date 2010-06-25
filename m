From: "Gopinath, Thara" <thara@ti.com>
Subject: RE: [PATCH 0/8] OMAP3: Adding Smartreflex and Voltage driver support
Date: Fri, 25 Jun 2010 13:34:05 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB032366B2D8@dbde02.ent.ti.com>
References: <1275150748-15386-1-git-send-email-thara@ti.com>
 <878w64xbc1.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:59397 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751624Ab0FYIEN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 25 Jun 2010 04:04:13 -0400
In-Reply-To: <878w64xbc1.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "paul@pwsan.com" <paul@pwsan.com>, "Cousson, Benoit" <b-cousson@ti.com>, "Sripathy, Vishwanath" <vishwanath.bs@ti.com>, "Sawant, Anand" <sawant@ti.com>



>>-----Original Message-----
>>From: Kevin Hilman [mailto:khilman@deeprootsystems.com]
>>Sent: Friday, June 25, 2010 4:55 AM
>>To: Gopinath, Thara
>>Cc: linux-omap@vger.kernel.org; paul@pwsan.com; Cousson, Benoit; Sripathy, Vishwanath; Sawant, Anand
>>Subject: Re: [PATCH 0/8] OMAP3: Adding Smartreflex and Voltage driver support
>>
>>Thara Gopinath <thara@ti.com> writes:
>>
>>> This patch series introduces smartreflex and voltage driver support
>>> for OMAP3430 and OMAP3630. SmartReflex modules do adaptive voltage
>>> control for real-time voltage adjustments.
>>>
>>> Originally all the functionalities introduced in this patch
>>> were present in arch/arm/mach-omap2/smartreflex.c file in Kevin's
>>> pm tree. This patch series does a major rewrite of this file
>>> and introduces a separate voltage driver. Major contributors
>>> to the original driver are
>>
>>I just noticed that one thing missing from this series compared to what
>>was in the previous PM branch is the disable/enable of SR in the idle
>>path, so SR is not getting exercised during idle anymore in the current
>>PM branch.
>>
>>Could you rememdy that please with another patch on top of this series
>>(the new pm-sr branch?)
>>
>>Kevin

Hello Kevin,

This was intentional as there is not voltage scaling happening in the idle thread in pm-sr branch. Smartreflex needs to be disabled only if a voltage scaling is done during retention/off. I had submitted a patch for addressing this and removing all voltage refrences in pm34xx.c against origin/pm branch the link to which is below
	https://patchwork.kernel.org/patch/103086/

Regards
Thara 
