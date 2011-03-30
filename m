From: Heikki Krogerus <heikki.krogerus@nokia.com>
Subject: Re: [PATCH v3 2/2] RX-51: Enable isp1704 power on/off
Date: Wed, 30 Mar 2011 08:08:54 +0300
Message-ID: <20110330050854.GB32672@esdhcp034230>
References: <1301405280-16899-1-git-send-email-kalle.jokiniemi@nokia.com>
 <1301405280-16899-3-git-send-email-kalle.jokiniemi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.128.24]:51875 "EHLO mgw-da01.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752447Ab1C3FJI (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 30 Mar 2011 01:09:08 -0400
Content-Disposition: inline
In-Reply-To: <1301405280-16899-3-git-send-email-kalle.jokiniemi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kalle Jokiniemi <kalle.jokiniemi@nokia.com>
Cc: linux-usb@vger.kernel.org, cbouatmailru@gmail.com, balbi@ti.com, sshtylyov@mvista.com, tony@atomide.com, khilman@ti.com, linux-omap@vger.kernel.org, jhnikula@gmail.com

On Tue, Mar 29, 2011 at 04:28:00PM +0300, Kalle Jokiniemi wrote:
> The isp1704 usb tranceiver is used for charging and can be
> disabled when not in use. Provide the powering routine to
> the driver via platform data.
> 
> Also changed the indent of ".name" variable in rx51_charger_device
> definition to use tabs same way as the new ".dev" variable indent.
> Put this in the same patch since the indent fix is only needed
> when there are multiple members in the struct definition.
> 
> Loosely based on earlier patches from Heikki Krogerus in
> Nokia N900 maemo kernel.
> 
> Signed-off-by: Kalle Jokiniemi <kalle.jokiniemi@nokia.com>
> Cc: Heikki Krogerus <heikki.krogerus@nokia.com>

Acked-By: Heikki Krogerus <heikki.krogerus@nokia.com>

-- 
heikki
