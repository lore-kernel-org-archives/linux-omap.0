From: "Sonasath, Moiz" <m-sonasath@ti.com>
Subject: RE: [PATCH RESEND] I2C: OMAP: Add missing wakeup events
Date: Tue, 13 Oct 2009 17:12:31 -0500
Message-ID: <CD8CC2B65FEE304DA95744A5472698F2029E37245F@dlee06.ent.ti.com>
References: <1255342885-15786-1-git-send-email-aaro.koskinen@nokia.com>
 <CD8CC2B65FEE304DA95744A5472698F2029E37200E@dlee06.ent.ti.com>
 <4AD44DD0.7000708@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:48672 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753823AbZJMWN2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 13 Oct 2009 18:13:28 -0400
In-Reply-To: <4AD44DD0.7000708@nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Aaro Koskinen <aaro.koskinen@nokia.com>
Cc: "ben-linux@fluff.org" <ben-linux@fluff.org>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hello Aaro!

> -----Original Message-----
> From: Aaro Koskinen [mailto:aaro.koskinen@nokia.com]
> Sent: Tuesday, October 13, 2009 4:52 AM
> To: Sonasath, Moiz
> Cc: ben-linux@fluff.org; linux-i2c@vger.kernel.org; linux-
> omap@vger.kernel.org
> Subject: Re: [PATCH RESEND] I2C: OMAP: Add missing wakeup events
> 
> Hello,
> 
> Sonasath, Moiz wrote:
> >> From: Jagadeesh Bhaskar Pakaravoor <j-pakaravoor@ti.com>
> >>
> >> Include wake up events for receiver overflow and transmitter
> >> underflow in OMAP_I2C_WE_REG configuration. Also fix a small
> >> typo.
> >>
> >> Signed-off-by: Jagadeesh Bhaskar Pakaravoor <j-pakaravoor@ti.com>
> >> Signed-off-by: Aaro Koskinen <aaro.koskinen@nokia.com>
> >> ---
> >>  drivers/i2c/busses/i2c-omap.c |    5 ++++-
> >>  1 files changed, 4 insertions(+), 1 deletions(-)
> >>
> >> diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-
> omap.c
> >> index 827da08..34ea9ed 100644
> >> --- a/drivers/i2c/busses/i2c-omap.c
> >> +++ b/drivers/i2c/busses/i2c-omap.c
> >> @@ -92,8 +92,10 @@
> >>  #define OMAP_I2C_STAT_AL	(1 << 0)	/* Arbitration lost int ena */
> >>
> >>  /* I2C WE wakeup enable register */
> >> -#define OMAP_I2C_WE_XDR_WE	(1 << 14)	/* TX drain wakup */
> >> +#define OMAP_I2C_WE_XDR_WE	(1 << 14)	/* TX drain wakeup */
> >>  #define OMAP_I2C_WE_RDR_WE	(1 << 13)	/* RX drain wakeup */
> >> +#define OMAP_I2C_WE_ROVR_WE	(1 << 11)	/* RX overflow wakeup */
> >> +#define OMAP_I2C_WE_XUDF_WE	(1 << 10)	/* TX underflow wakeup */
> >
> > These bits are not documented in OMAP3430, they are reserved. How can
> they be used?
> 
> Hmm, that's a valid point. I will have to check if I can find more info on
> the background of this patch.

AFAIK, these bits have been introduced in OMAP3630 as it has a new IP block for I2C. But these bits are reserved bits for OMAP3430.

> 
> A.

