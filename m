From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: RE: [PM-SR] [PATCH] OMAP: PM: Remove the usage of vdd id's.
Date: Fri, 25 Jun 2010 23:25:31 +0200
Message-ID: <74583B8642AB8841B30447520659FCA901AA60B73C@dnce01.ent.ti.com>
References: <1277391768-3361-1-git-send-email-thara@ti.com>
 <87aaqjj6cd.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:52745 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751862Ab0FYVZg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 25 Jun 2010 17:25:36 -0400
Content-Class: urn:content-classes:message
In-Reply-To: <87aaqjj6cd.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>, "Gopinath, Thara" <thara@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "paul@pwsan.com" <paul@pwsan.com>, "Sripathy, Vishwanath" <vishwanath.bs@ti.com>, "Sawant, Anand" <sawant@ti.com>

>From: Kevin Hilman [mailto:khilman@deeprootsystems.com]
>Sent: Friday, June 25, 2010 8:49 PM
>
>Thara Gopinath <thara@ti.com> writes:
>
>> This patch removes the usage of vdd and sr id alltogether.
>> This is achieved by introducing a separte voltage domain per
>> VDD and hooking this up with the voltage and smartreflex
>> internal info structure. Any user of voltage or smartreflex layer
>> should call into omap_volt_domain_get to get the voltage
>> domain handle and make use of this to call into the various
>> exported API's.
>>
>> These changes should be part of V2 of the sr/voltage series
>> instead of being a separate patch in itself.
>>
>> Signed-off-by: Thara Gopinath <thara@ti.com>
>
>[...]
>
>> -static struct omap_sr *_sr_lookup(int srid)
>> +static struct omap_sr *_sr_lookup(struct omap_volt_domain
>*volt_domain)
>>  {
>>      struct omap_sr *sr_info, *temp_sr_info;
>>
>>      sr_info = NULL;
>>      list_for_each_entry(temp_sr_info, &sr_list, node) {
>> -            if (srid == temp_sr_info->srid) {
>> +            if (volt_domain == temp_sr_info->volt_domain) {
>>                      sr_info = temp_sr_info;
>>                      break;
>
>Do we still need an _sr_lookup() function?  Isn't there a single SR
>instance per voltage domain?

Yep, it must be a one to one mapping. But you still need to get the smartreflex
instance that belong to a certain voltage domain. A voltage domain does not know
if it has a SR that can control it.

Benoit
Texas Instruments France SA, 821 Avenue Jack Kilby, 06270 Villeneuve Loubet. 036 420 040 R.C.S Antibes. Capital de EUR 753.920



