From: <kalle.jokiniemi@nokia.com>
Subject: RE: [PATCH V4 3/3] OMAP: I2C: Add mpu wake up latency constraint	in
 i2c
Date: Tue, 24 Nov 2009 16:19:00 +0100
Message-ID: <E839BB5467CE1640B3CC2F90F647A52C274A095246@NOK-EUMSG-02.mgdnok.nokia.com>
References: <> <1256125881-12441-1-git-send-email-kalle.jokiniemi@digia.com>
	 <1256125881-12441-2-git-send-email-kalle.jokiniemi@digia.com>
	 <1256125881-12441-3-git-send-email-kalle.jokiniemi@digia.com>
	 <1256125881-12441-4-git-send-email-kalle.jokiniemi@digia.com>
	 <CD8CC2B65FEE304DA95744A5472698F2029E427B04@dlee06.ent.ti.com>
 <1256644921.6751.61.camel@ubuntu>
 <CD8CC2B65FEE304DA95744A5472698F2029E75531B@dlee06.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:52424 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756848AbZKXPTe convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 24 Nov 2009 10:19:34 -0500
In-Reply-To: <CD8CC2B65FEE304DA95744A5472698F2029E75531B@dlee06.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: m-sonasath@ti.com, khilman@deeprootsystems.com
Cc: linux-omap@vger.kernel.org, jhnikula@gmail.com, paul@pwsan.com, nm@ti.com, vikram.pandita@ti.com, jouni.hogander@nokia.com


Hi,


> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org 
> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of ext 
> Sonasath, Moiz
> Sent: 23. marraskuuta 2009 18:10
> To: Kalle Jokiniemi
> Cc: khilman@deeprootsystems.com; linux-omap@vger.kernel.org; 
> Jarkko Nikula; Paul Walmsley; Menon, Nishanth; Pandita, 
> Vikram; Hogander Jouni (Nokia-D/Tampere)
> Subject: RE: [PATCH V4 3/3] OMAP: I2C: Add mpu wake up 
> latency constraint in i2c
> 

<<snip-snip>>

> > 
> > Well, I don't completely agree with the necessity of preparing for 
> > different rx/tx thresholds. For this to make sense, the i2c-omap 
> > driver should first separate in it's code the use of rx and tx 
> > thresholds. If someone is planning to do that, he/she should anyway 
> > update the usage of fifo_size throughout the code, 
> including the wake up latency setting.
> > 
> > Anyways, attached a patch that separates the mpu wake up 
> latencies for 
> > rx and tx. In case that is needed. Though I'm not for it, since it 
> > adds unneeded complexity.
> > 
> 
> Yes Kalle, you are right! Not having different RX/TX wake-up 
> latencies will absolutely work fine with the in-place code as 
> we have both the RX/TX thresholds same.

Great :)

> But, I think in 
> future we might have to play around with different RX/TX 
> thresholds and so from a conceptually right and generic point 
> of view it makes sense to incur the cost of the added complexity.

I agree. Once someone differentiates the thresholds in the driver, it very much makes sense to also calculate different mpu wake up latencies for RX and TX.

> 
> The patch V4 looks perfect to me :)

Great :)

So, where do we push it?

- Kalle


> 
> - Moiz
>  
> > - Kalle
> > 
> > >
> > > >
> > > >  	/* reset ASAP, clearing any IRQs */ diff --git 
> > > > a/include/linux/i2c-omap.h b/include/linux/i2c-omap.h new file 
> > > > mode 100644 index 0000000..1362fba
> > > > --- /dev/null
> > > > +++ b/include/linux/i2c-omap.h
> > > > @@ -0,0 +1,9 @@
> > > > +#ifndef __I2C_OMAP_H__
> > > > +#define __I2C_OMAP_H__
> > > > +
> > > > +struct omap_i2c_bus_platform_data {
> > > > +	u32		clkrate;
> > > > +	void		(*set_mpu_wkup_lat)(struct 
> device *dev, int set);
> > > > +};
> > > > +
> > > > +#endif
> > > > --
> > > > 1.5.4.3
> > >
> > > Regards
> > > Moiz Sonasath
> > >
> --
> To unsubscribe from this list: send the line "unsubscribe 
> linux-omap" in the body of a message to 
> majordomo@vger.kernel.org More majordomo info at  
> http://vger.kernel.org/majordomo-info.html
> 