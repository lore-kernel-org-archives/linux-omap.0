From: Nishanth Menon <nm@ti.com>
Subject: Re: [PM-OPP][PATCH v2 1/2] omap: pm: opp: remove opp_id
Date: Wed, 11 Aug 2010 20:36:53 -0500
Message-ID: <4C635035.4070100@ti.com>
References: <1281494623-11232-1-git-send-email-nm@ti.com> <87aaos1znl.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:59551 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758303Ab0HLBg7 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 11 Aug 2010 21:36:59 -0400
In-Reply-To: <87aaos1znl.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Eduardo Valentin <eduardo.valentin@nokia.com>, Paul Walmsley <paul@pwsan.com>, "Nayak, Rajendra" <rnayak@ti.com>, "Premi, Sanjeev" <premi@ti.com>, "Gopinath, Thara" <thara@ti.com>, Tony Lindgren <tony@atomide.com>

Kevin Hilman had written, on 08/11/2010 06:46 PM, the following:
> Nishanth Menon <nm@ti.com> writes:
> 
>> Remove the concept of opp_id now that SRF is gone from pm branch
>> the new framework should exist on silicon variants without the
>> notion of opp ids
[...]

>>
>>  arch/arm/plat-omap/include/plat/opp.h |   15 ---------
>>  arch/arm/plat-omap/opp.c              |   52 ---------------------------------
>>  2 files changed, 0 insertions(+), 67 deletions(-)
> 
> I squashed this into patch 1 in pm-opp and also removed the references
> to to the deprecated functions in Documentation/arm/OMAP/omap_pm.
arrgh.. i missed that.. thanks for doing it..
-- 
Regards,
Nishanth Menon
