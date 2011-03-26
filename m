From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH/RFC 00/19] OMAP: voltage layer cleanup and restructure
Date: Fri, 25 Mar 2011 17:20:56 -0700
Message-ID: <87mxkipw9j.fsf@ti.com>
References: <1300924833-26745-1-git-send-email-khilman@ti.com>
	<87lj04xe2t.fsf@ti.com> <4D8CA8A6.8060102@ti.com>
	<alpine.DEB.2.00.1103251338580.21987@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:43564 "EHLO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932395Ab1CZAVB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 25 Mar 2011 20:21:01 -0400
Received: by mail-iy0-f171.google.com with SMTP id 20so1404131iyi.2
        for <linux-omap@vger.kernel.org>; Fri, 25 Mar 2011 17:20:58 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1103251338580.21987@utopia.booyaka.com> (Paul
	Walmsley's message of "Fri, 25 Mar 2011 17:02:40 -0600 (MDT)")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: "Cousson, Benoit" <b-cousson@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Paul Walmsley <paul@pwsan.com> writes:

> Hi Kevin
>
> you might want to consider renaming 
>
> OMAP3_PRM_VC_VDD_MPU_ID
>
> etc. to something like:
>
> OMAP3_VC_VDD_MPU_ID
>
> and to define those in some vc.h header file.

OK

> Also, I'd suggest moving the struct omap_prm_vc_ops assignments out of the 
> prm*.c code into the vcXXXX_data.c files, ideally into some initcall, and 
> renaming the struct omap_prm_vc_ops to simply struct omap_vc_ops.

OK

> As long as the VC's low-level registers are in the PRM, those reads/writes 
> should happen through PRM code, IMHO.

OK, what I will probably do then is at least create some
omapX_prm_vc_read/write/rmw functions in prmXXXX.c.  The prototypes for
these will be identical for OMAP3 & 4, so the read/writes can be called
from SoC independent code (via func ptrs) as needed.

I'll try this approach on Monday.

Kevin
