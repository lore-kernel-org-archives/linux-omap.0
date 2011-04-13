From: Heikki Krogerus <heikki.krogerus-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v3 2/2] RX-51: Enable isp1704 power on/off
Date: Wed, 13 Apr 2011 08:10:06 +0300
Message-ID: <20110413051006.GA32404@esdhcp034230>
References: <1301405280-16899-1-git-send-email-kalle.jokiniemi@nokia.com>
 <1301405280-16899-3-git-send-email-kalle.jokiniemi@nokia.com>
 <20110330050854.GB32672@esdhcp034230>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20110330050854.GB32672@esdhcp034230>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kalle Jokiniemi <kalle.jokiniemi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, cbouatmailru-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, sshtylyov-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org, khilman-l0cyMroinI0@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, jhnikula-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi,

On Wed, Mar 30, 2011 at 08:08:54AM +0300, ext Heikki Krogerus wrote:
> On Tue, Mar 29, 2011 at 04:28:00PM +0300, Kalle Jokiniemi wrote:
> > The isp1704 usb tranceiver is used for charging and can be
> > disabled when not in use. Provide the powering routine to
> > the driver via platform data.
> > 
> > Also changed the indent of ".name" variable in rx51_charger_device
> > definition to use tabs same way as the new ".dev" variable indent.
> > Put this in the same patch since the indent fix is only needed
> > when there are multiple members in the struct definition.
> > 
> > Loosely based on earlier patches from Heikki Krogerus in
> > Nokia N900 maemo kernel.
> > 
> > Signed-off-by: Kalle Jokiniemi <kalle.jokiniemi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
> > Cc: Heikki Krogerus <heikki.krogerus-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
> 
> Acked-By: Heikki Krogerus <heikki.krogerus-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>

Before Anton takes these, this one needs ack from Tony.

-- 
heikki
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
