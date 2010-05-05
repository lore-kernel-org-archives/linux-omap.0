From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [PATCH 1/2] ARM: McBSP: Fix request for irq in OMAP4
Date: Wed, 5 May 2010 13:39:03 +0300
Message-ID: <20100505133903.cde41896.jhnikula@gmail.com>
References: <1273016270-31452-1-git-send-email-jorge.candelaria@ti.com>
	<1273016270-31452-2-git-send-email-jorge.candelaria@ti.com>
	<E0D41E29EB0DAC4E9F3FF173962E9E94026F8C6E56@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f222.google.com ([209.85.219.222]:45531 "EHLO
	mail-ew0-f222.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934369Ab0EEKh4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 May 2010 06:37:56 -0400
Received: by ewy22 with SMTP id 22so1435778ewy.37
        for <linux-omap@vger.kernel.org>; Wed, 05 May 2010 03:37:54 -0700 (PDT)
In-Reply-To: <E0D41E29EB0DAC4E9F3FF173962E9E94026F8C6E56@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "G, Manjunath Kondaiah" <manjugk@ti.com>
Cc: "Candelaria Villarreal, Jorge" <jorge.candelaria@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Wed, 5 May 2010 08:32:13 +0530
"G, Manjunath Kondaiah" <manjugk@ti.com> wrote:

> > -		init_completion(&mcbsp->rx_irq_completion);
> > -		err = request_irq(mcbsp->rx_irq, 
> > omap_mcbsp_rx_irq_handler,
> > +		if (!cpu_is_omap44xx) {
> > +			init_completion(&mcbsp->rx_irq_completion);
> > +			err = request_irq(mcbsp->rx_irq,
> > +					omap_mcbsp_rx_irq_handler,
> >  					0, "McBSP", (void *)mcbsp);
> 
> How about using request_threaded_irq?
> Refer to: http://lwn.net/Articles/302043/
> 
Threaded irq conversion would be better to handle as a separate patch
as it does different thing than this patch.

-- 
Jarkko
