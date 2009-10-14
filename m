From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: [PATCH RESEND] I2C: OMAP: Add missing wakeup events
Date: Wed, 14 Oct 2009 08:25:42 -0500
Message-ID: <13B9B4C6EF24D648824FF11BE8967162039B235CF9@dlee02.ent.ti.com>
References: <1255342885-15786-1-git-send-email-aaro.koskinen@nokia.com>
 <CD8CC2B65FEE304DA95744A5472698F2029E37200E@dlee06.ent.ti.com>
 <4AD44DD0.7000708@nokia.com>
 <CD8CC2B65FEE304DA95744A5472698F2029E37245F@dlee06.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:58827 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756521AbZJNN0e convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 14 Oct 2009 09:26:34 -0400
In-Reply-To: <CD8CC2B65FEE304DA95744A5472698F2029E37245F@dlee06.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Sonasath, Moiz" <m-sonasath@ti.com>, Aaro Koskinen <aaro.koskinen@nokia.com>
Cc: "ben-linux@fluff.org" <ben-linux@fluff.org>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> > >>  /* I2C WE wakeup enable register */
> > >> -#define OMAP_I2C_WE_XDR_WE      (1 << 14)       /* TX drain wakup */
> > >> +#define OMAP_I2C_WE_XDR_WE      (1 << 14)       /* TX drain wakeup */
> > >>  #define OMAP_I2C_WE_RDR_WE      (1 << 13)       /* RX drain wakeup */
> > >> +#define OMAP_I2C_WE_ROVR_WE     (1 << 11)       /* RX overflow wakeup */
> > >> +#define OMAP_I2C_WE_XUDF_WE     (1 << 10)       /* TX underflow wakeup */
> > >
> > > These bits are not documented in OMAP3430, they are reserved. How can
> > they be used?
> >
> > Hmm, that's a valid point. I will have to check if I can find more info on
> > the background of this patch.
>
> AFAIK, these bits have been introduced in OMAP3630 as it has a new IP block
> for I2C. But these bits are reserved bits for OMAP3430.

Couple notes:
        - IP block is updated but it is not new.  These should just be some reserved bits converted.  New bits expand wakeup capability and enhance FIFO operation with DMA.

        - Driver for a while supported OMAP1/2420 style I2C and OMAP2430/3/4 style I2C.  Definitions between broad class drivers are different.  The interrupt handler is easiest to see this.  This is not so relevant to above bits but is good to keep in mind.

Regards,
Richard W.

