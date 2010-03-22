From: "Gopinath, Thara" <thara@ti.com>
Subject: RE: [PATCHv2 00/17] OMAP3: PM: Smartreflex and voltage revamp.
Date: Mon, 22 Mar 2010 20:09:51 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB03220FBFA5@dbde02.ent.ti.com>
References: <1268903755-4151-1-git-send-email-thara@ti.com>
 <4BA27BCC.60404@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:53837 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751493Ab0CVOkE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 22 Mar 2010 10:40:04 -0400
In-Reply-To: <4BA27BCC.60404@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Menon, Nishanth" <nm@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>, "paul@pwsan.com" <paul@pwsan.com>, "Cousson, Benoit" <b-cousson@ti.com>, "Sripathy, Vishwanath" <vishwanath.bs@ti.com>, "Sawant, Anand" <sawant@ti.com>



>>-----Original Message-----
>>From: Menon, Nishanth
>>Sent: Friday, March 19, 2010 12:45 AM
>>To: Gopinath, Thara
>>Cc: linux-omap@vger.kernel.org; khilman@deeprootsystems.com; paul@pwsan.com; Cousson, Benoit;
>>Sripathy, Vishwanath; Sawant, Anand
>>Subject: Re: [PATCHv2 00/17] OMAP3: PM: Smartreflex and voltage revamp.
>>
>>Gopinath, Thara had written, on 03/18/2010 04:15 AM, the following:
>>[..]
>>
>>> This patch series is based on Kevin's PM tree origin/pm-wip-opp branch
>>> and is dependent on the following patches not yet applied onto this branch.
>>>
>>> 	http://patchwork.kernel.org/patch/81504/
>>> 	http://patchwork.kernel.org/patch/81606/
>>The 2nd patch does not seem to apply anymore
>>
>>see [1] - no more sysc_flags as it was queued to .34-rcX?

I do not understand this.. Second patch seems to apply for me on wip-opp branch off Kevin's tree
>>
>>--
>>Regards,
>>Nishanth Menon
>>Ref:
>>[1]
>>http://git.kernel.org/?p=linux/kernel/git/khilman/linux-omap-pm.git;a=blob;f=arch/arm/plat-
>>omap/include/plat/omap_hwmod.h;h=440b4164f2f65e8557713ce9fff2636ed02fe523;hb=pm-wip-opp#l258
