From: "Gopinath, Thara" <thara@ti.com>
Subject: RE: [PATCH 03/16] OMAP3: PM: Convert smartreflex driver into a
 platform driver using hwmods and omap-device layer
Date: Fri, 12 Mar 2010 15:18:54 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB0321EC965D@dbde02.ent.ti.com>
References: <1267003757-22456-1-git-send-email-thara@ti.com>
	<1267003757-22456-2-git-send-email-thara@ti.com>
	<1267003757-22456-3-git-send-email-thara@ti.com>
	<1267003757-22456-4-git-send-email-thara@ti.com>
 <87hboyy3wi.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:41629 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932067Ab0CLJtC convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 12 Mar 2010 04:49:02 -0500
In-Reply-To: <87hboyy3wi.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "paul@pwsan.com" <paul@pwsan.com>, "Menon, Nishanth" <nm@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>, "Sripathy, Vishwanath" <vishwanath.bs@ti.com>, "Sawant, Anand" <sawant@ti.com>



>>-----Original Message-----
>>From: Kevin Hilman [mailto:khilman@deeprootsystems.com]
>>Sent: Tuesday, March 02, 2010 11:58 PM
>>To: Gopinath, Thara
>>Cc: linux-omap@vger.kernel.org; paul@pwsan.com; Menon, Nishanth; Cousson, Benoit; Sripathy,
>>Vishwanath; Sawant, Anand
>>Subject: Re: [PATCH 03/16] OMAP3: PM: Convert smartreflex driver into a platform driver using hwmods
>>and omap-device layer
>>
>>Thara Gopinath <thara@ti.com> writes:
>>
>>> This patch converts the exisitng smartreflex library into a
>>> platform driver with device , driver registrations using hardware mods.
>>> As part of this Ntarget values are passed as platform data.
>>>
>>> Signed-off-by: Thara Gopinath <thara@ti.com>
>>
>>Nice work Thara.  This is good.  Some minor comments below, but some
>>general comments first.
>>
>>As discussed, eventually (longer term) we'll want to move the driver
>>parts of this to a regulator driver.  To ease that transition, I think
>>it would be nice to start now by separating the driver portions of
>>this file from the device portions.
>>
>>You've already done a good job of keeping them separate in this file
>>(most of the device stuff is at the end) but I think having a separate
>>file is probably even better.  Maybe move driver stuff to sr_driver.c
>>and leave device stuff in smartreflex.c?  I don't care much about the
>>names at this point.
Hi Kevin,

Quick question.. If we are going to separate out smartreflex device portions from this file , can't we keep them in devices.c instead of going for a separate file?

Regards
Thara

