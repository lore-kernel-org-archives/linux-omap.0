From: <kalle.jokiniemi@nokia.com>
Subject: RE: [PATCH v3 2/2] RX-51: Enable isp1704 power on/off
Date: Wed, 20 Apr 2011 10:38:13 +0000
Message-ID: <9D0D31AA57AAF5499AFDC63D6472631B084995@008-AM1MPN1-031.mgdnok.nokia.com>
References: <1301405280-16899-1-git-send-email-kalle.jokiniemi@nokia.com>
 <1301405280-16899-3-git-send-email-kalle.jokiniemi@nokia.com>
 <20110330050854.GB32672@esdhcp034230> <20110413051006.GA32404@esdhcp034230>
 <20110413062830.GB12665@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.128.26]:40556 "EHLO mgw-da02.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752095Ab1DTKi1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 20 Apr 2011 06:38:27 -0400
In-Reply-To: <20110413062830.GB12665@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, Heikki.Krogerus@nokia.com, cbouatmailru@gmail.com
Cc: linux-usb@vger.kernel.org, balbi@ti.com, sshtylyov@mvista.com, khilman@ti.com, linux-omap@vger.kernel.org, jhnikula@gmail.com

Thanks for the ack. Now can we get this patch set in? Anton are you reading this?

If you need refreshed set, I can do that.

- Kalle

 > -----Original Message-----
 > From: ext Tony Lindgren [mailto:tony@atomide.com]
 > Sent: 13. huhtikuuta 2011 9:29
 > To: Krogerus Heikki (Nokia-SD/Helsinki)
 > Cc: Jokiniemi Kalle (Nokia-SD/Tampere); linux-usb@vger.kernel.org;
 > cbouatmailru@gmail.com; balbi@ti.com; sshtylyov@mvista.com;
 > khilman@ti.com; linux-omap@vger.kernel.org; jhnikula@gmail.com
 > Subject: Re: [PATCH v3 2/2] RX-51: Enable isp1704 power on/off
 > 
 > * Heikki Krogerus <heikki.krogerus@nokia.com> [110413 08:07]:
 > > Hi,
 > >
 > > On Wed, Mar 30, 2011 at 08:08:54AM +0300, ext Heikki Krogerus wrote:
 > > > On Tue, Mar 29, 2011 at 04:28:00PM +0300, Kalle Jokiniemi wrote:
 > > > > The isp1704 usb tranceiver is used for charging and can be
 > > > > disabled when not in use. Provide the powering routine to
 > > > > the driver via platform data.
 > > > >
 > > > > Also changed the indent of ".name" variable in rx51_charger_device
 > > > > definition to use tabs same way as the new ".dev" variable indent.
 > > > > Put this in the same patch since the indent fix is only needed
 > > > > when there are multiple members in the struct definition.
 > > > >
 > > > > Loosely based on earlier patches from Heikki Krogerus in
 > > > > Nokia N900 maemo kernel.
 > > > >
 > > > > Signed-off-by: Kalle Jokiniemi <kalle.jokiniemi@nokia.com>
 > > > > Cc: Heikki Krogerus <heikki.krogerus@nokia.com>
 > > >
 > > > Acked-By: Heikki Krogerus <heikki.krogerus@nokia.com>
 > >
 > > Before Anton takes these, this one needs ack from Tony.
 > 
 > Looks good to me:
 > 
 > Acked-by: Tony Lindgren <tony@atomide.com>
