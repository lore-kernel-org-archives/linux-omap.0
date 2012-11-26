From: wfp5p-A/mCt7huS1Rvw44tLj6iNJvpjmsXDcsSh13vi7wywA4@public.gmane.org (Bill Pemberton)
Subject: Re: [PATCH 065/493] i2c: remove use of __devexit_p
Date: Mon, 26 Nov 2012 08:52:18 -0500
Message-ID: <20121126135218.45F6780157@viridian.itc.virginia.edu>
References: <20121122214915.GD14851@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20121122214915.GD14851-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Rudolf Marek <r.marek-/xGekIyIa4Ap1Coe8Ar9gA@public.gmane.org>, Jochen Friedrich <jochen-NIgtFMG+Po8@public.gmane.org>, Peter Korsgaard <jacmet-OfajU3CKLf1/SzgSGea1oA@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>, Vitaly Wool <vitalywool-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Guan Xuetao <gxt-TG0Ac1+ktVePQbnJrJN+5g@public.gmane.org>, Barry Song <baohua.song-kQvG35nSl+M@public.gmane.org>, "Mark M. Hoffman" <mhoffman-xQSgfq/1h4JiLUuM0BA3LQ@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Wolfram Sang writes:
> 
> 
> --osDK9TLjxFScVI/L
> Content-Type: text/plain; charset=us-ascii
> Content-Disposition: inline
> Content-Transfer-Encoding: quoted-printable
> 
> On Tue, Nov 20, 2012 at 02:46:21PM +0100, Jean Delvare wrote:
> > On Mon, 19 Nov 2012 13:20:14 -0500, Bill Pemberton wrote:
> > > CONFIG_HOTPLUG is going away as an option so __devexit_p is no longer
> > > needed.
> >=20
> > As mentioned on the lm-sensors list for hwmon patches already, I think
> > it would be much clearer to not split __devexit, __devexit_p, __devinit
> > etc. removal into separate patches. One patch per subsystem would be
> > easier to review and apply. If patches grow too large then you'd rather
> > split in a different direction, for example drivers/i2c/muxes vs.
> > drivers/i2c/busses or even grouped by related bus drivers (see entries
> > "I2C OVER PARALLEL PORT" and "I2C/SMBUS CONTROLLER DRIVERS FOR PC" in
> > MAINTAINERS for examples of meaningful groups.)
> 
> I agree with Jean here. Is there a V2 planned? With a change like this?
> 

Yes, my plan is to redo the patches for the i2c subsystem.

-- 
Bill
