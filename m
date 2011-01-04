From: "Ghorai, Sukumar" <s-ghorai@ti.com>
Subject: RE: [PATCH v7 4/7] omap3: nand: prefetch in irq mode support
Date: Tue, 4 Jan 2011 14:20:17 +0530
Message-ID: <2A3DCF3DA181AD40BDE86A3150B27B6B036A57ACC7@dbde02.ent.ti.com>
References: <1293629546-18831-1-git-send-email-s-ghorai@ti.com>
 <1293629546-18831-5-git-send-email-s-ghorai@ti.com>
 <B85A65D85D7EB246BE421B3FB0FBB593024816D63C@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:41291 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750922Ab1ADIux convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 4 Jan 2011 03:50:53 -0500
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB593024816D63C@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Nori, Sekhar" <nsekhar@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: Vimal Singh <vimalsingh@ti.com>, "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>



[..snip...]
> > +		if (info->buf_len & (info->buf_len < bytes))
> 
> Meant to use logical AND here?
[Ghorai] thanks, you are right.

[..snip..]
> > +	init_completion(&info->comp);
> 
> You can use INIT_COMPLETION to reset the completion variable.
> Same change can be done in write below.
[..snip..]
> s/methode/method
> 
[Ghorai] yes. I will do this 

[..snip..]
> > +	/* waiting for write to complete */
> > +	wait_for_completion(&info->comp);
> > +	/* wait for data to flushed-out before reset the prefetch */
> > +	do {
> > +		ret = gpmc_read_status(GPMC_PREFETCH_COUNT);
> > +	} while (ret);
> 
> Please have a timeout for this while loop in case hardware does
> not become ready. Also, consider using cpu_relax() inside the
> tight loop.
> 
[Ghorai] Thanks. I will send again.

