From: "Gopinath, Thara" <thara@ti.com>
Subject: RE: [PATCHv2 6/8] OMAP3: PM: Adding smartreflex class3 driver
Date: Tue, 14 Sep 2010 21:28:46 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB0329441CFE@dbde02.ent.ti.com>
References: <1281707231-3026-1-git-send-email-thara@ti.com>
	<1281707231-3026-7-git-send-email-thara@ti.com>
 <87vd6yb9z4.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:60052 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753643Ab0INP6x convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 14 Sep 2010 11:58:53 -0400
In-Reply-To: <87vd6yb9z4.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "paul@pwsan.com" <paul@pwsan.com>, "Cousson, Benoit" <b-cousson@ti.com>, "Sripathy, Vishwanath" <vishwanath.bs@ti.com>, "Sawant, Anand" <sawant@ti.com>, "Derrick, David" <dderrick@ti.com>



>>-----Original Message-----
>>From: Kevin Hilman [mailto:khilman@deeprootsystems.com]
>>Sent: Thursday, August 26, 2010 4:01 AM
>>To: Gopinath, Thara
>>Cc: linux-omap@vger.kernel.org; paul@pwsan.com; Cousson, Benoit; Sripathy, Vishwanath; Sawant, Anand;
>>Derrick, David
>>Subject: Re: [PATCHv2 6/8] OMAP3: PM: Adding smartreflex class3 driver
>>
>>Thara Gopinath <thara@ti.com> writes:
>>
>>> Smartreflex Class3 implementation continuously monitors
>>> silicon performance  and instructs the Voltage Processors
>>> to increase or decrease the voltage.
>>> This patch adds smartreflex class 3 driver. This driver hooks
>>> up with the generic smartreflex driver smartreflex.c to abstract
>>> out class specific implementations out of the generic driver.
>>>
>>> Signed-off-by: Thara Gopinath <thara@ti.com>
>>> ---
>>>  arch/arm/mach-omap2/Makefile             |    1 +
>>>  arch/arm/mach-omap2/board-3430sdp.c      |    2 +
>>>  arch/arm/mach-omap2/board-3630sdp.c      |    2 +
>>>  arch/arm/mach-omap2/board-zoom3.c        |    2 +
>>
>>I think this should be board-zoom-peripherals.c so it is enabled for
>>Zoom2 also.
>>
>>>  arch/arm/mach-omap2/smartreflex-class3.c |   61 ++++++++++++++++++++++++++++++
>>>  arch/arm/mach-omap2/smartreflex-class3.h |   23 +++++++++++
>>>  arch/arm/plat-omap/Kconfig               |    9 ++++
>>
>>Please separate this into the 2 patches.  One for the class driver, and
>>a second to modify the board files.

Will do this.
Regards
Thara
>>
>>Kevin
