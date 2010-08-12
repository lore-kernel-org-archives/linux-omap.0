From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PM-OPP][PATCH 2/2] omap3: opp: make independent of cpufreq
Date: Thu, 12 Aug 2010 07:34:28 -0700
Message-ID: <87iq3fucgb.fsf@deeprootsystems.com>
References: <1281493018-29294-1-git-send-email-nm@ti.com>
	<1281493018-29294-3-git-send-email-nm@ti.com>
	<5A47E75E594F054BAF48C5E4FC4B92AB0324110879@dbde02.ent.ti.com>
	<4C627EDF.2000404@gmail.com>
	<5A47E75E594F054BAF48C5E4FC4B92AB032411094B@dbde02.ent.ti.com>
	<4C628BA6.6090507@ti.com>
	<5A47E75E594F054BAF48C5E4FC4B92AB0324110E11@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:41525 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753875Ab0HLOeb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Aug 2010 10:34:31 -0400
Received: by pwi4 with SMTP id 4so148827pwi.19
        for <linux-omap@vger.kernel.org>; Thu, 12 Aug 2010 07:34:31 -0700 (PDT)
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB0324110E11@dbde02.ent.ti.com>
	(Thara Gopinath's message of "Thu, 12 Aug 2010 19:50:55 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gopinath, Thara" <thara@ti.com>
Cc: "Menon, Nishanth" <nm@ti.com>, Nishanth Menon <menon.nishanth@gmail.com>, linux-omap <linux-omap@vger.kernel.org>, Eduardo Valentin <eduardo.valentin@nokia.com>, Paul Walmsley <paul@pwsan.com>, "Nayak, Rajendra" <rnayak@ti.com>, "Premi, Sanjeev" <premi@ti.com>, Tony Lindgren <tony@atomide.com>

"Gopinath, Thara" <thara@ti.com> writes:

[...]

>>>>>>
>>>>>>> No reason why we should have a different file for OMAP4. So a better name than opp3xxx_data.c?
>>>>>> why do we need to have it in the same file? Remember, 3630,3430 are
>>>>>> under OMAP3 family, but omap4 is considered a different arch.
>>>>
>>>> Code is more or less the same. Is that not a sufficient reason to reuse a  file ?
>>>I dont really care as long as opp layer is usable by mpurate without
>>>depending on cpufreq and it is maintainable without going to if else
>>>nightmare. But personally, I dont see really reusuable code in that file
>>>(other than doing an opp addition in a loop) it could result eventually
>>>in a large amount of code redundancy and maintenance nightmare with
>>>OMAP4 variants coming in.
>
> Why do you say maintenance nightmare? It is going to be one opp table
> per SoC. Anyways, Kevin what is your take on this?
>

I think we should keep separate files for each SoC listing the OPP data,
and in those files should be *only* data.

The init functions across these files will be basically the same, so
maybe the common code should be pulled out into a separate file (pm.c?),
and the data files have a very simple init function (device_initcall) that just registers
their data.

Kevin

