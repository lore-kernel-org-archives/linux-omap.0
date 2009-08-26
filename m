From: "Gupta, Ajay Kumar" <ajay.gupta-l0cyMroinI0@public.gmane.org>
Subject: RE: [PATCH] usb: disable OTG AUTOIDLE only with omap3430
Date: Wed, 26 Aug 2009 17:17:28 +0530
Message-ID: <19F8576C6E063C45BE387C64729E73940436A4A15B@dbde02.ent.ti.com>
References: <1242658456-5723-1-git-send-email-ext-niilo.1.minkkinen@nokia.com>
 <13B9B4C6EF24D648824FF11BE8967162038BED5CF1@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <13B9B4C6EF24D648824FF11BE8967162038BED5CF1-EovWT4A8QTWIQmiDNMet8wC/G2K4zDHf@public.gmane.org>
Content-Language: en-US
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Woodruff, Richard" <r-woodruff2-l0cyMroinI0@public.gmane.org>, Niilo Minkkinen <ext-niilo.1.minkkinen-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org" <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

> -----Original Message-----
> From: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org [mailto:linux-usb-
> owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org] On Behalf Of Woodruff, Richard
> Sent: Tuesday, May 19, 2009 12:53 AM
> To: Niilo Minkkinen; linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org
> Subject: RE: [PATCH] usb: disable OTG AUTOIDLE only with omap3430
> 
> 
> > From: linux-omap-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org [mailto:linux-omap-
> > owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org] On Behalf Of Niilo Minkkinen
> > Sent: Monday, May 18, 2009 9:54 AM
> 
> > Omap3 MUSB AUTOIDLE functionality configured through OTG_SYSCONFIG
> > register prevents the device from going into retention.
> > This is a workaround (by Richard Woodruff/TI), as his comment :
> > > A new MUSB bug which is a match to data below was identified very
> > > recently (on hardware and in simulation).
> > > This bug is in 3430 and not 3630.
> > > As a priority test (and as new default) you should have engineers
> > > disable autoidle for MUSB block.
> > > This is the workaround which will show up in next errata.
> >
> > Signed-off-by: Niilo Minkkinen <ext-niilo.1.minkkinen-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
> 
> Signed-off-by: Richard Woodruff <r-woodruff2-l0cyMroinI0@public.gmane.org>
> 
> Yes this is needed for 34xx. Side note is this cost around 1mW of power
> during active mode of MUSB. When device is not active cost is not
> significant.  System impact depends on duty cycle of MUSB in usecase.

Richard/Niilo,
	This should also be applicable to 35xx (right?)  and so we got to 
update the fix with below patch.

Regards,
Ajay

========== patch =========================
There is an issue with MUSB AUTOIDLE as reported by Niilo Minkkinen in below commit.

9a4b5e36ce58febdd2039dd4d129ee7edf4f5536
usb: musb: disable OTG AUTOIDLE only with omap3430

As OMAP35x is just a variant of OMAP34xx chip thus the fix is also applicable for OMAP35x so updating it for OMAP35x.

Signed-off-by: Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
---
 drivers/usb/musb/omap2430.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/usb/musb/omap2430.c b/drivers/usb/musb/omap2430.c index 453796c..ab8336d 100644
--- a/drivers/usb/musb/omap2430.c
+++ b/drivers/usb/musb/omap2430.c
@@ -233,7 +233,7 @@ int __init musb_platform_init(struct musb *musb)
 	 * MUSB AUTOIDLE don't work in 3430.
 	 * Workaround by Richard Woodruff/TI
 	 */
-	if (!cpu_is_omap3430())
+	if (!cpu_is_omap3430() && !cpu_is_omap35xx())
 		l |= AUTOIDLE;		/* enable auto idle */
 	omap_writel(l, OTG_SYSCONFIG);
 
--
1.6.2.4
==============================================

> 
> Regards,
> Richard W.
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-usb" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
