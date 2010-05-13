From: "Gopinath, Thara" <thara@ti.com>
Subject: RE: [PATCHv3 12/22] OMAP3: PM: Minimizing the passing around of sr
 id in smartreflex.c
Date: Thu, 13 May 2010 12:43:15 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB0322D7D370@dbde02.ent.ti.com>
References: <1271408597-3066-1-git-send-email-thara@ti.com>
	<1271408597-3066-2-git-send-email-thara@ti.com>
	<1271408597-3066-3-git-send-email-thara@ti.com>
	<1271408597-3066-4-git-send-email-thara@ti.com>
	<1271408597-3066-5-git-send-email-thara@ti.com>
	<1271408597-3066-6-git-send-email-thara@ti.com>
	<1271408597-3066-7-git-send-email-thara@ti.com>
	<1271408597-3066-8-git-send-email-thara@ti.com>
	<1271408597-3066-9-git-send-email-thara@ti.com>
	<1271408597-3066-10-git-send-email-thara@ti.com>
	<1271408597-3066-11-git-send-email-thara@ti.com>
	<1271408597-3066-12-git-send-email-thara@ti.com>
	<1271408597-3066-13-git-send-email-thara@ti.com>
 <87pr1kius7.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:48732 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752132Ab0EMHNY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 13 May 2010 03:13:24 -0400
In-Reply-To: <87pr1kius7.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "paul@pwsan.com" <paul@pwsan.com>, "Cousson, Benoit" <b-cousson@ti.com>, "Sripathy, Vishwanath" <vishwanath.bs@ti.com>, "Sawant, Anand" <sawant@ti.com>



>>-----Original Message-----
>>From: Kevin Hilman [mailto:khilman@deeprootsystems.com]
>>Sent: Wednesday, April 28, 2010 12:32 AM
>>To: Gopinath, Thara
>>Cc: linux-omap@vger.kernel.org; paul@pwsan.com; Cousson, Benoit; Sripathy, Vishwanath; Sawant, Anand
>>Subject: Re: [PATCHv3 12/22] OMAP3: PM: Minimizing the passing around of sr id in smartreflex.c
>>
>>Thara Gopinath <thara@ti.com> writes:
>>
>>> This patch ensures that sr id is passed as a parameter only to
>>> public APIs in smartreflex.c and other APIs in smartreflex.c
>>> uses the omap_sr strucutres.
>>>
>>> Signed-off-by: Thara Gopinath <thara@ti.com>
>>
>>Good change, but...
>>
>>> ---
>>>  arch/arm/mach-omap2/smartreflex.c |   36 +++++++++++++-----------------------
>>>  1 files changed, 13 insertions(+), 23 deletions(-)
>>>
>>> diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/smartreflex.c
>>> index fffd5f7..c6942e9 100644
>>> --- a/arch/arm/mach-omap2/smartreflex.c
>>> +++ b/arch/arm/mach-omap2/smartreflex.c
>>> @@ -190,16 +190,8 @@ static void sr_configure(struct omap_sr *sr)
>>>  	sr->is_sr_reset = 0;
>>>  }
>>>
>>> -static void sr_start_vddautocomp(int srid)
>>> +static void sr_start_vddautocomp(struct omap_sr *sr)
>>>  {
>>> -	struct omap_sr *sr = _sr_lookup(srid);
>>> -
>>> -	if (!sr) {
>>> -		pr_warning("omap_sr struct corresponding to SR%d not found\n",
>>> -								srid + 1);
>>> -		return;
>>> -	}
>>> -
>>>  	if (!sr_class || !(sr_class->enable)) {
>>>  		pr_warning("smartreflex class driver not registered\n");
>>>  		return;
>>> @@ -211,30 +203,22 @@ static void sr_start_vddautocomp(int srid)
>>>  	}
>>>
>>>  	sr->is_autocomp_active = 1;
>>> -	if (!sr_class->enable(srid)) {
>>> +	if (!sr_class->enable(sr->srid)) {
>>
>>... the class3 layer is still taking SR ID as a parameter and it
>>should also just take an sr_info ptr.

Hi Kevin,

sr_info is an internal structure for smartreflex driver. The intention behind this patch is all external API's pass the srid and internally the driver static APIs take sr_info as parameter. I did not realize this point till now when I was doing the actual changes and hence the late reply :-)

Regards
Thara

>>
>>Kevin
