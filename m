From: "Gopinath, Thara" <thara@ti.com>
Subject: RE: [PM-SR] [PATCH] OMAP: PM: Remove the usage of vdd id's.
Date: Wed, 4 Aug 2010 10:01:41 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB0323E68CC7@dbde02.ent.ti.com>
References: <1277391768-3361-1-git-send-email-thara@ti.com>
 <87hbkrm0kj.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:49256 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751336Ab0HDEbs convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 4 Aug 2010 00:31:48 -0400
In-Reply-To: <87hbkrm0kj.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "paul@pwsan.com" <paul@pwsan.com>, "Cousson, Benoit" <b-cousson@ti.com>, "Sripathy, Vishwanath" <vishwanath.bs@ti.com>, "Sawant, Anand" <sawant@ti.com>



>>-----Original Message-----
>>From: Kevin Hilman [mailto:khilman@deeprootsystems.com]
>>Sent: Friday, June 25, 2010 11:56 PM
>>To: Gopinath, Thara
>>Cc: linux-omap@vger.kernel.org; paul@pwsan.com; Cousson, Benoit; Sripathy, Vishwanath; Sawant, Anand
>>Subject: Re: [PM-SR] [PATCH] OMAP: PM: Remove the usage of vdd id's.
>>
>>Thara Gopinath <thara@ti.com> writes:
>>
>>> This patch removes the usage of vdd and sr id alltogether.
>>> This is achieved by introducing a separte voltage domain per
>>> VDD and hooking this up with the voltage and smartreflex
>>> internal info structure. Any user of voltage or smartreflex layer
>>> should call into omap_volt_domain_get to get the voltage
>>> domain handle and make use of this to call into the various
>>> exported API's.
>>
>>Great, I'm glad to see those gone.
>>
>>Minor comment on naming:
>>
>>In current code, we currently have
>>
>>   struct clockdomain *clkdm;
>>   struct powerdomain *pwrdm;
>>
>>so, for consistency, I'd suggest using
>>
>>   struct voltagedomain *voltdm;
>>
>>instead of this:
>>
>>   struct omap_volt_domain *volt_domain;
>>
>>
>>Also, it looks like your 'struct omap_vdd_info' is the real struct that
>>represents a voltage domain.
>>
>>Maybe you're planning this already, but I suggest you get rid of
>>omap_vdd_info and just move all that stuff into the voltagedomain.
>>Again, that will probably create a diff with a ton of renames, so this
>>should just be part of your V2 series.

Are you sure? Because omap_vdd_info contains all the internal details about the
voltage domains. Do we really want to expose it? IMHO omap_vdd_info should remain as
internal structure instead of exposing it out.

Regards
Thara

