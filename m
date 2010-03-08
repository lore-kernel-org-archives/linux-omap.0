From: "Aguirre, Sergio" <saaguirre@ti.com>
Subject: RE: [RFC part1/2 merge][PATCH 06/10] omap3: serial: Fix uart4
 handling for 3630
Date: Mon, 8 Mar 2010 10:44:16 -0600
Message-ID: <A24693684029E5489D1D202277BE894453D68DC8@dlee02.ent.ti.com>
References: <1267625925-22616-1-git-send-email-saaguirre@ti.com>
	<1267625925-22616-7-git-send-email-saaguirre@ti.com>
 <87sk8ez96n.fsf@deeprootsystems.com>
 <A24693684029E5489D1D202277BE894453D6866B@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:36893 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755463Ab0CHQoY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 8 Mar 2010 11:44:24 -0500
In-Reply-To: <A24693684029E5489D1D202277BE894453D6866B@dlee02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Aguirre, Sergio" <saaguirre@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>



> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Aguirre, Sergio
> Sent: Friday, March 05, 2010 5:12 PM
> To: Kevin Hilman
> Cc: linux-omap@vger.kernel.org
> Subject: RE: [RFC part1/2 merge][PATCH 06/10] omap3: serial: Fix uart4
> handling for 3630
> 
> 
> From: Kevin Hilman [mailto:khilman@deeprootsystems.com]
> Sent: Friday, March 05, 2010 4:38 PM
> 
> <snip>
> 
> > > @@ -694,6 +698,10 @@ void __init omap_serial_early_init(void)
> > >
> > >  		if (cpu_is_omap44xx())
> > >  			p->irq += 32;
> > > +
> > > +		/* IRQ for UART4 in omap3630 is 80 */
> > > +		if (cpu_is_omap3630() && (i == 3))
> > > +			p->irq = 80;
> >
> > Should add a symbolic name to irqs.h and use it here, instead
> > of hard-coded constant.
> 
> Sounds like a nice idea! Thanks!
> 
> I'll update the patchset and resend.

Actually, I have been thinking on a patch to remove all magic numbering, also for OMAP4... I'll think about it and include it in the next version.

Regards,
Sergio

> 
> Regards,
> Sergio
> >
> > Kevin
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
