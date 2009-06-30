From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 01/04] OMAP3: PM: Disable PER DPLL idle before OFF, reduces OFF latency by 20ms
Date: Tue, 30 Jun 2009 15:24:28 -0700
Message-ID: <87bpo55pib.fsf@deeprootsystems.com>
References: <5A47E75E594F054BAF48C5E4FC4B92AB0305B77F0D@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.174]:23888 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753254AbZF3WY2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 30 Jun 2009 18:24:28 -0400
Received: by wf-out-1314.google.com with SMTP id 26so171604wfd.4
        for <linux-omap@vger.kernel.org>; Tue, 30 Jun 2009 15:24:31 -0700 (PDT)
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB0305B77F0D@dbde02.ent.ti.com> (Rajendra Nayak's message of "Tue\, 30 Jun 2009 11\:28\:18 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Nayak, Rajendra" <rnayak@ti.com>
Cc: Kalle Jokiniemi <kalle.jokiniemi@digia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Derrick, David" <dderrick@ti.com>, "Woodruff, Richard" <r-woodruff2@ti.com>

"Nayak, Rajendra" <rnayak@ti.com> writes:

[...]

>>>
>>> Oh.. it turns out that when the scratchpad save routine is called,
>>> the autoidle for PER is not even set. Its only set some place
>>> later.  So the 20ms or so advantage was always there on l-o pm
>>> branch even without this patch :)
>>>
>>
>>So for the benefit of the archives... 
>>
>>I'm dropping this patch since the equivalent is alrady in PM branch.
>
> Today the sequence is such that the PER dpll autoidle is set only
> after the first scratchpad save (so this patch has no
> affect). Sometime in future, if with some change in function
> sequencing we end up enabling the PER dpll autoidle early on, we
> might have an additional 20ms or so OFF latency without anyone
> really noticing.  Would'nt it be good to just have this patch to
> take care of any sequencing changes later?

Yes, I think you're right.  This change could indeed prevent some
future problmes down the road.  I'll merge it.

Thanks,

Kevin
