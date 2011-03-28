From: <kalle.jokiniemi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Subject: RE: [PATCH v2 2/2] RX-51: Enable isp1704 power on/off
Date: Mon, 28 Mar 2011 08:52:23 +0000
Message-ID: <9D0D31AA57AAF5499AFDC63D6472631B06CFA1@008-AM1MPN1-036.mgdnok.nokia.com>
References: <1301295099-22066-1-git-send-email-kalle.jokiniemi@nokia.com>
 <1301295099-22066-3-git-send-email-kalle.jokiniemi@nokia.com>
 <17a241ba5fb52c72ed49ad345910065f@mail.gmail.com>
 <9D0D31AA57AAF5499AFDC63D6472631B06CEE3@008-AM1MPN1-036.mgdnok.nokia.com>
 <20110328083915.GF2251@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20110328083915.GF2251-UiBtZHVXSwEVvW8u9ZQWYwjfymiNCTlR@public.gmane.org>
Content-Language: en-US
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: balbi-l0cyMroinI0@public.gmane.org
Cc: keshava_mgowda-l0cyMroinI0@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Heikki.Krogerus-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org, jhnikula-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, khilman-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi,

 > -----Original Message-----
 > From: ext Felipe Balbi [mailto:balbi-l0cyMroinI0@public.gmane.org]
 > Sent: 28. maaliskuuta 2011 11:39
 > To: Jokiniemi Kalle (Nokia-MS/Tampere)
 > Cc: keshava_mgowda-l0cyMroinI0@public.gmane.org; linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-
 > omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; balbi-l0cyMroinI0@public.gmane.org; Krogerus Heikki (Nokia-MS/Helsinki);
 > jhnikula-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org; khilman-l0cyMroinI0@public.gmane.org
 > Subject: Re: [PATCH v2 2/2] RX-51: Enable isp1704 power on/off
 > 
 > Hi,
 > 
 > (break your lines at 80-chars, I asked you to do this before)

Sorry, using outlook :( ... Will do that.

 > 
 > On Mon, Mar 28, 2011 at 08:06:32AM +0000, kalle.jokiniemi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org wrote:
 > > Hi,
 > >
 > >  > -----Original Message-----
 > >  > From: ext Keshava Munegowda [mailto:keshava_mgowda-l0cyMroinI0@public.gmane.org]
 > >  > Sent: 28. maaliskuuta 2011 10:19
 > >  > To: Jokiniemi Kalle (Nokia-MS/Tampere); linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-
 > >  > omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; Felipe Balbi
 > >  > Cc: Krogerus Heikki (Nokia-MS/Helsinki); jhnikula-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org; Kevin Hilman
 > >  > Subject: RE: [PATCH v2 2/2] RX-51: Enable isp1704 power on/off
 > >  >
 > >  > > +
 > >  > >  static struct platform_device rx51_charger_device = {
 > >  > > -	.name = "isp1704_charger",
 > >  > > +	.name	= "isp1704_charger",
 > >  >
 > >  > Both are same; you don't need this change!
 > >
 > > No, actually they are not same. I added tab instead of space to match
 > > indentation with the .dev member. This is the correct way IMHO.
 > 
 > Still, changing that indentation isn't part of $SUBJECT. You need to put
 > that in another patch.

Are you sure? It'll be patch that changes indentation that need not be
changed... Only the additional member definition makes the indentation
necessary, hence I see it as natural part of this patch.

But if that's a problem, I can do a separate patch, no problem.

- Kalle

 > 
 > --
 > balbi
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
