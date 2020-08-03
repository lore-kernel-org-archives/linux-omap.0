Return-Path: <SRS0=q+og=BN=vger.kernel.org=linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B26F1C433DF
	for <linux-omap@archiver.kernel.org>; Mon,  3 Aug 2020 19:52:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61B0422CAD
	for <linux-omap@archiver.kernel.org>; Mon,  3 Aug 2020 19:52:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728167AbgHCTwq (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Mon, 3 Aug 2020 15:52:46 -0400
Received: from smtprelay0007.hostedemail.com ([216.40.44.7]:55530 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728069AbgHCTwq (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Mon, 3 Aug 2020 15:52:46 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 8CCEB180A9F23;
        Mon,  3 Aug 2020 19:52:44 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: bath65_48004ae26fa0
X-Filterd-Recvd-Size: 4366
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf18.hostedemail.com (Postfix) with ESMTPA;
        Mon,  3 Aug 2020 19:52:42 +0000 (UTC)
Message-ID: <101585b1d3c2a9db8fe394c51f64115e8bfc1754.camel@perches.com>
Subject: Re: [PATCH][next] fbdev: Use fallthrough pseudo-keyword
From:   Joe Perches <joe@perches.com>
To:     Sam Ravnborg <sam@ravnborg.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Timur Tabi <timur@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Antonino Daplas <adaplas@gmail.com>,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Date:   Mon, 03 Aug 2020 12:52:40 -0700
In-Reply-To: <20200803194024.GA525506@ravnborg.org>
References: <20200707210539.GA12530@embeddedor>
         <20200803194024.GA525506@ravnborg.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.3-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-omap-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

On Mon, 2020-08-03 at 21:41 +0200, Sam Ravnborg wrote:
> On Tue, Jul 07, 2020 at 04:05:39PM -0500, Gustavo A. R. Silva wrote:
> > Replace the existing /* fall through */ comments and its variants with
> > the new pseudo-keyword macro fallthrough[1]. Also, remove unnecessary
> > fall-through markings when it is the case.
> > 
> > [1] https://www.kernel.org/doc/html/latest/process/deprecated.html?highlight=fallthrough#implicit-switch-case-fall-through
> > 
> > Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> 
> Thanks.
> 
> Fixed indent in arcfb.c while applying.
> Applied to drm-misc-next and it will appear in 5.10

Perhaps better would be to fix all the switch / case
brace uses so that it looks more typical kernel style.

> > diff --git a/drivers/video/fbdev/arcfb.c b/drivers/video/fbdev/arcfb.c
> > index 6f7838979f0a..ae3d8e8b8d33 100644
> > --- a/drivers/video/fbdev/arcfb.c
> > +++ b/drivers/video/fbdev/arcfb.c
> > @@ -419,7 +419,7 @@ static int arcfb_ioctl(struct fb_info *info,
> >  			schedule();
> >  			finish_wait(&arcfb_waitq, &wait);
> >  		}
> > -		/* fall through */
> > +			fallthrough;
> >  
> >  		case FBIO_GETCONTROL2:
> >  		{

---
 drivers/video/fbdev/arcfb.c | 52 ++++++++++++++++++++++-----------------------
 1 file changed, 25 insertions(+), 27 deletions(-)

diff --git a/drivers/video/fbdev/arcfb.c b/drivers/video/fbdev/arcfb.c
index 6f7838979f0a..4419655e3e58 100644
--- a/drivers/video/fbdev/arcfb.c
+++ b/drivers/video/fbdev/arcfb.c
@@ -403,35 +403,33 @@ static int arcfb_ioctl(struct fb_info *info,
 	unsigned long flags;
 
 	switch (cmd) {
-		case FBIO_WAITEVENT:
-		{
-			DEFINE_WAIT(wait);
-			/* illegal to wait on arc if no irq will occur */
-			if (!par->irq)
-				return -EINVAL;
-
-			/* wait until the Arc has generated an interrupt
-			 * which will wake us up */
-			spin_lock_irqsave(&par->lock, flags);
-			prepare_to_wait(&arcfb_waitq, &wait,
-					TASK_INTERRUPTIBLE);
-			spin_unlock_irqrestore(&par->lock, flags);
-			schedule();
-			finish_wait(&arcfb_waitq, &wait);
-		}
-		/* fall through */
+	case FBIO_WAITEVENT: {
+		DEFINE_WAIT(wait);
+		/* illegal to wait on arc if no irq will occur */
+		if (!par->irq)
+			return -EINVAL;
 
-		case FBIO_GETCONTROL2:
-		{
-			unsigned char ctl2;
+		/* wait until the Arc has generated an interrupt
+		 * which will wake us up */
+		spin_lock_irqsave(&par->lock, flags);
+		prepare_to_wait(&arcfb_waitq, &wait, TASK_INTERRUPTIBLE);
+		spin_unlock_irqrestore(&par->lock, flags);
+		schedule();
+		finish_wait(&arcfb_waitq, &wait);
+		fallthrough;
+	}
 
-			ctl2 = ks108_readb_ctl2(info->par);
-			if (copy_to_user(argp, &ctl2, sizeof(ctl2)))
-				return -EFAULT;
-			return 0;
-		}
-		default:
-			return -EINVAL;
+	case FBIO_GETCONTROL2: {
+		unsigned char ctl2;
+
+		ctl2 = ks108_readb_ctl2(info->par);
+		if (copy_to_user(argp, &ctl2, sizeof(ctl2)))
+			return -EFAULT;
+		return 0;
+	}
+
+	default:
+		return -EINVAL;
 	}
 }
 


