From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: [PATCH 0/5] V7/Cortex/omap34xx fixes for 2.6.33-rc1: DCC,
 kexec, atags
Date: Fri, 8 Jan 2010 16:32:05 -0600
Message-ID: <13B9B4C6EF24D648824FF11BE896716203A8571CA0@dlee02.ent.ti.com>
References: <20091219034151.26198.26570.stgit@localhost>
 <aec7e5c30912272155s41ce8914hd03a5e4c740a5b9d@mail.gmail.com>
 <20091229220705.GM3512@atomide.com>
 <alpine.DEB.2.00.1001051053000.2083@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:49280 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752959Ab0AHWcP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 8 Jan 2010 17:32:15 -0500
In-Reply-To: <alpine.DEB.2.00.1001051053000.2083@utopia.booyaka.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>
Cc: Magnus Damm <magnus.damm@gmail.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>


> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Paul Walmsley
> Sent: Tuesday, January 05, 2010 11:54 AM

> > Also, what's the Cortex version on your v7? It's rev r2p3 on
> > omap3430.
>
> Just a quick note - I think it is r1p3 on OMAP34xx ES3.1 and below, and
> r1p7 on ES3.1.2.

Not quite accurate for the 'below' but as they are non-production they are not so impacting.

Current production CortexA8 chips for 3430:
        es3.2   :       r1p7
        es3.1   :       r1p3
        Earlier esX.Y used r0p0, r1p1, r1p2

Production candidate chips for 3630:
        es1.x   :       r3p2

Regards,
Richard W.

