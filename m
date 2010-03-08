From: "Aguirre, Sergio" <saaguirre@ti.com>
Subject: RE: [RFC part1/2 merge v2 RESEND][PATCH 01/10] OMAP3: serial: Check
 for zero-based physical addr
Date: Mon, 8 Mar 2010 14:28:21 -0600
Message-ID: <A24693684029E5489D1D202277BE894453E4CF84@dlee02.ent.ti.com>
References: <1268069332-14082-1-git-send-email-saaguirre@ti.com>
 <1268069332-14082-2-git-send-email-saaguirre@ti.com>
 <20100308182443.GD6630@gandalf>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:34418 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753798Ab0CHU2c convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 8 Mar 2010 15:28:32 -0500
In-Reply-To: <20100308182443.GD6630@gandalf>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "me@felipebalbi.com" <me@felipebalbi.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Kevin Hilman <khilman@deeprootsystems.com>, "Pandita, Vikram" <vikram.pandita@ti.com>, Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>



> -----Original Message-----
> From: Felipe Balbi [mailto:me@felipebalbi.com]
> Sent: Monday, March 08, 2010 12:25 PM
> To: Aguirre, Sergio
> Cc: linux-omap@vger.kernel.org; Kevin Hilman; Pandita, Vikram; Paul
> Walmsley; Tony Lindgren
> Subject: Re: [RFC part1/2 merge v2 RESEND][PATCH 01/10] OMAP3: serial:
> Check for zero-based physical addr
> 
> On Mon, Mar 08, 2010 at 11:28:43AM -0600, Sergio Aguirre wrote:
> > @@ -727,6 +733,10 @@ void __init omap_serial_init_port(int port)
> >  	pdev = &uart->pdev;
> >  	dev = &pdev->dev;
> >
> > +	/* Don't proceed if there's no clocks available */
> > +	if (!uart->ick || !uart->fck)
> > +		return;
> 
> with that loop getting the clocks I would expect this not to happen. If
> it happens, then I would guess it deserves a
> BUG_ON(!uart->ick || !uart->fck)

Yeah, makes sense.

Will fix.

Thanks,
Sergio

> 
> --
> balbi
