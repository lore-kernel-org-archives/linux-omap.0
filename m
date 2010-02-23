From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Subject: [PATCH]  OMAP: McBSP: Drop unnecessary status/error bit clearing on reg_cache retrieved register values
Date: Tue, 23 Feb 2010 16:50:38 +0100
Message-ID: <201002231650.40351.jkrzyszt@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from d1.icnet.pl ([212.160.220.21]:39424 "EHLO d1.icnet.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753186Ab0BWPuG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 23 Feb 2010 10:50:06 -0500
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Cc: Jarkko Nikula <jhnikula@gmail.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org

The MsBSP register cache will never have any error/status flags set, si=
nce=20
these flags are never written to the reg_cache. So it is kind of not=20
necessary to clear these flags, which are actually always 0.

In other words, clearing the status/error flags are not necessary, sinc=
e the=20
reg_cache will never got these bits set. We can just write back the=20
register content from the cache as it is when clearing an error conditi=
on.

Created against l-o for-next commit 62a7c2cc4c8e57e80ccf379536f362fe6e8=
63ac3
dated 2010-02-22.
Tested on Amstrad Delta.

Reported-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Signed-off-by: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>

---
=46riday 15 January 2010 10:11:28 Peter Ujfalusi wrote:
> ...
>
> > @@ -653,7 +657,7 @@ int omap_mcbsp_pollwrite(unsigned int id
> >       if (MCBSP_READ(mcbsp, SPCR2) & XSYNC_ERR) {
> >               /* clear error */
> >               MCBSP_WRITE(mcbsp, SPCR2,
> > -                             MCBSP_READ(mcbsp, SPCR2) & (~XSYNC_ER=
R));
> > +                             MCBSP_READ_CACHE(mcbsp, SPCR2) & (~XS=
YNC_ERR));
>
> Well, I think here also, the reg_cache does not have the XSYNC_ERR se=
t, it
> is only set in the McBSP register.

Peter,
Yes, that's right.

> >               /* resend */
> >               return -1;
> >       } else {
> > @@ -662,10 +666,12 @@ int omap_mcbsp_pollwrite(unsigned int id
> >               while (!(MCBSP_READ(mcbsp, SPCR2) & XRDY)) {
> >                       if (attemps++ > 1000) {
> >                               MCBSP_WRITE(mcbsp, SPCR2,
> > -                                         MCBSP_READ(mcbsp, SPCR2) =
& (~XRST));
> > +                                             MCBSP_READ_CACHE(mcbs=
p, SPCR2) &
> > +                                             (~XRST));=20
>
> Also here, the XRST will surely not set in the cached SPCR2...

Probably not. XRST and other xRST flags seem to be controlled by softwa=
re=20
only, and can be actually set by omap_mcbsp_request() to get required=20
functional blocks out of reset state. Here it is toggled back and forth=
, so=20
the code has to reset it explicitly and then set it back again.

> This applies fro all other cases regarding to status/error bits in Mc=
BSP.

You probably managed to point out all applicable cases, since I was not=
 able=20
to find more, neither while examining the code itself nor reviewing the=
=20
SPRU592E reference one more time.=20

> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0udelay(10);
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0MCBSP_WRITE(mcbsp, SPCR2,
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =A0 =A0MCBSP_READ(mcbsp, =
SPCR2) | (XRST));
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0MC=
BSP_READ_CACHE(mcbsp, SPCR2) |
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0(X=
RST));=20
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0udelay(10);
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0dev_err(mcbsp->dev, "Could not write to"
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0" McBSP%d Register\n", mcb=
sp->id);

Thanks,
Janusz

 arch/arm/plat-omap/mcbsp.c |   12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

--- git/arch/arm/plat-omap/mcbsp.c.orig	2010-02-23 11:36:43.000000000 +=
0100
+++ git/arch/arm/plat-omap/mcbsp.c	2010-02-23 16:39:45.000000000 +0100
@@ -133,8 +133,7 @@ static irqreturn_t omap_mcbsp_tx_irq_han
 		dev_err(mcbsp_tx->dev, "TX Frame Sync Error! : 0x%x\n",
 			irqst_spcr2);
 		/* Writing zero to XSYNC_ERR clears the IRQ */
-		MCBSP_WRITE(mcbsp_tx, SPCR2,
-			    MCBSP_READ_CACHE(mcbsp_tx, SPCR2) & ~(XSYNC_ERR));
+		MCBSP_WRITE(mcbsp_tx, SPCR2, MCBSP_READ_CACHE(mcbsp_tx, SPCR2));
 	} else {
 		complete(&mcbsp_tx->tx_irq_completion);
 	}
@@ -154,8 +153,7 @@ static irqreturn_t omap_mcbsp_rx_irq_han
 		dev_err(mcbsp_rx->dev, "RX Frame Sync Error! : 0x%x\n",
 			irqst_spcr1);
 		/* Writing zero to RSYNC_ERR clears the IRQ */
-		MCBSP_WRITE(mcbsp_rx, SPCR1,
-			    MCBSP_READ_CACHE(mcbsp_rx, SPCR1) & ~(RSYNC_ERR));
+		MCBSP_WRITE(mcbsp_rx, SPCR1, MCBSP_READ_CACHE(mcbsp_rx, SPCR1));
 	} else {
 		complete(&mcbsp_rx->tx_irq_completion);
 	}
@@ -934,8 +932,7 @@ int omap_mcbsp_pollwrite(unsigned int id
 	/* if frame sync error - clear the error */
 	if (MCBSP_READ(mcbsp, SPCR2) & XSYNC_ERR) {
 		/* clear error */
-		MCBSP_WRITE(mcbsp, SPCR2,
-				MCBSP_READ_CACHE(mcbsp, SPCR2) & (~XSYNC_ERR));
+		MCBSP_WRITE(mcbsp, SPCR2, MCBSP_READ_CACHE(mcbsp, SPCR2));
 		/* resend */
 		return -1;
 	} else {
@@ -975,8 +972,7 @@ int omap_mcbsp_pollread(unsigned int id,
 	/* if frame sync error - clear the error */
 	if (MCBSP_READ(mcbsp, SPCR1) & RSYNC_ERR) {
 		/* clear error */
-		MCBSP_WRITE(mcbsp, SPCR1,
-				MCBSP_READ_CACHE(mcbsp, SPCR1) & (~RSYNC_ERR));
+		MCBSP_WRITE(mcbsp, SPCR1, MCBSP_READ_CACHE(mcbsp, SPCR1));
 		/* resend */
 		return -1;
 	} else {
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
