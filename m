From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PM-SR] [PATCH] OMAP: PM: Remove the usage of vdd id's.
Date: Wed, 04 Aug 2010 14:08:19 -0700
Message-ID: <878w4mdr24.fsf@deeprootsystems.com>
References: <1277391768-3361-1-git-send-email-thara@ti.com>
	<87hbkrm0kj.fsf@deeprootsystems.com>
	<5A47E75E594F054BAF48C5E4FC4B92AB0323E68CC7@dbde02.ent.ti.com>
	<4C5975A9.4010008@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f174.google.com ([209.85.212.174]:58082 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758046Ab0HDVIV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 4 Aug 2010 17:08:21 -0400
Received: by pxi14 with SMTP id 14so2209725pxi.19
        for <linux-omap@vger.kernel.org>; Wed, 04 Aug 2010 14:08:21 -0700 (PDT)
In-Reply-To: <4C5975A9.4010008@ti.com> (Benoit Cousson's message of "Wed, 04
	Aug 2010 16:14:01 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: "Gopinath, Thara" <thara@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "paul@pwsan.com" <paul@pwsan.com>, "Sripathy, Vishwanath" <vishwanath.bs@ti.com>, "Sawant, Anand" <sawant@ti.com>

"Cousson, Benoit" <b-cousson@ti.com> writes:

> On 8/4/2010 6:31 AM, Gopinath, Thara wrote:
>>>> From: Kevin Hilman [mailto:khilman@deeprootsystems.com]
>>>> Sent: Friday, June 25, 2010 11:56 PM
>>>>
>>>> Thara Gopinath<thara@ti.com>  writes:
>>>>
>>>>> This patch removes the usage of vdd and sr id alltogether.
>>>>> This is achieved by introducing a separte voltage domain per
>>>>> VDD and hooking this up with the voltage and smartreflex
>>>>> internal info structure. Any user of voltage or smartreflex layer
>>>>> should call into omap_volt_domain_get to get the voltage
>>>>> domain handle and make use of this to call into the various
>>>>> exported API's.
>>>>
>>>> Great, I'm glad to see those gone.
>>>>
>>>> Minor comment on naming:
>>>>
>>>> In current code, we currently have
>>>>
>>>>    struct clockdomain *clkdm;
>>>>    struct powerdomain *pwrdm;
>>>>
>>>> so, for consistency, I'd suggest using
>>>>
>>>>    struct voltagedomain *voltdm;
>>>>
>>>> instead of this:
>>>>
>>>>    struct omap_volt_domain *volt_domain;
>>>>
>>>>
>>>> Also, it looks like your 'struct omap_vdd_info' is the real struct that
>>>> represents a voltage domain.
>>>>
>>>> Maybe you're planning this already, but I suggest you get rid of
>>>> omap_vdd_info and just move all that stuff into the voltagedomain.
>>>> Again, that will probably create a diff with a ton of renames, so this
>>>> should just be part of your V2 series.
>>
>> Are you sure? Because omap_vdd_info contains all the internal details about the
>> voltage domains. Do we really want to expose it? IMHO omap_vdd_info should remain as
>> internal structure instead of exposing it out.
>
> I think as well that struct voltagedomain should be a soc generic
> representation of the voltage domain, whereas omap_vdd_info will
> contain all the soc specific details.

OK.

Kevin

> The issue with voltage domain, is that the compared to clockdomain and
> powerdomain, the details are quite different between OMAP2, 3 and 4.
> OMAP2 does not have any VP, VC, SR, so in this case, the voltagedomain
> should be almost empty whereas OMAP3 will contain much more
> stuff. OMAP4 should be pretty similar.
>
> That being said, since we have only 1 scalable voltage domain on
> OMAP2, we can still manage the overhead.
>
> Benoit
