From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 1/5] usb: phy: twl4030-usb: Remove unused irq_enabled
Date: Thu, 28 Aug 2014 11:14:57 -0700
Message-ID: <20140828181457.GK16006@atomide.com>
References: <1409182091-31191-1-git-send-email-tony@atomide.com>
 <1409182091-31191-2-git-send-email-tony@atomide.com>
 <20140828022051.GB5273@saruman.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140828022051.GB5273-HgARHv6XitL9zxVx7UNMDg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Cc: kishon-l0cyMroinI0@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org> [140827 19:21]:
> Hi,
> 
> On Wed, Aug 27, 2014 at 04:28:07PM -0700, Tony Lindgren wrote:
> > It's not being used any longer.
> > 
> > Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
> > ---
> >  drivers/phy/phy-twl4030-usb.c     | 2 --
> >  drivers/usb/phy/phy-twl6030-usb.c | 2 --
> >  2 files changed, 4 deletions(-)
> > 
> > diff --git a/drivers/phy/phy-twl4030-usb.c b/drivers/phy/phy-twl4030-usb.c
> > index 9cd33a4..bc28ecc 100644
> > --- a/drivers/phy/phy-twl4030-usb.c
> > +++ b/drivers/phy/phy-twl4030-usb.c
> > @@ -164,7 +164,6 @@ struct twl4030_usb {
> >  	enum omap_musb_vbus_id_status linkstat;
> >  	bool			vbus_supplied;
> >  	u8			asleep;
> > -	bool			irq_enabled;
> >  
> >  	struct delayed_work	id_workaround_work;
> >  };
> > @@ -755,7 +754,6 @@ static int twl4030_usb_probe(struct platform_device *pdev)
> >  	 * set_host() and/or set_peripheral() ... OTG_capable boards
> >  	 * need both handles, otherwise just one suffices.
> >  	 */
> > -	twl->irq_enabled = true;
> >  	status = devm_request_threaded_irq(twl->dev, twl->irq, NULL,
> >  			twl4030_usb_irq, IRQF_TRIGGER_FALLING |
> >  			IRQF_TRIGGER_RISING | IRQF_ONESHOT, "twl4030_usb", twl);
> 
> can you split this into two patches ? drivers/phy will be taken by
> Kishon and drivers/usb/phy by me. another possibility is that I get an
> Acked-by from Kishon and I can take $subject as is.

Oops yes sorry I already forgot I'm patching twl6030 too. Below
is the updated version of this patch for Kishon with just the
twl4030 changes. I will post the twl6030 changes separately.

Regards,

Tony

8< ---------------------
From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Date: Mon, 18 Aug 2014 07:54:16 -0700
Subject: [PATCH] usb: phy: twl4030-usb: Remove unused irq_enabled

It's not being used any longer.

Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>

--- a/drivers/phy/phy-twl4030-usb.c
+++ b/drivers/phy/phy-twl4030-usb.c
@@ -164,7 +164,6 @@ struct twl4030_usb {
 	enum omap_musb_vbus_id_status linkstat;
 	bool			vbus_supplied;
 	u8			asleep;
-	bool			irq_enabled;
 
 	struct delayed_work	id_workaround_work;
 };
@@ -755,7 +754,6 @@ static int twl4030_usb_probe(struct platform_device *pdev)
 	 * set_host() and/or set_peripheral() ... OTG_capable boards
 	 * need both handles, otherwise just one suffices.
 	 */
-	twl->irq_enabled = true;
 	status = devm_request_threaded_irq(twl->dev, twl->irq, NULL,
 			twl4030_usb_irq, IRQF_TRIGGER_FALLING |
 			IRQF_TRIGGER_RISING | IRQF_ONESHOT, "twl4030_usb", twl);
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
