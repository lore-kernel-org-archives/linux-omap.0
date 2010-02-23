From: "Anna, Suman" <s-anna@ti.com>
Subject: RE: [RESEND] [PATCH 1/5] omap2/3/4: mailbox: remove compiler warning
Date: Tue, 23 Feb 2010 10:12:42 -0600
Message-ID: <2C1563023E232C49B9F505633D57C2DA2640F2CA81@dlee04.ent.ti.com>
References: <2C1563023E232C49B9F505633D57C2DA2640F2C540@dlee04.ent.ti.com>
 <4B8319D6.8080909@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:46418 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752178Ab0BWQMr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 23 Feb 2010 11:12:47 -0500
In-Reply-To: <4B8319D6.8080909@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, "Hiroshi.DOYU@nokia.com" <Hiroshi.DOYU@nokia.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>

Omar,

> >
> > +#if defined(CONFIG_ARCH_OMAP2420) /* IVA */
> >   err_iva1:
> > -	omap_mbox_unregister(&mbox_dsp_info);
> > +	if (cpu_is_omap2420())
> > +		omap_mbox_unregister(&mbox_dsp_info);
> > +#endif
> 
> why not moving omap_mbox_unregister to the block containing the ifdefs?
> at least you won't be adding an ifdef and if(cpu_xx)

Thanks Omar for the comment. I have received multiple comments on this new #ifdef. So, have sent out a new cleaner patch removing this.

Regards
Suman
