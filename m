From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 0/3] omap3: pm: removes hardcoded VDD1/2 OPP values and make threshold generic
Date: Thu, 19 Nov 2009 10:53:53 -0800
Message-ID: <87y6m28hxa.fsf@deeprootsystems.com>
References: <E0D41E29EB0DAC4E9F3FF173962E9E940254330A61@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f42.google.com ([209.85.160.42]:38535 "EHLO
	mail-pw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751222AbZKSSxt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 19 Nov 2009 13:53:49 -0500
Received: by pwi3 with SMTP id 3so1578869pwi.21
        for <linux-omap@vger.kernel.org>; Thu, 19 Nov 2009 10:53:55 -0800 (PST)
In-Reply-To: <E0D41E29EB0DAC4E9F3FF173962E9E940254330A61@dbde02.ent.ti.com> (G. N.'s message of "Thu\, 19 Nov 2009 16\:52\:29 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "G.N, Vijayakumar" <vijaykumar.gn@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

"G.N, Vijayakumar" <vijaykumar.gn@ti.com> writes:

> With 3 patches I am trying to 
> 1. Remove hardcoded VDD1 OPP values and make threshold generic
> 2. Remove hardcoded VDD2 OPP values and make threshold generic
> 3. adding new api inplace of MIN/MAX_VDD1/VDD2_OPP 
>          to support 3630 OPP constraning along with the existing 3430 constraint.
>
> Patches are rebased on the 2.6.32-rc7.
>
> Patches have been tested for 3630 for 2.6.32-rc5.

I'm going to hold off on this series.

We're in the middle of discussions and proposals on a major rework of
the OPP layer, so I don't think it's worthwhile to spend time on these
relatively minor cleanups at the moment.

Kevin
