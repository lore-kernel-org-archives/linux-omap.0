From: Luciano Coelho <coelho-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 3.3 v2] I2C: OMAP: fix build breakage when CONFIG_OF is
 not set
Date: Tue, 14 Feb 2012 11:55:31 +0200
Message-ID: <1329213331.3032.62.camel@cumari>
References: <1328699901-19488-1-git-send-email-coelho@ti.com>
	 <20120213232707.GH2999@freya.fluff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120213232707.GH2999-RazCHl0VsYgkUSuvROHNpA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Benoit Cousson <b-cousson-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi Ben,

On Mon, 2012-02-13 at 23:27 +0000, Ben Dooks wrote: 
> On Wed, Feb 08, 2012 at 01:18:21PM +0200, Luciano Coelho wrote:
> > diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
> > index f713eac..fd200eb 100644
> > --- a/drivers/i2c/busses/i2c-omap.c
> > +++ b/drivers/i2c/busses/i2c-omap.c
> > @@ -979,6 +979,8 @@ static const struct of_device_id omap_i2c_of_match[] = {
> >  	{ },
> >  };
> >  MODULE_DEVICE_TABLE(of, omap_i2c_of_match);
> > +#else
> > +static const struct of_device_id *omap_i2c_of_match = NULL;
> >  #endif
> 
> of_match_ptr(_ptr) will go to NULL if CONFIG_OF is not set, use that please.

Yes, you're right.  But this patch can be ignored, since there was
already an equivalent one queued up (which I missed).  And it uses
of_match_ptr() ;)

Thanks for your comment anyway!

-- 
Cheers,
Luca.
