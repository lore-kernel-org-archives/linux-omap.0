From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 00/02] OMAP3 clock: Remove virtual clock nodes
Date: Mon, 20 Apr 2009 11:44:21 -0500
Message-ID: <87ocurcm1m.fsf@deeprootsystems.com>
References: <5A47E75E594F054BAF48C5E4FC4B92AB02FB251DD1@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.230]:52127 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751178AbZDTQo0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 20 Apr 2009 12:44:26 -0400
Received: by rv-out-0506.google.com with SMTP id f9so1976710rvb.1
        for <linux-omap@vger.kernel.org>; Mon, 20 Apr 2009 09:44:26 -0700 (PDT)
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB02FB251DD1@dbde02.ent.ti.com> (Rajendra Nayak's message of "Fri\, 17 Apr 2009 11\:27\:42 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Nayak, Rajendra" <rnayak@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Jean Pihet <jpihet@mvista.com>

"Nayak, Rajendra" <rnayak@ti.com> writes:

> Resending this patch-set with some issues of tabs-to-spaces reported by Kevin Hilman
> fixed and also some warning removals from Jean Pihet.
>
> Patches apply on latest linux-omap pm branch  +
> [PATCH 00/10] OMAP3: SR: Fixes in Smartreflex driver sent on 04/15/09
> http://marc.info/?l=linux-omap&m=123980012121460&w=2
>

Thanks, pushing this whitespace-fixed version of series to PM branch
today.

Kevin

>
> This patch set removes the virtual clock node implementation for
> VDD1/2 on omap3 which was causing issues with recursive locking of spinlocks.
> All references to virtual clock nodes from resource framework and cpufreq
> driver are removed. Resource framework now uses individual dpll clock
> nodes to do frequency scaling.
> Most of the functionality implemented as part of the virtual clock nodes
> is now implemented internally in the resource framework.
>
> Thanks to Tero Kristo <tero.kristo@nokia.com> who has implemented 
> most of these changes.
>
> regards,
> Rajendra
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
