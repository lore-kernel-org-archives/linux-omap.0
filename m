From: <kalle.jokiniemi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Subject: RE: [PATCH v3 2/2] RX-51: Enable isp1704 power on/off
Date: Wed, 20 Apr 2011 10:56:51 +0000
Message-ID: <9D0D31AA57AAF5499AFDC63D6472631B0849C1@008-AM1MPN1-031.mgdnok.nokia.com>
References: <1301405280-16899-1-git-send-email-kalle.jokiniemi@nokia.com>
 <1301405280-16899-3-git-send-email-kalle.jokiniemi@nokia.com>
 <20110330050854.GB32672@esdhcp034230> <20110413051006.GA32404@esdhcp034230>
 <20110413062830.GB12665@atomide.com>
 <9D0D31AA57AAF5499AFDC63D6472631B084995@008-AM1MPN1-031.mgdnok.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <9D0D31AA57AAF5499AFDC63D6472631B084995-vKHveGmogcsbcE5WFD5oKCw+Ng1cvSfHNLMJvB61ksU@public.gmane.org>
Content-Language: en-US
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, Heikki.Krogerus-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org, cbouatmailru-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, avorontsov-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, sshtylyov-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org, khilman-l0cyMroinI0@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, jhnikula-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: linux-omap@vger.kernel.org


 > -----Original Message-----
 > From: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org [mailto:linux-usb-
 > owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org] On Behalf Of ext kalle.jokiniemi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org
 > Sent: 20. huhtikuuta 2011 13:38
 > To: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org; Krogerus Heikki (Nokia-SD/Helsinki);
 > cbouatmailru-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
 > Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; balbi-l0cyMroinI0@public.gmane.org; sshtylyov-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org;
 > khilman-l0cyMroinI0@public.gmane.org; linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; jhnikula-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
 > Subject: RE: [PATCH v3 2/2] RX-51: Enable isp1704 power on/off
 > 
 > Thanks for the ack. Now can we get this patch set in? Anton are you reading
 > this?

Let's try another mail address for Anton...

- Kalle

 > 
 > If you need refreshed set, I can do that.
 > 
 > - Kalle
 > 
 >  > -----Original Message-----
 >  > From: ext Tony Lindgren [mailto:tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org]
 >  > Sent: 13. huhtikuuta 2011 9:29
 >  > To: Krogerus Heikki (Nokia-SD/Helsinki)
 >  > Cc: Jokiniemi Kalle (Nokia-SD/Tampere); linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org;
 >  > cbouatmailru-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org; balbi-l0cyMroinI0@public.gmane.org; sshtylyov-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org;
 >  > khilman-l0cyMroinI0@public.gmane.org; linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; jhnikula-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
 >  > Subject: Re: [PATCH v3 2/2] RX-51: Enable isp1704 power on/off
 >  >
 >  > * Heikki Krogerus <heikki.krogerus-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org> [110413 08:07]:
 >  > > Hi,
 >  > >
 >  > > On Wed, Mar 30, 2011 at 08:08:54AM +0300, ext Heikki Krogerus wrote:
 >  > > > On Tue, Mar 29, 2011 at 04:28:00PM +0300, Kalle Jokiniemi wrote:
 >  > > > > The isp1704 usb tranceiver is used for charging and can be
 >  > > > > disabled when not in use. Provide the powering routine to
 >  > > > > the driver via platform data.
 >  > > > >
 >  > > > > Also changed the indent of ".name" variable in rx51_charger_device
 >  > > > > definition to use tabs same way as the new ".dev" variable indent.
 >  > > > > Put this in the same patch since the indent fix is only needed
 >  > > > > when there are multiple members in the struct definition.
 >  > > > >
 >  > > > > Loosely based on earlier patches from Heikki Krogerus in
 >  > > > > Nokia N900 maemo kernel.
 >  > > > >
 >  > > > > Signed-off-by: Kalle Jokiniemi <kalle.jokiniemi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
 >  > > > > Cc: Heikki Krogerus <heikki.krogerus-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
 >  > > >
 >  > > > Acked-By: Heikki Krogerus <heikki.krogerus-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
 >  > >
 >  > > Before Anton takes these, this one needs ack from Tony.
 >  >
 >  > Looks good to me:
 >  >
 >  > Acked-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
 > --
 > To unsubscribe from this list: send the line "unsubscribe linux-usb" in
 > the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
 > More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
