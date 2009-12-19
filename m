From: "Pagare, Abhijit" <abhijitpagare@ti.com>
Subject: RE: OMAP4 clock code needs some modifying now that clockdomains are
 present
Date: Sat, 19 Dec 2009 15:45:53 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02BFFDEF40@dbde02.ent.ti.com>
References: <alpine.DEB.2.00.0912181118100.12561@utopia.booyaka.com>
 <alpine.DEB.2.00.0912181331010.12561@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:40159 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751110AbZLSKQA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 19 Dec 2009 05:16:00 -0500
In-Reply-To: <alpine.DEB.2.00.0912181331010.12561@utopia.booyaka.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: "Nayak, Rajendra" <rnayak@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Paul,
	Thanks for the update. I will take care of that, rebase on the suggested queue and send them soon.

Best Regards,
Abhijit Pagare
> -----Original Message-----
> From: Paul Walmsley [mailto:paul@pwsan.com]
> Sent: Saturday, December 19, 2009 2:02 AM
> To: Pagare, Abhijit
> Cc: Nayak, Rajendra; linux-omap@vger.kernel.org
> Subject: Re: OMAP4 clock code needs some modifying now that clockdomains
> are present
> 
> Hi Abhijit,
> 
> On Fri, 18 Dec 2009, Paul Walmsley wrote:
> 
> > going through the clock code, I noticed that it still has several
> >
> > #ifndef CONFIG_ARCH_OMAP4 /* FIXME: Remove this once clkdm f/w is in
> place */
> 
> Just noticed this also in clock44xx_data.c:
> 
> 			/* TODO
> 			omap2_init_clk_clkdm(c->lk.clk);
> 			*/
> 
> - Paul
