From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 01/04] OMAP3: PM: Disable PER DPLL idle before OFF, reduces OFF latency by 20ms
Date: Wed, 01 Jul 2009 07:36:29 -0700
Message-ID: <87k52sv5aq.fsf@deeprootsystems.com>
References: <5A47E75E594F054BAF48C5E4FC4B92AB0305B7837E@dbde02.ent.ti.com>
	<87zlbov64k.fsf@deeprootsystems.com>
	<13B9B4C6EF24D648824FF11BE8967162039632B16F@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f185.google.com ([209.85.222.185]:64674 "EHLO
	mail-pz0-f185.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751003AbZGAOg2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 1 Jul 2009 10:36:28 -0400
Received: by pzk15 with SMTP id 15so758118pzk.4
        for <linux-omap@vger.kernel.org>; Wed, 01 Jul 2009 07:36:31 -0700 (PDT)
In-Reply-To: <13B9B4C6EF24D648824FF11BE8967162039632B16F@dlee02.ent.ti.com> (Richard Woodruff's message of "Wed\, 1 Jul 2009 09\:28\:19 -0500")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Woodruff, Richard" <r-woodruff2@ti.com>
Cc: "Nayak, Rajendra" <rnayak@ti.com>, "Derrick, David" <dderrick@ti.com>, Paul Walmsley <paul@pwsan.com>, Kalle Jokiniemi <kalle.jokiniemi@digia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

"Woodruff, Richard" <r-woodruff2@ti.com> writes:

>> From: Kevin Hilman [mailto:khilman@deeprootsystems.com]
>> Sent: Wednesday, July 01, 2009 9:19 AM
>
>> David, did you see stability problems when using this patch on top of
>> linux-omap PM branch?  Or did you see problems on some internal tree?
>
> Issue was on one internal tree.  Tests need to be re-applied to current trees.
>

OK, then presumably the same problems already exist in linux-omap
since we've had this feature for awhile.

I'm going to apply this patch to the PM branch.

A more detailed report of the test and the instability against the current
tree would be very helpful.

Kevin


