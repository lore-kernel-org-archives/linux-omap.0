From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PM-OPP][PATCH v2 1/2] omap: pm: opp: remove opp_id
Date: Wed, 11 Aug 2010 16:46:06 -0700
Message-ID: <87aaos1znl.fsf@deeprootsystems.com>
References: <1281494623-11232-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:51310 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751477Ab0HKXqJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 11 Aug 2010 19:46:09 -0400
Received: by pzk26 with SMTP id 26so243114pzk.19
        for <linux-omap@vger.kernel.org>; Wed, 11 Aug 2010 16:46:09 -0700 (PDT)
In-Reply-To: <1281494623-11232-1-git-send-email-nm@ti.com> (Nishanth Menon's
	message of "Tue, 10 Aug 2010 21:43:43 -0500")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Eduardo Valentin <eduardo.valentin@nokia.com>, Paul Walmsley <paul@pwsan.com>, Rajendra Nayak <rnayak@ti.com>, Sanjeev Premi <premi@ti.com>, Thara Gopinath <thara@ti.com>, Tony Lindgren <tony@atomide.com>

Nishanth Menon <nm@ti.com> writes:

> Remove the concept of opp_id now that SRF is gone from pm branch
> the new framework should exist on silicon variants without the
> notion of opp ids
>
> This also removes the deprecated functions opp_get_opp_id and
> opp_find_by_opp_id.
>
> Cc: Eduardo Valentin <eduardo.valentin@nokia.com>
> Cc: Kevin Hilman <khilman@deeprootsystems.com>
> Cc: Paul Walmsley <paul@pwsan.com>
> Cc: Rajendra Nayak <rnayak@ti.com>
> Cc: Sanjeev Premi <premi@ti.com>
> Cc: Thara Gopinath <thara@ti.com>
> Cc: Tony Lindgren <tony@atomide.com>
>
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
> v1: original patch https://patchwork.kernel.org/patch/118723/
> v2: I missed cleaning up opp_add properly :( (I should have removed
>   the variable i and removed the list walk for renumbering..) apologies
>   on the spam..
> Note: for folks using SRF, you'd have to revert this patch
>
>  arch/arm/plat-omap/include/plat/opp.h |   15 ---------
>  arch/arm/plat-omap/opp.c              |   52 ---------------------------------
>  2 files changed, 0 insertions(+), 67 deletions(-)

I squashed this into patch 1 in pm-opp and also removed the references
to to the deprecated functions in Documentation/arm/OMAP/omap_pm.

Kevin
