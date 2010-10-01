From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCHv3 1/17] OMAP2/3/4:dmtimer:add device names to flck nodes
Date: Fri, 01 Oct 2010 08:49:12 -0700
Message-ID: <87r5g9ap6v.fsf@deeprootsystems.com>
References: <1285059060-26316-1-git-send-email-tarun.kanti@ti.com>
	<4CA4F005.6000208@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:32869 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750988Ab0JAPtR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 Oct 2010 11:49:17 -0400
Received: by pvg2 with SMTP id 2so799798pvg.19
        for <linux-omap@vger.kernel.org>; Fri, 01 Oct 2010 08:49:17 -0700 (PDT)
In-Reply-To: <4CA4F005.6000208@ti.com> (Benoit Cousson's message of "Thu, 30
	Sep 2010 22:16:05 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>, Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Gopinath, Thara" <thara@ti.com>, "Basak, Partha" <p-basak2@ti.com>

"Cousson, Benoit" <b-cousson@ti.com> writes:

[...]

> Since we are in the name discussion, I'd like as well to potentially
> stop using the dmtimer / gptimer confusing naming convention, and
> replace that with a simple name "timer". Or potentially "omap_timer".
> Dual Mode timer does not mean at lot and General Purpose timer is not
> that better.
>
> We already started that discussion with Kevin some time ago but didn't
> really conclude.
>
> Tony, Paul and Kevin,
> Do you have any opinion on that subject?

Since the HW teams have decided on aligned names for all the IPs, I
think we should stick with those.  In this case, "timer".

However, since that is such a generic word and used throughout the
kernel, maybe calling it omap_timer is better.

I'd live with either,

Kevin

