From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v4 6/6] ARM: dts: am335x-evm: fix reg and range property
 of GPMC NAND node
Date: Mon, 12 May 2014 12:44:01 -0700
Message-ID: <20140512194401.GA5668@atomide.com>
References: <1399668412-10818-1-git-send-email-pekon@ti.com>
 <1399668412-10818-4-git-send-email-pekon@ti.com>
 <CABxcv==icXxn74_zz1YQTq2jvuPyDSSh5ZM_NKA1W3SUzD6EKA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:31801 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751509AbaELToJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 12 May 2014 15:44:09 -0400
Content-Disposition: inline
In-Reply-To: <CABxcv==icXxn74_zz1YQTq2jvuPyDSSh5ZM_NKA1W3SUzD6EKA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Javier Martinez Canillas <javier@dowhile0.org>
Cc: Pekon Gupta <pekon@ti.com>, Benoit Cousson <bcousson@baylibre.com>, linux-omap <linux-omap@vger.kernel.org>

* Javier Martinez Canillas <javier@dowhile0.org> [140510 10:12]:
> Hello Pekon,
> 
> On Fri, May 9, 2014 at 10:46 PM, Pekon Gupta <pekon@ti.com> wrote:
> > 1) NAND device memory is not directly accessible to CPU, its indirectly accessed
> >    via registers. So the 'reg' property for GPMC NAND nodes should be limited to
> >    address range of internal GPMC registers only.
> > 2) Also, minimum granularity of address space under a GPMC chip-select is 16MB
> >    so 'range' property for GPMC NAND node should specify 16MB as its memory-size
> 
> This is true for all SoC using the GPMC right? So we need to do the
> same modification for all OMAP boards to avoid mapping a bigger
> address space unnecessarily.

Yes we should fix them all up. See also the commenting standard I suggested
in the parallel NAND series.

Regards,

Tony
