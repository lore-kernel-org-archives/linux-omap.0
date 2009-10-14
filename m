From: "Varadarajan, Charu Latha" <charu@ti.com>
Subject: RE: [PATCH] OMAP3: Fix McBSP poll read and write for 32bit reg
 access
Date: Wed, 14 Oct 2009 16:31:34 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02BA31ADB5@dbde02.ent.ti.com>
References: <E0D41E29EB0DAC4E9F3FF173962E9E940253DAF770@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:54726 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755260AbZJNLDu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 14 Oct 2009 07:03:50 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id n9EB3B6V029090
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Wed, 14 Oct 2009 06:03:13 -0500
In-Reply-To: <E0D41E29EB0DAC4E9F3FF173962E9E940253DAF770@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "G, Manjunath Kondaiah" <manjugk@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Syed, Rafiuddin" <rafiuddin.syed@ti.com>

> -----Original Message-----
> From: G, Manjunath Kondaiah
> Sent: Wednesday, October 14, 2009 4:01 PM
> To: 'vimal singh'; Varadarajan, Charu Latha
> Cc: linux-omap@vger.kernel.org; Syed, Rafiuddin
> Subject: RE: [PATCH] OMAP3: Fix McBSP poll read and write for
> 32bit reg access
>
>
>
> > -----Original Message-----
> > From: linux-omap-owner@vger.kernel.org
> > [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of vimal singh
> > Sent: Wednesday, October 14, 2009 3:23 PM
> > To: Varadarajan, Charu Latha
> > Cc: linux-omap@vger.kernel.org; Syed, Rafiuddin
> > Subject: Re: [PATCH] OMAP3: Fix McBSP poll read and write for
> > 32bit reg access
>
> > >
> > >        base = mcbsp->io_base;
> > >        /* if frame sync error - clear the error */
> > > -       if (readw(base + OMAP_MCBSP_REG_SPCR1) & RSYNC_ERR) {
> > > +       if (OMAP_MCBSP_READ(base, SPCR1) & RSYNC_ERR) {
> > >                /* clear error */
> > > -               writew(readw(base + OMAP_MCBSP_REG_SPCR1) &
> > (~RSYNC_ERR),
> > > -                      base + OMAP_MCBSP_REG_SPCR1);
> > > +               OMAP_MCBSP_WRITE(base, SPCR1,
> > OMAP_MCBSP_READ(base, SPCR1)
> > > +                                       & (~RSYNC_ERR));
> > >                /* resend */
> > >                return -1;
>
> Return value can be a meaningful macro with proper value?
>
> > >        } else {
> > >                /* wait for recieve confirmation */
> > >                int attemps = 0;
> > > -               while (!(readw(base + OMAP_MCBSP_REG_SPCR1)
> > & RRDY)) {
> > > -                       if (attemps++ > 1000) {
> > > -                               writew(readw(base +
> > OMAP_MCBSP_REG_SPCR1) &
> > > -                                      (~RRST),
> > > -                                      base +
> OMAP_MCBSP_REG_SPCR1);
> > > +               while (!(OMAP_MCBSP_READ(base, SPCR1) & RRDY)) {
> > > +                       if (attemps++ > 10000) {
> > > +                               OMAP_MCBSP_WRITE(base, SPCR1,
> > > +
>
> Why attemps changed from 1000 to 10000?
Ooops.. That's a typo, but critical error. Will do the needful.
>
> -Manjunath
>
>
