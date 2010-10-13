From: "Premi, Sanjeev" <premi-l0cyMroinI0@public.gmane.org>
Subject: RE: [WL1271 DC support on OMAP3EVM 2/5] ARM: Supported for Standard
 SDIO driver on OMAP3EVM for WL1271 DC
Date: Wed, 13 Oct 2010 18:31:18 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB5930234405CB8@dbde02.ent.ti.com>
References: <B85A65D85D7EB246BE421B3FB0FBB5930234405BCA@dbde02.ent.ti.com>
 <2615178032399077084343141213216@psmtp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <2615178032399077084343141213216-w9+Jh5EvMMwAvxtiuMwx3w@public.gmane.org>
Content-Language: en-US
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sanjay Kumar Champati <csanjay-EvXpCiN+lbve9wHmmfpqLFaTQe2KTcn/@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: "linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

> -----Original Message-----
> From: Sanjay Kumar Champati [mailto:csanjay-EvXpCiN+lbve9wHmmfpqLFaTQe2KTcn/@public.gmane.org] 
> Sent: Wednesday, October 13, 2010 5:50 PM
> To: Premi, Sanjeev; linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> Cc: linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> Subject: RE: [WL1271 DC support on OMAP3EVM 2/5] ARM: 
> Supported for Standard SDIO driver on OMAP3EVM for WL1271 DC
> 
[snip]...[snip]

> > > diff --git a/drivers/mmc/core/sdio_ops.c 
> b/drivers/mmc/core/sdio_ops.c
> > > index 4eb7825..4213ee0 100644
> > > --- a/drivers/mmc/core/sdio_ops.c
> > > +++ b/drivers/mmc/core/sdio_ops.c
> > > @@ -114,6 +114,9 @@ int mmc_io_rw_direct(struct mmc_card
> > > *card, int write, unsigned fn,
> > >
> > >  	return 0;
> > >  }
> > > +#ifdef CONFIG_WL1271_WLAN
> > > +EXPORT_SYMBOL(mmc_io_rw_direct);
> > > +#endif
> > 
> > [sp] Why is the export required?
> For the standard SDIO support WL1271 driver is using 
> "mmc_io_rw_direct".
> > 
> > >
> > >  int mmc_io_rw_extended(struct mmc_card *card, int write, 
> unsigned fn,
> > >  	unsigned addr, int incr_addr, u8 *buf, unsigned blocks,
> > > unsigned blksz)
> > > @@ -181,4 +184,6 @@ int mmc_io_rw_extended(struct mmc_card
> > > *card, int write, unsigned fn,
> > >
> > >  	return 0;
> > >  }
> > > -
> > > +#ifdef CONFIG_WL1271_WLAN
> > > +EXPORT_SYMBOL(mmc_io_rw_extended);
> > > +#endif
> > 
> > [sp] Why is the export required?
> For the standard SDIO support WL1271 driver is using 
> "mmc_io_rw_extended".
> > 

[sp] part of my question is: Why do you need to modify the
     generic sdio implementation to export these functions?

     You cannot make "custom" modifications here. See similar
     comment in other patch as well.

[snip]...[snip]
--
To unsubscribe from this list: send the line "unsubscribe linux-wireless" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
