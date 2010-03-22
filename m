From: "Gopinath, Thara" <thara@ti.com>
Subject: RE: [PATCH 2/3] OMAP3: PM: Smartreflex IP update changes for
 OMAP3630
Date: Mon, 22 Mar 2010 12:35:10 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB03220FBD71@dbde02.ent.ti.com>
References: <1268068851-30022-1-git-send-email-thara@ti.com>
	<1268068851-30022-2-git-send-email-thara@ti.com>
	<1268068851-30022-3-git-send-email-thara@ti.com>
 <87lje2u2on.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:48347 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754181Ab0CVHFV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 22 Mar 2010 03:05:21 -0400
In-Reply-To: <87lje2u2on.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "paul@pwsan.com" <paul@pwsan.com>, "Menon, Nishanth" <nm@ti.com>, "Sripathy, Vishwanath" <vishwanath.bs@ti.com>, "Sawant, Anand" <sawant@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>



>>-----Original Message-----
>>From: Kevin Hilman [mailto:khilman@deeprootsystems.com]
>>Sent: Monday, March 08, 2010 11:16 PM
>>To: Gopinath, Thara
>>Cc: linux-omap@vger.kernel.org; paul@pwsan.com; Menon, Nishanth; Sripathy, Vishwanath; Sawant, Anand;
>>Cousson, Benoit
>>Subject: Re: [PATCH 2/3] OMAP3: PM: Smartreflex IP update changes for OMAP3630
>>
>>Thara Gopinath <thara@ti.com> writes:
>>
>>> OMAP3430 uses the 65nm version of the smartreflex IP where as
>>> OMAP3630 and OMAP4430 uses the 45nm updated IP.
>>>
>>> This patch adds support for the updated smartreflex IP used
>>> in OMAP3630 and OMAP4 in the smartreflex driver.
>>>
>>> Major changes between the two versions of IP involve:
>>> 1. Change in offset position for ERRCONFIG and SENERROR registers
>>> 2. Change in bit positions for VP bound interrupt enable and status
>>>    in ERRCONFIG register.
>>> 3. Change in bit positions and width of SENNENABLE and SENPENABLE
>>>    bits in SRCONFIG registers.
>>> 4. Introduction of separate irq registers for MCU bound interrupts.
>>> 5. Removal of clockactivity bits in ERRCONFIG and introduction of
>>>   idlemode and wakeupenable bits in ERRCONFIG.
>>>
>>> Signed-off-by: Thara Gopinath <thara@ti.com>
>>> ---
>>>  arch/arm/mach-omap2/smartreflex.c |  218 ++++++++++++++++++++++++++++---------
>>>  arch/arm/mach-omap2/smartreflex.h |   51 +++++++--
>>>  2 files changed, 208 insertions(+), 61 deletions(-)
>>>
>>> diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/smartreflex.c
>>> index 7aa84ab..2b1c529 100644
>>> --- a/arch/arm/mach-omap2/smartreflex.c
>>> +++ b/arch/arm/mach-omap2/smartreflex.c
>>> @@ -58,6 +58,18 @@ static struct omap_smartreflex_class_data *sr_class;
>>>
>>>  #define SR_REGADDR(offs)	(sr->srbase_addr + offset)
>>>
>>> +static inline int sr_type(void)
>>> +{
>>> +	if (cpu_is_omap3630())
>>
>>what about OMAP4?

Hi Kevin,

OMAP4 support will be added as a different patch once these preliminary patches get accepted.

Regards
Thara


