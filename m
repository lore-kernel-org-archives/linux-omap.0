From: "Gopinath, Thara" <thara@ti.com>
Subject: RE: [RFC 3/7] OMAP: Introduce voltage domain pointer and device
 specific set rate and get rate in device opp structures.
Date: Thu, 5 Aug 2010 11:18:59 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB0323E69162@dbde02.ent.ti.com>
References: <1278065909-32148-1-git-send-email-thara@ti.com>
	<1278065909-32148-2-git-send-email-thara@ti.com>
	<1278065909-32148-3-git-send-email-thara@ti.com>
	<1278065909-32148-4-git-send-email-thara@ti.com>
	<87iq3rkyit.fsf@deeprootsystems.com>
	<5A47E75E594F054BAF48C5E4FC4B92AB0323E68C90@dbde02.ent.ti.com>
 <87d3tydr5z.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:37013 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757845Ab0HEFtH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 5 Aug 2010 01:49:07 -0400
In-Reply-To: <87d3tydr5z.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "paul@pwsan.com" <paul@pwsan.com>, "Cousson, Benoit" <b-cousson@ti.com>, "Sripathy, Vishwanath" <vishwanath.bs@ti.com>, "Sawant, Anand" <sawant@ti.com>, "Basak, Partha" <p-basak2@ti.com>



>>-----Original Message-----
>>From: Kevin Hilman [mailto:khilman@deeprootsystems.com]
>>Sent: Thursday, August 05, 2010 2:36 AM
>>To: Gopinath, Thara
>>Cc: linux-omap@vger.kernel.org; paul@pwsan.com; Cousson, Benoit; Sripathy, Vishwanath; Sawant, Anand;
>>Basak, Partha
>>Subject: Re: [RFC 3/7] OMAP: Introduce voltage domain pointer and device specific set rate and get
>>rate in device opp structures.
>>
>>"Gopinath, Thara" <thara@ti.com> writes:
>>
>>>>>> @@ -385,6 +380,11 @@ int opp_add(const struct omap_opp_def *opp_def)
>>>>>>
>>>>>>  		dev_opp->oh = oh;
>>>>>>  		dev_opp->dev = &oh->od->pdev.dev;
>>>>>> +		dev_opp->vdd_name = kzalloc(strlen(opp_def->vdd_name) + 1,
>>>>>> +				GFP_KERNEL);
>>>>>> +		strcpy(dev_opp->vdd_name, opp_def->vdd_name);
>>>>>
>>>>>Since this is user-defined data/string, should probably have a max
>>>>>strlen and use strncpy.
>>>
>>> I did not get this. What is the problem with the strlen here ?
>>
>>It's more of a paranoia issue than a technical issue.  I don't like
>>blindly using strlen on strings that are user-configurable.  I guess,
>>since they're coming from the OPP table, they're not terribly
>>configurable, so it's probably not a big deal.
>>
>>However, since opp_add() is already doing one kzalloc, I think it's
>>probably cleaner to just to make this field a fixed lenght and
>>then use strncpy():
>>
>>#define VDD_NAME_LEN 8
>>
>>struct device_opp {
>>       ...
>>       char vdd_name[VDD_NAME_LEN];
>>       ...
>>}

Gotcha! Will incorporate in V2.

Regards
Thara
