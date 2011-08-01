From: Kevin Hilman <khilman@ti.com>
Subject: Re: [RFC/PATCH 7/7] WIP: HACK/RFC: omap_device: begin to decouple platform_device from omap_device
Date: Mon, 01 Aug 2011 15:11:57 -0700
Message-ID: <87pqkon5n6.fsf@ti.com>
References: <1311292338-11830-1-git-send-email-khilman@ti.com>
	<1311292338-11830-9-git-send-email-khilman@ti.com>
	<20110730120332.GA15539@n2100.arm.linux.org.uk>
	<20110731025807.GA24334@ponder.secretlab.ca>
	<20110731150540.GA3019@n2100.arm.linux.org.uk> <871ux5nnop.fsf@ti.com>
	<CACxGe6t4tNeD-Pn6WFt1XOMC=_Q0cf4uD3kRkOckKH+S1JUJDA@mail.gmail.com>
	<20110801185009.GA5217@legolas.emea.dhcp.ti.com>
	<20110801200743.GA21535@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:34039 "EHLO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752933Ab1HAWMA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 1 Aug 2011 18:12:00 -0400
Received: by gxk2 with SMTP id 2so4321738gxk.8
        for <linux-omap@vger.kernel.org>; Mon, 01 Aug 2011 15:11:59 -0700 (PDT)
In-Reply-To: <20110801200743.GA21535@n2100.arm.linux.org.uk> (Russell King's
	message of "Mon, 1 Aug 2011 21:07:43 +0100")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Felipe Balbi <balbi@ti.com>, Grant Likely <grant.likely@secretlab.ca>, linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, "G. Manjunath Kondaiah" <manjugk@ti.com>, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org

Russell King - ARM Linux <linux@arm.linux.org.uk> writes:

> Help the typechecker do its job.  As we have only one (at the moment...)
> And make it:
>
> +struct omap_device;
>
>  struct pdev_archdata {
> +#ifdef CONFIG_ARCH_OMAP
> +	struct omap_device *omap;
> +#endif
>  };
>
> for bonus points, so we only get the additional pointer for OMAP.

OK, will do it this way.

Kevin
