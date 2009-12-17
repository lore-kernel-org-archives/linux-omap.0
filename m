From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] OMAP: I2C: Add mpu wake up latency constraint in i2c
Date: Thu, 17 Dec 2009 17:36:28 +0100
Message-ID: <20091217173628.306a378b@hyperion.delvare>
References: <1259172229-25386-1-git-send-email-kalle.jokiniemi@nokia.com>
	<E839BB5467CE1640B3CC2F90F647A52C274A0E73AB@NOK-EUMSG-02.mgdnok.nokia.com>
	<alpine.DEB.2.00.0911300023120.17083@utopia.booyaka.com>
	<E839BB5467CE1640B3CC2F90F647A52C274B07929A@NOK-EUMSG-02.mgdnok.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <E839BB5467CE1640B3CC2F90F647A52C274B07929A-xJW1crHCIS+8kqYwC468Frtp2NbXvJi8gfoxzgwHRXE@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: kalle.jokiniemi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, peter.ujfalusi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org, jouni.hogander-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org, khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org, kalle.jokiniemi-sMOQStClEysAvxtiuMwx3w@public.gmane.org, m-sonasath-l0cyMroinI0@public.gmane.org, jhnikula-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, nm-l0cyMroinI0@public.gmane.org, paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Thu, 17 Dec 2009 16:18:24 +0100, kalle.jokiniemi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org wrote:
> Hi Jean,
> 
> > -----Original Message-----
> > From: Jokiniemi Kalle (Nokia-D/Tampere) 
> > Sent: 11. joulukuuta 2009 12:47
> > To: 'ext Paul Walmsley'; ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org
> > Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; 
> > Ujfalusi Peter (Nokia-D/Tampere); Hogander Jouni 
> > (Nokia-D/Tampere); khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org; 
> > kalle.jokiniemi-sMOQStClEysAvxtiuMwx3w@public.gmane.org; m-sonasath-l0cyMroinI0@public.gmane.org; 
> > jhnikula-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org; nm-l0cyMroinI0@public.gmane.org
> > Subject: RE: [PATCH] OMAP: I2C: Add mpu wake up latency 
> > constraint in i2c
> > 
> > Hi Ben,
> > 
> > What's the status on this one? Have you had time to check it out?
> > 
> > - Kalle
> > 
> > 
> > > -----Original Message-----
> > > From: ext Paul Walmsley [mailto:paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org]
> > > Sent: 30. marraskuuta 2009 9:24
> > > To: Jokiniemi Kalle (Nokia-D/Tampere)
> > > Cc: ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org; linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; 
> > > linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; Ujfalusi Peter 
> > (Nokia-D/Tampere); Hogander 
> > > Jouni (Nokia-D/Tampere); khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org; 
> > > kalle.jokiniemi-sMOQStClEysAvxtiuMwx3w@public.gmane.org; m-sonasath-l0cyMroinI0@public.gmane.org; jhnikula-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org; 
> > > nm-l0cyMroinI0@public.gmane.org
> > > Subject: RE: [PATCH] OMAP: I2C: Add mpu wake up latency 
> > constraint in 
> > > i2c
> > > 
> > > Hi Ben, Kalle,
> > > 
> > > On Thu, 26 Nov 2009, kalle.jokiniemi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org wrote:
> > > 
> > > > Could you take this patch to i2c tree? The patch has been
> > > discussed in linux-omap list, and this version was the one that was 
> > > agreed to pushed forward.
> 
> 
> Ben is bit unresponsive about my patch. Would you Jean be the current linux-i2c maintainer?

Only for the core and PC drivers. Not platform drivers.

> Could you take my patch in?

Not really. Either wait for Ben to respond, or push the patch through
the OMAP tree. If this really doesn't work, you might try Andrew Morton.

-- 
Jean Delvare
