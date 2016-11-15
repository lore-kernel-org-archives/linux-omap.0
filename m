From: Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH] usb: musb: omap2430: make complain on -EPROBE_DEFER
 dev_dbg
Date: Tue, 15 Nov 2016 15:13:31 -0600
Message-ID: <20161115211331.GD11011@uda0271908>
References: <20161109141026.GF20859@localhost.localdomain>
 <20161109174847.GY2428@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20161109174847.GY2428-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Ladislav Michl <ladis-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Wed, Nov 09, 2016 at 10:48:48AM -0700, Tony Lindgren wrote:
> * Ladislav Michl <ladis-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org> [161109 07:11]:
> > There is no point having this complaint to be dev_err as it is just adding
> > noise to bootlog.
> 
> Acked-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>

Applied. Thanks.
-Bin.

> 
> > Signed-off-by: Ladislav Michl <ladis-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>
> > ---
> >  drivers/usb/musb/omap2430.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/usb/musb/omap2430.c b/drivers/usb/musb/omap2430.c
> > index 451b372..7c9aa5e 100644
> > --- a/drivers/usb/musb/omap2430.c
> > +++ b/drivers/usb/musb/omap2430.c
> > @@ -277,7 +277,7 @@ static int omap2430_musb_init(struct musb *musb)
> >  		if (status == -ENXIO)
> >  			return status;
> >  
> > -		dev_err(dev, "HS USB OTG: no transceiver configured\n");
> > +		dev_dbg(dev, "HS USB OTG: no transceiver configured\n");
> >  		return -EPROBE_DEFER;
> >  	}
> >  
> > -- 
> > 2.1.4
> > 
> > 
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
