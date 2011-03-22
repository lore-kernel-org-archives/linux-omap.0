From: <kalle.jokiniemi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Subject: RE: [PATCH 1/2] USB: twl4030-usb: do board specific phy_power
 up/down
Date: Tue, 22 Mar 2011 10:12:24 +0000
Message-ID: <9D0D31AA57AAF5499AFDC63D6472631B06AF41@008-AM1MPN1-036.mgdnok.nokia.com>
References: <1300715420-25602-1-git-send-email-kalle.jokiniemi@nokia.com>
 <1300715420-25602-2-git-send-email-kalle.jokiniemi@nokia.com>
 <4D875EE6.50505@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4D875EE6.50505-hkdhdckH98+B+jHODAdFcQ@public.gmane.org>
Content-Language: en-US
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: sshtylyov-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, Heikki.Krogerus-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org, jhnikula-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, ilkka.koskinen-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi,

 > -----Original Message-----
 > From: ext Sergei Shtylyov [mailto:sshtylyov-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org]
 > Sent: 21. maaliskuuta 2011 16:21
 > To: Jokiniemi Kalle (Nokia-MS/Tampere)
 > Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; balbi-l0cyMroinI0@public.gmane.org;
 > tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org; Krogerus Heikki (Nokia-MS/Helsinki);
 > jhnikula-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org; Koskinen Ilkka (Nokia-MS/Tampere)
 > Subject: Re: [PATCH 1/2] USB: twl4030-usb: do board specific phy_power
 > up/down
 > 
 > Hello.
 > 
 > Kalle Jokiniemi wrote:
 > 
 > > In case some board has special powering sequences for
 > > the USB tranceiver, call those during __twl4030_phy_power
 > > calls.
 > 
 > > This is a preparation patch to allow powering down the
 > > ISP1707 USB serial tranceiver in Nokia N900.
 > 
 > > Signed-off-by: Kalle Jokiniemi <kalle.jokiniemi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
 > > ---
 > >  drivers/usb/otg/twl4030-usb.c |    9 ++++++++-
 > >  1 files changed, 8 insertions(+), 1 deletions(-)
 > 
 > > diff --git a/drivers/usb/otg/twl4030-usb.c b/drivers/usb/otg/twl4030-usb.c
 > > index 6ca505f..dea99b1 100644
 > > --- a/drivers/usb/otg/twl4030-usb.c
 > > +++ b/drivers/usb/otg/twl4030-usb.c
 > > @@ -348,13 +348,20 @@ static void twl4030_i2c_access(struct twl4030_usb
 > *twl, int on)
 > >
 > >  static void __twl4030_phy_power(struct twl4030_usb *twl, int on)
 > >  {
 > > -	u8 pwr = twl4030_usb_read(twl, PHY_PWR_CTRL);
 > > +	u8 pwr;
 > 
 >     Why change this line? Also, some prefer that initialized variables precede
 > uninitialized ones...

One likes the apple, one likes the orange. I'll change that back, no problem.

- Kalle

 > 
 > > +	struct twl4030_usb_data *board = twl->dev->platform_data;
 > > +
 > > +	pwr = twl4030_usb_read(twl, PHY_PWR_CTRL);
 > >
 > >  	if (on)
 > >  		pwr &= ~PHY_PWR_PHYPWD;
 > >  	else
 > >  		pwr |= PHY_PWR_PHYPWD;
 > >
 > > +	/* do board specific power up/down, if available */
 > > +	if (board->phy_power)
 > > +		board->phy_power(twl->dev, 0, on);
 > > +
 > >  	WARN_ON(twl4030_usb_write_verify(twl, PHY_PWR_CTRL, pwr) < 0);
 > >  }
 > 
 > WBR, Sergei
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
